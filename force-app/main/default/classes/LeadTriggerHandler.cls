/*
	Date			Developer Name			Description
	22/11/2018		Edgar Santillana		Created
*/
public class LeadTriggerHandler extends TriggerHandler {

    private String estatus_Calificado = 'Calificado';
    private Account acc = new Account();
    private Contact cont = new Contact();
    private Set<Id> accountSet = new Set<Id>();
    private Set<String> leadCompany = new Set<String>();
    private Set<String> leadName = new Set<String>();
    private Set<Account> accountDuplicateSet = new Set<Account>();
    private List<Account> accountList = new List<Account>();
    private List<Account> accountDuplicateList = new List<Account>();
    private List<Contact> contactList = new List<Contact>();
    private List<Lead> leadConvertedList = new List<Lead>();
    private List<Database.LeadConvert> leadConverts = new List<Database.LeadConvert>();
    private Map<String,Account> accountMap = new Map <String,Account>();
    private Map<String,Contact> contactMap = new Map <String,Contact>();
    private Map<String,Lead> leadMap = new Map <String,Lead>();
    
    public override void afterInsert(){
        
        leadConverted(validateList(Trigger.New));
    }
    
    public override void afterUpdate(){
        
        leadConverted(validateList(Trigger.New));
    }

    private void leadConverted(List<Lead> leadList){
        
        // Get the status for lead converted
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        
        // Create set of company from leads
        for(Lead leadRecord : leadList){
            leadCompany.add(leadRecord.Company);
            leadName.add(leadRecord.FirstName + ' ' + leadRecord.LastName);
        }

        // Create map with accounts that exist depends of name
        for(Account accountExist :[SELECT Id, Name, (SELECT Id, Name FROM Contacts WHERE Name IN : leadName)  FROM Account WHERE Name IN :leadCompany  LIMIT 10000]){
            accountMap.put(accountExist.Name, accountExist);
        }
        
        //Check if the duplicate accounts in the list doesn't exist 
        for(String accountDuplicate :validateAccountList(leadList)){
            if(!accountMap.containsKey(accountDuplicate)){
                acc.Name = accountDuplicate;
                accountDuplicateSet.add(acc);
            }
        }
		
		// Create the duplicate accounts and add to the account map        
        if(!accountDuplicateSet.isEmpty() && accountDuplicateSet.size() > 0){
            accountDuplicateList.addAll(accountDuplicateSet);
            insert accountDuplicateList;
            for(Account tempAccount : accountDuplicateList){
                accountMap.put(tempAccount.Name, tempAccount);
            }
        }
        
        for(Lead leadRecord : leadList){
            if(leadRecord.Status == estatus_Calificado && !leadRecord.isConverted){
                Database.LeadConvert leadC = new Database.LeadConvert();
                leadC.setDoNotCreateOpportunity(TRUE);
                leadC.setLeadId(leadRecord.Id);
                if(accountMap.containsKey(leadRecord.Company)){
                    Account tempAccount = accountMap.get(leadRecord.Company);
                    leadC.setAccountId(tempAccount.Id);

                    for(Contact tempContact : tempAccount.Contacts){
                       String name = leadRecord.FirstName + ' ' + leadRecord.LastName;
                        if(name == tempContact.Name){
                        	leadC.setContactId(tempContact.Id);
                    	}
                    }
                }

                leadC.setConvertedStatus(convertStatus.MasterLabel);
                
                leadConverts.add(leadC);

                leadMap.put(leadRecord.Id,leadRecord);               
            }
        }
        
        if (!leadConverts.isEmpty()) {
            List<Database.LeadConvertResult> lcr = Database.convertLead(leadConverts);
            if(lcr.size() > 0 && !lcr.isEmpty()){
                for(Database.LeadConvertResult cr :lcr ){
                    if(leadMap.containsKey(cr.leadid) && cr.accountid != null && cr.contactid != null){
                        Lead tempLead = leadMap.get(cr.leadid);
                        acc.Id = cr.accountid;
                        acc.Name = tempLead.Company;
                        accountList.add(acc);

                        cont.Id = cr.contactid;
                        cont.FirstName = tempLead.FirstName;
                        cont.LastName = tempLead.LastName;
                        contactList.add(cont);
                    }
                }
            }
         }
        
        // Update accounts
        if(!accountList.isEmpty() && accountList.size() > 0){
            accountMap.clear();
            accountMap.putAll(accountList);
            update accountMap.values();
        }
        
        // Update contacts
        if(!contactList.isEmpty() && contactList.size() > 0){
            contactMap.putAll(contactList);
            update contactMap.values();
        }
        
    }
    
    // Check if the list of leads not contain duplicate contact record
    private List<Lead> validateList(List<Lead> leadList){
        
        Map<String,Lead> tempMap = new Map<String,Lead>();
        String duplicateKey = '';
        
        for(Lead leadRecord : leadList){
            duplicateKey = leadRecord.Company + leadRecord.FirstName + leadRecord.LastName;
            tempMap.put(duplicateKey, leadRecord);
        }
        
        return tempMap.values();
    }
    
    //Check if the list of leads not contain duplicate account record
    private Set<String> validateAccountList(List<Lead> leadList){
        
        Set<String> encounteredNames = new Set<String>();
        Set<String> duplicateNames = new Set<String>();
        
        for(Lead leadRecord :leadList){
            if(encounteredNames.contains(leadRecord.Company) && leadRecord.Status == estatus_Calificado){
                duplicateNames.add(leadRecord.Company);
            }else if(leadRecord.Status == estatus_Calificado){
                encounteredNames.add(leadRecord.Company);
            }
		}
        return duplicateNames;
    }
}
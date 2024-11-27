/*
	Date			Developer Name			Description
	22/11/2018		Edgar Santillana		Created
*/
@isTest
public class LeadTriggerHandler_Test {
    
    @isTest
    public static void leadConvertInsert(){
        
        List<Lead> leadList = new List<Lead>();
        
        Lead newLead = new Lead();
        newLead.FirstName = 'Edgar';
        newLead.LastName = 'Santillana';
        newLead.Company = 'Test';
        newLead.Status = 'Calificado';
        leadList.add(newLead);
        
        Lead newLeadSameAccount = new Lead();
        newLeadSameAccount.FirstName = 'Ruben';
        newLeadSameAccount.LastName = 'Santillana';
        newLeadSameAccount.Company = 'Test';
        newLeadSameAccount.Status = 'Calificado';
        leadList.add(newLeadSameAccount);
        
        Lead newLeadDupli = new Lead();
        newLeadDupli.FirstName = 'Ruben';
        newLeadDupli.LastName = 'Santillana';
        newLeadDupli.Company = 'Test';
        newLeadDupli.Status = 'Calificado';
        leadList.add(newLeadDupli);
        
        Test.startTest();
        	insert leadList;
            Lead newLeadDuplica = new Lead();
            newLeadDuplica.FirstName = 'Ruben';
            newLeadDuplica.LastName = 'Santillana';
            newLeadDuplica.Company = 'Test';
            newLeadDuplica.Status = 'Calificado';
            insert newLeadDuplica;
        Test.stopTest();
        
        Account acc = [SELECT Id, Name FROM Account Limit 1];
        List<Contact> contactList  = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :acc.Id];
        
        System.assertEquals('Test', acc.Name);
        System.assertEquals(2, contactList.size());
        
    }
    
    @isTest
    public static void leadConvertUpdate(){
        
        List<Lead> leadList = new List<Lead>();
        
        Lead newLead = new Lead();
        newLead.FirstName = 'Edgar';
        newLead.LastName = 'Santillana';
        newLead.Company = 'Test';
        leadList.add(newLead);
        
        Lead newLeadSameAccount = new Lead();
        newLeadSameAccount.FirstName = 'Ruben';
        newLeadSameAccount.LastName = 'Santillana';
        newLeadSameAccount.Company = 'Test';
        leadList.add(newLeadSameAccount);
        
        Lead newLeadDuplicade = new Lead();
        newLeadDuplicade.FirstName = 'Ruben';
        newLeadDuplicade.LastName = 'Santillana';
        newLeadDuplicade.Company = 'Test';
        leadList.add(newLeadDuplicade);
        
        insert leadList;
 
        
        Test.startTest();	
        	leadList.clear();
        	newLead.Status = 'Calificado';
        	leadList.add(newLead);
            newLeadSameAccount.Status = 'Calificado';
        	leadList.add(newLeadSameAccount);
            newLeadDuplicade.Status = 'Calificado';
        	leadList.add(newLeadDuplicade);
        	update leadList;
        Test.stopTest();
        
         Account acc = [SELECT Id, Name FROM Account Limit 1];
        List<Contact> contactList  = [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :acc.Id];
        
        System.assertEquals('Test', acc.Name);
        System.assertEquals(2, contactList.size());
        
    }

    @isTest
    public static void leadConvert100(){
        List<Lead> leadLst = new List<Lead>();
        Integer count = 0;

            for (Integer i = 0; i < 100; i++ ) {
                
                Lead l = new Lead(Firstname = 'Edgar' + i, 
                                  Lastname = 'Santillana', 
                                  Company = 'Test'+ i,
                                 Status = 'Calificado');
                leadLst.add(l);
            }
        
        	Test.startTest();
            	insert leadLst;
        	Test.stopTest();
        
        for(Account acc : [SELECT Id, Name FROM Account Order By Id ASC ]){
            System.assertEquals('Test' + count, acc.Name);
            count++;
        }
        count = 0;
        for(Contact con : [SELECT Id, FirstName, LastName FROM Contact Order By Id ASC ]){
            System.assertEquals('Edgar' + count, con.FirstName);
            System.assertEquals('Santillana', con.LastName);
            count++;
        }
    }

}
public class Popup_Controller {
    
    public id CaseNrt {get;set;}
    public Account acc {get;set;}
    public boolean displayPopup {get; set;}     
	public Popup_Controller(ApexPages.StandardController controller){
         CaseNrt = (id)controller.getRecord().id;
        acc = [SELECT Alert_Account__c From Account where Id = :CaseNrt Limit 1 ];
        if(acc.Alert_Account__c ){
                    displayPopup = true; 
        }

       
    }
    

    public void showPopup()
    {
    	displayPopup = true;
    }
    
    public void closePopup() {
        Account newAccount = new Account();
        newAccount.Id = CaseNrt;
        newAccount.Alert_Account__c = false;
        update newAccount;
        displayPopup = false;
    }
    
    public void redirectPopup()
    {
    displayPopup = false;
        //Please uncomment below 3 statements and replace YourObjectId
       // PageReference p=new Pagereference('/'+YourObjectId);
       //  p.setRedirect(true);
       //  return p;
        
    }

}
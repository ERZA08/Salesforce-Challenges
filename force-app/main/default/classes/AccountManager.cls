@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager  {

    @HttpGet
    global static Account getAccount() {
         RestRequest request = RestContext.request;
         String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
          Account result = [Select Id,(select Id,Name from Contacts) from Account  
                                        WHERE Id = :accountId];
        return result;
    }

}
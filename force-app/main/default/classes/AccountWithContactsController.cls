/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-14-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-11-2025   Edgar Santillana   Initial Version
**/
public with sharing class AccountWithContactsController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
        return [SELECT Id, FirstName, LastName, Email, Phone 
                FROM Contact 
                WHERE AccountId = :accountId LIMIT 50];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountWithContacts(Id accountId) {
        return [SELECT Id, Name, (SELECT Id, FirstName, LastName, Email, Phone FROM Contacts)
                FROM Account 
                WHERE Id = :accountId LIMIT 50];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(Id accountId) {
        return [SELECT Id, Name, Industry, Phone, Website
                FROM Account LIMIT 10 ];
    }
}
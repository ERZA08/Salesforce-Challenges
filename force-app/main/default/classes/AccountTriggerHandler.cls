/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-03-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   08-01-2024   Edgar Santillana   Initial Version
**/
public with sharing class AccountTriggerHandler {
    /**
    * @description 
    * @author Edgar Santillana | 08-01-2024 
    * @param newAccounts 
    * @param oldAccountMap 
    * @param isBefore 
    * @param isInsert 
    * @param isUpdate 
    **/
    public static void handleTrigger(List<Account> newAccounts, Map<Id, Account> oldAccountMap, Boolean isBefore, Boolean isInsert, Boolean isUpdate) {
        if (isBefore) {
            if (isInsert) {
                beforeInsert(newAccounts);
            } else if (isUpdate) {
                beforeUpdate(newAccounts, oldAccountMap);
            }
        } else {
            if (isInsert) {
                afterInsert(newAccounts);
            } else if (isUpdate) {
                afterUpdate(newAccounts, oldAccountMap);
            }
        }
    }

    private static void beforeInsert(List<Account> newAccounts) {
       
    }

    private static void beforeUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
       
    }

    private static void afterInsert(List<Account> newAccounts) {
        Set<Id> accountIdSet = new Set<Id>();
        for (Account acc : newAccounts) {
            accountIdSet.add(acc.Id);
        }
        createContact(accountIdSet);
    }

    /**
    * @description 
    * @author Edgar Santillana | 08-01-2024 
    * @param newAccounts 
    * @param oldAccountMap 
    **/
    private static void afterUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        List<AccountRiskChangeEvent__e> events = new List<AccountRiskChangeEvent__e>();
        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);
            System.debug('Updated Account: ' + acc.Name);
            if (acc.Risk__c != oldAcc.Risk__c && acc.Risk__c == 'High') {
                AccountRiskChangeEvent__e event = new AccountRiskChangeEvent__e(
                    AccountId__c = acc.Id,
                    AccountOwnerId__c = acc.OwnerId
                );
                events.add(event);
            }    
        }

        if (!events.isEmpty()) {
            System.debug('Event was created: ' + events);
            EventBus.publish(events);
        }
    }


    
    /**
    * @description Create a new contact for each account created in the system
    * @author Edgar Santillana | 02-03-2025 
    * @param newAccounts 
    **/
    @future 
    private static void createContact(List<Id> accountIdSet) {
        List<Contact> contacts = new List<Contact>();
        
        if (accountIdSet.isEmpty()) {
            return;
        }

        try{
            System.debug('Creating contacts for accounts: ' + accountIdSet);
            for (Account acc : [SELECT Id, Name FROM Account WHERE Id IN :accountIdSet]) {
                Contact contact = new Contact(
                    FirstName = 'Contact',
                    LastName = acc.Name,
                    AccountId = acc.Id,
                    Email =  acc.Name + '@company.com'
                );
                contacts.add(contact);
            }
            insert contacts;
        } catch (Exception e) {
            System.debug('Error creating contacts: ' + e.getMessage());
        }
    }
}
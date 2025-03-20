/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 03-20-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   03-20-2025   Edgar Santillana   Initial Version
**/
@isTest
private class AccountWithContactsControllerTest {


@IsTest static void testGetContacts() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id);
        insert con;
        
        List<Contact> contacts = AccountWithContactsController.getContacts(acc.Id);
        Assert.areEqual(1, contacts.size(), 'Expected 1 contact');
        Assert.areEqual('Test', contacts[0].FirstName, 'Expected first name to be Test');
        Assert.areEqual('Contact', contacts[0].LastName, 'Expected last name to be Contact');
        Assert.areEqual(acc.Id, contacts[0].AccountId, 'Expected account ID to match');
    }

@IsTest static void testGetAccountWithContacts() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id);
        insert con;
        
        List<Account> accounts = AccountWithContactsController.getAccountWithContacts(acc.Id);
        
        Assert.areEqual(1, accounts.size(), 'Expected 1 account');
        Assert.areEqual('Test Account', accounts[0].Name, 'Expected account name to be Test Account');
        Assert.areEqual(1, accounts[0].Contacts.size(), 'Expected 1 contact');
        Assert.areEqual('Test', accounts[0].Contacts[0].FirstName, 'Expected first name to be Test');
        Assert.areEqual('Contact', accounts[0].Contacts[0].LastName, 'Expected last name to be Contact');
        Assert.areEqual(acc.Id, accounts[0].Contacts[0].AccountId, 'Expected account ID to match');
    }

@IsTest static void testGetAccounts() {
    Account acc = new Account(Name = 'Test Account');
    insert acc;
    
    List<Account> accounts = AccountWithContactsController.getAccounts(acc.Id);
    
    Assert.areEqual(1, accounts.size(), 'Expected 1 account');
    Assert.areEqual('Test Account', accounts[0].Name, 'Expected account name to be Test Account');
    Assert.areEqual(acc.Id, accounts[0].Id, 'Expected account ID to match');
}
}
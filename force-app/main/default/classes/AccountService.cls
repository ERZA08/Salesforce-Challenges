/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-10-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-10-2025   Edgar Santillana   Initial Version
**/
public with sharing class AccountService {

    public List<AccountWrapper> getAccountsWithOpportunties(){
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();
        List<Account> accounts = [
            SELECT Id, Name, (SELECT Id, Name FROM Contacts), (SELECT Id, Name FROM Opportunities WHERE IsClosed = false) 
            FROM Account 
            WHERE Id IN (SELECT AccountId FROM Opportunity WHERE IsClosed = false)];
        for(Account account : accounts){
            accountWrappers.add(new AccountWrapper(account, account.Contacts, account.Opportunities));
        }
        return accountWrappers;
    }

    public List<Opportunity> getAccountsTop5Revenue(){

        List<Opportunity> opportunities = [
            SELECT AccountId, Account.Name, SUM(Amount) totalAmount
            FROM Opportunity
            WHERE StageName = 'Closed Won'
            GROUP BY AccountId, Account.Name
            ORDER BY TotalRevenue DESC 
            LIMIT 5
        ];
        return opportunities;
    }

    public List<Contact> getContactsWithoutOpportunities(){
        List<Contact> contacts = [
            SELECT Id, Name, Account.Name, Email
            FROM Contact
            WHERE Id NOT IN (SELECT ContactId FROM OpportunityContactRole WHERE ContactId != NULL)
        ];
        return contacts;
    }

    public List<Opportunity> getOpportunitiesWithSpecificProduct( String productName ){
        List<Opportunity> opportunities = [
            SELECT Id, Name, Account.Name, Amount, CloseDate, StageName
            FROM Opportunity
            WHERE Id IN (SELECT OpportunityId FROM OpportunityLineItem WHERE PricebookEntry.Product2.Name = :productName)
        ];
        return opportunities;
    }

    public List<Account> getAccountsWithCases(){
        List<Account> accounts = [
            SELECT AccountId, Account.Name, COUNT(Id) CaseCount
            FROM Case
            GROUP BY AccountId, Account.Name
            HAVING COUNT(Id) >= 3
            ORDER BY  COUNT(Id) DESC 
        ];
        return accounts;
    }

    public List<Lead> getLeadsMostRecentlyTop10(){
        List<Lead> leads = [
            SELECT Id, Name, Company, Phone, Email, Status, CreatedDate
            FROM Lead
            ORDER BY CreatedDate DESC 
            LIMIT 10
        ];
        return leads;
    }
    

    public class AccountWrrapper{
        public Account account;
        public List<Contact> contacts;
        public List<Opportunity> opportunities;

        public AccountWrrapper(Account account, List<Contact> contacts, List<Opportunity> opportunities){
            this.account = account;
            this.contacts = contacts;
            this.opportunities = opportunities;
        }
    }
}
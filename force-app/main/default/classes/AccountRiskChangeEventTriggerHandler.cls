/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 08-01-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   08-01-2024   Edgar Santillana   Initial Version
**/
public with sharing class AccountRiskChangeEventTriggerHandler {
    public static void handleTrigger(List<AccountRiskChangeEvent__e> newAccounts) {
        createCase(newAccounts);
    }

    /**
    * @description 
    * @author Edgar Santillana | 08-01-2024 
    * @param newAccounts 
    **/
    private static void createCase(List<AccountRiskChangeEvent__e> newAccounts) {
        List<Case> cases = new List<Case>();

        for (AccountRiskChangeEvent__e event : newAccounts) {
            Case newCase = new Case(
                AccountId = event.AccountId__c,
                Subject = 'New Case from Risk Field',
                Description = 'A case created due to Risk picklist value change on Account.',
                Status = 'New',
                Origin = 'Account'
            );
            cases.add(newCase);
        }
        
        if (!cases.isEmpty()) {
            insert cases;
        }
    }
}
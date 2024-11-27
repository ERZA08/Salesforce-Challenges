/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 03-14-2024
 * @last modified by  : Edgar Santillana 
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   03-14-2024   Edgar Santillana   Initial Version
**/
public with sharing class editableTableController {
    public editableTableController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getCustomObjectRecords() { 
        return [SELECT Name, Account.Name, StageName FROM Opportunity];
    }
}
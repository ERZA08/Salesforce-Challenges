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
public with sharing class CaseManagerController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getOpenCases() {
        return [SELECT Id, CaseNumber, Subject, Status, Priority, CreatedDate, LastModifiedDate FROM Case WHERE IsClosed = false LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getClosedCases() {
        return [SELECT Id, CaseNumber, Subject, Status, Priority, CreatedDate, LastModifiedDate FROM Case WHERE IsClosed = true LIMIT 10];
    }


}
/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   07-30-2024   Edgar Santillana   Initial Version
**/
public with sharing class LocationInsertQueueable implements Queueable{
    private List<Location__c> locationsToInsert;

    public LocationInsertQueueable(List<Location__c> locations) {
        this.locationsToInsert = locations;
    }

    public void execute(QueueableContext context) {
        if (!locationsToInsert.isEmpty()) {
            insert locationsToInsert;
        }
    }
}
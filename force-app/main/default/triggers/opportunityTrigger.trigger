/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 11-27-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   11-27-2024   Edgar Santillana   Initial Version
**/
trigger opportunityTrigger on Opportunity (before insert, before update) {

    System.debug('So this is a trigger to do something');
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.beforeInsertTriggerHandler(Trigger.new);
        }
        if(Trigger.isUpdate){
            OpportunityTriggerHandler.beforeUpdateTriggerHandler(Trigger.new,Trigger.oldMap);
        }
    }

}
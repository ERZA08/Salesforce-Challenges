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
trigger AccountEventTrigger on AccountRiskChangeEvent__e  ( after insert) {
    AccountRiskChangeEventTriggerHandler.handleTrigger(Trigger.new);
}
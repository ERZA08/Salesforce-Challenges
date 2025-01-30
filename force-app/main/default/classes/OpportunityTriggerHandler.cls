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
public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }

    public static void beforeInsertTriggerHandler(List<Opportunity> recordList){
        //Flag is runnin for second time 
        updatePriority(recordList, null);
    }


    public static void beforeUpdateTriggerHandler(List<Opportunity> recordList, Map<Id,Opportunity> oldMap){
        //Flag is runnin for second time 
        System.debug('before update');
        updatePriority(recordList, oldMap);
    }

    private static void updatePriority(List<Opportunity> recordList, Map<Id,Opportunity> oldMap){

        if(oldMap != null){
            for(Opportunity record :recordList){
                Opportunity oldOpp = oldMap.values()[0];
                System.debug('before update');
                if(record.Amount != oldOpp.Amount){
                    System.debug('before update' + record.Amount);
                    if(record.Amount < 5000){
                        record.Dev_Priority__c = 'Low';
                    }else if(record.Amount >= 5000 && record.Amount <= 10000){
                        record.Dev_Priority__c = 'Medium';
                    }else if(record.Amount > 10000){
                        record.Dev_Priority__c = 'High';
                    }
                }
            }
        }else {
            for(Opportunity record :recordList){
                if(record.Amount < 5000){
                    record.Dev_Priority__c = 'Low';
                }else if(record.Amount >= 5000 && record.Amount <= 10000){
                    record.Dev_Priority__c = 'Medium';
                }else if(record.Amount > 10000){
                    record.Dev_Priority__c = 'High';
                }
            }
        }

    }
}
public with sharing class OpportunityControllerController {

    @AuraEnabled
    public static List<Opportunity> getOpportunities(){
        return [Select Id, Name, StageName, CloseDate
                	From Opportunity
                	Order by Name desc Limit 50];
    }
    
    @AuraEnabled
    public static Opportunity saveOpportunity(Opportunity opportunity){
        	upsert opportunity;
        	return opportunity;
    }

}
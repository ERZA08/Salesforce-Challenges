global with sharing class SomeClass implements schedulable{

    global void execute(schedulableContext ctx){
        
        Datetime dt = System.now();
        Datetime dtfiveminutesbefore = System.now().addMinutes(-5);
        Integer numAvailableTime = 2;
        List<Courses__c> course = new List<Courses__c>(); 
        List<Available_Time__c> cList = new List<Available_Time__c>();  

        course = [select id from courses__c Where createdDate >= :dtfiveminutesbefore and createdDate <= :dt Limit 10000];

        if(!course.isEmpty() && course.size() > 0){
            for(Courses__c i: course){ 
                for(Integer j = 0; j < numAvailableTime; j++){
                    Available_Time__c cust = new Available_Time__c(); 
                    cust.Name = 'Available Time' + j;
                    cust.Course__c = i.Id;
                    cList.add(cust); 
                }  
            }
            insert cList; 
        }
 
    }
}
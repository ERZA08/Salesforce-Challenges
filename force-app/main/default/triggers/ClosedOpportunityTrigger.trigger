trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    //Crear lista de Tareas
    List<Task> taskList = new List<Task>();
    
    //Buscar las Oportunidades Cerradas Ganadas
    For(Opportunity opp : [Select Id, Name From Opportunity
                          Where Id IN :Trigger.New AND
                           StageName = 'Closed Won' ]){
                               taskList.add(new Task(
                                   	Priority = 'Normal',
                                    Status = 'Not Started',
                               		Subject = 'Follow Up Test Task',
                                    WhatId = opp.Id
                               ));
                           }
    if(taskList.size() > 0){
         insert taskList;
    }

}
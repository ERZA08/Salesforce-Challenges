global class LeadProcessor implements Database.Batchable<sObject> {
	
	Public String query = 'Select Id, FirstName, LastName, Company, LeadSource From Lead Where LeadSource = null';
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Lead> scope) {
   		List<Lead> misProspectos = new List<Lead>();
   		for(Lead l: scope){
   			l.LeadSource = 'Dreamforce';
   		}
   		update misProspectos;
	}
	
	global void finish(Database.BatchableContext BC) {

	}
	
}
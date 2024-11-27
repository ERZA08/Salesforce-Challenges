global class DailyLeadProcessor implements Schedulable {
	global void execute(SchedulableContext sc) {
		/*LeadProcessor b = new LeadProcessor();
		database.executebatch(b);*/
		List<Lead> misProspectos = new List<Lead>();
   		for(Lead l: [Select Id, LeadSource From Lead Where LeadSource = null Limit 200]){
   			l.LeadSource = 'Dreamforce';
   		}
   		update misProspectos;
	}
}
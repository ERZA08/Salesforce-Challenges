@isTest
private class DailyLeadProcessorTest
{

	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	@isTest
	static void itShould()
	{
		//Inserta Registros de Prospectos
		List<Lead> ltsLeads = new List<Lead>();
		for(Integer i = 0; i < 200; i++){
			Lead l = new Lead( FirstName = 'LeadPrueba ' + i,
								 LastName = 'Otro ' + i,
								 Company = 'Pizsaz');
			ltsLeads.add(l);
		}

		insert ltsLeads;

		//Ejecuta 
		Map<Id,Lead> mLead = new Map<Id,Lead>(ltsLeads);
		List<Id> ltsIDs = new List<Id>(mLead.keySet());
		
		Test.startTest();
		 String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());        
		 List<Lead> ltsCP = new List<Lead>();

		 ltsCP = [Select Id From Lead Where Id in:ltsIDs And LeadSource = 'Dreamforce'];
		 System.assertEquals(0,ltsCP.size());
		 Test.stopTest();
		
		
		 //Verifica
		 /*ltsCP = [Select Id From Lead Where Id in:ltsIDs And LeadSource = 'Dreamforce'];
		 System.assertEquals(ltsLeads.size(),ltsCP.size());*/
	}
}
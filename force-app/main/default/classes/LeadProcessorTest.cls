@isTest
private class LeadProcessorTest
{
	@isTest
	static void empiezaMetodo()
	{
		List<Lead> prospectos = new List<Lead>();
		for(Integer i = 0; i < 200; i++ ){
			Lead nuevoProspecto = new Lead();
			nuevoProspecto.FirstName = 'Lead ' + i;
			nuevoProspecto.LastName = 'First ' + i;
			nuevoProspecto.Company = 'bla';
			prospectos.add(nuevoProspecto);
		}
		insert prospectos;
        
        Test.startTest();
            LeadProcessor pex = new LeadProcessor();
            Id batchId = Database.executeBatch(pex);
		Test.stopTest();
	}
}
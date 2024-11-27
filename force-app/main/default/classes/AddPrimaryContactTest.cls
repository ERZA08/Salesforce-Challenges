@isTest
private class AddPrimaryContactTest
{
	@isTest
	static void itShould()
	{
		// Given
		List<Account> cuentasNY = new List<Account>();
		List<Account> cuentasCA = new List<Account>();
		for(Integer i = 0; i < 50; i++){
			cuentasNY.add(new Account(name = 'cuenta' + i, BillingState = 'NY'));
		}
		insert cuentasNY;
		for(Integer i = 50; i < 100; i++){
			cuentasCA.add(new Account(name = 'cuenta' + i, BillingState = 'CA'));
		}
		insert cuentasCA;

		Contact miContacto = new Contact();
		miContacto.FirstName = 'demo';
		miContacto.LastName = 'demo';

		AddPrimaryContact acp = new AddPrimaryContact(miContacto,'CA');
		Test.startTest();
		System.enqueueJob(acp);
		Test.stopTest();

	}

	/*@isTest 
	static void actualizaCuentas(){

		Contact miContacto = new Contact();
		miContacto.FirstName = 'demo';
		miContacto.LastName = 'demo';

		AddPrimaryContact acp = new AddPrimaryContact(miContacto,'CA');
		Test.startTest();
		System.enqueueJob(acp);
		Test.stopTest();

		//System.assertEquals(50, [select count() from Contact where accountID IN (SELECT id FROM Account WHERE BillingState = 'CA')]);  
		
		/*for(Account a: [select Id From Account Where BillingState = 'CA' ]){
			System.assertEquals(1, [select count() From Contact Where AccountId = :a.Id]);
		}	

		for(Account a: [select Id From Account Where BillingState = 'NY' ]){
			System.assertEquals(1, [select count() From Contact Where AccountId = :a.Id]);
		}		*/
	
	//}
}
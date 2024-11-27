@isTest
private class AccountTriggerTest 
{
	
	@isTest public static void testCreateAccounts(){
		List<Account> misCuentas = new List<Account>();
		for(Integer i = 0; i < 200; i++){
			Account a = new Account();
			a.Name = 'Nueva cuenta ' + i;
			a.BillingState = 'CA';
			misCuentas.add(a);
		}

		insert misCuentas;

		misCuentas = [Select Name, ShippingState 
							From Account Where BillingState = 'CA'];

		for(Account a:misCuentas){
			System.assertEquals('CA',a.ShippingState);
		}
	}

	@isTest public static void testNoCreateAccounts(){
		List<Account> misCuentas = new List<Account>();
		for(Integer i = 0; i < 200; i++){
			Account a = new Account();
			a.Name = 'Nueva cuenta ' + i;
			//a.BillingState = 'CA';
			misCuentas.add(a);
		}

		insert misCuentas;

		misCuentas = [Select Name, ShippingState 
							From Account Where BillingState = null];

		for(Account a:misCuentas){
			System.assertEquals('N/A',a.ShippingState);
		}
	}
}
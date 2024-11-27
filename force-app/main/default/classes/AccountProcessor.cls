public class AccountProcessor {

static List<Account> misCuentasNoFake = new List<Account>();
	static List<Contact> misContactos100Real = new List<Contact>();

	@future
	public static void countContacts(List<Id> listaCuentas){

		Integer numeroContactos = 0;

		misCuentasNoFake = [Select Name, Number_of_Contacts__c 
									From Account Where Id in :listaCuentas];

		misContactos100Real = [Select FirstName, AccountId 
									From Contact Where AccountId in :listaCuentas];

		for(Account a: misCuentasNoFake){
			numeroContactos = 0;
			for(Contact c: misContactos100Real){
				if(c.AccountId == a.Id){
					numeroContactos++;
				}
			}
			a.Number_of_Contacts__c = numeroContactos;
		}

		update misCuentasNoFake;
	}

}
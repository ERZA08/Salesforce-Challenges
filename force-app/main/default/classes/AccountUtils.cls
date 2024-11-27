public class AccountUtils  {

	 static List<Account> ltsCuentas = new List<Account>();

	public static List<Account> accountsByState (String stateAbbreviation ){

			ltsCuentas = [Select Id, Name From Account Where BillingState = :stateAbbreviation ];
		return ltsCuentas;

	}

}
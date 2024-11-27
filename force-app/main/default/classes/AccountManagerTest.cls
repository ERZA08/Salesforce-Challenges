@isTest
private class AccountManagerTest {
	
	/*@isTest static void test_method_one() {
		 
		 Id recordId = '0014100000JkvZg';
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://erzza-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+
            recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        //System.assert(thisAccount != null);
        //System.assertEquals('cuentanueva10', thisAccount.name);
        //
	}*/

	    private static testMethod void getAccountTest1() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://erzza-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+ recordId +'/contacts' ;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }

    static Id createTestRecord() {
        // Create test record
        Account TestAcc = new Account(
          Name='Test record');
        insert TestAcc;
        Contact TestCon= new Contact(
        LastName='Test', 
        AccountId = TestAcc.id);
        return TestAcc.Id;
    }      

	
}
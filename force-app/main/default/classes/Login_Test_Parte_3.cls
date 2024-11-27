public class Login_Test_Parte_3 {
	
    public  string[] cc {get;set;}
    public string username22 {get;set;}
    public string password22  {get;set;}
    public string session  {get;set;}
    partnerSoapSforceCom.SessionHeader_element sh = new partnerSoapSforceCom.SessionHeader_element();

    public PageReference  iniciarSesion(){
         /*partnerSoapSforceCom.Soap n = new partnerSoapSforceCom.Soap();
     	 partnerSoapSforceCom.LoginResult f = n.login(username22, password22);
         sh.sessionId = f.sessionId;
         n.SessionHeader = sh;
        n.endpoint_x = f.serverUrl;
        
        session = f.sessionId;
        partnerSoapSforceCom.QueryResult qresult = n.query('Select count() from Account');*/

        try{
            partnerSoapSforceCom2.soap con = new partnerSoapSforceCom2.soap();
            con.SessionHeader = new partnerSoapSforceCom2.SessionHeader_element ();
            partnerSoapSforceCom2.loginResult  loginResult = new partnerSoapSforceCom2.loginResult();
            loginResult =con.login(username22,password22);
            con.endpoint_x =loginResult.ServerUrl;
            con.Sessionheader.sessionid = loginResult.sessionid;
            partnerSoapSforceCom2.queryResult qr = new partnerSoapSforceCom2.queryResult ();
            qr=con.query('SELECT Id, AccountNumber FROM Account Limit 1');
            System.debug('------'+qr);
            session = qr.records[0].toString();
        }
        catch(Exception e)
        {
        	session =e.getMessage();
        }
        return null;
        
        
        
    }
    
    
   
     
}
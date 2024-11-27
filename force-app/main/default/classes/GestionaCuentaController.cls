public class GestionaCuentaController {

	public Account cuentaTest { set; get; }
	public string idAcc { set; get; }
	public string nombreContacto { set; get;}
	public string apellidoContacto { set; get;}
	public string emailContacto { set; get;}
	public Integer telefonoContacto { set; get;}

	public GestionaCuentaController(){
		idAcc = ApexPages.currentPage().getParameters().get('id');
		if(idAcc != null){
			cuentaTest = [Select Id, Name, accountnumber, rating, industry 
							From Account
								Where Id = :idAcc];
		}else{
			cuentaTest = new Account();
		}
	}

	public PageReference save(){
		if(idAcc != null ){
			update cuentaTest;
			return null;
		}else{
			insert cuentaTest;
			PageReference pageRef = new PageReference('/apex/GeneraCuentaContacto');
			pageRef.getParameters().put('id',cuentaTest.Id);
			pageRef.setRedirect(true);
			return pageRef;
		}
	}

	public PageReference saveContact(){
		if(idAcc != null){
			Contact  c = new Contact( FirstName = nombreContacto,
									  LastName = apellidoContacto,
									  Email = emailContacto,
									  AccountId = cuentaTest.Id);

			insert c;
			return null;
		}else{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Que te pasa? Tu no tienes cuenta D:<'));
			return null;
		}
	}

	public PageReference saveAll(){
		if(idAcc != null){
			return null;
		}else{
			insert cuentaTest;
			Contact  c = new Contact( FirstName = nombreContacto,
									  LastName = apellidoContacto,
									  Email = emailContacto,
									  AccountId = cuentaTest.Id);
			
			insert c;
			PageReference pageRef = new PageReference('/apex/GeneraCuentaContacto');
			pageRef.getParameters().put('id',cuentaTest.Id);
			pageRef.setRedirect(true);
			return pageRef;
		}
	}

}
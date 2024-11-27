public class AddPrimaryContact implements Queueable {

	private List<Contact> contactos = new List<Contact>();
	private String state;
	private Contact contacto;

	public AddPrimaryContact(Contact  contacto, String state){
		this.contacto = contacto;
		this.state = state;

	}

	public void execute(QueueableContext context) {

		 List<Account> ListAccount = [SELECT ID, Name ,(Select id,FirstName,LastName from contacts ) FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
         List<Contact> lstContact = new List<Contact>();
         for (Account acc:ListAccount)
         {
                 Contact cont = this.contacto.clone(false,false,false,false);
                 cont.AccountId =  acc.id;
                 lstContact.add( cont );
         }
         
         if(lstContact.size() >0 )
         {
             insert lstContact;
         }
		/*List<Account> ltsCuentas = [SELECT ID, Name ,(Select id,FirstName,LastName from contacts ) FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
        for(Account c: ltsCuentas){
        	Contact nuevoContacto = this.contacto.clone(false,false,false,false);
        		nuevoContacto.AccountId = c.Id;
        	contactos.add(nuevoContacto);
        }
        if(contactos.size() > 0){
        	 insert contactos;
        }*/
       
	}
}
public class Ejercicio3 {
    
    public void crearCuentas(){
        for(Integer a = 0; a < 10; a++){
            try{
                 Account nuevaCuenta = new Account(Name = 'Cuenta Prueba ' + a);
                if(a < 3){
                    nuevaCuenta.Industry = 'Agriculture';
                }else if(a >= 3 && a < 7){
                     nuevaCuenta.Industry = 'Education';
                }else{
                    nuevaCuenta.Industry = 'Insurance';
                }
                insert nuevaCuenta;
                System.debug(nuevaCuenta.Name + ' ' + nuevaCuenta.Industry);
            }catch (DmlException e) {
       				System.debug('A DML exception has occurred: ' + e.getMessage());
      			} 
        }
        
    }
    
    public void actualizaEducacion(){
         List<Account> listaEducacion = [Select Name from Account where Industry = 'Education'];
        try{
              for(Account b: listaEducacion ){
            	b.NumberOfEmployees = 100;
                System.debug(b.Name + ' ' + b.Industry + ' ' + b.NumberOfEmployees);    
        		}
             update listaEducacion;
        }catch (DmlException e) {
 				System.debug('A DML exception has occurred: ' + e.getMessage());
			} 
      
    }
    
    public void relacionaContactos(){
        
       Integer asignaContactos = 0;
       
       
       List<Account> listaI = [Select Name from Account where Industry = 'Insurance'];
        List<Contact> lisctaC = [Select AccountId,FirstName,LastName From Contact Limit 6];
        try{
              for(Account b: listaI ){
                  for(Integer otro = 0; otro < 2; otro++){
                      lisctaC[otro + asignaContactos].AccountId = b.Id;
                       System.debug(lisctaC[otro + asignaContactos].AccountId + ' ' + lisctaC[otro + asignaContactos].FirstName);   
                  }
                  asignaContactos = asignaContactos + 2;    
        	  }
             update lisctaC;
        }catch (DmlException e) {
 				System.debug('A DML exception has occurred: ' + e.getMessage());
			} 
    }
    

}
public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer numContactos,String pLastName){
        List<Contact> nuevosContactos = new List<Contact>();
        
        for(Integer i = 0; i<numContactos;i++){
            Contact nuevoContacto = new Contact(
            FirstName = 'Nombre ' + i ,
            LastName = pLastName
            );
            
            nuevosContactos.add(nuevoContacto);
        }
      		return nuevosContactos;
    }
}
public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(string pName){
        
        List<List<sObject>> listaContactoProspecto = new List<List<sObject>>();
         						listaContactoProspecto = [FIND :pName IN ALL FIELDS 
                   						RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName)];
        return listaContactoProspecto;
        
    }

}
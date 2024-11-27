trigger GestionaSede on Sede__c (before insert, before update) {
    
    //Creamos Listas necesarias para almacenar los datos
    List<Campus__c> misCampus = new List<Campus__c>();
    Set<String> misCodigos = new Set<String>();
    List<Sede__c> misSedes = new List<Sede__c>();
    
    if(Trigger.isBefore){//Antes de insertar o actualizar
        //Almacenamos en una lista unica los codigos de cada camups que se ingreso en la sede
        for(Sede__c s: Trigger.New){
            if(s.Codigo_Campus__c != null){
                misCodigos.add(s.Codigo_Campus__c);
            }else{
                s.addError('No se especifico el codigo del campus');
            }
        }
        
        //Nos traemos el id del campus de la lista de nuestros codigos
        misCampus = [Select Id, Codigo_Campus__c From Campus__c Where Codigo_Campus__c in: misCodigos ];
        
        //Por ultimo seteamos el valor de id campus en sede dependiendo el codigo ingresado
        //verificando que coincida en el objeto campus y en sede
        for(Sede__c s:Trigger.new){
            for(Campus__c c: misCampus){
                if(s.Codigo_Campus__c == c.Codigo_Campus__c){
                    s.Campus__c = c.id;
                }
            }
        }
        
    }
    
    

}
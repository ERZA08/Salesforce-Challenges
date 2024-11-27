trigger GestionaContacto on Contact (before insert, before update) {
    
    Set<String> misNumerosCuentaSAP = new Set<String>();
    List<Account> misCuentas = new List<Account>();
    List<Account> nuevasCuentas = new List<Account>();
    
    
    //Guardamos los numeros de cuentas SAP
    if(Trigger.isBefore){
        for(Contact c: Trigger.New){
            if(c.Numero_Cuenta_SAP__c != null){
                misNumerosCuentaSAP.add(c.Numero_Cuenta_SAP__c);
            }else{
                c.addError('Ingrese un numero de cuenta SAP');
            }
        }
        
     misCuentas = [Select Id, Name, Numero_Cuenta_SAP__c From Account Where Numero_Cuenta_SAP__c in: misNumerosCuentaSAP ];
        
        for(Contact c:Trigger.New){
            for(Account a: misCuentas){
                  if(c.Numero_Cuenta_SAP__c == a.Numero_Cuenta_SAP__c){
                        c.AccountId = a.id;
                    }
            }if(c.AccountId == null){
                    Account a2 = new Account(Name = 'Nuevo ' + c.Numero_Cuenta_SAP__c);
                     a2.Numero_Cuenta_SAP__c = c.Numero_Cuenta_SAP__c; 
                    //c.AccountId = a2.Id;
                    nuevasCuentas.add(a2);
            }
        }
        insert nuevasCuentas;

        for(Contact c: Trigger.New){
            for(Account a: nuevasCuentas){
                if(c.Numero_Cuenta_SAP__c == a.Numero_Cuenta_SAP__c){
                    c.AccountId = a.Id;
                }
            }
        }
    }
    

}
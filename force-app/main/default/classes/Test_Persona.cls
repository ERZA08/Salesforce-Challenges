@isTest
public class Test_Persona {
    
    public static testmethod void test1(){
        
        Persona np = new Persona('Jorge',25,'H',0,80,1.75);
        Persona np2 = new Persona('Aldair',15,'H');
        Persona np3 = new Persona();
        
        Persona np4 = new Persona('Juan',15,'H',0,150,1.5);
         Persona np5 = new Persona('Alicia',45,'M',0,45,1.9);
        Persona np6 = new Persona('Alicia',45,'M',0,70,1.75);

        
        Test.startTest();
         np6.miMensaje(np6.calcularIMC());
        np.miMensaje(np.calcularIMC());
        np4.miMensaje( np4.calcularIMC());
        np.toString();
        np5.miMensaje( np5.calcularIMC());
        np5.comprobarSexo();
        np.comprobarSexo();
        np5.esMayorDeEdad();
        np4.esMayorDeEdad();
        Test.stopTest();
        
    }

}
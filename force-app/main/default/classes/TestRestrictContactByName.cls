@isTest
public class TestRestrictContactByName {
    //Crear una variable invalida para el apellido
    public static string invalidName1 = 'INVALIDNAME';

    //Metodo para verificar que atrape cualquier error o que pase el test
    @isTest static void testRestrictContactByNameFalse(){
        Contact nuevoContacto = new Contact(FirstName = 'Luis',LastName = invalidName1);//Creamos el contacto
        Test.startTest();//Iniciamos la prueba
    	Database.SaveResult result = Database.insert(nuevoContacto); //Insertamos el nuevo contacto en la base de datos y que nos devuelda el resultado
        Test.stopTest();//Paramos la prueba
        
        System.assert(!result.isSuccess());//Si fue posible insertar el nuevo contacto
        System.assert(result.getErrors().size() > 0);//No produjo ningun error
        System.assertEquals('The Last Name "'+invalidName1+'" is not allowed for DML',
                             result.getErrors()[0].getMessage());//TRajo el mensaje de error especificado en el trigger
    }

}
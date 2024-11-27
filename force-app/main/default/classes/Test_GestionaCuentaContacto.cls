@isTest
public class Test_GestionaCuentaContacto {
    
    public static testMethod void test1(){
        Test.startTest();
        PageReference pageRef = Page.GeneraCuentaContacto;
        Test.setCurrentPage(pageRef);
        
        GestionaCuentaController controller = new GestionaCuentaController();
        
        controller.nombreContacto = 'Mas';
         controller.apellidoContacto = 'fdfsdf';
         controller.emailContacto = 'esdfsd@sdfd.com';
         controller.telefonoContacto = 54562;
        controller.saveContact();
        
        controller.cuentaTest.name = 'Firstttt';
         controller.cuentaTest.accountnumber = '021554';
         controller.cuentaTest.rating = 'Hot';
         controller.cuentaTest.industry = 'Agricluture';
        controller.save();
        
        
        
        Test.stopTest();
    }
    
    public static testMethod void test2(){
        Account a = new Account(Name = 'Jose');
        insert a;
        
        Test.startTest();
        PageReference pageRef = Page.GeneraCuentaContacto;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',a.Id);
        GestionaCuentaController controller = new GestionaCuentaController();
        
        controller.nombreContacto = 'Mas';
         controller.apellidoContacto = 'fdfsdf';
         controller.emailContacto = 'esdfsd@sdfd.com';
         controller.telefonoContacto = 54562;
        controller.saveContact();
        
        controller.cuentaTest.name = 'Firstttt';
         controller.cuentaTest.accountnumber = '021554';
         controller.cuentaTest.rating = 'Hot';
         controller.cuentaTest.industry = 'Agricluture';
        controller.save();
        
        
        
        Test.stopTest();
    }
    
     public static testMethod void test3(){
        Test.startTest();
        PageReference pageRef = Page.GeneraCuentaContacto;
        Test.setCurrentPage(pageRef);
        
        GestionaCuentaController controller = new GestionaCuentaController();
        
        controller.nombreContacto = 'Mas';
         controller.apellidoContacto = 'fdfsdf';
         controller.emailContacto = 'esdfsd@sdfd.com';
         controller.telefonoContacto = 54562;

        
        controller.cuentaTest.name = 'Firstttt';
         controller.cuentaTest.accountnumber = '021554';
         controller.cuentaTest.rating = 'Hot';
         controller.cuentaTest.industry = 'Agricluture';
        controller.saveAll();
        
        
        
        Test.stopTest();
    }
    
     public static testMethod void test4(){
        Account a = new Account(Name = 'Jose');
        insert a;
        
        Test.startTest();
        PageReference pageRef = Page.GeneraCuentaContacto;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',a.Id);
        GestionaCuentaController controller = new GestionaCuentaController();
        
        controller.nombreContacto = 'Mas';
         controller.apellidoContacto = 'fdfsdf';
         controller.emailContacto = 'esdfsd@sdfd.com';
         controller.telefonoContacto = 54562;

        
        controller.cuentaTest.name = 'Firstttt';
         controller.cuentaTest.accountnumber = '021554';
         controller.cuentaTest.rating = 'Hot';
         controller.cuentaTest.industry = 'Agricluture';
        controller.saveAll();
        
        
        
        Test.stopTest();
    }

}
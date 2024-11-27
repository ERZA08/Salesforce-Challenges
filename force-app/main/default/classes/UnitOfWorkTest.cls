@isTest
public with sharing class UnitOfWorkTest {

    @isTest
    static void challengeComplete(){

        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        List<Note> noteList = new List<Note>();

         // Create a Unit Of Work
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );

        for(Integer i = 0; i<100; i++){
            
            Account acc = new Account();
            acc.Name = 'Test' + i;
            uow.registerNew(acc);
            
            for(Integer j = 0; j<5; j++){ 
            	Contact con = new Contact();
            	con.FirstName = 'Test' + j;
            	con.LastName = 'Test' + j;
            	uow.registerNew(con); 
            
            	Note noteRow = new Note();
            	noteRow.Title = 'Note ' + j;
            	uow.registerNew(noteRow,Note.ParentId, con);
        	}
        }
        uow.commitWork();

         // Create a Unit Of Work
        fflib_SObjectUnitOfWork uow2 = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Contact.SObjectType
            }
        );

       for(Contact con : [SELECT Id, AccountId, Phone FROM Contact LIMIT 10000]){
           if(con.Phone == null || con.Phone == ''){
               con.Phone = '123456789';
               uow2.registerDirty(con);
           }
       }

        Test.StartTest();
            uow2.commitWork();
        Test.StopTest();

        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }


}
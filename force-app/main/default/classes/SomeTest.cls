@isTest
private class SomeTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {
        List<Courses__c> coursesList = new List<Courses__c>();

        for(Integer i = 0; i < 12; i++){
        System.System.debug('List ' + i);
            Courses__c course = new Courses__c();
            course.Name = 'Course ' + i;
            coursesList.add(course);
        }
        System.System.debug('List ' + coursesList);
        Insert coursesList;

        Test.StartTest();
            SomeClass some = new SomeClass();
            // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
            String sch = '0 5 * * * ?';// Or '0 0 1 * 6 ? 2019'
            String jobID = System.schedule('Create Available Time records', sch, some);
            List<Available_Time__c> recordsExist = [SELECT Id FROM Available_Time__c];
            System.assertEquals(0, recordsExist.size(), 'Available Times exist before job has run');
        Test.StopTest();
            
        recordsExist = [SELECT Id FROM Available_Time__c];
        System.assertEquals(24, recordsExist.size(), 'Available Times exist before job has run');
    }
}
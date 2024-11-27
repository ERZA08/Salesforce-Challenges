@isTest 
public class TestVerifyDate {
	VerifyDate objecto = new VerifyDate();
    public static Date date1 = date.newInstance(2015, 12, 15);
    public static Date date2 = date.newInstance(2015, 12, 16);
    public static Date date3 = date.newInstance(2015, 12, 31);

    
    @isTest static void testCheckDates(){
       Date Fecha = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2,Fecha);
    }
    
    @isTest static void testCheckDatesFalse(){
       Date Fecha = VerifyDate.CheckDates(date.newInstance(2015, 10, 15), date.newInstance(2015, 12, 15));
        System.assertEquals(VerifyDate.SetEndOfMonthDate(date1),Fecha);
    }
    
    @isTest static void testDateWithin30Days(){
      Boolean verificaFecha = VerifyDate.DateWithin30Days(date1, date2);
        System.assertEquals(True,verificaFecha);
    }
    
    @isTest static void testSetEndOfMonthDate(){
        Date Fecha2 = VerifyDate.SetEndOfMonthDate(date1);
        System.assertEquals(date3, Fecha2);
    }
}
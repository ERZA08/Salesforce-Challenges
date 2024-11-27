@isTest
private class ParkLocatorTest  {
    
    @isTest static void test_method_one() {
        // Implement test code
        String[] theResult = new String[]{'Shiretoko National Park', 'Oze National Park', 'Hakusan National Park'};
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] result = ParkLocator.country('Japan');
        System.assertEquals(theResult,result);
    }
    
}
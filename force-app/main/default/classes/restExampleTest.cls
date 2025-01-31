/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 01-30-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   01-30-2025   Edgar Santillana   Initial Version
**/
@isTest
private class restExampleTest {

@isTest
    static void testDebugLog() {
        RestExample restExample = new RestExample();
        test.startTest();
        restExample.debugImage();
        test.stopTest();
       
    }
}
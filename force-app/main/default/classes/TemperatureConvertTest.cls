@isTest
public class TemperatureConvertTest {
	    @isTest static void testWarmTemp() {
        Decimal celsius = TemperatureConvert.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    
    @isTest static void testFreezingPoint() {
        Decimal celsius = TemperatureConvert.FahrenheitToCelsius(32);
        System.assertEquals(0,celsius);
    }

    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConvert.FahrenheitToCelsius(212);        
        System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
    } 
    
    @isTest static void testNegativeTemp() {
        Decimal celsius = TemperatureConvert.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }
}
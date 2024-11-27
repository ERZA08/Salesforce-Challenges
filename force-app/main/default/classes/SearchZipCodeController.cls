/**
 * @description       : Search Zip Code controller class
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 08-01-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   07-30-2024   Edgar Santillana   Initial Version
**/
public with sharing class SearchZipCodeController {

    Static Final String DOMAIN = 'https://api.zippopotam.us/';
    Static Final String ZIPCODE_NOT_FOUND = 'Zip Code Not Found';
    Static Final String ZIPCODE_FOUND = 'Zip Code Found';

    /**
    * @description Search Zip Code method for Screen Flow
    * @author Edgar Santillana | 08-01-2024 
    * @param zipCodes 
    * @return List<List<Location__c>> 
    **/
    @InvocableMethod(label='Search Zip Code' description='Search zip code details for multiple countries')
    public static List<List<Location__c>> searchZipCodeFlow(List<String> zipCodes) {

        List<String> countryCodes = new List<String>{'us', 'ca', 'de', 'fr', 'nl', 'ch', 'at', 'be', 'au', 'nz','mx'};
        List<Location__c> locationDetailsTempList = new List<Location__c>();
        List<List<Location__c>> locationDetailList =  new List<List<Location__c>>();

        String zipCode = zipCodes[0];

        for(String countryCode : countryCodes){

            String endpoint = DOMAIN + countryCode + '/' + zipCode;
            System.debug('URL: ' + endpoint);

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');

            try{
                HttpResponse response = http.send(request);
                if (response.getStatusCode() == 200) {
                    locationDetailsTempList.addAll(createLocationRecord(response.getBody()));
                }
            }catch(Exception e){
                System.debug('Error Line: ' + e.getLineNumber() +  ' -  Error Cause: ' + e.getCause());
                throw new AuraHandledException('Exception: ' + e.getMessage());
            }
        }

        if(locationDetailsTempList.size() > 0){
            Schema.DescribeSObjectResult locationDescribe = Schema.getGlobalDescribe().get('Location__c').getDescribe();
            List<Location__c> locationDetailsNONUSTempList = new List<Location__c>();

            for(Location__c locationDetails : locationDetailsTempList){
                if(!locationDetails.Country_Code__c.equals('US')){
                    locationDetailsNONUSTempList.add(locationDetails);
                }
            }
            
            if(locationDescribe.isCreateable()){
                System.enqueueJob(new LocationInsertQueueable(locationDetailsNONUSTempList));
                locationDetailList.add(locationDetailsTempList);
            }
        }


        if(locationDetailList.size() > 0){
            System.debug('Location List: ' + locationDetailList[0]);
            return locationDetailList;
        }else{
            return null;
        }
    }

    
    /**
    * @description Search Zip Code method for LWC
    * @author Edgar Santillana | 08-01-2024 
    * @param countryCode 
    * @param zipCode 
    * @return String 
    **/
    @AuraEnabled(cacheable=false)
    public static String searchZipCode(String countryCode, String zipCode) {

        String endpoint = DOMAIN + countryCode + '/' + zipCode;
        
        System.debug('URL: ' + endpoint);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        try {
            HttpResponse response = http.send(request);

            System.debug(response.getStatusCode());
            System.debug(response.getStatus());
            System.debug(response.getHeaderKeys());
            System.debug(response.getHeader('Content-Type'));
            System.debug(response.getBody());
            
            if (response.getStatusCode() == 200) {
                List<Location__c> locationDetailList = createLocationRecord(response.getBody());

                if(locationDetailList.size() > 0){
                    Schema.DescribeSObjectResult locationDescribe = Schema.getGlobalDescribe().get('Location__c').getDescribe();
                    
                    if(locationDescribe.isCreateable()){
                        System.enqueueJob(new LocationInsertQueueable(locationDetailList));
                    }
                }

                return response.getBody();
            } else if(response.getStatusCode() == 404){
                return null;
            }else {
                throw new AuraHandledException('Error: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error Line: ' + e.getLineNumber() +  ' -  Error Cause: ' + e.getCause());
            throw new AuraHandledException('Exception: ' + e.getMessage());
        }
    }

    /**
    * @description Help method to map http string body to Location object
    * @author Edgar Santillana | 08-01-2024 
    * @param responseBody 
    * @return List<Location__c> 
    **/
    private static List<Location__c> createLocationRecord( String responseBody ){
        
        List<Location__c> locationDetailList = new List<Location__c>();

        Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
        List<Object> places = (List<Object>) responseData.get('places');
        for (Object placeObj : places) {

            Map<String, Object> place = (Map<String, Object>) placeObj;
            Location__c tempLocation = new Location__c();

            tempLocation.Country__c = (String) responseData.get('country');
            tempLocation.Country_Code__c = (String) responseData.get('country abbreviation');
            tempLocation.State__c = place.containsKey( 'state') ? (String) place.get('state'): '';
            tempLocation.State_Code__c = (String) place.get('state abbreviation');
            tempLocation.Place_Name__c = (String) place.get('place name');
            tempLocation.Latitude__c = Decimal.valueOf((String) place.get('latitude'));
            tempLocation.Longitude__c = Decimal.valueOf((String) place.get('longitude'));
            tempLocation.Name = (String) responseData.get('country') + '-' + (String) place.get('place name');

            locationDetailList.add(tempLocation);
        }
        return locationDetailList;
    }
    
}
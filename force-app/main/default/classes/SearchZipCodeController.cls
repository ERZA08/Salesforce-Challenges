/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   07-30-2024   Edgar Santillana   Initial Version
**/
public with sharing class SearchZipCodeController {
    
    @AuraEnabled(cacheable=false)
    public static String searchZipCode(String countryCode, String zipCode) {

        String endpoint = 'https://api.zippopotam.us/' + countryCode + '/' + zipCode;
        
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

    private static List<Location__c> createLocationRecord( String responseBody ){
        
        List<Location__c> locationDetailList = new List<Location__c>();

        Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
        List<Object> places = (List<Object>) responseData.get('places');
        for (Object placeObj : places) {
            Map<String, Object> place = (Map<String, Object>) placeObj;
            Location__c tempLocation = new Location__c();
            if (Schema.sObjectType.Location__c.fields.Country__c.isCreateable()) {
                tempLocation.Country__c = (String) responseData.get('country');
            }
            tempLocation.Country_Code__c = (String) responseData.get('country abbreviation');
            tempLocation.State__c = (String) place.get('state');
            tempLocation.State_Code__c = (String) place.get('state abbreviation');
            tempLocation.Place_Name__c = (String) place.get('place name');
            tempLocation.Latitude__c = Decimal.valueOf((String) place.get('latitude'));
            tempLocation.Longitude__c = Decimal.valueOf((String) place.get('longitude'));
            tempLocation.Name = (String) responseData.get('country') + '-' + (String) place.get('place name');

            if(!tempLocation.Country_Code__c.equals('US')){
                locationDetailList.add(tempLocation);
            }
        }
        return locationDetailList;
    }
    
}
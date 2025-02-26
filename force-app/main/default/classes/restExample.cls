/**
 * @description       : Apex callout class to get a random image of a dog.
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-18-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   01-24-2025   Edgar Santillana   Initial Version
**/
@RestResource(urlMapping='/dogImage')
global with sharing class restExample {

    private final static String ENDPOINT = 'https://dog.ceo/api/breeds/image/random';
    private final static String ENDPOINTPOSTMAN = 'https://postman-echo.com/get';
    private static final String MESSAGE_KEY = 'message';

    @AuraEnabled
    public static String debugImage(){
        string imagedebug = doGet();
        system.debug('Image is from ' + imagedebug);
        return imagedebug;
    }

    /**
     * @description : Makes an HTTP GET request to fetch a random dog image.
     * @return      : A string containing the URL of the random dog image or an error message.
     */
    @HttpGet
    global static string doGet() {

        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        
        String imageString = (String) responseMap.get(MESSAGE_KEY);

        switch on res.getStatusCode() {
            when 200 {
                System.debug(imageString);
                return imageString;
            }
            when 404 {
                System.debug('Status code 404');
                return null;
            }
            when else {
                System.debug('Status code 500');
                return null;
            }
        }
    }

    public static void doGetPostman(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINTPOSTMAN);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
        } else {
            System.debug('Error: ' + response.getStatusCode());
        }

        System.debug('Current Time: ' + Limits.getCpuTime());
        System.debug('Limit Time: ' + Limits.getLimitCpuTime());
    }
}



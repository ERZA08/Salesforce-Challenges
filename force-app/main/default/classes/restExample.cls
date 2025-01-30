/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 01-24-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   01-24-2025   Edgar Santillana   Initial Version
**/
global with sharing class RestExample {

    private final static String ENDPOINT = 'https://dog.ceo/api/breeds/image/random';

    public void debugImage(){
        string imagedebug = doGat();
        system.debug('Image is from ' + imagedebug);
    }

    @HttpGet
    global static string doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String imageString = req.requestURI.substring(ENDPOINT);

        
        if(req.statis == 200){
            System.debug(imageString);
            return imageString;
        } else if(req.status == 404){
            throw new Exception(
                'Image not found');
        } else{
            throw new Exception(
                'Mesage'
            );
        }

        return imageString;
    }
}
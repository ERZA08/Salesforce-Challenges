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
import { LightningElement } from 'lwc';
import getDogImage from '@salesforce/apex/restExample.debugImage';

export default class RandomDogImage extends LightningElement {
    dogImageUrl;
    error;
    isButtonDisabled = false;

    connectedCallback() {

        this.getDogImage();
        setTimeout(() => {
            this.isButtonDisabled = false;
        }, 500);
    }

    getDogImage(){
        this.isButtonDisabled = true;
        getDogImage()
            .then(result => {
                this.dogImageUrl = result;
            })
            .catch(error => {
                this.error = error;
            });
        
    }

    handleClick(){
        
        this.getDogImage();
        setTimeout(() => {
            this.isButtonDisabled = false;
        }, 500);
    }
    
}
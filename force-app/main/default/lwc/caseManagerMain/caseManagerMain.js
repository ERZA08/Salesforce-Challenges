/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 03-20-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   03-20-2025   Edgar Santillana   Initial Version
**/
import { LightningElement, wire, api } from 'lwc';
import getOpenCases from '@salesforce/apex/CaseManagerController.getOpenCases';
import getCloseCases from '@salesforce/apex/CaseManagerController.getClosedCases';
import { showToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseManagerMain extends LightningElement {

    @api openCases;
    @api closeCases;

    @wire(getOpenCases) wireOpenCases;
    @wire(getCloseCases) wireClosedCases;

    showToast(title, message, variant){
        const event = new showToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

}
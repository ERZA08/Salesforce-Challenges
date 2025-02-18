/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-13-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-11-2025   Edgar Santillana   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountWithContactsController.getContacts';

export default class AccountWithContactsContactList extends LightningElement {

    @api contacts;
    @api accountId;

    // @wire(getContacts, {accountId: '$accountId'})
    // wiredContacts({error, data}) {
    //     if (data) {
    //         this.contacts = data;
    //     } else if (error) {
    //         console.error('AccountWithContactsContactList.wiredContacts', this.getErrorMessage(error));
    //     }
    // }

    connectedCallback() {
        console.log('AccountWithContactsContactList.connectedCallback', this.contacts);
        this.accountId = '0014100000ERlIaAAL';
    }

    getErrorMessage(error) {
        return error && error.body && error.body.message ? error.body.message : 'Unknown error';
    }
}




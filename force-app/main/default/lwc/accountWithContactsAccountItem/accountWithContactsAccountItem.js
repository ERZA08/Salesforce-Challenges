/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-13-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-13-2025   Edgar Santillana   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import getAccountWithContacts from '@salesforce/apex/AccountWithContactsController.getAccountWithContacts';

export default class AccountWithContactsAccountItem extends LightningElement {

    @api accountId;
    @api account;
    @api contacts;

    @wire(getAccountWithContacts, {accountId: '$accountId'})
    wiredAccount({error, data}) {
        if (data) {
            this.account = data[0];
            this.contacts = this.account.Contacts;
            console.log('Account: ', this.account);
            console.log('Contacts: ', this.contacts);
        } else if (error) {
            console.error('AccountWithContactsContactList.wiredContacts', this.getErrorMessage(error));
        }
    }

    connectedCallback() {
        console.log('AccountWithContactsAccountItem.connectedCallback');
        this.accountId = '0014100000ERlIaAAL';
    }
}
/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-14-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-14-2025   Edgar Santillana   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountWithContactsController.getAccounts';

export default class AccountWithContactAccountList extends LightningElement {

    @api accounts;

    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accounts = undefined;
        }
    }

    handleCardClick(event) {
        const accountId = event.currentTarget.dataset.id;
        console.log('accountId: ' + accountId);
        const selectedEvent = new CustomEvent('selectedevent', { detail: accountId });
        this.dispatchEvent(selectedEvent);
    }
}
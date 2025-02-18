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
import { LightningElement, api } from 'lwc';

export default class AccountWithContactMain extends LightningElement {
    
    @api selectedAccountId;

    handleAccountSelected(event) {
        console.log('AccountWithContactMain.handleAccountSelected', event.detail);
        this.selectedAccountId = event.detail;
    }
}
/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 02-11-2025
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   02-11-2025   Edgar Santillana   Initial Version
**/
import { LightningElement, api } from 'lwc';


export default class AccountWithContactsContactItem extends LightningElement {

    @api contact = {FirstName: 'First Name', LastName: 'Last Name', Title: 'Title', Phone: 'Phone', Email: 'Email'};

}
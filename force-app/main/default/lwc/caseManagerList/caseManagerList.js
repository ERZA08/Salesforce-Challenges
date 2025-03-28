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
import { LightningElement, api } from 'lwc';

export default class CaseManagerList extends LightningElement {

    @api caseList;

     // Returns the correct SLDS icon based on case status
     getStatusIcon(status) {
        switch (status) {
            case 'New': return 'utility:warning';
            case 'Working': return 'utility:sync';
            case 'Escalated': return 'utility:priority';
            case 'Closed': return 'utility:check';
            default: return 'utility:info';
        }
    }

    // Returns SLDS pill color class based on priority
    getPriorityClass(priority) {
        switch (priority) {
            case 'High': return 'slds-theme_error';  // Red
            case 'Medium': return 'slds-theme_warning';  // Orange
            case 'Low': return 'slds-theme_success';  // Green
            default: return 'slds-theme_info';  // Blue
        }
    }
    
}
/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 03-14-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   03-14-2024   Edgar Santillana   Initial Version
**/
import { LightningElement, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import getCustomObjectRecords from '@salesforce/apex/editableTableController.getCustomObjectRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; // Import ShowToastEvent


const columns = [
    { label: 'Nombre', fieldName: 'Name', type: 'text', editable: true },
    { label: 'Cuenta', fieldName: 'Account.Name', type: 'text' },
    { label: 'Etapa', fieldName: 'StageName', type: 'text', editable: true }
    // Agrega más columnas según los campos que desees mostrar y editar
];

export default class EditableTable extends LightningElement {

    data;
    error;
    columns = columns;
    draftValues = [];

    @wire(getCustomObjectRecords)
    wiredRecords(result) {
        this.wiredResult = result;
        if (result.data) {
            this.data = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }

    handleSave(event) {
        const recordInputs = event.detail.draftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput =>
            updateRecord(recordInput)
        );

        Promise.all(promises)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Registros actualizados',
                        variant: 'success'
                    })
                );
                // Refrescar los datos para mostrar los cambios actualizados
                return refreshApex(this.wiredResult);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error al actualizar registros',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            })
            .finally(() => {
                this.draftValues = [];
            });
    }
}
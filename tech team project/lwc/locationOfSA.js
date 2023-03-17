import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class LoadContact extends LightningElement {
    @api recordId;
    sadetail;
    errors;
    mapMarkers;

    @wire(getRecord, { recordId: '$recordId', fields: ['SA_Detail__c.Location__Latitude__s', 'SA_Detail__c.Location__Longitude__s'] })
        wiredRecord({ error, data }) {
            if (error) {
                this.errors = error;
                this.sadetail = undefined;
            } else if (data) {
                this.sadetail  = data;
                var latitude  = this.sadetail.fields.Location__Latitude__s.value;
                var longitude  = this.sadetail.fields.Location__Longitude__s.value;
                this.mapMarkers = [
                    {
                        location: {
                            Latitude: latitude,
                            Longitude: longitude,
                        },
                    },
                ];
            }
        }
}

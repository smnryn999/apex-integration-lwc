import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/SA_Detail__c.Name';
import LATITUDE from '@salesforce/schema/SA_Detail__c.Location__Latitude__s';
import LONGITUDE from '@salesforce/schema/SA_Detail__c.Location__Longitude__s';

export default class LocationOfSA extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, LATITUDE, LONGITUDE] }) sadetail;
    
    get name (){
        return getFieldValue(this.sadetail.data, NAME_FIELD);
    }
    get latitude (){
        return getFieldValue(this.sadetail.data, LATITUDE);
    }
    get longitude (){
        return getFieldValue(this.sadetail.data, LONGITUDE);
    }
   
    mapMarkers = [{
        location: {Latitude:this.latitude, Longitude:this.longitude},
        title: this.name
        }
    ];           
}

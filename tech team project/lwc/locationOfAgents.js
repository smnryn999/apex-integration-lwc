import { LightningElement, wire, track } from 'lwc';
import getSADetails from '@salesforce/apex/SADetails.getSADetails';

export default class LocationOfAgents extends LightningElement {
    @track mapMarkers;
    errors;

    @wire(getSADetails, {name:""})
    wiredLocations({ error, data }) {
        if (data) {
            this.mapMarkers = data.map((element) => {
                return {
                    location: {
                        Latitude: element.Location__Latitude__s,
                        Longitude: element.Location__Longitude__s
                    },
                    title: element.Name
                };
            });
            this.errors = undefined;
        } else if (error) {
            this.errors = error;
            this.mapMarkers = undefined;
        }
    }
}

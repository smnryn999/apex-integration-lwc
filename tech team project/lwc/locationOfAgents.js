import { LightningElement, wire } from 'lwc';
import getLocations from '@salesforce/apex/SADetails.getSADetails';

export default class LocationOfAgents extends LightningElement {
    mapMarkers;
    errors;

    @wire(getLocations)
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

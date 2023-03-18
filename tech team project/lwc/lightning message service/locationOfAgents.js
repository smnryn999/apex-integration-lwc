import { LightningElement, wire, track } from 'lwc';
import {subscribe, MessageContext} from "lightning/messageService";
import SA_CHANNEL from "@salesforce/messageChannel/SADataMessageChannel__c";

export default class LocationOfAgents extends LightningElement {
    @wire(MessageContext) messageContext;

    @track mapMarkers;
    errors;
    zoom = "1";
    subscription = null;

    connectedCallback() {
        if (this.subscription) {
          return;
        }
        this.subscription = subscribe(this.messageContext, SA_CHANNEL,
          (message) => {
            this.handleMessage(message);
          }
        );
      }


      handleMessage(message) {
        if (message) {
            this.mapMarkers = message.salesagents.map((element) => {
                return {
                    location: {
                        Latitude: element.Location__Latitude__s,
                        Longitude: element.Location__Longitude__s
                    },
                    title: element.Name
                };
            });
            this.errors = undefined;
        } else {
            this.errors = "Something went wrong.";
            this.mapMarkers = undefined;
        }
        this.mapMarkers.length==1 ? this.zoom = "8" : this.zoom = "1";
    }
}

import { LightningElement, wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getSADetails from "@salesforce/apex/SADetails.getSADetails";
import { publish, MessageContext } from "lightning/messageService";
import SA_CHANNEL from "@salesforce/messageChannel/SADataMessageChannel__c";

class TileSalesAgents extends NavigationMixin(LightningElement) {
    @wire(MessageContext) messageContext;
    
    searchTerm="";
    agents;

    filterSA(event){
        this.searchTerm = event.target.value;
    }
    @wire(getSADetails, {name:"$searchTerm"})
    wiredSADetails(result){
        this.agents = result;
        if (result.data) {
           const message = {
               salesagents: result.data
           };
           publish(this.messageContext, SA_CHANNEL, message);
        }
    };

    goToRecordPage(event){
        var recId = event.target.name;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recId,
                objectApiName: 'SA_Details__c',
                actionName: 'view',
            }
        });
    }
}

export default TileSalesAgents;

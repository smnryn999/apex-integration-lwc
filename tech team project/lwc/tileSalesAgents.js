import { LightningElement} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getSADetails from "@salesforce/apex/SADetails.getSADetails";

class TileSalesAgents extends NavigationMixin(LightningElement) {
    searchTerm;
    agents;
    errors;

    filterSA(event){
        this.searchTerm = event.target.value;

        getSADetails({name:this.searchTerm}).then(result => {
            this.agents=result;
            this.errors=undefined;
        }).catch(error => {
            this.agents=undefined;
            this.errors=error;
        });
    }

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
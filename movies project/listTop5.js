import { LightningElement, track, wire } from 'lwc';
import getSeries from '@salesforce/apex/GetWorksForLWC.getSeries';
import getMovies from '@salesforce/apex/GetWorksForLWC.getMovies';
import { NavigationMixin } from 'lightning/navigation';

export default class ListMovies extends NavigationMixin(LightningElement) {
  
    @wire(getSeries) series;
    @wire(getMovies) movies;

    goToTVShow(event){
        const recId = event.target.name;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recId,
                objectApiName: 'Series__c',
                actionName: 'view',
            },
        });
    }

    goToMovie(event){
        const recId = event.target.name;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recId,
                objectApiName: 'Movies__c',
                actionName: 'view',
            },
        });
    }
}

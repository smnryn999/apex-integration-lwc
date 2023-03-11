import { LightningElement, track, wire } from 'lwc';
import getSeries from '@salesforce/apex/GetWorksForLWC.getSeries';
import getMovies from '@salesforce/apex/GetWorksForLWC.getMovies';

export default class ListMovies extends LightningElement {
  
    @wire(getSeries) series;
    @wire(getMovies) movies;

}

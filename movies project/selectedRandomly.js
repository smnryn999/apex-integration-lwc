import { LightningElement, track } from 'lwc';
import getShowRandomly from "@salesforce/apex/GetWorksForLWC.getShowRandomly";
import getMovieRandomly from "@salesforce/apex/GetWorksForLWC.getMovieRandomly";

export default class SelectRandomly extends LightningElement {
    @track tvShow;
    @track errors;
    getTVShow(){
        getShowRandomly().then(result=>this.tvShow = result).catch(error=>this.errors=error);
    }

    @track movie;
    @track errores;
    getMovie(){
        getMovieRandomly().then(result=>this.movie = result).catch(error=>this.errores=error);
    }
}

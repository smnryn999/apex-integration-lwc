import { LightningElement } from 'lwc';
import insertTheMovie from "@salesforce/apex/GetMovies.insertTheMovie";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HomePage extends LightningElement {

    movieName = "";
    getMovieName(event){
        this.movieName = event.target.value;
    }

    saveMovie(){
        alert(this.movieName);
        insertTheMovie({mName:this.movieName})
        .then(()=>{
            const event = new ShowToastEvent({
                title: 'Success',
                message: this.movieName + ' has been created successfully.',
                variant: "success"
            });
            this.dispatchEvent(event);
        })
        .catch(()=>{
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'There is a problem.',
                variant: "error"
            });
            this.dispatchEvent(event);
        });
    }
}

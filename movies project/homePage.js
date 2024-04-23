import { LightningElement } from 'lwc';
import insertTheMovie from "@salesforce/apex/GetMovies.insertTheMovie";
import insertTheSeries from "@salesforce/apex/GetMovies.insertTheSeries";
import insertBook from "@salesforce/apex/GetBooks.getBook";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HomePage extends LightningElement {

    movieName = "";
    showName = "";
    bookName = "";
    authorName = "";

    // Movie
    getMovieName(event){
        this.movieName = event.target.value;
    }

    saveMovie(){
        console.log(this.movieName);
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

    // TV Show
    getTVShowName(event){
        this.showName = event.target.value;
    }

    saveTVShow(){
        console.log(this.showName);
        insertTheSeries({sName:this.showName})
        .then(()=>{
            const event = new ShowToastEvent({
                title: 'Success',
                message: this.showName + ' has been created successfully.',
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

    // Book
    getBookName(event){
        this.bookName = event.target.value;
    }
    getAuthorName(event){
        this.authorName = event.target.value;
    }

    saveBook(){
        console.log(this.bookName);
        insertBook({bookName: this.bookName, authorName: this.authorName})
        .then(()=>{
            const event = new ShowToastEvent({
                title: 'Success',
                message: this.bookName + ' has been created successfully.',
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

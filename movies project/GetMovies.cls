public class GetMovies {
   
    @AuraEnabled
    public static Series__c insertTheSeries(string sName){
        List<string> listContent = httpHandle(sName);
        
        Date releasedDate = listContent[2] != null ? Date.parse(listContent[2]) : null;
        decimal imdbRatingVal = Decimal.valueOf(listContent[5]);
            
        Series__c theSeries = new Series__c(Name=listContent[0], Genre__c=listContent[1], Released__c = releasedDate, Year__c = listContent[3], Writer__c = listContent[4], IMDB_Rating__c = imdbRatingVal, Actors__c = listContent[6], Story__c = listContent[7], Director__c = listContent[8]);
        insert theSeries;
        return theSeries;
    }
    
    @AuraEnabled
    public static Movies__c insertTheMovie(string mName){
        
        List<string> listContent = httpHandle(mName);
        
        Date releasedDate = listContent[2] != null ? Date.parse(listContent[2]) : null;
        decimal imdbRatingVal = Decimal.valueOf(listContent[5]);
            
        Movies__c theMovie = new Movies__c(Name=listContent[0], Genre__c=listContent[1], Released__c = releasedDate, Writer__c = listContent[4], IMDB_Rating__c = imdbRatingVal, Actors__c = listContent[6], Story__c = listContent[7], Director__c = listContent[8]);
        insert theMovie;
        return theMovie;
    }

    @future(callout = true)
    public static void updateTheSeries(string sName){
        
        List<string> listContent = httpHandle(sName);
        
        Date releasedDate = listContent[2] != null ? Date.parse(listContent[2]) : null;
        decimal imdbRatingVal = Decimal.valueOf(listContent[5]);
        
        Series__c theSeries = [SELECT Name, Genre__c, Released__c, Year__c, Writer__c, IMDB_Rating__c, Actors__c, Story__c, Director__c FROM Series__c WHERE Name = :sName];
        theSeries.Genre__c = listContent[1];
        theSeries.Released__c = releasedDate;
        theSeries.Year__c = listContent[3];
        theSeries.Writer__c = listContent[4];
        theSeries.IMDB_Rating__c = imdbRatingVal;
        theSeries.Actors__c = listContent[6];
        theSeries.Story__c = listContent[7];
        theSeries.Director__c = listContent[8];
        update theSeries;    
    }
    
    @future(callout = true)
    public static void updateTheMovie(string mName){
        
        List<string> listContent = httpHandle(mName);
        
        Date releasedDate = listContent[2] != null ? Date.parse(listContent[2]) : null;
        decimal imdbRatingVal = Decimal.valueOf(listContent[5]);
        
        Movies__c theMovie = [SELECT Name, Genre__c, Released__c, Writer__c, IMDB_Rating__c, Actors__c, Story__c, Director__c FROM Movies__c WHERE Name = :mName];
        theMovie.Genre__c = listContent[1];
        theMovie.Released__c = releasedDate;
        theMovie.Writer__c = listContent[4];
        theMovie.IMDB_Rating__c = imdbRatingVal;
        theMovie.Actors__c = listContent[6];
        theMovie.Story__c = listContent[7];
        theMovie.Director__c = listContent[8];
        update theMovie;
    }
    
    private static List<string> httpHandle(string movieName){
        movieName = movieName.replaceAll(' ', '+');
        movieName = movieName.replaceAll('&', '%26');
        string apikey;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.omdbapi.com/?apikey='+apikey+'&t='+movieName+'&plot=full');
        request.setMethod('GET');
        request.setTimeout(500);
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode()+' and '+response.getBody());
        
        Map<string,object> theMovie =(Map<string,object>) JSON.deserializeuntyped(response.getBody());
        
        string title = (string)theMovie.get('Title');
        string genre = (string)theMovie.get('Genre');
        genre = genre.replaceAll(',', ';');
        
        string released = (string)theMovie.get('Released'); // "10 Oct 2012"
        string day = released.substring(0,2);
        string year = released.substringAfterLast(' ');
        string month = released.substringBetween(' ', ' ');
        switch on month {
            when 'Jan' {month='01';}
            when 'Feb' {month='02';}
            when 'Mar' {month='03';}
            when 'Apr' {month='04';}
            when 'May' {month='05';}
            when 'Jun' {month='06';}
            when 'Jul' {month='07';}
            when 'Aug' {month='08';}
            when 'Sep' {month='09';}
            when 'Oct' {month='10';}
            when 'Nov' {month='11';}
            when 'Dec' {month='12';}            
        }
        released = released == 'N/A' ? null : (day + '/' + month + '/' + year);
                
        string yearAll = (string)theMovie.get('Year');
        string writer = (string)theMovie.get('Writer');
        string imdbRating = (string)theMovie.get('imdbRating');
    
        string actors = (string)theMovie.get('Actors');
        string story = (string)theMovie.get('Plot');
        string director = (string)theMovie.get('Director');
        
        List<string> listContent = new List<string>{title, genre, released, yearAll, writer, imdbRating, actors, story, director};
        return listContent;
    }
}

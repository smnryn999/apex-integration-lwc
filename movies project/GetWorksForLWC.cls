public with sharing class GetWorksForLWC {
    @AuraEnabled(cacheable=true)
    public static list<series__c> getSeries(){
        list<series__c> liste = [SELECT Name, Genre__c, Released__c, Year__c, Writer__c, Actors__c, IMDB_Rating__c FROM Series__c ORDER BY IMDB_Rating__c DESC LIMIT 5];
        return liste;
    }

    @AuraEnabled(cacheable=true)
    public static list<movies__c> getMovies(){
        list<movies__c> liste = [SELECT Name, Genre__c, Released__c, Writer__c, Actors__c, IMDB_Rating__c FROM Movies__c ORDER BY IMDB_Rating__c DESC LIMIT 5];
        return liste;
    }
    
    @AuraEnabled
    public static Series__c getShowRandomly(){
        Integer count = [SELECT Count() FROM Series__c];
        Integer randomNum = Integer.valueOf(Math.random()*count);
        Series__c theShow = [SELECT Name, Genre__c, Released__c, Year__c, Writer__c, Actors__c, Story__c, IMDB_Rating__c FROM Series__c LIMIT 1 OFFSET :randomNum];
        
        return theShow;
    }
    
    @AuraEnabled
    public static Movies__c getMovieRandomly(){
        Integer count = [SELECT Count() FROM Movies__c];
        Integer randomNum = Integer.valueOf(Math.random()*count);
        Movies__c theMovie = [SELECT Name, Genre__c, Released__c, Writer__c, Actors__c, Story__c, IMDB_Rating__c FROM Movies__c LIMIT 1 OFFSET :randomNum];
        
        return theMovie;
    }
}

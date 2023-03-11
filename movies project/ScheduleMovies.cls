public class ScheduleMovies implements Schedulable {
    public void execute(SchedulableContext context){
        List<Series__c> listShows = [SELECT Id, Name FROM Series__c];
        for(Series__c show:listShows){
            try{GetMovies.updateTheSeries(show.Name);}
            catch(Exception e){System.debug(e.getMessage());}
        }
        
        List<Movies__c> listMovies = [SELECT Id, Name FROM Movies__c];
        for(Movies__c movie:listMovies){
            try{GetMovies.updateTheMovie(movie.Name);}
            catch(Exception e){System.debug(e.getMessage());}
        }
    }
}

 /*
  ScheduleMovies sm = new ScheduleMovies();
  System.schedule('Schedule Works', '0 0 08 1 * ? 2023', sm);
  */

public class GetBooks {
    public static void getBook(String bookName){
        
        bookName = bookName.replaceAll(' ', '+');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://openlibrary.org/search.json?title='+bookName);
        request.setMethod('GET');
        request.setHeader('content-type', 'application/json');
        // request.setHeader('authorization', 'apikey 5pROSPdgIHzaTswgHHsxB9:2r8guwZh9i9FZp34Z61k9Y');
        HttpResponse response = http.send(request);
        // System.debug(response.getStatusCode() + ' and ' + response.getBody());
        
        Map<string,object> theBook =(Map<string,object>) JSON.deserializeuntyped(response.getBody());
               
        List<Object> documentsList = (List<Object>)theBook.get('docs');
        Map<String, Object> documentsMap = (Map<String, Object>)documentsList[0];
        
        String title = (String)documentsMap.get('title');
        Object[] author = (Object[])documentsMap.get('author_name');
        String first_publish_year = String.valueOf(documentsMap.get('first_publish_year'));
        Object[] publishDate = (Object[])documentsMap.get('publish_date');
        Object[] language = (Object[])documentsMap.get('language');
        Object[] persons = (Object[])documentsMap.get('person');
        Object[] timeOfStory = (Object[])documentsMap.get('time');
        Integer number_of_pages = (Integer)documentsMap.get('number_of_pages_median');
        Decimal rating = (Decimal)documentsMap.get('ratings_average');
       
        System.debug(title+', '+author[0]+', '+publishDate[0] + ', '+ first_publish_year);
        System.debug(language); 
        System.debug(persons);  
        System.debug(timeOfStory); 
        System.debug(number_of_pages + ', ' + rating); 
        
        String textPersons='';
        if(persons != null){
            for(Object p:persons){
                textPersons += (String)p + ', ';
            }
        }
        
        String textTime='';
        if(timeOfStory != null){
            for(Object t:timeOfStory){
                textTime += (String)t;
            }
        }
        
        Book__c book = new Book__c();
        book.Name = title;
        book.Author__c = (String)author[0];
        book.First_Publish_Year__c = first_publish_year;
        book.Language__c = language != null ? (String)language[0] : null;
        book.Fictitious_Characters__c = textPersons.substringBeforeLast(',');
        book.When_the_Story_Takes_Place__c = textTime;
        book.Number_Of_Pages__c = number_of_pages;
        book.Rating__c = rating;
        insert book;
    }
}

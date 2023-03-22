public with sharing class SADetails {
    @AuraEnabled(cacheable = true)
    public static List<SA_Detail__c> getSADetails(String name){
        return [SELECT Name, Customer_Handled__c, Experience__c, Date_of_Joining__c, Location__c, Location__Longitude__s, Location__Latitude__s
                FROM SA_Detail__c WHERE Name LIKE :'%'+name+'%' ORDER BY CreatedDate DESC LIMIT 6];
    }
}

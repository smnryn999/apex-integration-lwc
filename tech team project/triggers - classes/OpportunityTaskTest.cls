@isTest
private class OpportunityTaskTest {
    @testSetup static void builtData(){
        Account acc = new Account(Name='New Account');
        insert acc;
        
        List<Opportunity> listOpp = new List<Opportunity>();
        for(integer i=0; i<50; i++){
            Opportunity opp = new Opportunity(Name='New Opp'+i, StageName='Prospecting', CloseDate=Date.today(), AccountId=acc.id);
            listOpp.add(opp);
        }
        insert listOpp;
        
        for(Opportunity opp:listOpp){
            opp.StageName = 'Closed Won';
        }
        update listOpp;
    }
    
    @isTest static void test(){
        System.assertEquals(50, [SELECT Count() FROM Task WHERE Subject = 'Follow up Task']);
        Task task = [SELECT ActivityDate, WhatId FROM Task LIMIT 1];
        System.assert(task.ActivityDate == Date.today().addMonths(1));
        System.assert(task.WhatId != null);
    }
}

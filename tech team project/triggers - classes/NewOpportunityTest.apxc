@isTest
public class NewOpportunityTest {
    @testSetup
    public static void buildRecords(){
        List<Account> listAcc = new List<Account>();
        List<Opportunity> listOpp = new List<Opportunity>();
        for(integer i=0; i<50; i++){
            Account acc = new Account(Name='Test'+i);
            listAcc.add(acc);
        }
        insert listAcc;        
        
        Opportunity opp = new Opportunity(Name='Test', CloseDate=Date.today(),
                                          StageName='Prospecting', AccountId=listAcc[0].id);
        insert opp;
        
        update listAcc;  
    }
    @isTest
    public static void test(){
        Opportunity opp = [SELECT CloseDate, StageName FROM Opportunity WHERE Name LIKE '%Opportunity' LIMIT 1];
        System.assert(opp.StageName == 'Prospecting');
        System.assert(opp.CloseDate == Date.today().addMonths(1));
        System.assertEquals(50, [SELECT Count() FROM Opportunity WHERE Name LIKE '%Opportunity']);
        System.assertEquals(51, [SELECT Count() FROM Opportunity]);
    }
}

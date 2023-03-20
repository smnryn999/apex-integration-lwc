@isTest
private class LeadSourceBatchTest {
    @testSetup
    static void buildData(){
        List<Lead> listLead = new List<Lead>();
        for(integer i=0; i<150; i++){
            Lead lead = new Lead(LastName='Test Lead', Company='Test Company');
            listLead.add(lead);
        }
        insert listLead;
    }
    @isTest
    static void test(){
        LeadSourceBatch lsb = new LeadSourceBatch();
        test.startTest();
        Database.executeBatch(lsb);
        System.schedule('Test Schedulable', '0 0 23 * * ? 2023', lsb);
        test.stopTest();
        System.assertEquals(150, [SELECT Count() FROM Lead WHERE LeadSource = 'Manual'], 'There is an error.');
    }
}

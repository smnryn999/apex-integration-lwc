@isTest
private class ActiveContactsTest {    
    @testSetup
    static void builtRecords(){
        List<Account> listAcc = new List<Account>();
        for(integer i=1; i<=50; i++){
            Account acc = new Account(Name = 'Test Account '+i);
            listAcc.add(acc);
        }
        insert listAcc;
        
        List<Contact> listCon = new List<Contact>();
        for(Account acc:listAcc){
            for(integer i=0; i<2; i++){
                Contact con = new Contact(LastName='Active Contact '+i, Active__c=true, AccountId=acc.id);
                listCon.add(con);
            }
        }
        for(Account acc:listAcc){
            Contact con = new Contact(LastName='Passive Contact', Active__c=false, AccountId=acc.id);
            listCon.add(con);
        }        
        insert listCon;
    }
    
    @isTest
    static void test(){
        System.assertEquals(50, [SELECT Count() FROM Account WHERE Active_Contacts__c=2]);
        System.assertEquals(150, [SELECT Count() FROM Contact]);
        Account acc = [SELECT Id, (SELECT id FROM Contacts WHERE Active__c=true) FROM Account LIMIT 1];
        delete acc.Contacts;
        System.assertEquals(49, [SELECT Count() FROM Account WHERE Active_Contacts__c=2]);
    }
}

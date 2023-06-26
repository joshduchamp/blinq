@IsTest
public class BlinqTest {
    @IsTest
    static void testToList() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).toList();
        Test.stopTest();

        Assert.areEqual(2, myLst.size());
    }

    @IsTest
    static void testToStringSet() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Wayne') };

        Test.startTest();
        Set<String> mySet = Blinq.my(lst).toStringSet('LastName');
        Test.stopTest();

        Assert.areEqual(1, mySet.size());
        Assert.isTrue(mySet.contains('Wayne'));
    }

    @IsTest
    static void testToIdSet() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN'),
            new Contact(Id = '0035300000H2LFiAAN')
        };

        Test.startTest();
        Set<Id> mySet = Blinq.my(lst).toIdSet();
        Test.stopTest();

        Assert.areEqual(2, mySet.size());
        Assert.isTrue(mySet.contains('0035300000H2LFiAAN'));
    }

    @IsTest
    static void testToIdSetOn() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP') };

        Test.startTest();
        Set<Id> mySet = Blinq.my(lst).toIdSetOn('AccountId');
        Test.stopTest();

        Assert.areEqual(1, mySet.size());
        Assert.isTrue(mySet.contains('0015300000PFOIaAAP'));
    }

    @IsTest
    static void testToStringMapOn() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Wayne') };

        Test.startTest();
        Map<String, SObject> myMap = Blinq.my(lst).toStringMapOn('LastName');
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('Wayne'));
    }

    @IsTest
    static void testToStringMapListOn() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Wayne') };

        Test.startTest();
        Map<String, List<SObject>> myMap = Blinq.my(lst).toStringMapListOn('LastName');
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('Wayne'));
        Assert.areEqual(2, myMap.get('Wayne').size());
    }

    @IsTest
    static void testToIdMap() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN'),
            new Contact(Id = '0035300000H2LFiAAN')
        };

        Test.startTest();
        Map<Id, SObject> myMap = Blinq.my(lst).toIdMap();
        Test.stopTest();

        Assert.areEqual(2, myMap.size());
        Assert.isTrue(myMap.containsKey('0035300000H2LFdAAN'));
    }

    @IsTest
    static void testToIdMapOn() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP') };

        Test.startTest();
        Map<Id, SObject> myMap = Blinq.my(lst).toIdMapOn('AccountId');
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('0015300000PFOIaAAP'));
    }

    @IsTest
    static void testToIdMapListOn() {
        List<Contact> lst = new List<Contact>{
            new Contact(AccountId = '0015300000PFOIaAAP'),
            new Contact(AccountId = '0015300000PFOIaAAP')
        };

        Test.startTest();
        Map<Id, List<SObject>> myMap = Blinq.my(lst).toIdMapListOn('AccountId');
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('0015300000PFOIaAAP'));
        Assert.areEqual(2, myMap.get('0015300000PFOIaAAP').size());
    }

    @IsTest
    static void testFilterOnEquals() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').equals('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnIsNull() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP'), new Contact() };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('AccountId').equals(null).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual(null, myLst[0].AccountId);
    }

    @IsTest
    static void testFilterOnNotEquals() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').notEquals('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnIsNotNull() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP'), new Contact() };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('AccountId').notEquals(null).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('0015300000PFOIaAAP', myLst[0].AccountId);
    }

    @IsTest
    static void testFilterOnGreaterThanString() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').greaterThan('Lane').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnGreaterThanDate() {
        List<Contact> lst = new List<Contact>{
            new Contact(Birthdate = Date.today().addYears(-50)),
            new Contact(Birthdate = Date.today().addYears(-20))
        };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('Birthdate').greaterThan(Date.today().addYears(-30)).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual(Date.today().addYears(-20), myLst[0].Birthdate);
    }

    @IsTest
    static void testFilterOnGreaterThanNumber() {
        List<Contact> lst = new List<Contact>{
            new Contact(MailingLongitude = 100),
            new Contact(MailingLongitude = 500)
        };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('MailingLongitude').greaterThan(300).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual(500, myLst[0].MailingLongitude);
    }

    @IsTest
    static void testFilterOnGreaterThanOrEqualTo() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').greaterThanOrEqualTo('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnLessThan() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').lessThan('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnLessThanOrEqualTo() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn('LastName').lessThanOrEqualTo('Lane').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testJoinAndCompare() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne'),
            new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane')
        };
        Map<Id,Contact> oldMap = new Map<Id,Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).leftJoin(oldMap, 'old').filterOn('LastName').notEquals('old', 'LastName').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testAny() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne'),
            new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane')
        };
        Map<Id,Contact> oldMap = new Map<Id,Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn('FirstName').notEquals('old', 'FirstName')
            .filterOn('LastName').notEquals('old', 'LastName')
            .any()
            .toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testAll() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne'),
            new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane')
        };
        Map<Id,Contact> oldMap = new Map<Id,Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn('FirstName').Equals('old', 'FirstName')
            .filterOn('LastName').Equals('old', 'LastName')
            .all()
            .toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }
}

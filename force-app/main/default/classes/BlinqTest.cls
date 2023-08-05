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
        Set<String> mySet = Blinq.my(lst).toStringSetOn(Contact.LastName);
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
        Set<Id> mySet = Blinq.my(lst).toIdSetOn(Contact.AccountId);
        Test.stopTest();

        Assert.areEqual(1, mySet.size());
        Assert.isTrue(mySet.contains('0015300000PFOIaAAP'));
    }

    @IsTest
    static void testToStringMapOn() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Wayne') };

        Test.startTest();
        Map<String, SObject> myMap = Blinq.my(lst).toStringMapOn(Contact.LastName);
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('Wayne'));
    }

    @IsTest
    static void testToStringMapListOn() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Wayne') };

        Test.startTest();
        Map<String, List<SObject>> myMap = Blinq.my(lst).toStringMapListOn(Contact.LastName);
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
        Map<Id, SObject> myMap = Blinq.my(lst).toIdMapOn(Contact.AccountId);
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
        Map<Id, List<SObject>> myMap = Blinq.my(lst).toIdMapListOn(Contact.AccountId);
        Test.stopTest();

        Assert.areEqual(1, myMap.size());
        Assert.isTrue(myMap.containsKey('0015300000PFOIaAAP'));
        Assert.areEqual(2, myMap.get('0015300000PFOIaAAP').size());
    }

    @IsTest
    static void testFilterOnEquals() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).equals('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnIsNull() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP'), new Contact() };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.AccountId).equals(null).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual(null, myLst[0].AccountId);
    }

    @IsTest
    static void testFilterOnNotEquals() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).notEquals('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnIsNotNull() {
        List<Contact> lst = new List<Contact>{ new Contact(AccountId = '0015300000PFOIaAAP'), new Contact() };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.AccountId).notEquals(null).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('0015300000PFOIaAAP', myLst[0].AccountId);
    }

    @IsTest
    static void testFilterOnGreaterThanString() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).greaterThan('Lane').toList();
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
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.Birthdate).greaterThan(Date.today().addYears(-30)).toList();
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
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.MailingLongitude).greaterThan(300).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual(500, myLst[0].MailingLongitude);
    }

    @IsTest
    static void testFilterOnGreaterThanOrEqualTo() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).greaterThanOrEqualTo('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnLessThan() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).lessThan('Wayne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testFilterOnLessThanOrEqualTo() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).lessThanOrEqualTo('Lane').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testStartsWith() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).startsWith('Way').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testEndsWith() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).endsWith('ne').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(2, myLst.size());
    }

    @IsTest
    static void testContains() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).contains('ayn').toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testIsIn() {
        List<Contact> lst = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.LastName).isIn(new List<String>{ 'Wayne', 'Lane' }).toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(2, myLst.size());
    }

    @IsTest
    static void testIsNull() {
        List<Contact> lst = new List<Contact>{ new Contact(FirstName = null, LastName = 'Wayne'), new Contact(FirstName = 'Lois', LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.FirstName).isNull().toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testIsNotNull() {
        List<Contact> lst = new List<Contact>{ new Contact(FirstName = null, LastName = 'Wayne'), new Contact(FirstName = 'Lois', LastName = 'Lane') };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).filterOn(Contact.FirstName).isNotNull().toList();
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
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn('LastName')
            .notEquals('old', 'LastName')
            .toList();
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
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn(Contact.FirstName)
            .notEquals('old', Contact.FirstName)
            .filterOn(Contact.LastName)
            .notEquals('old', Contact.LastName)
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
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn(Contact.FirstName)
            .Equals('old', Contact.FirstName)
            .filterOn(Contact.LastName)
            .Equals('old', Contact.LastName)
            .all()
            .toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testCustomLogic() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne', AccountId = '0015300000PFOIaAAP'),
            new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane', AccountId = '0015300000PFOIaAAP')
        };
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));
        oldMap.put('0035300000H2LFiAAN', new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn(Contact.AccountId).equals('0015300000PFOIaAAP')
            .filterOn(Contact.LastName).equals('Lane')
            .customLogic('1 AND NOT 2')
            .toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Wayne', myLst[0].LastName);
    }

    @IsTest
    static void testNestedValues() {
        Account acctObj = new Account(Name = 'ACME');
        List<Contact> contacts = new List<Contact>{ new Contact(Account = acctObj) };

        Test.startTest();
        Set<String> accountNames = Blinq.my(contacts).toStringSetOn('Account.Name');
        Test.stopTest();

        Assert.isTrue(accountNames.contains('ACME'));
    }

    @IsTest
    static void testFirst() {
        List<Contact> contacts = new List<Contact>{ new Contact(LastName = 'Wayne'), new Contact(LastName = 'Lane')};

        Test.startTest();
        Contact conObj = (Contact)Blinq.my(contacts).first();
        Test.stopTest();

        Assert.areEqual('Wayne', conObj.LastName);
    }

    @IsTest
    static void testFirstNull() {
        List<Contact> contacts = new List<Contact>();

        Test.startTest();
        Contact conObj = (Contact)Blinq.my(contacts).first();
        Test.stopTest();

        Assert.isNull(conObj);
    }

    @IsTest
    static void testLastNull() {
        List<Contact> contacts = new List<Contact>();

        Test.startTest();
        Contact conObj = (Contact)Blinq.my(contacts).last();
        Test.stopTest();

        Assert.isNull(conObj);
    }

    @IsTest
    static void testFilterOnAlias() {
        List<Contact> lst = new List<Contact>{
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne'),
            new Contact(Id = '0035300000H2LFiAAN', LastName = 'Lane')
        };
        Map<Id, Contact> oldMap = new Map<Id, Contact>();
        oldMap.put('0035300000H2LFdAAN', new Contact(Id = '0035300000H2LFdAAN', LastName = 'notWayne'));

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst)
            .leftJoin(oldMap, 'old')
            .filterOn('old', Contact.Id)
            .Equals(null)
            .toList();
        Test.stopTest();

        Assert.areEqual(2, lst.size());
        Assert.areEqual(1, myLst.size());
        Assert.areEqual('Lane', myLst[0].LastName);
    }

    @IsTest
    static void testSetValue() {
        List<Contact> lst = new List<Contact> {
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne')
        };

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).setValue(Contact.FirstName, 'Bruce').toList();
        Test.stopTest();

        Assert.areEqual('Bruce', myLst[0].FirstName);
    }

    @IsTest
    static void testSetSObject() {
        List<Contact> lst = new List<Contact> {
            new Contact(Id = '0035300000H2LFdAAN', LastName = 'Wayne')
        };
        Account acct = new Account(Name = 'Test Account');

        Test.startTest();
        List<Contact> myLst = Blinq.my(lst).setSObject(Contact.AccountId, acct).toList();
        Test.stopTest();

        Assert.isNotNull(myLst[0].Account);
    }
}
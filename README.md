# Blinq Apex Collection Library

Blinq is library in apex loosely modeled after C#'s Linq library to be able to easily manipulate collections of sobjects.

A predominent part of apex is bulk processing collections of data. This can result in a lot of code around looping lists to build maps and sets. This library aims to make those operations easier and more readable. 

## Installation

Clone this repository to get the Blinq library and deploy it to your org.

Or download in prod from https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480pXQAQ

Or download in sandbox from https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480pXQAQ

## Examples

```apex
// create a set of ids from a list of contacts
Set<Id> contactIds = Blinq.my(contacts).toIdSet();

// create a set of account ids from a list of contacts
Set<Id> accountIds = Blinq.my(contacts).toIdSetOn(Contact.AccountId);

// filter on contacts with an account
List<Contact> filtered = Blinq.my(contacts).filterOn(Contact.AccountId).notEquals(null).toList();

// get a set of account names
List<String> accountNames = Blinq.my(contacts).toStringSetOn('Account.Name');

// create a map of contacts on account id
Map<Id,List<SObject>> myMap = Blinq.my(contacts).toIdMapListOn(Contact.AccountId);

// filter on contacts over 21 and return in a map
Date dt = Date.today().addYears(-21);
Map<Id,SObject> over21 = Blinq.my(contacts).filterOn(Contact.Birthdate).lessThanOrEqualTo(dt).toIdMap();

// filter on contacts whose first or last name changed
List<Contact> filtered = Blinq.my(contacts)
    .leftJoin(oldMap, 'old')
    .filterOn(Contact.FirstName).notEqualTo('old', Contact.FirstName)
    .filterOn(Contact.LastName).notEqualTo('old', Contact.LastName)
    .any()
    .toList();

// filter on new contacts or contacts whose name changed and has no account id
List<Contact> filtered = Blinq.my(contacts)
    .leftJoin(oldMap, 'old)
    .filterOn('old', Contact.Id).isNull()
    .filterOn(Contact.LastName).notEqualTo('old', Contact.LastName)
    .filterOn(Contact.AccountId).isNull()
    .customLogic('1 OR (2 AND 3)')
    .toList();

// Set values and sobjects in a collection
Account acct = [SELECT Id FROM Account LIMIT 1];
List<Contact> myLst = Blinq.my(contacts)
    .setValue(Contact.AccountId, acct.Id)
    .setSObject(Contact.AccountId, acct)
    .toList();
```
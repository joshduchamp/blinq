# Blinq Apex Collection Library

Blinq is library in apex loosely modeled after C#'s Linq library to be able to easily manipulate collections of sobjects.

A predominent part of apex is bulk processing collections of data. This can result in a lot of code around looping lists to build maps and sets. This library aims to make those operations easier and more readable. 

## Installation

Clone this repository to get the Blinq library and deploy it to your org.

Or download in prod from https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480nCQAQ 

Or download in sandbox from https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5G00000480nCQAQ 

## Examples

```apex
// create a set of ids from a list of contacts
Set<Id> contactIds = Blinq.my(contacts).toIdSet();

// create a set of account ids from a list of contacts
Set<Id> accountIds = Blinq.my(contacts).toIdSetOn('AccountId');

// filter on contacts with an account
List<Contact> filtered = Blinq.my(contacts).filterOn('AccountId').notEquals(null).toList();

// create a map of contacts on account id
Map<Id,List<SObject>> myMap = Blinq.my(contacts).toIdMapListOn('AccountId');

// filter on contacts over 21 and return in a map
Date dt = Date.today().addYears(-21);
Map<Id,SObject> over21 = Blinq.my(contacts).filterOn('Birthdate').lessThanOrEqualTo(dt).toIdMap();
```
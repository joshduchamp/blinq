# Blinq Apex Collection Library

Blinq is library in apex loosely modeled after C#'s Linq library to be able to easily manipulate collections of sobject.

A predominent part of apex is bulk processing collections of data. This can result in a lot of code around loops lists to build maps and sets. This library aims to make those operations easier and more readable. 

## Installation

Clone this repository to get the Blinq library and deploy it to your org.

## Examples

```apex
// create a set of ids from a list of contacts
Set<Id> contactIds = Blinq.my(contacts).toIdSet();

// create a set of account ids from a list of contacts
Set<Id> accountIds = Blinq.my(contacts).toIdSetOn('AccountId');

// filter on contacts with an account
List<Contact> contactsWithAccount = Blinq.my(contacts).filterOn('AccountId').notEquals(null).toList();

// create a map of contacts on account id
Map<Id,List<SObject>> myMap = Blinq.my(contacts).toIdMapListOn('AccountId');

// filter on contacts over 21 and return in a map
Map<Id,SObject> over21 = Blinq.my(contacts).filterOn('Birthdate').lessThanOrEqualTo(Date.today().addYears(-21)).toIdMap();
```
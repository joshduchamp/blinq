global class Blinq {
    private List<SObject> objList;
    private Map<String, Map<Id,SObject>> joinMap = new Map<String, Map<Id,SObject>>();

    private Blinq(List<SObject> collection) {
        this.objList = collection;
    }

    public static Blinq my(List<SObject> collection) {
        return new Blinq(collection);
    }

    global Blinq leftJoin(Map<Id,SObject> objMap, String alias) {
        joinMap.put(alias, objMap);
        return this;
    }

    global List<SObject> toList() {
        return this.objList;
    }

    global Set<String> toStringSet(String fieldName) {
        Set<String> objSet = new Set<String>();
        for (SObject sobj : this.objList) {
            objSet.add((String) sobj.get(fieldName));
        }
        return objSet;
    }

    global Set<Id> toIdSet() {
        return toIdSetOn('Id');
    }

    global Set<Id> toIdSetOn(String fieldName) {
        Set<Id> objSet = new Set<Id>();
        for (SObject sobj : this.objList) {
            objSet.add((Id) sobj.get(fieldName));
        }
        return objSet;
    }

    global Map<String, SObject> toStringMapOn(String fieldName) {
        Map<String, SObject> objMap = new Map<String, SObject>();
        for (SObject sobj : this.objList) {
            objMap.put((String) sobj.get(fieldName), sobj);
        }
        return objMap;
    }

    global Map<String, List<SObject>> toStringMapListOn(String fieldName) {
        Map<String, List<SObject>> objListMap = new Map<String, List<SObject>>();
        for (SObject sobj : this.objList) {
            String key = (String) sobj.get(fieldName);
            List<SObject> objList = objListMap.get(key);
            if (objList == null) {
                objList = new List<SObject>();
            }
            objList.add(sobj);
            objListMap.put(key, objList);
        }
        return objListMap;
    }

    global Map<Id, SObject> toIdMap() {
        return toIdMapOn('Id');
    }

    global Map<Id, SObject> toIdMapOn(String fieldName) {
        Map<Id, SObject> objMap = new Map<Id, SObject>();
        for (SObject sobj : this.objList) {
            objMap.put((Id) sobj.get(fieldName), sobj);
        }
        return objMap;
    }

    global Map<Id, List<SObject>> toIdMapListOn(String fieldName) {
        Map<Id, List<SObject>> objListMap = new Map<Id, List<SObject>>();
        for (SObject sobj : this.objList) {
            Id key = (Id) sobj.get(fieldName);
            List<SObject> objList = objListMap.get(key);
            if (objList == null) {
                objList = new List<SObject>();
            }
            objList.add(sobj);
            objListMap.put(key, objList);
        }
        return objListMap;
    }

    global String fieldName;
    global Blinq filterOn(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    global Blinq equals(Object value) {
        return compare(new BlinqCompareEquals(), value);
    }

    global Blinq equals(String alias, String fieldName) {
        return compare(new BlinqCompareEquals(), alias, fieldName);
    }

    global Blinq notEquals(Object value) {
        return compare(new BlinqCompareNotEquals(), value);
    }

    global Blinq notEquals(String alias, String fieldName) {
        return compare(new BlinqCompareNotEquals(), alias, fieldName);
    }

    global Blinq greaterThan(Object value) {
        return compare(new BlinqCompareGreaterThan(), value);
    }

    global Blinq greaterThan(String alias, String fieldName) {
        return compare(new BlinqCompareGreaterThan(), alias, fieldName);
    }

    global Blinq greaterThanOrEqualTo(Object value) {
        return compare(new BlinqCompareGreaterThanOrEqualTo(), value);
    }

    global Blinq greaterThanOrEqualTo(String alias, String fieldName) {
        return compare(new BlinqCompareGreaterThanOrEqualTo(), alias, fieldName);
    }

    global Blinq lessThan(Object value) {
        return compare(new BlinqCompareLessThan(), value);
    }

    global Blinq lessThan(String alias, String fieldName) {
        return compare(new BlinqCompareLessThan(), alias, fieldName);
    }

    global Blinq lessThanOrEqualTo(Object value) {
        return compare(new BlinqCompareLessThanOrEqualTo(), value);
    }

    global Blinq lessThanOrEqualTo(String alias, String fieldName) {
        return compare(new BlinqCompareLessThanOrEqualTo(), alias, fieldName);
    }

    private Blinq compare(IBlinqCompare comparer, Object value) {
        List<SObject> filteredList = new List<SObject>();
        for (SObject sobj : this.objList) {
            if (comparer.compare(sobj.get(this.fieldName), value)) {
                filteredList.add(sobj);
            }
        }
        this.objList = filteredList;
        return this;
    }

    private Blinq compare(IBlinqCompare comparer, String alias, String aliasFieldName) {
        List<SObject> filteredList = new List<SObject>();
        for (SObject sobj : this.objList) {
            SObject aliasObj = joinMap.get(alias).get(sobj.Id);
            if (comparer.compare(sobj.get(this.fieldName), aliasObj.get(aliasFieldName))) {
                filteredList.add(sobj);
            }
        }
        this.objList = filteredList;
        return this;
    }

    public class BlinqException extends Exception {}
}

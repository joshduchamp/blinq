global class Blinq {
    private List<SObject> objList;

    private Blinq(List<SObject> collection) {
        this.objList = collection;
    }

    public static Blinq my(List<SObject> collection) {
        return new Blinq(collection);
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

    global Blinq notEquals(Object value) {
        return compare(new BlinqCompareNotEquals(), value);
    }

    global Blinq greaterThan(Object value) {
        return compare(new BlinqCompareGreaterThan(), value);
    }

    global Blinq greaterThanOrEqualTo(Object value) {
        return compare(new BlinqCompareGreaterThanOrEqualTo(), value);
    }

    global Blinq lessThan(Object value) {
        return compare(new BlinqCompareLessThan(), value);
    }

    global Blinq lessThanOrEqualTo(Object value) {
        return compare(new BlinqCompareLessThanOrEqualTo(), value);
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
}

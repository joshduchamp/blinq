global class Blinq {
    private List<SObject> objList;
    private Map<String, Map<Id,SObject>> joinMap = new Map<String, Map<Id,SObject>>();
    private List<BlinqFilter> filterList = new List<BlinqFilter>();
    private Boolean filtersExecuted = false;

    private Blinq(List<SObject> collection) {
        this.objList = collection;
    }

    global static Blinq my(List<SObject> collection) {
        return new Blinq(collection);
    }

    global Blinq leftJoin(Map<Id,SObject> objMap, String alias) {
        joinMap.put(alias, objMap);
        return this;
    }

    global List<SObject> toList() {
        tryFilter();
        return this.objList;
    }

    global Set<String> toStringSetOn(Schema.SObjectField field) {
        return toStringSetOn(field.getDescribe().getName());
    }

    global Set<String> toStringSetOn(String fieldName) {
        tryFilter();
        Set<String> objSet = new Set<String>();
        for (SObject sobj : this.objList) {
            objSet.add((String) BlinqFieldValue.resolve(sobj, fieldName));
        }
        return objSet;
    }

    global Set<Id> toIdSet() {
        tryFilter();
        return toIdSetOn('Id');
    }

    global Set<Id> toIdSetOn(Schema.SObjectField field) {
        return toIdSetOn(field.getDescribe().getName());
    }

    global Set<Id> toIdSetOn(String fieldName) {
        tryFilter();
        Set<Id> objSet = new Set<Id>();
        for (SObject sobj : this.objList) {
            objSet.add((Id) BlinqFieldValue.resolve(sobj, fieldName));
        }
        return objSet;
    }

    global Map<String, SObject> toStringMapOn(Schema.SObjectField field) {
        return toStringMapOn(field.getDescribe().getName());
    }

    global Map<String, SObject> toStringMapOn(String fieldName) {
        tryFilter();
        Map<String, SObject> objMap = new Map<String, SObject>();
        for (SObject sobj : this.objList) {
            objMap.put((String) BlinqFieldValue.resolve(sobj, fieldName), sobj);
        }
        return objMap;
    }

    global Map<String, List<SObject>> toStringMapListOn(Schema.SObjectField field) {
        return toStringMapListOn(field.getDescribe().getName());
    }

    global Map<String, List<SObject>> toStringMapListOn(String fieldName) {
        tryFilter();
        Map<String, List<SObject>> objListMap = new Map<String, List<SObject>>();
        for (SObject sobj : this.objList) {
            String key = (String) BlinqFieldValue.resolve(sobj, fieldName);
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
        tryFilter();
        return toIdMapOn('Id');
    }

    global Map<Id, SObject> toIdMapOn(Schema.SObjectField field) {
        return toIdMapOn(field.getDescribe().getName());
    }

    global Map<Id, SObject> toIdMapOn(String fieldName) {
        tryFilter();
        Map<Id, SObject> objMap = new Map<Id, SObject>();
        for (SObject sobj : this.objList) {
            objMap.put((Id) BlinqFieldValue.resolve(sobj, fieldName), sobj);
        }
        return objMap;
    }

    global Map<Id, List<SObject>> toIdMapListOn(Schema.SObjectField field) {
        return toIdMapListOn(field.getDescribe().getName());
    }

    global Map<Id, List<SObject>> toIdMapListOn(String fieldName) {
        tryFilter();
        Map<Id, List<SObject>> objListMap = new Map<Id, List<SObject>>();
        for (SObject sobj : this.objList) {
            Id key = (Id) BlinqFieldValue.resolve(sobj, fieldName);
            List<SObject> objList = objListMap.get(key);
            if (objList == null) {
                objList = new List<SObject>();
            }
            objList.add(sobj);
            objListMap.put(key, objList);
        }
        return objListMap;
    }

    global BlinqFilter filterOn(Schema.SObjectField field) {
        return filterOn(field.getDescribe().getName());
    }

    global BlinqFilter filterOn(String fieldName) {
        BlinqFilter filter = new BlinqFilter(this, fieldName);
        this.filterList.add(filter);
        return filter;
    }

    global BlinqFilter filterOn(String alias, Schema.SObjectField field) {
        return filterOn(alias, field.getDescribe().getName());
    }

    global BlinqFilter filterOn(String alias, String fieldName) {
        BlinqFilter filter = new BlinqFilter(this, alias, fieldName);
        this.filterList.add(filter);
        return filter;
    }

    global Blinq any() {
        return customLogic(buildLogic('OR'));
    }
    
    global Blinq all() {
        return customLogic(buildLogic('AND'));
    }

    private String buildLogic(String op) {
        List<String> lst = new List<String>();
        for (Integer i = 1; i <= this.filterList.size(); i++) {
            lst.add(String.valueOf(i));
        }
        String logic = String.join(lst, ' ' + op + ' ');
        return logic;
    }

    global Blinq customLogic(String conditionalLogic) {
        this.filtersExecuted = true;
        if (!this.filterList.isEmpty()) {
            List<SObject> filteredObjects = new List<SObject>();
            for (SObject sobj : this.objList) {
                List<Boolean> values = new List<Boolean>();
                for (BlinqFilter filter : this.filterList) {
                    values.add(filter.result(sobj, this.joinMap));
                }
                if (BlinqLogic.evaluate(conditionalLogic, values)) {
                    applyValues(sobj);
                    applySObjects(sobj);
                    filteredObjects.add(sobj);
                }
            }
            this.objList = filteredObjects;
        } else {
            for (SObject sobj : this.objList) {
                applyValues(sobj);
                applySObjects(sobj);
            }
        }
        return this;
    }

    private void applyValues(SObject sobj) {
        for (Schema.SObjectField field : this.setValueMap.keySet()) {
            sobj.put(field, this.setValueMap.get(field));
        }
    }

    private Map<Schema.SObjectField, Object> setValueMap = new Map<Schema.SObjectField, Object>();
    global Blinq setValue(Schema.SObjectField field, Object value) {
        this.setValueMap.put(field, value);
        return this;
    }

    private void applySObjects(SObject sobj) {
        for (Schema.SObjectField field : this.setSObjectMap.keySet()) {
            sobj.putSObject(field, this.setSObjectMap.get(field));
        }
    }

    private Map<Schema.SObjectField, SObject> setSObjectMap = new Map<Schema.SObjectField, SObject>();
    global Blinq setSOBject(Schema.SObjectField field, SObject sobj) {
        this.setSObjectMap.put(field, sobj);
        return this;
    }

    global SObject first() {
        tryFilter();
        if (this.objList.isEmpty()) {
            return null;
        }
        return this.objList[0];
    }

    global SObject last() {
        tryFilter();
        if (this.objList.isEmpty()) {
            return null;
        }
        return this.objList[this.objList.size()-1];
    }

    private void tryFilter() {
        if (!this.filtersExecuted) {
            all();
        }
    }
}
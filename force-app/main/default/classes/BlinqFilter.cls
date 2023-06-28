global class BlinqFilter {
    private Blinq blinqObj;
    private String fieldName;
    private IBlinqCompare comparer;
    private Object value;
    private String alias;
    private String aliasFieldName;
    private Boolean isJoinedFilter { get { return this.alias != null; } }

    public BlinqFilter(Blinq blinqObj, String fieldName) {
        this.blinqObj = blinqObj;
        this.fieldName = fieldName;
    }

    public Boolean result(SObject sobj, Map<String, Map<Id,SObject>> joinMap) {
        Object objA = BlinqFieldValue.resolve(sobj, this.fieldName);
        Object objB = null;
        if (this.isJoinedFilter) {
            SObject aliasObj = joinMap.get(this.alias).get(sobj.Id);
            objB = aliasObj == null ? null : BlinqFieldValue.resolve(aliasObj, this.aliasFieldName);
        } else {
            objB = this.value;
        }
        System.debug('objA => ' + objA);
        System.debug('objB => ' + objB);
        return this.comparer.compare(objA, objB);
    }

    global Blinq equals(Object value) {
        this.comparer = new BlinqCompareEquals();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq equals(String alias, String fieldName) {
        this.comparer = new BlinqCompareEquals();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq notEquals(Object value) {
        this.comparer = new BlinqCompareNotEquals();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq notEquals(String alias, String fieldName) {
        this.comparer = new BlinqCompareNotEquals();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq greaterThan(Object value) {
        this.comparer = new BlinqCompareGreaterThan();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq greaterThan(String alias, String fieldName) {
        this.comparer = new BlinqCompareGreaterThan();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq greaterThanOrEqualTo(Object value) {
        this.comparer = new BlinqCompareGreaterThanOrEqualTo();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq greaterThanOrEqualTo(String alias, String fieldName) {
        this.comparer = new BlinqCompareGreaterThanOrEqualTo();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq lessThan(Object value) {
        this.comparer = new BlinqCompareLessThan();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq lessThan(String alias, String fieldName) {
        this.comparer = new BlinqCompareLessThan();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq lessThanOrEqualTo(Object value) {
        this.comparer = new BlinqCompareLessThanOrEqualTo();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq lessThanOrEqualTo(String alias, String fieldName) {
        this.comparer = new BlinqCompareLessThanOrEqualTo();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }
}

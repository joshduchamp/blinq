global class BlinqFilter {
    private Blinq blinqObj;
    private String fieldName;
    private IBlinqCompare comparer;
    private Object value;
    private String alias;
    private String aliasLeft;
    private String aliasFieldName;
    private Boolean isJoinedFilter { get { return this.alias != null; } }

    public BlinqFilter(Blinq blinqObj, String fieldName) {
        this.blinqObj = blinqObj;
        this.fieldName = fieldName;
    }

    public BlinqFilter(Blinq blinqObj, String alias, String fieldName) {
        this.blinqObj = blinqObj;
        this.aliasLeft = alias;
        this.fieldName = fieldName;
    }

    public Boolean result(SObject sobj, Map<String, Map<Id,SObject>> joinMap) {
        Object objA = null;
        if (this.aliasLeft == null) {
            objA = BlinqFieldValue.resolve(sobj, this.fieldName);
        } else {
            SObject aliasObj = joinMap.get(this.aliasLeft).get(sobj.Id);
            objA = aliasObj == null ? null : BlinqFieldValue.resolve(aliasObj, this.fieldName);
        }
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

    global Blinq equals(String alias, Schema.SObjectField field) {
        return equals(alias, field.getDescribe().getName());
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

    global Blinq notEquals(String alias, Schema.SObjectField field) {
        return notEquals(alias, field.getDescribe().getName());
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

    global Blinq greaterThan(String alias, Schema.SObjectField field) {
        return greaterThan(alias, field.getDescribe().getName());
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

    global Blinq greaterThanOrEqualTo(Schema.SObjectField field) {
        return greaterThanOrEqualTo(alias, field.getDescribe().getName());
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

    global Blinq lessThan(String alias, Schema.SObjectField field) {
        return lessThan(alias, field.getDescribe().getName());
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

    global Blinq lessThanOrEqualTo(String alias, Schema.SObjectField field) {
        return lessThanOrEqualTo(alias, field.getDescribe().getName());
    }

    global Blinq lessThanOrEqualTo(String alias, String fieldName) {
        this.comparer = new BlinqCompareLessThanOrEqualTo();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq startsWith(String value) {
        this.comparer = new BlinqCompareStartsWith();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq startsWith(String alias, Schema.SObjectField field) {
        return startsWith(alias, field.getDescribe().getName());
    }

    global Blinq startsWith(String alias, String fieldName) {
        this.comparer = new BlinqCompareStartsWith();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq endsWith(String value) {
        this.comparer = new BlinqCompareEndsWith();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq endsWith(String alias, Schema.SObjectField field) {
        return endsWith(alias, field.getDescribe().getName());
    }

    global Blinq endsWith(String alias, String fieldName) {
        this.comparer = new BlinqCompareEndsWith();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq contains(String value) {
        this.comparer = new BlinqCompareContains();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq contains(String alias, Schema.SObjectField field) {
        return contains(alias, field.getDescribe().getName());
    }

    global Blinq contains(String alias, String fieldName) {
        this.comparer = new BlinqCompareContains();
        this.alias = alias;
        this.aliasFieldName = fieldName;
        return this.blinqObj;
    }

    global Blinq isIn(List<Object> value) {
        this.comparer = new BlinqCompareIsIn();
        this.value = value;
        return this.blinqObj;
    }

    global Blinq isNull() {
        this.comparer = new BlinqCompareEquals();
        this.value = null;
        return this.blinqObj;
    }

    global Blinq isNotNull() {
        this.comparer = new BlinqCompareNotEquals();
        this.value = null;
        return this.blinqObj;
    }

}

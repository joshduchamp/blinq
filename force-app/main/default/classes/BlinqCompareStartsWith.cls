public class BlinqCompareStartsWith implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        return ((String) objA).startsWith((String) objB);
    }
}
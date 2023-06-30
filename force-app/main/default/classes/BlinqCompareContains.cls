public class BlinqCompareContains implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        return ((String) objA).contains((String) objB);
    }
}
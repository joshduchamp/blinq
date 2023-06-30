public class BlinqCompareEndsWith implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        return ((String) objA).endsWith((String) objB);
    }
}
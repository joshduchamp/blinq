public class BlinqCompareIsIn implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        return ((List<Object>) objB).contains(objA);
    }
}
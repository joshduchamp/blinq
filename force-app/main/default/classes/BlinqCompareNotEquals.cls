public class BlinqCompareNotEquals implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        return objA != objB;
    }
}
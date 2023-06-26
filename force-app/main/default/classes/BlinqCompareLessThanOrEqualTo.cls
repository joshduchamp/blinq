public class BlinqCompareLessThanOrEqualTo implements IBlinqCompare {
    public Boolean compare(Object objA, Object objB) {
        try {
            return (Double) objA <= (Double) objB;
        } catch (TypeException e) {
            return String.valueOf(objA) <= String.valueOf(objB);
        }
    }
}
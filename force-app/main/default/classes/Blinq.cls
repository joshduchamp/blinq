global class Blinq {
    private List<Object> objList;

    private Blinq(List<Object> collection) {
        this.objList = collection;
    }

    public static Blinq my(List<Object> collection) {
        return new Blinq(collection);
    }

    public List<Object> toList() {
        return this.objList;
    }
}
public class BlinqFieldValue {
    public static Object resolve(SObject sobj, String fieldName) {
        List<String> fieldNameList = fieldName.split('\\.');
        String firstField = fieldNameList.remove(0);
        if (fieldNameList.isEmpty()) {
            return sobj.get(firstField);
        }
        return resolve(sobj.getSObject(firstField), String.join(fieldNameList, '.'));
    }
}
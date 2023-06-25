@IsTest
public class BlinqTest {
    @IsTest
    static void testToList() {
        List<TestObj> lst = new List<TestObj> {
            new TestObj('hello'),
            new TestObj('world')
        };
        Test.startTest();
        List<TestObj> myList = (TestObj[])Blinq.my(lst).toList();
        Test.stopTest();

        Assert.areEqual(2, myList.size());
    }

    private class TestObj {
        public String thing1;
        public TestObj(String thing1) {
            this.thing1 = thing1;
        }
    }
}
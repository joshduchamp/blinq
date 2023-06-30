@IsTest
public class BlinqLogicTest {
    @IsTest
    static void testLogicParsing() {
        Assert.areEqual(true, BlinqLogic.evaluate('1', new List<Boolean>{ true }));
        Assert.areEqual(false, BlinqLogic.evaluate('1', new List<Boolean>{ false }));
        Assert.areEqual(true, BlinqLogic.evaluate('1   OR 2', new List<Boolean>{ true, true }));
        Assert.areEqual(true, BlinqLogic.evaluate('1 OR 2', new List<Boolean>{ true, false }));
        Assert.areEqual(true, BlinqLogic.evaluate('1 OR NOT 2', new List<Boolean>{ false, false }));
        Assert.areEqual(true, BlinqLogic.evaluate('1 AND 2', new List<Boolean>{ true, true }));
        Assert.areEqual(false, BlinqLogic.evaluate('1 AND 2', new List<Boolean>{ true, false }));
        Assert.areEqual(false, BlinqLogic.evaluate('NOT ( 1 AND 2 )', new List<Boolean>{ true, true }));
        Assert.areEqual(true, BlinqLogic.evaluate('NOT(1 AND 2)', new List<Boolean>{ false, false }));
        Assert.areEqual(false, BlinqLogic.evaluate('NOT (1 OR 2)', new List<Boolean>{ false, true }));
        Assert.areEqual(
            true,
            BlinqLogic.evaluate('1 AND (NOT 2 OR (3 AND 4))', new List<Boolean>{ true, true, true, true })
        );
        Assert.areEqual(true, BlinqLogic.evaluate('1 AND NOT 2', new List<Boolean>{ true, false }));
    }
}

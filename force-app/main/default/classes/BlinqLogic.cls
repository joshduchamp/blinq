public class BlinqLogic {
    private static final Pattern tokenPattern = Pattern.compile('\\(|\\)|OR|AND|\\w+');
    private String conditionalLogic = null;
    private Boolean value1 = null;
    private Boolean value2 = null;
    private Operation op = null;
    private Boolean notFlag = false;
    
    private List<String> tokens {
        get {
            if (tokens == null) {
                Matcher tokenMatcher = tokenPattern.matcher(conditionalLogic);
                List<String> tokenList = new List<String>();
                while (tokenMatcher.find()) {
                    String token = tokenMatcher.group();
                    tokenList.add(token);
                }
                tokens = tokenList;
            }
            return tokens;
        }
        set;
    }

    public static Boolean evaluate(String conditionalLogic, List<Boolean> values) {
        return new BlinqLogic(conditionalLogic).evaluate(values);
    }

    public BlinqLogic(String conditionalLogic) {
        this.conditionalLogic = conditionalLogic;
    }

    private Boolean evaluate(List<Boolean> values) {

        for( Integer i = 0; i < tokens.size(); i++ ) {
            String token = tokens[i];
            switch on token {
                when 'NOT' {
                    notFlag = true;
                }
                when 'OR' {
                    op = Operation.OP_OR;
                }
                when 'AND' {
                    op = Operation.OP_AND;
                }
                when '(' {
                    String nestedCondition = '';
                    Integer x = 0;
                    for(i = i+1; i < tokens.size(); i++) {
                        token = tokens[i];
                        if (token == '(') {
                            x++;
                        }
                        if (token == ')') {
                            if (x == 0) {
                                break;
                            } else {
                                x--;
                            }
                        }
                        nestedCondition += token + ' ';
                    }
                    Boolean nestedValue = evaluate(nestedCondition, values);
                    updateValue(nestedValue);
                }
                when ')' {
                    throw new BlinqException('Code should not have been reached');
                }
                when else {
                    if (token.isNumeric()) {
                        Integer numericValue = Integer.valueOf(token);
                        Boolean value = values[numericValue-1];
                        updateValue(value);
                    } else {
                        throw new BlinqException('Invalid token: ' + token);
                    }
                }
            }
            if (op == Operation.OP_AND && value1 != null && value2 != null) {
                value1 = value1 && value2;
                value2 = null;
                op = null;
            }
            if (op == Operation.OP_OR && value1 != null && value2 != null) {
                value1 = value1 || value2;
                value2 = null;
                op = null;
            }
        }
        return value1;
    }

    private void updateValue(Boolean newValue) {
        if (notFlag) {
            newValue = !newValue;
            notFlag = false;
        }
        if (value1 == null) {
            value1 = newValue;
        } else {
            value2 = newValue;
        }
    }

    private enum Operation {
        OP_AND,
        OP_OR,
        OP_NOT
    }

}
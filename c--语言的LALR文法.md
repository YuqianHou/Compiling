

procedure → procedure functions| function

function → type functionName parameterList codeBlock

functionName → identifier | main

codeBlock → codeBlock statement|statement

statement → data；|branchStatement|loopStatement|jumpStatement；|callStatement；|variableDeclaration；|assignmentStatement；

branchStatement → simpleBranchStatement|multiBranchStatement

simpleBranchStatement → if (data) codeBlock else  codeBlock | if (data) codeBlock

multiBranchStatement → if (data)codeBlock multiCondition else codeBlock

multiCondition → multiCondition else if  codeBlock |else if codeBlock

loopStatement → while (data)codeBlock| for (assignmentStatement；compoundExpression；compoundExpression)  codeBlock

jumpStatement → continue|break|return|return data

callStatement → identifier parameterList

parameterList →(variableName)|()

variableDeclaration → dataType variableStatement

variableStatement→ variableStatement variableName| variableStatement assignmentStatement

variableStatement→ variableStatement variableName| variableStatement assignmentStatement | variableName | assignmentStatement

variableName → variableName ,identifier | identifier

assignmentStatement → assignmentStatement,identifier = data|identifier = data

data → constant|identifier|compoundExpression|(dataType)(data)|selfOperator data|data selfOperator

compoundExpression → compoundExpression operator expression |（compoundExpression operator expression）| expression

expression → data operator data|(data operator data)

type → void|dataType

dataType → int | float

operator → relationalOperator | arithmeticOperator

relationalOperator →  >= |  <= | ==

arithmeticOperator → \+ | \- |\* | /

selfOperator → ++ | --
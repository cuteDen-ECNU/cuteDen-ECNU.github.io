grammar Expr;
expr
    : or_expr
    ;

or_expr
    : and_expr (OR and_expr)*
    ;

and_expr
    : relation_expr (AND relation_expr)*
    ;

relation_expr
    : paren_expr bin_relation_op paren_expr
    | paren_expr
    ;

paren_expr
    : BOOLEAN
    | count_expr
    | pre_expr
    | LPAREN expr RPAREN
    | atom
    ;

BOOLEAN : 'true' | 'false' ;

count_expr
    : 'count(' expr ')'
    ;

pre_expr
    : 'pre(' expr ')'
    ;

id_expr
    : ID
    ;

atom
    : hex_int
    | double
    | id_expr
    | int_part
    ;

bin_relation_op
    : EQUALS
    | NOT_EQ
    | LESS_THAN
    | GREATER_THAN
    | LT_EQ
    | GT_EQ
    ;

double
    : (MINUS)? (int_part)? fraction
    ;

ID
    :([A-Z]
    | [a-z]
    | '_')+ 
    ;

hex_int
    : HEX_INT
    | HEX_UINT
    ;

HEX_UINT
    : '0' 'x' ([0-9a-fA-F])+ 'U' 
    ;

HEX_INT
    : '0' 'x' ([0-9a-fA-F])+
    ;

fraction
    : DOT DIGIT+
    ;

int_part
    : DIGIT+
    ;

DIGIT
    : [0-9]
    ;

NON_ZERO_DIGIT
    : [1-9]
    ;



LPAREN : '(' ;
RPAREN : ')' ;

AND : '&&';
OR : '||';

LESS_THAN : '<';
GREATER_THAN : '>';
EQUALS : '==';
NOT_EQ : '!=';
GT_EQ : '>=';
LT_EQ : '<=';

MINUS : '-';
ADD : '+';
DOT : '.';

COUNT : 'count';
PRE : 'pre';
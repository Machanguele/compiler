package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r,\n]+
%{
    public String lexeme;
%}
%%
int |
if |
else |
while {lexeme=yytext(); return Reservadas;}

/*Operadores Logicos*/
"vv" {return Disjuncao;}
"^^" {return Conjuncao;}
"^" {return Negacao;}

/*Operadores Relacionais*/
"==" {return Igualdade;}
"<>" {return Diferente;}
">" {return Maior;}
">=" {return MaiorOuIgual;}
"<" {return Menor;}
"<=" {return MenorOuIgual;}

/*Tipo de dado*/
kakunene |ntxumo |mitxumo |mutsongo |tundo |mukulo |kulunkulu {lexeme=yytext(); return Tipo_de_Dado;}


/*Marcador de Inicio*/
Sungula {lexeme=yytext(); return MarcadorInicio;}

/*Marcador de Fim*/
Gama {lexeme=yytext(); return MarcadorFim;}

/*Palavras reservadas, NB: */
Sungula|
Gama|
kakunene|ntxumo|tundo|mukulo|kulunkulu {lexeme=yytext(); return PalavraReservada; }


/*Caracteres especiais*/
"'"|"/" {lexeme=yytext(); return CaracteresEspeciais}



/*Estrutura de controlo*/
("loko" | "phazama" | "langa") {lexeme  = yytext(); return ESTRUTURA_DE_CONTROLO;}
("leyi") {lexeme  = yytext(); return ESTRUTURA_DE_CONTROLO_CASO;}


/*Estrutura de Repeticao*/
("ka" | "yendla" | "nkanrini" | "maha") {lexeme  = yytext(); return ESTRUTURA_DE_REPETICAO;}


(";") {lexeme  = yytext(); return FIM_DE_INSTRUCAO;}
(",") {lexeme  = yytext(); return CONCATENACAO;}
(":") {lexeme  = yytext(); return INICIAR_CASE;}
("{") {lexeme  = yytext(); return INICIAR_BLOCO_FUNCAO;}
("}") {lexeme  = yytext(); return TERMINAR_BLOCO_FUNCAO;}
("(") {lexeme  = yytext(); return COMECAR_PARAMETRO;}
(")") {lexeme  = yytext(); return TERMINAR_PARAMETRO;}



{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
"=" {return Igual;}
"+" {return Suma;}
"-" {return Resta;}
"*" {return Multiplicacion;}
"/" {return Division;}
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Numero;}
 . {return ERROR;}
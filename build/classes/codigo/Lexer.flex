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
kakunene |
ntxumo |
mitxumo |
mutsongo |
tundo |
mukulo |
kulunkulu {lexeme=yytext(); return Tipo_de_Dado;}


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
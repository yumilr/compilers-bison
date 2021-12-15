%{
#include "parser.hpp"
#include "FlexScanner.hpp"
#define YY_DECL int utec::compilers::FlexScanner::lex(utec::compilers::Parser::semantic_type *yylval)
%}

%option c++ interactive noyywrap noyylineno nodefault

uint_const	{digit}+

letra [a-zA-Z]
digit [0-9]


%%

"entero"   {return Parser::token::ENTERO;}
"sin_tipo" {return Parser::token::SIN_TIPO;}
"retorno" {return Parser::token::RETORNO;}
"mientras" {return Parser::token::MIENTRAS;}
"sino" {return Parser::token::SINO;}
"si" {return Parser::token::SI;}
"main" {return Parser::token::MAIN;}

"("     { return Parser::token::par_begin; }
")"     { return Parser::token::par_end; }
"["     { return Parser::token::cor_begin; }
"]"     { return Parser::token::cor_end; }
"{"     { return Parser::token::bra_begin; }
"}"     { return Parser::token::bra_end; }
";"     { return Parser::token::d_com; }
","     { return Parser::token::com; }

"<"  { yylval->op_val = new std::string(yytext); return Parser::token::LT; }
"<="  { yylval->op_val = new std::string(yytext); return Parser::token::LEQ; }
">"  { yylval->op_val = new std::string(yytext); return Parser::token::GT; }
">="  { yylval->op_val = new std::string(yytext); return Parser::token::GEQ; }
"=="  { yylval->op_val = new std::string(yytext); return Parser::token::EQ; }
"!="  { yylval->op_val = new std::string(yytext); return Parser::token::NEQ; }

"+"  { yylval->op_val = new std::string(yytext); return Parser::token::SUM_OP; }
"-"  { yylval->op_val = new std::string(yytext); return Parser::token::RES_OP; }
"*"  { yylval->op_val = new std::string(yytext); return Parser::token::MUL_OP; }
"/"  { yylval->op_val = new std::string(yytext); return Parser::token::DIV_OP; }

{letra}+ { yylval->op_val = new std::string(yytext); return Parser::token::ID; }
[+-]?{digit}+	{ yylval->int_val = atoi(yytext); return Parser::token::NUM; }

[ \t]*		{}
[\n]		{ /*yylineno++;*/	}

.		{ std::cout<<"Error\n"; std::cerr << "SCANNER "; /*yyerror("");*/ exit(1);	}

%%

int yyFlexLexer::yylex() {
    throw std::runtime_error("Invalid call to yyFlexLexer::yylex()");
}

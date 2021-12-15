%{
#include <iostream>
#include <string>
#include <cmath>
#include <FlexLexer.h>
%}

%require "3.5.1"
%language "C++"

%define api.parser.class {Parser}
%define api.namespace {utec::compilers}
%parse-param {FlexScanner* scanner} {int* result}

%code requires
{
    namespace utec::compilers {
        class FlexScanner;
    } // namespace utec::compilers
}

%code
{
    #include "FlexScanner.hpp"
    #define yylex(x) scanner->lex(x)
}

%union{
    std::string* op_val;
    int int_val;
}

%start	programa 

%token <int_val> NUM
%token ID ENTERO SIN_TIPO RETORNO MIENTRAS SI SINO MAIN
%token MUL_OP DIV_OP SUM_OP RES_OP ASSIGN  
%token LT LEQ GT GEQ EQ NEQ
%token par_begin par_end cor_begin cor_end bra_begin bra_end
%token com d_com


%%

programa: lista_declaracion {*result = 666;}
		;

lista_declaracion:  
    lista_declaracion declaracion {std::cout<<"Sth\n";}
    | declaracion
    ;

declaracion: 
    | ENTERO ID declaracion_fact
    | SIN_TIPO ID par_begin params par_end bra_begin bra_end
    ;

declaracion_fact:
    var_declaracion_fact
    | par_begin params par_end bra_begin bra_end

var_declaracion_fact:
    d_com
    | cor_begin NUM cor_end d_com

params:
    /*empty*/
    | lista_params
;

lista_params:
    lista_params com param
    | param
;

param:
    tipo ID
    | tipo ID cor_begin cor_end
;

tipo:
    ENTERO
    | SIN_TIPO
;

%%

void utec::compilers::Parser::error(const std::string& msg) {
    std::cerr << msg << " " /*<< yylineno*/ <<'\n';
    exit(1);
}
/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    CHAR = 260,
    DOUBLE = 261,
    WHILE = 262,
    IF = 263,
    ELSE = 264,
    FOR = 265,
    DO = 266,
    BREAK = 267,
    CONTINUE = 268,
    INCLUDE = 269,
    MAIN = 270,
    RETURN = 271,
    VOID = 272,
    OPERATOR_INCREMENT = 273,
    OPERATOR_DECREMENT = 274,
    OPERATOR_GREATER_EQUAL = 275,
    OPERATOR_LESS_EQUAL = 276,
    OPERATOR_EQUAL = 277,
    OPERATOR_NOT_EQUAL = 278,
    OPERATOR_AND = 279,
    OPERATOR_OR = 280,
    OPERATOR_PLUS_EQUAL = 281,
    OPERATOR_MINUS_EQUAL = 282,
    OPERATOR_MULTIPLY_EQUAL = 283,
    OPERATOR_DIVIDE_EQUAL = 284,
    OPERATOR_MODULUS_EQUAL = 285,
    HEADER = 286,
    ID = 287,
    NUMBER = 288,
    STRING = 289
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define CHAR 260
#define DOUBLE 261
#define WHILE 262
#define IF 263
#define ELSE 264
#define FOR 265
#define DO 266
#define BREAK 267
#define CONTINUE 268
#define INCLUDE 269
#define MAIN 270
#define RETURN 271
#define VOID 272
#define OPERATOR_INCREMENT 273
#define OPERATOR_DECREMENT 274
#define OPERATOR_GREATER_EQUAL 275
#define OPERATOR_LESS_EQUAL 276
#define OPERATOR_EQUAL 277
#define OPERATOR_NOT_EQUAL 278
#define OPERATOR_AND 279
#define OPERATOR_OR 280
#define OPERATOR_PLUS_EQUAL 281
#define OPERATOR_MINUS_EQUAL 282
#define OPERATOR_MULTIPLY_EQUAL 283
#define OPERATOR_DIVIDE_EQUAL 284
#define OPERATOR_MODULUS_EQUAL 285
#define HEADER 286
#define ID 287
#define NUMBER 288
#define STRING 289

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

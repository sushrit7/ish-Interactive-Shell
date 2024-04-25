#ifndef _yy_defines_h_
#define _yy_defines_h_

#define WORD 257
#define COMMAND 258
#define FILENAME 259
#define BACKGROUND 260
#define PIPE 261
#define PIPE_ERROR 262
#define SEMICOLON 263
#define REDIRECT_IN 264
#define REDIRECT_OUT 265
#define REDIRECT_ERROR 266
#define APPEND 267
#define APPEND_ERROR 268
#define OPTION 269
#define STRING 270
#define LOGICAL_AND 271
#define LOGICAL_OR 272
#define EXIT 273
#define JOBS 274
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE
{
    char	*string;
    int		integer;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */

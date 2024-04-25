%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <pwd.h>

%}

%union
{
    char	*string;
    int		integer;
}

%token 	<string>	WORD
%token 	<string>	COMMAND
%token 	<string>	FILENAME
%token	<int>		BACKGROUND
%token	<int>		PIPE
%token	<int>		PIPE_ERROR
%token	<int>		SEMICOLON
%token	<int>		REDIRECT_IN
%token	<int>		REDIRECT_OUT
%token	<int>		REDIRECT_ERROR
%token	<int>		APPEND
%token	<int>		APPEND_ERROR
%token	<string>	OPTION
%token	<string>	STRING
%token	<int>		LOGICAL_AND
%token	<int>		LOGICAL_OR
%token  <string>        EXIT

%token  <string>        JOBS
%%
cmd_line        : cmd_line separator COMMAND parameters
                {
		              add_command_seperator($<string>3);
		            }
                | EXIT
                {
		              execute_exit();
                }
                |JOBS
                {
                jobs();
                }
                | COMMAND parameters
                {
		              add_command($<string>1);
		            }
                | cmd_line BACKGROUND 
		            {                     
                  put_background();
                }
		            | cmd_line SEMICOLON
                |  
                | error 
                ;

separator 	    : BACKGROUND
                {
                  //add_background();
                }
                | PIPE_ERROR
                | PIPE
                {
                  //printf("Found Pipe!\n");
                  add_pipe();
                }
                | SEMICOLON
                {
                  add_semicolon();
                  //printf("GOT SEMICOLON");
                }
                ;

parameters	    : parameters OPTION
                {
                  add_args($<string>2);
                }
                | parameters STRING
                {
                  add_args($<string>2);;
                }
                | parameters WORD
                {
                  add_args($<string>2);
                }
                | parameters REDIRECT_IN FILENAME
                {
                  //printf("Redirecting input from file '%s'\n", $<string>3);
                  execute_redirect_in($<string>3);
                }
                | parameters REDIRECT_OUT FILENAME
                {
                  //printf("Redirecting output for file '%s'\n", $<string>3);
                  execute_redirect_out($<string>3);
                }
                | parameters REDIRECT_ERROR FILENAME
                {
                  //printf("Redirecting output error for file '%s'\n", $<string>3);
                  execute_redirect_error($<string>3);
                }
                | parameters APPEND FILENAME
                {
                  //printf("Redirecting append for file '%s'\n", $<string>3);
                  execute_redirect_append($<string>3);
                }
                | parameters APPEND_ERROR FILENAME
                {
                  //printf("Redirecting append error for file '%s'\n", $<string>3);
                  execute_redirect_append_error($<string>3);
                }
                |
                ;
%%

int yyerror(char *s)
{
    fprintf(stderr, "syntax error\n");
    return 0;
}



 
 
 
 

 
 
 
 
 

 
 
 
 
 
 
 
 
 

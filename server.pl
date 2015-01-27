%%%%%%%%%%%%%%
% Web Server %
%%%%%%%%%%%%%%

:- use_module(library('http/thread_httpd')).
:- use_module(library('http/http_dispatch')).
:- use_module(library('http/html_write')).
:- use_module(library('http/http_parameters')).
:- use_module(library('http/http_error.pl')).
:- use_module(library('http/http_ssl_plugin.pl')).


:- include('manip.pl').
:- include('parse.pl').

https_server(Port, Options) :-
	http_server(http_dispatch,
		    [ port(Port),
		      timeout(60),
		      ssl([ host('sl.rossfenning.co.uk'),
			    certificate_file('/etc/ssl/certs/sl.rossfenning.co.uk.pem'),
			    key_file('/etc/ssl/private/sl.rossfenning.co.uk.key')
			  ])
		    | Options
		    ]).


server(Port) :-
        http_server(http_dispatch, [port(Port)]).

:- http_handler('/', root, []).
:- http_handler('/tell', tell, []).
:- http_handler('/ask', ask, []).

root(_Request) :-
        reply_html_page([ title('Shadowlaw')
                        ],
                        [ p('This is the main page. Use /tell')
                        ]).

tell(Request) :-
	http_parameters(Request,
			[
			 fact(Fact, [optional(false)])
			]),
	atom_codes(Fact,String),
	(
	 split(String," ",Tokens),
	 atomise(Tokens,Atoms),
	 sentence(Semantics,Atoms,List),
	 assertz(Semantics),
	 reply_html_page([ title('Shadowlaw')
                        ],
                        p('Fact stored.')
		       )
	)
	;
	reply_html_page([ title('Shadowlaw')
                        ],
                        p('Unable to parse your input.')
		       ).


ask(Request) :-
	http_parameters(Request,
			[
			 query(Query, [optional(false)])
			]),
	(
	 atom_codes(Query,String),
	 split(String," ",Tokens),
	 atomise(Tokens,Atoms),
	 sentence(Semantics,Atoms,List),
	 catch(Semantics,E,fail),
	 reply_html_page([ title('Shadowlaw')
                        ],
                        p('True.')
		       )
	)
	;
	 reply_html_page([ title('Shadowlaw')
                        ],
                        p('Not true.')
			).
	
% Starts the server
:- https_server(9001,[]).



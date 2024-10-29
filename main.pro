%============= Hechos OLA INVERNAL =============

padece(gustavo, gripe).
padece(shakira, hepatitis).
padece(juanes, intoxicacion).
padece(francia, hepatitis).
padece(sofia, gripe).

es_sintoma(fiebre, gripe).
es_sintoma(cansancio, hepatitis).
es_sintoma(dolorEstomago, intoxicacion).
es_sintoma(cansancio, gripe).

suprime(aspirina, fiebre).
suprime(lomotil, dolorEstomago).

%============= Reglas OLA INVERNAL =============

padece_de(Persona, Enfermedad, Linea) :- 
    padece(Persona, Enfermedad), Linea := Linea+20.

siente(Persona, Sintoma, Linea) :- 
    padece(Persona, Enfermedad), es_sintoma(Sintoma, Enfermedad), Linea := Linea+20.

alivia(Farmaco, Enfermedad,Linea) :- 
    suprime(Farmaco, Sintoma), es_sintoma(Sintoma, Enfermedad), Linea := Linea+20. 

alivia(Farmaco, Enfermedad) :- 
    suprime(Farmaco, Sintoma), es_sintoma(Sintoma, Enfermedad). 


aliviara_con(Persona, Farmaco ,Linea) :-
    padece(Persona, Enfermedad), alivia(Farmaco, Enfermedad), Linea := Linea+20.

%============= Hechos ARBOL FAMILIAR =============

esHombre(javier).
esHombre(lisandro).
esHombre(carlos).
esHombre(matias).
esHombre(joaquin).


esMujer(maria).
esMujer(jimena).
esMujer(belkis).
esMujer(luisa).

sonPadres_de(javier,maria, carlos).
sonPadres_de(javier, maria, jimena).
sonPadres_de(lisandro, jimena, joaquin).
sonPadres_de(lisandro, jimena, matias).
sonPadres_de(carlos, belkis, luisa).



sonEsposos(javier, maria).
sonEsposos(maria, javier).

sonEsposos(lisandro, jimena).
sonEsposos(jimena, lisandro).

sonEsposos(carlos, belkis).
sonEsposos(belkis, carlos).

%============= Reglas ARBOL FAMILIAR =============


son_hombres(X) :- esHombre(X).
son_mujeres(X) :- esMujer(X).

es_padre_de(Padre,Hijo) :- esPadre(Padre,Hijo).
son_esposos(Esposa, Esposo):- sonEsposos(Esposa, Esposo), sonEsposos(Eposo, Esposa).

es_hermana_de(Hermana, Hermano) :- 
    esMujer(Hermana), 
    (sonPadres_de(X,Y, Hermana);sonPadres_de(Y,X, Hermana)), 
    (sonPadres_de(X,Y, Hermano);sonPadres_de(Y,X, Hermano)).

es_hermano_de(Hermano, Hermana) :- 
    esHombre(Hermano), 
    (sonPadres_de(X,Y, Hermana); sonPadres_de(Y,X, Hermana)), 
    (sonPadres_de(X,Y, Hermano); sonPadres_de(Y,X, Hermana)).

es_hijo_de(Hijo, Padre) :-
    esHombre(Hijo),
    (sonPadres_de(Padre, _, Hijo); sonPadres_de(_,Padre,Hijo)).

es_hija_de(Hija, Padre) :-
    esMujer(Hija),
    (sonPadres_de(Padre, _, Hija); sonPadres_de(_,Padre,Hija)).

%============= Interfaz =============

?-window(_, _,crea_ventana(),"Aplicacion",150, 50, 450, 450).

%----- crea el menu -----

crea_ventana(init):- 
menu(pop_up, _,_,salir(_),"&ARCHIVO"), 
menu(pop_up, _,_,ola_invernal(_),"&OLA INVERNAL"),
menu(pop_up, _,_,arbol_generazional(_),"&ARBOL GENERACIONAL").

%----- Crea el submenu Salir -----
salir(init):-	
menu(normal, _,_,cerrar_ven(_),"&Salir").
cerrar_ven(press):- close_window(X).


%--------------------------------------------
%>crear el submenu logico
ola_invernal(init):-
menu(normal, _,_,que_enfermedad_padece(_),"&Que enfermedad padece un individuo en particular?"),
menu(normal, _,_,quienes_padecen_gripe(_),"&Quienes padecen gripe?"),
menu(normal, _,_,quienes_sienten_dolor_de_estomago(_),"&Quienes sienten dolor de estomago?"),
menu(normal, _,_,quienes_sienten_cansancio(_),"&Quienes  sienten cansancio?"),
menu(normal, _,_,que_faramaco_alivia(_),"&Que farmaco aliviara a un individuo particular? ").


%crear la subfuncion para prestar Arbol Geneaoligico
%-------------------------------------------------------------
arbol_generazional(init):
menu(normal, _,_,preguntas(_),"&preguntas?").   
    

preguntas(press):-
window( _, _, ventana_preguntas(_), "&informe", 150,500,8000,8000).
ventana_preguntas(init):-button(_,_,boton_iniciar_arbol(_),"&Iniciar",320,35,95,30).

boton_iniciar_arbol(press) :-
    Linea1 = 100,
    Linea2 = 140,
    Linea3 = 180,
    Linea4 = 220,
    Linea5 = 260,
    Linea7 = 300,
    Linea8 = 340,
    Linea9 = 380,
    Linea10 = 420,
    Linea11 = 460,
    text_out(50, 80, "¿Quién es hermana de Jimena?"),
    es_hermana_de(jimena, Y),
    text_out(50, Linea1, print(Y)), nl,

    text_out(50, 120, "¿Quiénes son los padres de Carlos?"),
    es_hijo_de(carlos, PadreCarlos),
    es_hijo_de(carlos, MadreCarlos),
    text_out(50, Linea2, print(PadreCarlos)),
    text_out(120, Linea2, print(MadreCarlos)), nl,

    text_out(50, 160, "¿Es Jimena hija de Javier?"),
    (es_hija_de(jimena, javier) -> 
        text_out(50, Linea3, "Sí") 
    ; 
        text_out(50, Linea3, "No")
    ), nl,
	text_out(50, 200, "¿Es Carlos hijo de Maria?"),
    (es_hijo_de(carlos, maria) -> 
        text_out(50, Linea4, "Sí") 
    ; 
        text_out(50, Linea4, "No")
    ), nl,
	text_out(50, 240, "¿Es joaquin hijo de belkis?"),
    (es_hijo_de(joaquin, javier) -> 
        text_out(50, Linea5, "Sí") 
    ; 
        text_out(50, Linea5, "No")
    ), nl,
	text_out(50, 280, "¿Es luisa hija de carlos?"),
    (es_hija_de(luisa, carlos) -> 
        text_out(50, Linea6, "Sí") 
    ; 
        text_out(50, Linea6, "No")
    ), nl,
	text_out(50, 320, "¿Es matias hijo de Lisandro?"),
    (es_hija_de(matias, lisandro) -> 
        text_out(50, Linea7, "Sí") 
    ; 
        text_out(50, Linea7, "No")
    ), nl,
	text_out(50, 360, "¿Es matias hijo de jimena?"),
    (es_hija_de(matias, jimena) -> 
        text_out(50, Linea8, "Sí") 
    ; 
        text_out(50, Linea8, "No")
    ), nl,
	text_out(50, 400, "¿Es joaquin hermano de Matias?"),
    (es_hermano_de(joaquin, matias) -> 
        text_out(50, Linea9, "Sí") 
    ; 
        text_out(50, Linea9, "No")
    ), nl,
	text_out(50, 440, "¿quien es hermano de joaquin ?"),
    (es_hija_de(jimena, javier) -> 
        text_out(50, Linea10, "Sí") 
    ; 
        text_out(50, Linea10, "No")
    ), nl.


boton_padres_carlos(press) :-
    Linea = 150,
    text_out(50, 120, "¿Quiénes son los padres de Carlos?"),
    es_padre_de(PadreCarlos, carlos),
    text_out(50, Linea, print(PadreCarlos)), nl.
%crear la subfuncion para prestar enfermedad padece

que_enfermedad_padece(press):-  
window( _, _, ventana_que_enfermedad_padece(_), "Que enfermedad padece un individuo en particular?", 150,50,800,800).
ventana_que_enfermedad_padece(init):-button(_,_,boton_iniciar_1(_),"&Iniciar",320,35,95,30).

boton_iniciar_1(press) :-
    Linea = 150,
    read(Nombre, "Ingrese el nombre de la persona que desea consultar:"),
    text_out(50, 120, "Que enfermedad padece el individuo?"),
    (   padece_de(Nombre, X, Linea)
    ->  text_out(50, Linea, print(X))
    ;   text_out(50, Linea, "No se encontrado ninguna enfermedad para esta persona.")
    ),
    nl.

%crear la subfuncion para quienes padecen gripe
quienes_padecen_gripe(press):-
window( _, _, ventana_quienes_padecen_de_gripe(_), "Quienes padecen de gripa?", 150,50,800,800).
ventana_quienes_padecen_de_gripe(init):-button(_,_,boton_iniciar_2(_),"&Iniciar",320,35,95,30).

boton_iniciar_2(press) :-
    Linea = 150,
    text_out(50, 120, "Quienes padecen de gripa?"),
	(padece_de(_, gripe, Linea)->
		padece_de(X, gripe, Linea),
		text_out(50, Linea, print(X)),nl,ln
	;
		message("resultado", "Nadie tiene gripa.",s)
	).

%crear la subfuncion para quienes padecen dolor de estomago
quienes_sienten_dolor_de_estomago(press):-
window( _, _, ventana_sienten_dolor_de_estomago(_), "Quienes sienten dolor de esomago?", 150,50,800,800).
ventana_sienten_dolor_de_estomago(init):-button(_,_,boton_iniciar_3(_),"&Iniciar",320,35,95,30).

boton_iniciar_3(press) :-
    Linea = 150,
    text_out(50, 120, "Quienes sienten dolor de esomago?"),
	(	siente(_, dolorEstomago, Linea)->
		siente(X, dolorEstomago, Linea),
		text_out(50, Linea, print(X)),nl,ln
	;
		message("resultado", "Nadie siente dolor de estomago.",s)
	).

%crear la subfuncion para quienes sienten cansancio
quienes_sienten_cansancio(press):-
window( _, _, ventana_sienten_cansancio(_), "quienes sienten cansancio?", 150,50,450,450).
ventana_sienten_cansancio(init):-button(_,_,boton_iniciar_4(_),"&Iniciar",320,35,95,30).

boton_iniciar_4(press) :-
    Linea = 150,
    text_out(50, 120, "quienes sienten cansancio?"),
	(	siente(_, cansancio, Linea)->
		siente(X, cansancio, Linea),
		text_out(50, Linea, print(X)),nl,ln
	;
		message("resultado", "Nadie siente dolor de estomago.",s)
	).

%crear la subfuncion para que facaio alivia
que_faramaco_alivia(press):-
window( _, _, ventana_que_farmaco_alivia(_), "que farmaco aliviara a un individuo en particular?", 150,50,800,800).
ventana_que_farmaco_alivia(init):-button(_,_,boton_iniciar_5(_),"&Iniciar",320,35,95,30).

boton_iniciar_5(press) :-
    Linea = 150,
    read(Nombre, "Ingrese el nombre del individuo que desea consultar su farmaco:"),
    text_out(50, 120, "que farmaco aliviara al individuo?"),
    (   aliviara_con(Nombre, X, Linea)
    ->  text_out(50, Linea, print(X))
    ;   text_out(50, Linea, "No se encontrado un farmaco para aliviar al individuo")
    ),
    nl.

primera(press):-  
window( _, _, ventana_primera(_), "ï¿½Quï¿½ noble es rufian?", 150,50,450,450).
segunda(press):-  
window( _, _, ventana_segunda(_), "ï¿½Quien es suceptible por Pedro?", 150,50,450,450).
tercera(press):-  
window( _, _, ventana_tercera(_), "ï¿½Quien es suceptible por Pedro?", 150,50,450,450).

ventana_primera(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP1(_),"&Iniciar",320,35,95,30).

ventana_segunda(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP2(_),"&Iniciar",320,35,95,30).

ventana_tercera(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP3(_),"&Iniciar",320,35,95,30).



boton_iniciarP1(press):-
    	Linea:= 100,
	text_out(50,Linea,"ï¿½Quien es rufian?"),
	noble_rufian(X, Linea),
	text_out(50,Linea, print(X)),ln.
	
boton_iniciarP2(press):-
    	Linea:= 100,
	text_out(50,Linea,"ï¿½Quien es suceptible de ser raptada por Pedro?"),
	rufian_rapta(Pedro,Y),
	text_out(50,Linea, print(Y)),ln.
	
boton_iniciarP3(press):-
    	Linea:= 100,
	text_out(50,Linea,"ï¿½Quien puede raptar a Monica?"),
	desea(X,monica),
	text_out(50,Linea, print(X)),ln.











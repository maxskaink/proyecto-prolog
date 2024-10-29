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


es_hombre(X) :- esHombre(X).
es_hombre(X) :- esMujer(X).

es_padre_de(Padre,Madre,Hijo) :- sonPadres_de(Padre,Madre,Hijo); sonPadres_de(Madre,Padre,Hijo),!.
son_esposos(Esposa, Esposo):- sonEsposos(Esposa, Esposo), sonEsposos(Eposo, Esposa).

es_hermana_de(Hermana, Hermano) :- 
    esMujer(Hermana), 
    es_padre_de(X,Y,Hermana), 
    es_padre_de(X,Y.Hermano),
	Hermano\= Hermana.

es_hermano_de(Hermano, Hermana) :- 
   	esHombre(Hermano),
    es_padre_de(Padre, Madre, Hermana),
    es_padre_de(Padre, Madre, Hermano),
	Hermano\= Hermana.
es_hijo_de(Hijo, Padre) :-
    esHombre(Hijo),
    (sonPadres_de(Padre, _, Hijo); sonPadres_de(_,Padre,Hijo)).

es_hija_de(Hija, Padre) :-
    esMujer(Hija),
    (sonPadres_de(Padre, _, Hija); sonPadres_de(_,Padre,Hija)).
es_tia(Tia, SobrinaOSobrino) :-
    esMujer(Tia),
    es_hermana_de(Tia, MadreOPadre),
    es_padre_de(MadreOPadre, _, SobrinaOSobrino).
es_tio(Tio, SobrinaOSobrino) :-
    esHombre(Tio),
    es_hermano_de(Tio, MadreOPadre), es_padre_de(MadreOPadre, _, SobrinaOSobrino).



%============= Interfaz =============

?-window(_, _,crea_ventana(),"Aplicacion",150, 100, 400, 300).

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
arbol_generazional(init):-
menu(normal, _,_,preguntas(_),"&preguntas").   
    

preguntas(press):-
window( _, _, ventana_preguntas(_), "&informe", 150,500,800,800).

ventana_preguntas(init):-
button(_,_,boton_jimenaHermanos(_),"¿Jimena tiene hermanos?",20,35,200,30),
button(_,_,boton_quienEsHermanoDeJimena(_),"&¿Quien es el hermano de jimena?",420,35,250,30),
button(_,_,boton_padres_carlos(_),"&¿Quienes son los padres de carlos?",20,100,250,30),

button(_,_,boton_jimenaHijaJavier(_),"&¿Es jimena hija de javier?",220,35,200,30),
button(_,_,boton_esCarlosHijaMaria(_),"&¿es carlos hija de maria?",500,100,250,30),
button(_,_,boton_esJoaquinHijoBelkis(_),"&¿es joaquin hijo de Belkis?",20,200,250,30),

button(_,_,boton_esLuisaHijaCarlos(_),"&¿es Luisa hija de carlos?",270,200,250,30),
button(_,_,boton_esMatiasHijoLisandro(_),"&¿Es matias hijo de lisandro?",520,200,260,30),
button(_,_,boton_esMatiasHijoJimena(_),"&¿Es matias hijo de jimena?",20,300,250,30),

button(_,_,boton_quienHijoDeJimena(_),"&¿Quien es hijo de jimena?",270,100,200,30),
button(_,_,boton_esJoaqinHermanoMatias(_),"&¿Es joaquin hermano de matias?",270,300,260,30),
button(_,_,boton_quienEsHeramanodeJoaquin(_),"&¿Quien es el hermano de joaquin?",520,300,260,30),

button(_,_,boton_estio(_),"&¿Es tio?",220,350,260,30),
button(_,_,boton_estia(_),"&¿Es tia?",500,350,260,30).



boton_jimenaHermanos(press):-
     Linea = 100,
    (es_hermana_de(jimena, Hermano) -> 
        message("jimena tiene hermanos", "SI", i) 
    ; 
        message("jimena tiene hermanos", "NO", i) 
    ), nl.

boton_quienEsHermanoDeJimena(press):-
    (es_hermana_de(jimena, Hermano) -> 
        message("quien es hermanode jimiena", print(Hermano), i) 
    ; 
        message("quien es hermanode jimiena", "NO", i) 
    ), nl.


boton_jimenaHijaJavier(press) :-
     Linea = 100,
    (es_hija_de(jimena, javier) -> 
        message("hijos de jimena", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.


boton_padres_carlos(press) :-
	es_padre_de( Padre,Madre, carlos),
     message("el padre de: ", print(Padre), i), 
     message("el padre de: ", print(Madre), i),nl. 

boton_esJimenaHijaJavier(press):-
    (es_hija_de(jimena, javier) -> 
        message("es jimean hija de javier", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_esCarlosHijaMaria(press):-
    (es_hijo_de(carlos, maria) -> 
        message("es carlos hijo de maria", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_esJoaquinHijoBelkis(press):-
    (es_hijo_de(joquin, belkis) -> 
        message("es joaquin hijo de belkis", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.

boton_esLuisaHijaCarlos(press):-
    (es_hija_de(luisa, carlos) -> 
        message("es luisa hija de carlos", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_esMatiasHijoLisandro(press):-
    (es_hijo_de(matias, lisandro) -> 
        message("es matias hijo de lisandro", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_esMatiasHijoJimena(press):-
    (es_hijo_de(matias, jimena) -> 
        message("es matias hijo de jimena", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_esJoaqinHermanoMatias(press):-
    (es_hermano_de(joaquin, matias) -> 
        message("es joaquin hermano de Matias", "SI", i) 
    ; 
        message("hijos de jimena", "NO", i) 
    ), nl.
boton_quienHijoDeJimena(press):-
    es_hijo_de(X, jimena),message("hijo de Jimena ", print(X), i) ,nl,ln.


boton_quienEsHeramanodeJoaquin(press):-
    es_hermano_de(joaquin, X) ,message("hermanos de joaquin", print(X), i) ,nl,ln.
boton_estia(press):-
	read(Nombre, "Ingrese el nombre de la persona que desea consultar:"),
    es_tia(Nombre, X) ,message("es tia", print(X), i) ,nl,ln.
boton_estio(press):-
	read(Nombre, "Ingrese el nombre de la persona que desea consultar:"),
    es_tio(Nombre, X) ,message("es tia", print(X), i) ,nl,ln.


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
	padece_de(X, gripe, Linea),
	text_out(50, Linea, print(X)),nl,ln.

%crear la subfuncion para quienes padecen dolor de estomago
quienes_sienten_dolor_de_estomago(press):-
window( _, _, ventana_sienten_dolor_de_estomago(_), "Quienes de dolor de esomago?", 150,50,800,800).
ventana_sienten_dolor_de_estomago(init):-button(_,_,boton_iniciar_3(_),"&Iniciar",320,35,95,30).

boton_iniciar_3(press) :-
    Linea = 150,
    text_out(50, 120, "Quienes de dolor de esomago?"),
	siente(X, dolorEstomago, Linea),
	text_out(50, Linea, print(X)),nl,ln.


%crear la subfuncion para quienes sienten cansancio
quienes_sienten_cansancio(press):-
window( _, _, ventana_sienten_cansancio(_), "quienes sienten cansancio?", 150,50,450,450).
ventana_sienten_cansancio(init):-button(_,_,boton_iniciar_4(_),"&Iniciar",320,35,95,30).

boton_iniciar_4(press) :-
    Linea = 150,
    text_out(50, 120, "quienes sienten cansancio?"),
	siente(X, cansancio, Linea),
	text_out(50, Linea, print(X)),nl,ln.

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











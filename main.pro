%Hechos OLA INVERNAL

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

%Reglas OLA INVERNAL

padece_de(Persona, Enfermedad) :- 
    padece(Persona, Enfermedad).
siente(Persona, Sintoma) :- 
    padece(Persona, Enfermedad), es_sintoma(Sintoma, Enfermedad).
alivia(Farmaco, Enfermedad) :- 
    suprime(Farmaco, Sintoma), es_sintoma(Sintoma, Enfermedad). 

aliviara_con(Farmaco, Persona) :-
    padece(Persona, Enfermedad), alivia(Farmaco, Enfermedad).

%%Preguntas
%1. ¿Qué enfermedad padece un individuo en particular? (este individuo será ingresado desde teclado).
%?- padece_de(gustavo, X), write("gustavo padece de: "), write(X),nl,ln.
%2. ¿Quiénes padecen gripe?
%?- padece_de(X, gripe), write(X), nl, ln.
%3. ¿Quiénes sienten dolor de estómago?
%?- siente(X, dolorEstomago), write(X), nl, ln.
%4. ¿Quiénes sienten cansancio?
%?-siente(X, cansancio), write(X), nl, ln.
%5. ¿Qué fármaco aliviará a un individuo particular? (este individuo será ingresado desde teclado).
%?-aliviara_con(X, gustavo), write("gustavo aliviara con: "), write(X),nl,ln.

%Hechos ARBOL FAMILIAR

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

%Reglas ARBOL FAMILIAR


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

%Preguntas

%?-es_hermana_de(jimena, X).


%Interfaz

%-----------------------------------------

?-window(_, _,crea_ventana(),"Aplicaci�n",150, 50, 450, 450).

%crea el men�

crea_ventana(init):- 
menu(pop_up, _,_,salir(_),"&ARCHIVO"), 
menu(pop_up, _,_,ola_invernal(_),"&OLA INVERNAL").
menu(pop_up, _,_,arbol_generazional(_),"&ARBOL GENERACIONAL").

%Crea el Submen� Salir
salir(init):-	
menu(normal, _,_,cerrar_ven(_),"&Salir").
cerrar_ven(press):- close_window(X).


%--------------------------------------------
%crear el submen� l�gico
ola_invernal(init):-
menu(normal, _,_,que_enfermedad_padece(_),"&Que enfermedad padece un individuo en particular?"),
menu(normal, _,_,quienes_padecen_gripe(_),"&Quienes padecen gripe?"),
menu(normal, _,_,quienes_sienten_dolor_de_estomago(_),"&Quienes sienten dolor de estomago?"),
menu(normal, _,_,quienes_sienten_cansancio(_),"&�Qui�nes sienten cansancio?"),
menu(normal, _,_,que_faramaco_alivia(_),"&�Qu� f�rmaco aliviar� a un individuo particular? ").

    
    

%crear la subfunci�on para prestar enfermedad padece

que_enfermedad_padece(press):-  
window( _, _, ventana_que_enfermedad_padece(_), "Que enfermedad padece un individuo en particular?", 150,50,450,450).
ventana_que_enfermedad_padece(press):-button(_,_,boton_iniciarPL(_),"&Iniciar",320,35,95,30).

boton_iniciarPL(press):-
    Linea :=150,
    text_out(50,100,"Quien le puede prestar un libro a Jimena?"),
    presta_libro(X,jimena,Linea),
    text_out(50, Linea, print(X)),ln.


%crear la subfuncion para quienes padecen gripe
quienes_padecen_gripe(press):-
window( _, _, ventana_quienes_padecen_de_gripe(_), "Quienes padecen de gripa?", 150,50,450,450).
ventana_quienes_padecen_de_gripe(init):-button(_,_,boton_iniciarPL(_),"&Iniciar",320,35,95,30).


%crear la subfuncion para quienes padecen dolor de estomago
quienes_sienten_dolor_de_estomago(press):-
window( _, _, ventana_sienten_dolor_de_estomago(_), "Quienes de dolor de esomago", 150,50,450,450).
ventana_sienten_dolor_de_estomago(init):-button(_,_,boton_iniciarPL(_),"&Iniciar",320,35,95,30).



%crear la subfuncion para quienes sienten cansancio
quienes_sienten_cansancio(press):-
window( _, _, ventana_sienten_cansancio(_), "quienes sienten cansancio", 150,50,450,450).
ventana_sienten_cansancio(init):-button(_,_,boton_iniciarPL(_),"&Iniciar",320,35,95,30).


%crear la subfuncion para que facaio alivia
que_faramaco_alivia(press):-
window( _, _, ventana_que_farmaco_alivia(_), "que farmaco alivia", 150,50,450,450).
ventana_que_farmaco_alivia(init):-button(_,_,boton_iniciarPL(_),"&Iniciar",320,35,95,30).


primera(press):-  
window( _, _, ventana_primera(_), "�Qu� noble es rufian?", 150,50,450,450).
segunda(press):-  
window( _, _, ventana_segunda(_), "�Quien es suceptible por Pedro?", 150,50,450,450).
tercera(press):-  
window( _, _, ventana_tercera(_), "�Quien es suceptible por Pedro?", 150,50,450,450).

ventana_primera(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP1(_),"&Iniciar",320,35,95,30).

ventana_segunda(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP2(_),"&Iniciar",320,35,95,30).

ventana_tercera(init):- window_brush(_, rgb(166, 129, 182)),
                    button(_,_,boton_iniciarP3(_),"&Iniciar",320,35,95,30).



boton_iniciarP1(press):-
    	Linea:= 100,
	text_out(50,Linea,"�Quien es rufian?"),
	noble_rufian(X, Linea),
	text_out(50,Linea, print(X)),ln.
	
boton_iniciarP2(press):-
    	Linea:= 100,
	text_out(50,Linea,"�Quien es suceptible de ser raptada por Pedro?"),
	rufian_rapta(Pedro,Y),
	text_out(50,Linea, print(Y)),ln.
	
boton_iniciarP3(press):-
    	Linea:= 100,
	text_out(50,Linea,"�Quien puede raptar a Monica?"),
	desea(X,monica),
	text_out(50,Linea, print(X)),ln.











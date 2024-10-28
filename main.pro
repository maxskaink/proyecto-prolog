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
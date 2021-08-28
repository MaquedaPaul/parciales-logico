%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - tieneCaracterPara Seleccionador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 :-style_check(-discontiguous).
es/2.
odiaCasa/2.
casa/1.
mago/1.
tieneCaracterPara/2.
permiteEntrar/2.
tieneCaracterPara/2.
podriaQuedarEn/2.
cadenaDeAmistades/1.


%Harry
es(corajudo,harry).
es(amistoso,harry).
es(orgulloso,harry).
es(inteligente,harry).
es(mestizo,harry).
odiaCasa(harry,slytherin).

%Draco
es(orgulloso,draco).
es(inteligente,draco).
es(puro,draco).
odiaCasa(draco,hufflepuff).

%Hermione
es(orgulloso,hermione).
es(inteligente,hermione).
es(impuro,hermione).
es(responsable,hermione).

casa(gryffindor).
casa(ravenclaw).
casa(slytherin).
casa(hufflepuff).

mago(harry).
mago(draco).
mago(hermione).





permiteEntrar(Mago,Casa):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

permiteEntrar(Mago,slytherin):-
    not(es(impuro,Mago)).

caracteristicaBuscada(gryffindor,corajudo).
caracteristicaBuscada(slytherin,inteligente).
caracteristicaBuscada(slytherin,orgulloso).
caracteristicaBuscada(ravenclaw,inteligente).
caracteristicaBuscada(ravenclaw,responsable).
caracteristicaBuscada(hufflepuff,corajudo).


tieneCaracterPara(Casa,Mago):-
    casa(Casa),
    mago(Mago),
    forall(caracteristicaBuscada(Casa,Caracteristica),es(Caracteristica,Mago)).




podriaQuedarEn(Mago,Casa):-
    tieneCaracterPara(Casa,Mago),
    permiteEntrar(Mago,Casa),
    not(odiaCasa(Mago,Casa)).

podriaQuedarEn(hermione,gryffindor).

cadenaDeAmistades(Magos):-
    %%son todos amistosos
    todosAmistosos(Magos),
    mismaCasaSiguiente(Magos).
    %nth1(Posicion,Mago,Magos),
    %nth1(Posicion+1,Mago2,Magos),
    %podriaQuedarEn(Mago,Casa),
    %podriaQuedarEn(Mago2,Casa).

mismaCasaSiguiente(Magos):-
    forall(consecutivos(Mago1,Mago2,Magos),podrianQuedarEnMismaCasa(Mago1,Mago2)).

podrianQuedarEnMismaCasa(Mago1,Mago2):-
    podriaQuedarEn(Mago1,Casa),
    podriaQuedarEn(Mago2,Casa),
    Mago1 \= Mago2.

todosAmistosos(Magos):-
    forall(member(Mago,Magos),es(amistoso,Mago)).

consecutivos(Anterior, Siguiente, Lista):-
    nth1(IndiceAnterior, Lista, Anterior),
    IndiceSiguiente is IndiceAnterior + 1,
    nth1(IndiceSiguiente, Lista, Siguiente).



%Con recursividad.
% cadenaDeCasas(Magos)
/*
cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
  puedeQuedarSeleccionadoPara(Mago1, Casa),
  puedeQuedarSeleccionadoPara(Mago2, Casa),
  cadenaDeCasas([Mago2 | MagosSiguientes]).
cadenaDeCasas([_]).
cadenaDeCasas([]).
*/
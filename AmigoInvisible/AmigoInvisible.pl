 :-style_check(-discontiguous).

%nacio(Fecha, Persona).
nacio(fecha(9, 9, 1994), juan).
nacio(fecha(26, 3, 1992), aye).
nacio(fecha(22, 12, 1995), feche).

%Punto 1
anterior(fecha(_, _, AnioAnterior), fecha(_, _ , Anio)):- AnioAnterior < Anio.
anterior(fecha(_, MesAnterior, Anio), fecha(_, Mes, Anio)):- MesAnterior < Mes.
anterior(fecha(DiaAnterior, Mes, Anio), fecha(Dia, Mes, Anio)):- DiaAnterior < Dia.

anteriorEnUnAnio(fecha(_, MesAnterior), fecha(_, Mes)):- MesAnterior < Mes.

anteriorEnUnAnio(fecha(DiaAnterior, Mes), fecha(Dia, Mes)):- DiaAnterior < Dia.



hoyEs(fecha(29, 8, 2021)).

dia(fecha(Dia,_,_), Dia).
mes(fecha(_, Mes,_), Mes).

yaPaso(Persona):-
    nacio(fecha(Dia, Mes, _), Persona),
    hoyEs(fecha(OtroDia, OtroMes, _)),
    anteriorEnUnAnio(fecha(Dia, Mes), fecha(OtroDia, OtroMes)).


%podriaRegalarle(OtroPersona, Persona, Fecha):-


%regalo(Regalador, Regalado, Regalo, Fecha)-

leRegalo(juan, feche, libro(terryPratchet, fantasia), 2018).
leRegalo(juan, aye, producto(harryPotter), 2019).
leRegalo(juan, aye, cerveza(artesanal,roja), 2020).
leRegalo(juan, feche, cerveza(quilmes,rubia), 2021).

leRegalo(aye, feche, libro(terryPratchet, fantasia), 2019).
leRegalo(aye, juan, libro(stanislawLem, scifi), 2020).

leRegalo(feche, juan, cerveza(artesanal, rubia), 2019).
leRegalo(feche, juan, producto(pokemon), 2020).
leRegalo(feche, aye, libro(maryShelley, terror), 2021).

podriaRegalarle(OtraPersona, Persona, Fecha):-
    nacio(_,OtraPersona),
    nacio(_,Persona),
    OtraPersona \= Persona,
    not(leRegalo(Persona, _, _, Fecha)),
    not(yaPaso(OtraPersona)),
    not(recibioRegaloEn(OtraPersona, Fecha)).


recibioRegaloEn(Persona, Fecha):-
    leRegalo(_,Persona,_,Fecha).


%Punto 3

esBuenRegalo(Persona, Regalo):-
    leGusta(Persona, Regalo).

leGusta(aye, cerveza(heneiken, rubia)).
leGusta(aye, producto(harryPotter)).
leGusta(juan, libro(_, scifi)).
leGusta(juan, libro(_, terror)).
leGusta(juan, Regalo):-
    esCaro(Regalo).

autor(libro(Autor,_),Autor).

leGusta(feche, producto(monsterHunster)).
leGusta(feche, Libro):-
    autor(Libro, terryPratchet),
    not(esCaro(Libro)).

esCaro(libro(rayBradbury, scifi)).
esCaro(libro(_, novela)).
esCaro(cerveza(artesanal, _)).


habilRegalador(Persona):-
    leRegalo(Persona, _, Regalo, _),
    forall((leRegalo(Persona,OtraPersona,Regalo,_), Persona \= OtraPersona),
    esBuenRegalo(OtraPersona, Regalo)),
    nuncaHizoDosRegalosParecidos(Persona).


nuncaHizoDosRegalosParecidos(Persona):-
    forall(regaloDosRegalosDistintos(Persona, Regalo, OtroRegalo),
    not(esParecido(Regalo, OtroRegalo))).

regaloDosRegalosDistintos(Persona, Regalo, OtroRegalo):-
    leRegalo(Persona,_,Regalo,_),
    leRegalo(Persona,_,OtroRegalo,_),
    Regalo \= OtroRegalo.

esParecido(cerveza(_,_),cerveza(_,_)).
esParecido(libro(_, Genero), libro(_, Genero)).

recibioRegaloYLeGusto(Persona, Regalo):-
    leRegalo(_, Persona, Regalo, _),
    leGusta(Persona, Regalo).



esMonotematico(Persona):-
    nacio(_,Persona),
    forall((recibioRegaloYLeGusto(Persona,Regalo),
    recibioRegaloYLeGusto(Persona, OtroRegalo),
    Regalo \= OtroRegalo),
    esParecido(Regalo, OtroRegalo)).




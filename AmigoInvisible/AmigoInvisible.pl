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

leRegalo(juan, feche, libroTP, 2018).
leRegalo(juan, aye, productoHP, 2019).
leRegalo(juan, aye, cervezaRoja, 2020).
leRegalo(juan, feche, libroTP, 2021).

leRegalo(aye, feche, libroTP, 2019).
leRegalo(aye, juan, libroSL, 2020).

leRegalo(feche, juan, cervezaRubia, 2019).
leRegalo(feche, juan, productoP, 2020).
leRegalo(feche, aye, libroMS, 2021).

podriaRegalarle(OtraPersona, Persona, Fecha):-
    nacio(_,OtraPersona),
    nacio(_,Persona),
    OtraPersona \= Persona,
    not(leRegalo(Persona, _, _, Fecha)),
    not(yaPaso(OtraPersona)),
    not(recibioRegaloEn(OtraPersona, Fecha)).


recibioRegaloEn(Persona, Fecha):-
    leRegalo(_,Persona,_,Fecha).





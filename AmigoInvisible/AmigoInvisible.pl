%nacio(Fecha, Persona).
nacio(fecha(9, 7, 1994), juan).
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




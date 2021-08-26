%Base de conocimientos

cumple(dodain,tiempo(dia(lunes),horario(9,15))).
cumple(dodain,tiempo(dia(miercoles),horario(9,15))).
cumple(dodain,tiempo(dia(viernes),horario(9,15))).

cumple(lucas,tiempo(dia(martes),horario(10,20))).

cumple(juanC,tiempo(dia(sabado),horario(18,22))).
cumple(juanC,tiempo(dia(domingo),horario(18,22))).

cumple(juanFdS,tiempo(dia(jueves),horario(10,20))).
cumple(juanFdS,tiempo(dia(viernes),horario(12,20))).

cumple(leoC,tiempo(dia(lunes),horario(14,18))).
cumple(leoC,tiempo(dia(miercoles),horario(14,18))).

cumple(martu,tiempo(dia(miercoles),horario(23,24))).



%Punto 1
%cumple(Persona, Horario)

cumple(vale,Tiempo):-
    cumple(dodain,Tiempo).
cumple(vale, Tiempo):-
    cumple(juanC,Tiempo).

%cumple(maiu,tiempo(dia(lunes), horario(0,8))).
%cumple(maiu,tiempo(dia(martes), horario(0,8))).


atiende(Empleado, DiaPuntual, HoraPuntual):-
    cumple(Empleado, 
    tiempo(dia(DiaPuntual), horario(HoraInicial, HoraFinal))),
    between(HoraInicial, HoraFinal, HoraPuntual).




dia(tiempo(dia(Dia),_),Dia).

horario(tiempo(_,horario(Comienzo,Final)),Comienzo,Final).



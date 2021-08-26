%Base de conocimientos

cumple(dodain,tiempo(dia(lunes),horario(9,15))).
cumple(dodain,tiempo(dia(miercoles),horario(9,15))).
cumple(dodain,tiempo(dia(viernes),horario(9,15))).

cumple(lucas,tiempo(dia(martes),horario(10,20))).

cumple(josesito,tiempo(dia(domingo),horario(0,12))).
cumple(carlos,tiempo(dia(domingo),horario(12,24))).

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

%Punto 2
atiende(Empleado, DiaPuntual, HoraPuntual):-
    cumple(Empleado, 
    tiempo(dia(DiaPuntual), horario(HoraInicial, HoraFinal))),
    between(HoraInicial, HoraFinal, HoraPuntual).


dia(tiempo(dia(Dia),_),Dia).
horario(tiempo(_,horario(Comienzo,Final)),Comienzo,Final).

%Punto 3


foreverAlone(Hora, Dia, Empleado):-
    distinct(Empleado, foreverAloneSub(Hora, Dia, Empleado)).

foreverAloneSub(Hora, Dia, Empleado):-
    atiende(Empleado, Dia, Hora),
    not((atiende(OtroEmpleado, Dia, Hora), Empleado \= OtroEmpleado)).


posibilidadesDeAtencion(Dia, Empleado):-
    distinct(Empleado, posibilidadesDeAtencionSub(Dia,Empleado)).

posibilidadesDeAtencionSub(Dia,Empleado):-
    not(horarioCompleto(Dia)),
    Empleado = "nadie".

posibilidadesDeAtencionSub(Dia, Empleado):-
    atiende(Empleado, Dia, _).

posibilidadesDeAtencionSub(Dia, Empleados):-
    findall(([Empleado | OtrosEmpleados]), compartenHorario(Dia, Empleado, OtrosEmpleados), Empleados).




horarioCompleto(Dia):-
    cumple(_,tiempo(dia(Dia),_)),
    forall(between(0,24,Hora), atiende(_,Dia, Hora)).


compartenHorario(Dia, Empleado, OtroEmpleado):-
    atiende(Empleado, Dia, Hora),
    atiende(OtroEmpleado, Dia, Hora),
    Empleado \= OtroEmpleado.


/* quienAtiende == atiende
posibilidadesAtencion(Dia, Personas):-
  findall(Persona, distinct(Persona, quienAtiende(Persona, Dia, _)), PersonasPosibles),
  combinar(PersonasPosibles, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-combinar(PersonasPosibles, Personas).
*/



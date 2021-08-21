De vez en cuando, la recompensa de un pirata puede aumentar a partir de ciertos eventos que la Marina y el Gobierno Mundial consideran importantes, por eso registramos cuál fue el impacto de distintos eventos sobre su recompensa, siendo la suma de todos esos montos la recompensa actual por su captura. También sabemos a qué tripulación pertenece cada pirata.


Consideraciones generales:

Todos los predicados principales deben ser inversibles.
Es importante no repetir lógica, desarrollar soluciones declarativas y con buenas abstracciones.

Desarrollar los predicados necesarios para resolver los siguientes requerimientos:

1)
Relacionar a dos tripulaciones y un evento si ambas participaron del mismo, lo cual sucede si dicho evento impactó en la recompensa de al menos un pirata de cada tripulación. Por ejemplo:
- Debería cumplirse para las tripulaciones heart y sombreroDePaja siendo dressrosa el evento del cual participaron ambas tripulaciones.
- No deberían haber dos tripulaciones que participen de llegadaAEastBlue, sólo los piratasDeArlong participaron de ese evento.


2)
Saber quién fue el pirata que más se destacó en un evento, en base al impacto que haya tenido su recompensa.
En el caso del evento de dressrosa sería Zoro, porque su recompensa subió en $200.000.000.

3)
Saber si un pirata pasó desapercibido en un evento, que se cumple si su recompensa no se vio impactada por dicho evento a pesar de que su tripulación participó del mismo.
Por ejemplo esto sería cierto para Bepo para el evento dressrosa, pero no para el evento sabaody por el cual su recompensa aumentó, ni para eniesLobby porque su tripulación no participó.

4)
Saber cuál es la recompensa total de una tripulación, que es la suma de las recompensas actuales de sus miembros.

5)
Saber si una tripulación es temible. Lo es si todos sus integrantes son peligrosos o si la recompensa total de la tripulación supera los $500.000.000. Consideramos peligrosos a piratas cuya recompensa actual supere los $100.000.000.
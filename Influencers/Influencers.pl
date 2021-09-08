
usuarioTiene(ana, redSocial(youtube, 3000000)).
usuarioTiene(ana, redSocial(instagram, 2700000)).
usuarioTiene(ana, redSocial(tiktok, 1000000)).
usuarioTiene(ana, redSocial(twitch, 2)).

usuarioTiene(beto, redSocial(twitch, 120000)).
usuarioTiene(beto, redSocial(youtube, 6000000)).
usuarioTiene(beto, redSocial(instagram, 1100000)).

usuarioTiene(cami, redSocial(tiktok, 2000)).

usuarioTiene(dani, redSocial(youtube, 1000000)).

usuarioTiene(evelyn, redSocial(instagram, 1)).

redSocial(youtube).
redSocial(tiktok).
redSocial(instagram).
redSocial(twitch).



influencer(Usuario):-
    seguidoresEnRedesSociales(Usuario, Seguidores),
    Seguidores > 10000.


seguidoresEn(Usuario, RedSocial, Seguidores):-
    usuarioTiene(Usuario, redSocial(RedSocial, Seguidores)).

seguidoresEnRedesSociales(Usuario, TotalSeguidores):-
    usuarioTiene(Usuario, _),
    findall(Seguidor, seguidoresEn(Usuario, _, Seguidor), Seguidores),
    sum_list(Seguidores, TotalSeguidores).


omnipresente(Influencer):-
    influencer(Influencer),
    forall(redSocialExistente(RedSocial), usuarioTiene(Influencer, redSocial(RedSocial,_))).


redSocialExistente(RedSocial):-
    usuarioTiene(_,redSocial(RedSocial, Personas)),
    Personas >= 1.

redSocial(redSocial(RedSocial,_), RedSocial).

exclusivo(Influencer):-
    influencer(Influencer),
    usuarioTiene(Influencer, RedSocial),
    forall(usuarioTiene(Influencer, OtraRedSocial), RedSocial == OtraRedSocial).


%video(RedSocial, [Personas], duracion(Tiempo))
%foto(RedSocial, [Personas])
%stream(RedSocial, Tematica).

publico(ana, tiktok, video([beto, evelyn], 1)).
publico(ana, tiktok, video([ana], 1)).
publico(ana, instagram, foto([beto, evelyn])).

publico(beto, instagram, foto([])).

publico(cami, twitch, stream(leagueOfLegends)).

publico(cami, youtube, video([cami], 5)).

publico(evelyn, instagram, foto([cami, evelyn])).

tematica(leagueOfLegends).
tematica(minecraft).
tematica(aoe).

relacionadaConVideojuegos(leagueOfLegends).
relacionadaConVideojuegos(minecraft).
relacionadaConVideojuegos(aoe).

adictiva(RedSocial):-
    publico(_, RedSocial,_),
    forall(publico(_,RedSocial, Contenido), esAdictivo(Contenido)).


esAdictivo(video(_,Minutos)):-
    Minutos < 3.

esAdictivo(stream(Tematica)):-
    relacionadaConVideojuegos(Tematica).

esAdictivo(foto(Personas)):-
    length(Personas, Cantidad),
    Cantidad < 4.


colaboran(Usuario, OtroUsuario):-
    colaboroCon(Usuario, OtroUsuario).

colaboran(Usuario, OtroUsuario):-
    colaboroCon(OtroUsuario, Usuario).

colaboroCon(Usuario, OtroUsuario):-
    publico(Usuario, _, Contenido),
    aparecenEn(Contenido, Personas),
    member(OtroUsuario, Personas),
    Usuario \= OtroUsuario.


aparecenEn(stream(Tematica), [Persona]):-
    publico(Persona, _, stream(Tematica)).

aparecenEn(foto(Personas), Personas).

aparecenEn(video(Personas, _), Personas).


caminoALaFama(Usuario):-
    usuarioTiene(Usuario,_),
    not(influencer(Usuario)),
    influencer(Influencer),
    publico(Influencer, _, Contenido),
    aparecenEn(Contenido, Personas),
    member(Usuario, Personas),
    Usuario \= Influencer.

caminoALaFama(Usuario):-
    usuarioTiene(Usuario,_),
    not(influencer(Usuario)),
    publico(Influencer, _, Contenido),
    aparecenEn(Contenido, Personas),
    member(OtroUsuario, Personas),
    publico(OtroUsuario, _, OtroContenido),
    aparecenEn(OtroContenido, OtrasPersonas),
    member(OtroUsuario, OtrasPersonas),
    Usuario \= Influencer,
    Usuario \= OtroUsuario,
    OtroUsuario \= Influencer.




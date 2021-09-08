
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

publico(ana, video(tiktok, [beto, evelyn], 1)).
publico(ana, video(tiktok, [ana], 1)).
publico(ana, foto(instagram, [beto, evelyn])).

publico(beto, foto(instagram, [])).

publico(cami, stream(twitch, leagueOfLegends)).

publico(cami, video(youtube, [cami], 5)).

publico(evelyn, foto(instagram, [cami, evelyn])).

tematica(leagueOfLegends).
tematica(minecraft).
tematica(aoe).


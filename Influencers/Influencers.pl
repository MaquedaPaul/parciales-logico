
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



influencer(Usuario):-
    seguidoresEnRedesSociales(Usuario, Seguidores),
    Seguidores > 10000.


seguidoresEn(Usuario, RedSocial, Seguidores):-
    usuarioTiene(Usuario, redSocial(RedSocial, Seguidores)).

seguidoresEnRedesSociales(Usuario, TotalSeguidores):-
    usuarioTiene(Usuario, _),
    findall(Seguidor, seguidoresEn(Usuario, _, Seguidor), Seguidores),
    sum_list(Seguidores, TotalSeguidores).





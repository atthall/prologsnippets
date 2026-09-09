% STRUKTURÁLIS TÉNYEK (Fixen az 5 elemű listára szabva)
helye(X, [X, _, _, _, _]).
helye(X, [_, X, _, _, _]).
helye(X, [_, _, X, _, _]).
helye(X, [_, _, _, X, _]).
helye(X, [_, _, _, _, X]).

% 4 eset, amikor X közvetlenül Y előtt van
koveti(X, Y, [X, Y, _, _, _]).
koveti(X, Y, [_, X, Y, _, _]).
koveti(X, Y, [_, _, X, Y, _]).
koveti(X, Y, [_, _, _, X, Y]).

% 10 eset, amikor X valahol Y előtt helyezkedik el
elotte(X, Y, [X, Y, _, _, _]).
elotte(X, Y, [X, _, Y, _, _]).
elotte(X, Y, [X, _, _, Y, _]).
elotte(X, Y, [X, _, _, _, Y]).
elotte(X, Y, [_, X, Y, _, _]).
elotte(X, Y, [_, X, _, Y, _]).
elotte(X, Y, [_, X, _, _, Y]).
elotte(X, Y, [_, _, X, Y, _]).
elotte(X, Y, [_, _, X, _, Y]).
elotte(X, Y, [_, _, _, X, Y]).

megold(Sorrend) :-
    % POZICIONÁLÁS
    % 1. Gombos jobb helyezést ért el, mint Cecília és mint a Sztár-Klub versenyzője,
    % de rosszabbat, mint Zabos.
    elotte(v(gombos,_,_), v(_,cecilia,_), Sorrend),
    elotte(v(gombos,_,_), v(_,_,sztar_klub), Sorrend),
    elotte(v(zabos,_,_), v(gombos,_,_), Sorrend),

    % 2. Az Anyókák képviselője közvetlenül Emília előtt végzett, 
    %    aki közvetlenül Dombos előtt végzett.
    koveti(v(_,_,anyokak), v(_,emilia,_), Sorrend),
    koveti(v(_,emilia,_), v(dombos,_,_), Sorrend),

    % 4. Lombos valahol Amália előtt, aki valahol az Öreg Nénék versenyzője előtt végzett.
    elotte(v(lombos,_,_), v(_,amalia,_), Sorrend),
    elotte(v(_,amalia,_), v(_,_,oreg_nenek), Sorrend),

    % SKATULYAELV (Minden névnek és klubnak lennie kell egy fix helyének)
    helye(v(dombos,_,_), Sorrend),
    helye(v(gombos,_,_), Sorrend),
    helye(v(kabos,_,_), Sorrend),
    helye(v(lombos,_,_), Sorrend),
    helye(v(zabos,_,_), Sorrend),

    helye(v(_,amalia,_), Sorrend),
    helye(v(_,cecilia,_), Sorrend),
    helye(v(_,emilia,_), Sorrend),
    helye(v(_,otilia,_), Sorrend),
    helye(v(_,rozalia,_), Sorrend),

    helye(v(_,_,anyokak), Sorrend),
    helye(v(_,_,mamikak), Sorrend),
    helye(v(_,_,nagyi_klub), Sorrend),
    helye(v(_,_,oreg_nenek), Sorrend),
    helye(v(_,_,sztar_klub), Sorrend),

    % KIZÁRÁSOK
    % 3. Rozália nem a Nagyi-Klub tagja.
    helye(v(_,rozalia,KlRozalia), Sorrend), KlRozalia \= nagyi_klub,
    % 5. Kabos keresztneve nem Cecília és nem Rozália.
    helye(v(kabos,KKabos,_), Sorrend), KKabos \= cecilia, KKabos \= rozalia,
    % 6. Lombos keresztneve nem Emília.
    helye(v(lombos,KLombos,_), Sorrend), KLombos \= emilia,
    % 7. Gombos nem az Öreg Nénék képviseletében játszott.
    helye(v(gombos,_,KlGombos), Sorrend), KlGombos \= oreg_nenek,
    % 8. Emília nem a Sztár-Klub tagja.
    helye(v(_,emilia,KlEmilia), Sorrend), KlEmilia \= sztar_klub,
    % ide kell ez is, mert az 1-ből következik, hogy cecilia nem a sztarklub tagja
    helye(v(_,cecilia,KlCecilia), Sorrend), KlCecilia \= sztar_klub.


?-megold(Sorrend).
Sorrend = [v(lombos,rozalia,mamikak), v(zabos,amalia,anyokak), v(gombos,emilia,nagyi_klub), v(dombos,cecilia,oreg_nenek), v(kabos,otilia,sztar_klub)]


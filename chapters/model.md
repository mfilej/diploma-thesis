# Modeliranje skritih markovskih modelov

Eden izmed večjih izzivov naloge je bila preslikava matematičnih algoritmov za modeliranje skritih markovskih modelov v programsko kodo. V tem delu bomo skušali opisati postopek preslikave, za bistvene algoritme bomo navedli psevdokodo, na koncu pa bomo razložili s kakšnimi težavami smo se srečevali in kako smo jih rešili. Postopek izgradnje modela bi lahko v grobem zastavili na naslednji način, kot je prikazan na sliki \ref{diag:baum_welch}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/baum_welch.pdf}
\end{center}
\caption{Potek postopne izgradnje modela}
\label{diag:baum_welch}
\end{figure}

Imamo torej glavno zanko, kjer se izvaja Baum-Welch algoritem (glej poglavje \ref{ch:hmm:bw}), dokler ni zadoščeno glavnemu pogoju. Algoritem je razdeljen na dva koraka, ki ju imenujemo korak $E$\angl[estimation] in korak $M$\angl[maximization]. V koraku $E$ izračunamo vmesne spremenljivke $\alpha$, $\beta$, $\gamma$ in $\xi$, s pomočjo katerih ocenimo trenutno verjetnost modela
$$\lambda = (a, b, \pi),$$
v koraku $M$ pa na njihovi podlagi izračunamo nov model
$$\bar{\lambda} = (\bar{a}, \bar{b}, \bar{\pi}).$$

\noindent Definiramo še nekaj oznak, ki se bodo uporabljale v nadaljevanju:

\begin{description}[style=multiline,itemsep=0em]
    \item[$N \dots$] število stanj modela;
    \item[$T \dots$] dolžina opazovanega zaporedja;
    \item[$K \dots$] število vseh možnih simbolov (včasih imenovano tudi velikost abecede);
    \item[$\boldsymbol{O} \dots$] opazovana sekvenca, ki je sestavljena iz opazovanih simbolov $\obsseq{1}{2}{T}$;
    \item[$\boldsymbol{V} \dots$] abeceda, sestavljena iz simbolov $(v_1, v_2, \dots, v_K)$.
\end{description}

Pomen besede *simbol* v kontekstu skritih markovskih modelov je različen glede na problemsko domeno, kjer modele uporabljamo. V primeru uporabe modelov za namen generiranja besedil lahko simbol predstavlja črko, skupino črk, besedo … Na podoben način izraz *abeceda* ni nujno povezan s črkami, kot v običajnem smislu, ampak na vse *simbole*, ki lahko nastopajo v besedilu. Ker razvijamo splošnonamenski knjižnjico, smo obdržali tudi splošno izrazoslovje.

V nadaljevanju predstavimo psevdokodo za izračun omenjenih spremenljivk.

## Korak E

Izračun spremenljivke $\alpha$ poteka v fukciji `estimate_alpha`~\eqref{koda:estimate_alpha}, ki je preslikava enačb \eqref{eq:fw:forw:init} in \eqref{eq:fw:forw:loop}.

\input{figures/estimate_alpha_algorithm}

Podobnosti med definicijama $\alpha$ in $\beta$ se pokažeta tudi v podobnosti njunih algoritmov. `estimate_beta`~\eqref{koda:estimate_beta} se razlikuje v izrazu za izračun vsote v notranji zanki, glavna zanka pa gre tokrat od zadnjega stanja nazaj. Algoritem je preslikava enačb \eqref{eq:fw:back:init} in \eqref{eq:fw:back:loop}.

\input{figures/estimate_beta_algorithm}

Ko imamo vrednosti $\alpha$ in $\beta$ lahko nadaljujemo z izračunom verjetnosti modela za posamezno stanje glede na dano opazovano sekvenco. S pomočjo definicije \eqref{eq:bw:xi} začnemo s spremenljivko $\xi$ in jo preslikamo v funkcijo `estimate_xi`~\eqref{koda:estimate_xi}.

\input{figures/estimate_xi_algorithm}

Zaradi zveze \eqref{eq:bw:gamma} med $\xi$ in $\gamma$ lahko slednjo izrazimo v funkciji `estimate_gamma`~\eqref{koda:estimate_gamma} na poenostavljen način.

\input{figures/estimate_gamma_algorithm}

S pomočjo spremenljivke $\alpha$ lahko, kot je pokazano v \eqref{eq:hmm:prob1}, izračunamo tudi verjetnost modela glede na dano opazovano sekvenco (`compute_model_probability`~\eqref{koda:model_prob}).

\input{figures/model_prob_algorithm}

## Korak M

Cilj $M$ koraka je s pomočjo izračunanih vrednosti spremenljivk $\gamma$ in $\xi$ ponovno oceniti parametre $\bar{\pi}$, $\bar{a}$ in $\bar{b}$ za nov model.

Funkcija `reestimate_pi`~\eqref{koda:reestimate_pi} verjetnosti začetnih stanj $\bar{\pi}$ izračuna tako, da enostavno prebere izračunane vrednosti spremenljivke $\bar{\gamma}$ za prvi simbol opazovane sekvence, kot določa enačba \eqref{eq:hmm:reest:pi}.

\input{figures/reestimate_pi_algorithm}

Na tej točki nam preostane še preslikava enačbe za izračun nove vrednosti $\bar{a}$ \eqref{eq:hmm:reest:a} v funkcijo `reestimate_a`~\eqref{koda:reestimate_a} in enačbe za izračun nove vrednosti $\bar{b}$ \eqref{eq:hmm:reest:b} v funkcijo `reestimate_b`~\eqref{koda:reestimate_b}.

\input{figures/reestimate_a_algorithm}
\input{figures/reestimate_b_algorithm}


## Iterativna maksimizacija parametrov {#iter}

Do te točke smo definirali vse ključne funkcije maksimizacijo paramterov modela, sedaj pa jih bomo skupaj povezali v glavno zanko, kot je to prikazano na sliki \ref{diag:baum_welch}. V literaturi~\cite{Xu1996} najdemo dokaze, da takšna maksimizacija modela nujno vodi proti povečanju verjetnosti modela, do točke kjer verjetnost konvergira proti kritični točki. Naš program lahko torej zasnujemo tako, da iteracijo nadaljuje do te kritične točke oz. njenega približka, t.j. točke, kjer se verjetnosti prejšnjega in trenutnega modela razlikujeta za manj kot neka določena vrednost $\varepsilon$\footnote{Izbire vrednosti $\varepsilon$ prepustimo uporabnikom, ker različni problemi zahtevajo različne vrednosti. Za relativno enostaven model smo začeli z vrednostjo $10^{-6}$.}. Da bi se zaščitili pred izbiro premajhne $\varepsilon$ vrednosti, glavno zanko še dodatno omejimo z navzgor omejenim maksimalnim številom ponovitev\footnote{Tudi ta vrednost je nastavljiva, privzeta omejitev je $100$ ponovitev.}.

\input{figures/main_loop_algorithm}

Do sedaj smo opisali temeljne algoritme našega programa, ki pa smo jih mogli do določene mere spremeniti oz. prirediti, da smo dobili željene funkcionalnosti in se izognili določenim težavam. V nadaljevanju bomo predstavili te spremembe, bistvo predstavljenih algoritmov pa se ni spremenilo, kar je tudi vidno v končni izvorni kodi.

## Izbira začetnih parametrov

Postopek iterativnoega izboljševanja parametrov modela opisan v poglavju \ref{iter} zahteva izbiro nekih začetnih parametrov, ki bodo služili kot vhod v iteracijo~\eqref{koda:main_loop}. Dobra izbira parametra lahko vpliva na to, ali bo maksimizacija pripelajla do lokalnega ali globalnega maksimuma~\cite{Rabiner1989}. V literaturi~\cite{Rabiner1989,Bilmes1997} zasledimo dva nezahtevna pristopa, ki se izkažeta za enako dobra: naključne vrednosti in enakomerno\footnote{Prehodu v vsako stanje dodelimo enako verjetnost.} \cite{Lustrek2004} razporejene vrednosti (seveda pod pogojem, da se držimo omejitev stohastičnosti in da so verjetnosti neničelne). Izjema je $b$ parameter modela, kjer se izkaže, da je dobra začetna ocena vrednosti pomembna~\cite{Rabiner1989}. Oceno lahko pridobimo na več načinov, odvisno od tipa podatkov. V našem primeru je vhod besedilo, tako da smo za vrednosti vzeli relativne frekvence pojavljanja simbolov.

## Podpora za mnogotera opazovana zaporedja

Baum-Welch algoritem je v osnovi definiran za maksimizacijo parametrov modela glede na dano opazovano sekvenco. Ker želimo v naši nalogi algoritem uporabiti za namen generiranja besedila, moramo za uspešno učenje modela uporabiti dovolj veliko učno množico, npr. krajšo knjigo dolžine $10.000$ besed. Takšno učno zaporedje nam predstavlja dve težavi: 1) Opazovano zaporedje takšne dolžine bo v koraku $E$ Baum-Welch algoritma za bolj oddaljene simbole izračunalo zelo majhe verjetnosti, ki bodo povzročile napako podkoračitve~\angl[underflow] (s to težavo smo se večkrat srečali zato jo bomo kasneje podrobneje opisali). 2) Zapis celotnega besedila v obliki enega opazovanja sporoča odvisnost zaporedja — povedi, ki nastopijo kasneje, so odvisno od povedi, ki so nastopile prej — ki je ne želimo modelirati (bolj kot odvisnost med povedmi je za nas zanimiva odvisnost med besedami).~\cite{Zhao2011}

V literaturi zasledimo različne načine obravnave mnogoterih zaporedij, od enostavnejših, kjer ima vsako zaporedje enako težo~\cite{Rabiner1989,Bilmes1997}, do kompleksnejših pristopov, kjer imajo lahko modeli različne uteži ali je njihova izbira celo dinamično prepuščena drugim algoritmom.~\cite{Zhao2011,Li2000}  Zaradi narave našega problema smo se odločili, da bomo vsako poved obravnavali kot neodvisno zaporedje. Algoritme za priredbo Baum-Welch algoritma za mnogotera zaporedja smo prevzeli iz enačb v članku \textquotedblleft{}An Erratum for \textquoteleft{}A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition\textquoteright{}\textquotedblright{}~\cite{rabinererratum}.

Algoritmi za izračun spremenljivk $\alpha\eqref{koda:estimate_alpha}, \beta\eqref{koda:estimate_beta}, \gamma\eqref{koda:estimate_gamma}, \xi\eqref{koda:estimate_xi}$ ostanejo enaki, korak $E$ kot celota pa se spremeni do te mere, da sedaj te spremenljivke računamo za vsako opazovano zaporedje  posebej. Če je $\boldsymbol{O}^{(k)}$ $k$-to zaporedje (oz. $k$-ta poved), potem moramo izračunati spremenljivke $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$.

S pomočjo teh spremenljivk najprej izračuanmo verjetnosti posameznih zaporedij glede na trenutni model $P(\boldsymbol{O}^{(k)}|\lambda)$ z nespremenjenim algoritmom \eqref{koda:model_prob}). Verjetnost celotne množice zaporedij glede na trenutni model $P(\boldsymbol{O}|\lambda)$ je nato enaka zmnožku posameznih verjetnosti~\cite{Rabiner1989}.

\begin{equation}
P(\boldsymbol{O}|\lambda) = \prod_{k=1}^K P(\boldsymbol{O}^{(k)}|\lambda)
\label{eq:multi_obs_model_prob}
\end{equation}

Algoritem za računanje verjetnosti modela~\eqref{koda:model_prob} vrača logaritem verjetnosti, zato lahko te vrednosti enostavno seštejemo.

Nazadnje se obrnemo še k posodobitvam za korak $M$, kjer smo priredili izračun algoritmov za maksimizacijo spremenljivk $\bar{\pi}~\eqref{koda:reestimate_pi}, \bar{a}~\eqref{koda:reestimate_a}$ in $\bar{b}~\eqref{koda:reestimate_b}$. Algoritmom smo dodali dodatno zanko, kjer se sprehodimo čez vsa opazovana zaporedja ($k \leftarrow 1$ do $K$), uporabo spremenljivk $\alpha, \beta, \gamma$ in $\xi$ pa smo zamenjali z novimi različicami $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$. Nove vrednosti v števcih in imenovalcih enačb je bilo potrebno sešteti in tako smo dobili vrednosti za modele z mnogoterimi opazovanimi sekvencami. Pomemben korak pri preverjanju pravilnosti je bil, da se je program tudi po spremembah za primer posameznega opazovanega zaporedja še vedno obnašal na enak način kot prej (prvotne specifikacije za posamezna opazovana zaporedja smo ohranili kar se da nedotaknjene).

## Preprečevanje napake podkoračitve

Aplikacija skritih markovskih modelov na dolga opazovana zaporedja zahteva računanje z izredno majnimi verjetnostmi. Takšne majhne vrednosti privedejo do nestabilnosti pri izračunavanju števil v plavajoči vejici~\cite{Mann2006}, med drugim tudi do napake podkoračitve\angl[underflow].

Pri implementaciji našega programa smo to težavo opazili, ko so, že po nekaj iteracijah Baum-Welch algoritma, vse spremenljivke dobile vrednost $0$. Razlog tiči v tem, da ima pri veliki množici vseh možnih zaporedij besed, neko poljubno opazovano zaporedje zelo majhno pogojno verjetnost. Za spopadanje s to težavo obstajata dve pogostejši rešitvi: eden je *lestvičenje*~\angl[scaling, rescaling] pogojnih verjetnosti na podlagi skrbno izbranih faktorjev, drugi pa zamenjava pogojnih verjetnosti z vrednostmi njihovih logaritmov\footnote{Beseda \emph{logaritem} se v tej nalogi vedno nanaša na naravni logaritem.}. Prednost slednjega načina je v tem, da lahko algoritme postopoma spremenimo in vseskozi preverjamo pravilnost sprememb le s tem, da v naših specifikacijah pričakovane vrednosti zamenjamo z njihovimi logaritmi~\cite{Mann2006}.

Vse potrebne priredbe algoritmov v koraku $E$ so zelo nazorno prikazane v članku \textquotedblleft{}Numerically Stable Hidden Markov Model Implementation\textquotedblright{}~\cite{Mann2006}, zato jih tukaj ne bomo posebej navajali.

V koraku $M$ algoritmov ni potrebno spreminjati, z izjemo končnih vrednosti, ki so sedaj logaritmirane, zato na njih v zadnjem koraku uporabimo naravno eksponentno funkcijo $e^x$.

## Simulacija skritih markovskih modelov

Z uspešno maksimiziranim modelom $\lambda$ lahko pričnemo z generiranjem oz. simuliranjem le-tega. Postopek, ki je znatno enostavnejši od maksimiziranja, je definiran v poglavju \ref{theory-hmm-gen}, algoritem \eqref{koda:simulate_hmm} pa postopek predstavi v obliki psevdokode.

\input{figures/simulate_hmm_algorithm}

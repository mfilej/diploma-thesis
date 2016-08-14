# Modeliranje skritih markovskih modelov {#ch:model}

Eden izmed večjih izzivov našega diplomskega dela je bila preslikava matematičnih algoritmov za modeliranje skritih markovskih modelov v programsko kodo. V sledečem poglavju bomo opisali postopek preslikave. Za ključne algoritme bomo navedli psevdokodo, na koncu pa bomo razložili, s kakšnimi težavami smo se srečevali in na kakšen način smo jih rešili.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/baum_welch.pdf}
\end{center}
\caption{Potek postopne izgradnje modela.}
\label{diag:baum_welch}
\end{figure}

Izgradnjo modela smo zastavili na način, prikazan na sliki \ref{diag:baum_welch}. Postopek vključuje glavno zanko, ki izvaja Baum-Welch algoritem (glej poglavje \ref{ch:hmm:bw}). Ko se dovolj približamo kritični točki, se zanka prekine.

Algoritem EM je sestavljen iz dveh korakov – koraka $E$ in koraka $M$. V koraku $E$ izračunamo vmesne vrednosti $\alpha$, $\beta$, $\gamma$ in $\xi$, s pomočjo katerih ocenimo trenutno verjetnost modela
$$\lambda = (a, b, \pi).$$
V koraku $M$ na podlagi dobljenih vrednosti izračunamo nov model
$$\bar{\lambda} = (\bar{a}, \bar{b}, \bar{\pi}).$$

\noindent Definiramo še nekaj oznak, ki jih bomo uporabljali v nadaljevanju:

\begin{description}[style=multiline,itemsep=0em]
    \item[$N \dots$] število stanj modela;
    \item[$T \dots$] dolžina opazovanega zaporedja;
    \item[$K \dots$] število vseh možnih simbolov\footnote{Pomen besede \emph{simbol} je v kontekstu skritih markovskih modelov lahko različen glede na problemsko domeno, v kateri modele uporabljamo. V primeru uporabe modelov za namen tvorjenja naravnega jezika lahko simbol predstavlja črko, skupino črk, besedo ali skupine besed.} (t.i. velikost abecede);
    \item[$\boldsymbol{O} \dots$] opazovana sekvenca, ki je sestavljena iz opazovanih simbolov $\obsseq{1}{2}{T}$;
    \item[$\boldsymbol{V} \dots$] abeceda, sestavljena iz simbolov $(v_1, v_2, \dots, v_K)$.
\end{description}

V nadaljevanju predstavljamo psevdokodo za izračun vrednosti $\alpha$, $\beta$, $\gamma$ in $\xi$.

## Korak E

Izračun spremenljivke $\alpha$ poteka v fukciji `estimate_alpha`~\eqref{koda:estimate_alpha}, ki je preslikava enačb \eqref{eq:fw:forw:init} in \eqref{eq:fw:forw:loop}.

\input{figures/estimate_alpha_algorithm}

Podobnost definicij $\alpha$ in $\beta$ se pokaže tudi v simetriji njunih algoritmov. Algoritem `estimate_beta`~\eqref{koda:estimate_beta} ima drugačen izraz za izračun vsote v notranji zanki. Glavna zanka se v tem primeru izvaja od zadnjega stanja proti prvemu. Algoritem je preslikava enačb \eqref{eq:fw:back:init} in \eqref{eq:fw:back:loop}.

\input{figures/estimate_beta_algorithm}

Ko pridobimo vrednosti $\alpha$ in $\beta$, lahko nadaljujemo z izračunom verjetnosti modela za posamezno stanje glede na dano opazovano zaporedje. Na podlagi definicije \eqref{eq:bw:xi} vrednost $\xi$ preslikamo v funkcijo `estimate_xi`~\eqref{koda:estimate_xi}.

\input{figures/estimate_xi_algorithm}

Na podlagi enačbe \eqref{eq:bw:gamma} lahko vrednost $\gamma$ na poenostavljen način izrazimo v funkciji `estimate_gamma`~\eqref{koda:estimate_gamma}.

\input{figures/estimate_gamma_algorithm}

S pomočjo spremenljivke $\alpha$ lahko, kot je pokazano v \eqref{eq:hmm:prob1}, izračunamo tudi verjetnost modela glede na dano opazovano sekvenco (`compute_model_probability`~\eqref{koda:model_prob}).

\input{figures/model_prob_algorithm}

## Korak M

Cilj koraka $M$ je, na podlagi izračunanih vrednosti $\gamma$ in $\xi$, ponovno oceniti parametre $\bar{\pi}$, $\bar{a}$ in $\bar{b}$ za nov model $\bar{\lambda}$.

Funkcija `reestimate_pi`~\eqref{koda:reestimate_pi} verjetnosti začetnih stanj $\bar{\pi}$ izračuna tako, da enostavno prebere izračunane vrednosti spremenljivke $\bar{\gamma}$ za prvi simbol opazovane sekvence, kot to določa enačba \eqref{eq:hmm:reest:pi}.

\input{figures/reestimate_pi_algorithm}

Sledita še preslikava enačbe za izračun nove vrednosti $\bar{a}$ \eqref{eq:hmm:reest:a} v funkcijo `reestimate_a`~\eqref{koda:reestimate_a} in enačbe za izračun nove vrednosti $\bar{b}$ \eqref{eq:hmm:reest:b} v funkcijo `reestimate_b`~\eqref{koda:reestimate_b}.

\input{figures/reestimate_a_algorithm}
\input{figures/reestimate_b_algorithm}


## Iterativna maksimizacija parametrov {#iter}

Predhodno smo definirali vse ključne funkcije maksimizacijo paramterov modela, sledi pa še povezava v glavno zanko, prikazano na sliki \ref{diag:baum_welch}. V literaturi~\cite{Xu1996} najdemo dokaze, da maksimizacija modela nujno vodi k povečanju verjetnosti modela do stopnje, ko le-ta konvergira proti kritični točki. Naš program lahko torej zasnujemo tako, da iteracijo nadaljuje do omenjene kritične točke oz. njenega približka, t.j. točke, kjer se verjetnosti prejšnjega in trenutnega modela razlikujeta za manj kot izbrano vrednost $\varepsilon$\footnote{Izbire vrednosti $\varepsilon$ prepustimo uporabnikom, ker različni problemi zahtevajo različne vrednosti. Za relativno enostaven model smo začeli z vrednostjo $10^{-6}$.}. Da bi se zaščitili pred izbiro premajhne vrednosti $\varepsilon$, glavno zanko še dodatno omejimo z navzgor omejenim maksimalnim številom ponovitev\footnote{Tudi ta vrednost je nastavljiva, privzeta omejitev je $100$ ponovitev.}.

\input{figures/main_loop_algorithm}

## Izbira začetnih parametrov

Postopek iterativnoega izboljševanja parametrov modela, opisan v poglavju \ref{iter}, zahteva izbiro začetnih parametrov, ki služijo kot vhod v iteracijo~\eqref{koda:main_loop}. Ustrezna izbira parametra vpliva na to, ali bo maksimizacija pripelajla samo do lokalnega ali pa do globalnega maksimuma~\cite{Rabiner1989}. V literaturi~\cite{Rabiner1989,Bilmes1997} zasledimo dva nezahtevna pristopa, ki se izkažeta za enako dobra: naključne vrednosti in enakomerno\footnote{Prehodu v vsako stanje dodelimo enako verjetnost.} \cite{Lustrek2004} razporejene vrednosti (pod pogojem, da se držimo omejitev stohastičnosti in da so verjetnosti neničelne). Izjema je parameter $b$, za katerega se izkaže, da je ustrezna začetna ocena vrednosti pomembna~\cite{Rabiner1989}. Oceno lahko pridobimo na več načinov, odvisno od tipa podatkov. V našem primeru je vhod besedilo, tako da smo za vrednosti vzeli relativne pogostosti pojavljanja simbolov.

## Podpora za mnogotera opazovana zaporedja {#ch:model:multiobs}

Baum-Welch algoritem je v osnovi definiran za maksimizacijo parametrov modela glede na dano opazovano sekvenco. Ker želimo algoritem uporabiti za namen tvorjenja besedila, moramo za uspešno učenje modela uporabiti dovolj veliko učno množico, npr. besedilo s približno $10.000$ besedami. Takšno učno zaporedje prinaša dve težavi:

* Opazovano zaporedje takšne dolžine bo v koraku $E$ Baum-Welch algoritma za bolj oddaljene simbole izračunalo zelo majhe verjetnosti, ki bodo povzročile napako podkoračitve\angl[underflow] (s to težavo smo se večkrat srečali, zato jo bomo kasneje podrobneje opisali).
* Zapis celotnega besedila v obliki enega opazovanja sporoča odvisnost zaporedja, kar pomeni, da so povedi, ki nastopijo kasneje, odvisne od predhodnih. Takšna odvisnost je v našem modelu nezaželjena (bolj kot odvisnost med povedmi je za nas zanimiva odvisnost med besedami).~\cite{Zhao2011}

V literaturi zasledimo različne pristope k obravnavi mnogoterih zaporedij. Pri enostavnejših pristopih ima vsako zaporedje enako težo~\cite{Rabiner1989,Bilmes1997}, pri kompleksnejših pa imajo lahko modeli različne uteži ali pa je njihova izbira celo dinamično prepuščena drugim algoritmom.~\cite{Zhao2011,Li2000}  Zaradi narave našega problema smo se odločili, da bomo vsako poved obravnavali kot neodvisno zaporedje. Algoritme za priredbo Baum-Welch algoritma za mnogotera zaporedja smo prevzeli iz enačb v članku~\cite{rabinererratum}.

Algoritmi za izračun vrednosti $\alpha\eqref{koda:estimate_alpha}, \beta\eqref{koda:estimate_beta}, \gamma\eqref{koda:estimate_gamma}, \xi\eqref{koda:estimate_xi}$ ostanejo enaki, korak $E$ pa se spremeni do te mere, da  vrednosti $\alpha, \beta, \gamma$ in $\xi$ računamo za vsako opazovano zaporedje posebej. Če je $\boldsymbol{O}^{(k)}$ $k$-to zaporedje (oz. $k$-ti stavek), potem moramo izračunati vrednosti $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$.

Z dobljenimi vrednostmi najprej izračuanmo verjetnosti posameznih zaporedij glede na trenutni model $P(\boldsymbol{O}^{(k)}|\lambda)$. Uporabimo algoritem \eqref{koda:model_prob}. Verjetnost celotne množice zaporedij glede na trenutni model $P(\boldsymbol{O}|\lambda)$ je enaka zmnožku posameznih verjetnosti~\cite{Rabiner1989}.

\begin{equation}
P(\boldsymbol{O}|\lambda) = \prod_{k=1}^K P(\boldsymbol{O}^{(k)}|\lambda)
\label{eq:multi_obs_model_prob}
\end{equation}

Vrednosti, izračunane po algoritmu~\eqref{koda:model_prob}, so logaritemi verjetnosti, zato jih lahko enostavno seštejemo.

Sledijo še posodobitve za korak $M$, za katerega smo priredili izračun algoritmov maksimizacije vrednosti $\bar{\pi}~\eqref{koda:reestimate_pi}, \bar{a}~\eqref{koda:reestimate_a}$ in $\bar{b}~\eqref{koda:reestimate_b}$. Algoritmom smo dodali zanko, ki zajema vsa opazovana zaporedja ($k \leftarrow 1$ do $K$). Vrednosti $\alpha, \beta, \gamma$ in $\xi$ smo zamenjali z njihovimi izpeljankami $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$.  

Za preverjanje pravilnosti postopka je pomembno, da lahko za primer posameznega opazovanega zaporedja dobimo enake vrednosti tako s prilagojenim kot z izvirnim algoritmom. Specifikacije za posamezna opazovana zaporedja ohranimo kar se da nedotaknjene.

## Preprečevanje napake podkoračitve {#ch:model:underflow}

Aplikacija skritih markovskih modelov na dolga opazovana zaporedja zahteva računanje z izredno majnimi verjetnostmi. Le-te privedejo do nestabilnosti pri izračunavanju števil v plavajoči vejici~\cite{Mann2006}, med njimi tudi do napake podkoračitve\angl[underflow].

Podkoračitev se pojavi že po nekaj iteracijah Baum-Welch algoritma (spremenljivke dobijo vrednost $0$). Razlog je v tem, da ima pri veliki množici vseh možnih zaporedij besed, neko poljubno opazovano zaporedje zelo majhno pogojno verjetnost. Za spopadanje s to težavo obstajata dve najpogostejši rešitvi:

* *lestvičenje*\angl[scaling, rescaling] pogojnih verjetnosti na podlagi skrbno izbranih faktorjev;
* zamenjava pogojnih verjetnosti z vrednostmi njihovih logaritmov\footnote{Beseda \emph{logaritem} se v tej nalogi nanaša izključno na naravni logaritem.}.

Prednost slednje je v tem, da lahko algoritme spreminjamo postopoma in pravilnost sprememb vseskozi preverjamo. Preverjanje izvajamo tako, da v naših specifikacijah pričakovane vrednosti zamenjamo z njihovimi logaritmi~\cite{Mann2006}.

Vse potrebne priredbe algoritmov v koraku $E$ so zelo nazorno prikazane v članku~\cite{Mann2006}, zato jih tukaj ne bomo posebej navajali.

V koraku $M$ algoritmov ni potrebno spreminjati, z izjemo končnih vrednosti, ki so logaritmirane, zato na njih v zadnjem koraku uporabimo naravno eksponentno funkcijo $e^x$.

## Simulacija skritih markovskih modelov

Po uspešni maksimizaciji modela lahko pričnemo z njegovim simuliranjem. Postopek, ki je enostavnejši od maksimizizacije, je definiran v poglavju \ref{theory-hmm-gen}. Algoritem \eqref{koda:simulate_hmm} postopek predstavi v obliki psevdokode.

\input{figures/simulate_hmm_algorithm}

# Skriti markovski modeli {#ch:theo}

Za verjetnostne porazdelitve, ki sestavljajo statistične modele, predpostavljamo, da aproksimirajo pojave iz realnega sveta. Ti približki so včasih dovolj dobri, da lahko te pojave z zadostno natančnostjo napovedujemo ali generiramo vzorce, ki so reprezentativni za statistično populacijo. Primer takih statističnih modelov so skriti markovski modeli. Uporabni so pri sekvenciranju DNA molekul, prepoznavanju govora, napovedovanju gibanj na finančnih trgih, ipd. V tem poglavju bomo spoznali teoretične temelje, ki omogočajo obstoj skritih markovskih modelov.

Verjetnostna teorija je ključnega pomena pri
razumevanju, izražanju in obravnavi koncepta negotovosti. Skupaj s teorijo odločanja nam omogočata, da na podlagi vseh informacij, ki jih imamo na voljo, opravimo optimalne napovedi, četudi so ti podatki nepopolni ali dvoumni~\cite{Bishop2006}.

V tem delu smo po \cite{Bishop2006} povzeli nekaj konceptov verjetnostne teorije, ki so ključnega pomena za razlago teoretičnih osnov skritih markovskih modelov.

\begin{description}
    \item[Pravilo vsote:] $$p(X) = \sum_{Y} p(X, Y)$$
    \item[Pravilo produkta:] $$p(X, Y) = p(Y | X) p(X)$$
\end{description}

$p(X, Y)$ je v tem primeru presek ali produkt verjetnosti, ki ga opišemo kot verjetnost, da se zgodita $X$ in $Y$. Na podoben način je količina $p(Y | X)$ pogojna verjetnost, oz. verjetnost da se zgodi $Y$ glede na $X$.

*Bayesovo pravilo* \eqref{eq:bayes} določa zvezo med pogojnimi verjetnostmi.

\begin{equation}
p(Y | X) = \frac{p(X | Y)p(Y)}{p(X)}
\label{eq:bayes}
\end{equation}

Spremenljivki $X$ in $Y$ sta *neodvisni*, kadar velja \eqref{eq:neod}.

\begin{equation}
p(X, Y) = p(X)p(Y)
\label{eq:neod}
\end{equation}

*Stohastični proces*, včasih imenovan *naključni* proces, je zbirka naključnih spremenljivk, ki predstavljajo spreminjanje nekega sistema skozi čas~\cite{Zhao2011}.

## Diskretni viri informacij {#ch:theo:vir}

Teorija informacije obravnava *diskretne vire informacije*, t.j. *naključne procese*, ki oddajajo informacijo zajeto v diskretnih signalih. Njihovo matematično modeliranje temelji na opazovanju nizov simbolov, ki jih le-ti oddajajo. Končni, neprazni množici teh simbolov $V = \{v_1, v_2, \dots, v_K\}, K \in \mathbb{N}$ pravimo tudi *abeceda vira*. Niz naključnih spremenljivk $$\{X_t, t = 1, 2, \dots, n\},$$ ki ustrezajo simbolom, ki jih vir oddaja, označimo z $X_1, X_2, \dots, X_n$, kjer $X_n$ označuje $n$-ti simbol oddane sekvence. Enačba \eqref{eq:porazd} definira porazdelitev verjetnosti, da vir odda znak $x_1$ v trenutku $t = 1$, $x_2$ v trenutku $t = 2$, \dots\ in znak $x_n$ v trenutku $t$, enačba \eqref{eq:stac} pa definira lastnost *stacionarnosti*. Za stacionarne vire pravimo, da se njihove verjetnostne lastnosti s časom ne spreminjajo~\cite{Pavesic2010}.
 
\begin{equation}
P(X_1 = x_1, \dots, X_n = x_n) = P(X_1 = x_1, \dots, X_n = x_n) \geq 0
\label{eq:porazd}
\end{equation}

\begin{equation}
P(X_{k+1} = x_1, \dots, X_{k+n} = x_n) = P(x_1, \dots, x_n)\label{eq:stac}
\end{equation}

Lastnost *ergodičnosti* pomeni, da lahko porazdelitev verjetnosti vira določimo iz samo enega dovolj dolgega niza simbolov~\cite{Pavesic2010}. Jezike lahko definiramo kot ergodične vire~\cite{Bruen2005}.

Diskretne vire nadaljno delimo na:

* vire *brez spomina*, za katere velja, da verjetnost za v danem trenutku oddan simbol ni odvisna od predhodno oddanega zaporedja simbolov;
* vire *s spominom*, za katere velja, da je oddaja simbola v danem trenutku odvisna od določenega števila ($k$) predhodno oddanih simbolov. Število $k$ določa *red* vira.

Vire s spominom prvega reda imenujemo *markovski*\footnote{V slovenski literaturi najdemo prevoda \emph{markovov}~\cite{Pavesic2010} in \emph{markovski}~\cite{Gyergyk1988}. V tem  besedilu smo se odločili za uporabo slednjega.} \eqref{eq:markovski}. Za markovske vire velja, da je oddaja simbola v $n$-tem trenutku odvisna le od simbola, ki je oddan v trenutku $n-1$. Enačba \eqref{eq:preh} definira še *prehodno verjetnost* $p_{ij}$, t.j. verjetnost, da je vir v trenutku $n+1$ oddal znak $x_j \in A$ pri pogoju, da je v trenutku $n$ oddal znak $x_i \in A$~\cite{Pavesic2010}.

\begin{align}
\begin{split}
&P(X_{n+1} = x_{n+1} \given (X_{n} = x_n, \dots, X_1 = x_1)) = \\
= &P(X_{n+1} = x_{n+1} \given X_{n} = x_n)
\end{split}
\label{eq:markovski}
\end{align}

\begin{equation}
p_{ij} = P(X{n+1} = x_j \given X_n = xi)
\label{eq:preh}
\end{equation}

Če privzamemo, da vsebuje abeceda $|A| = m$ simbolov, potem lahko določimo $1 \leq i, j \leq m$. Sedaj vrednosti $p_{ij}$ sestavljajo *matriko prehodnih verjetnosti* $P = [p_{ij}]$ (slika \ref{diag:prehmat}).

\begin{figure}
$$
P = 
 \begin{bmatrix}
  p_{11} & p_{12} & \cdots & p_{1m} \\
  p_{21} & p_{22} & \cdots & p_{2m} \\
  \vdots & \vdots & \ddots & \vdots \\
  p_{m1} & p_{m2} & \cdots & p_{mm} 
 \end{bmatrix}
$$
\caption{Matrika prehodnih verjetnosti.}
\label{diag:prehmat}
\end{figure}

*Markovska veriga* ali *markovski model* je stohastični proces, za katerega velja markovska lastnost \eqref{eq:markovski}~\cite{Bishop2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/markov_chain.pdf}
\end{center}
\caption{Markovska veriga prvega reda z množico opazovanj ${x_n}$, kjer je porazdelitev $p(x_n | x_{n-1})$ posameznega opazovanja $x_n$ odvisna od izida predhodnega opazovanja $x_{n-1}$.}
\label{diag:markov_chain}
\end{figure}

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/hidden_markov_model.pdf}
\end{center}
\caption{Markovska veriga z latentnimi (neopazovanimi ali prikritimi) spremenljivkami $\{z_n\}$. Vsako opazovanje $\{x_n\}$ je pogojeno pripadajoči latentni spremenljivki.}
\label{diag:markov_latent}
\end{figure}

## Skriti markovski modeli

Slika \ref{diag:markov_latent} prestavlja osnovo, iz katere med drugim izhajajo tudi skriti markovski modeli~\cite{Bishop2006}.

Za markovske modele velja, da so v vsakem trenutku v enem izmed $N$ stanj iz množice $S = \{S_1, S_2, \dots, S_N\}$. Ob časih $t = 0, 1, \dots, T$ prehajajo med različnimi stanji $S_n, n \in N$.

_Skriti_ markovski modeli so izpeljanka markoviskih modelov, kjer opazovalci poznajo le neko vejrentostno funkcijo stanja, samo stanje pa je skrito~\cite{Lustrek2004}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/hmm_trans.pdf}
\end{center}
\caption{Skriti markovski model, predstavljen na razprt način. Prehodi med stanji so prikazani skozi čas. Vsak stolpec v tem diagramu predstavlja eno izmed latentnih spremenljivk $z_n$ iz slike \ref{diag:markov_latent}.}
\label{diag:hmm_trans}
\end{figure}

Skriti markovski model $\lambda$ je definiran v obliki\footnote{Zapis običajno poenostavimo kot $\lambda = (A, B, \pi)$.}

\begin{equation}
\lambda = (A, B, \pi, N, M),
\label{eq:theory:model}
\end{equation}

\noindent kjer so $A, B, \pi, N$ in $M$, parametri, ki opisujejo model~\cite{Rabiner1989}.

\begin{description}

\item[$\boldsymbol{N}\dots$] Število stanj modela.

\item[$\boldsymbol{M}\dots$] Število različnih simbolov opazovanja oz. velikost abecede.
\item[$\boldsymbol{A}\dots$] Matrika verjetnosti prehodov stanj $A = [a_{ij}]$, ki opisuje verjetnost, da se bo sistem ob času $t+1$ znašel v stanju $S_j$ ob dejstvu, da je ob času $t$ bil v stanju $S_i$:

\begin{equation}
a_{ij} = P(q_{t+1} = S_j \given q_t = S_i),\qquad 1 \leq i, j \leq N.
\label{eq:hmm_a}
\end{equation}

\item[$\boldsymbol{B}\dots$] Matrika verjetnosti oddanih simbolov $B = [b_j(k)]$, ki opisuje verjetnost, da bo sistem, ki se ob času $t$ nahaja v stanju $S_j$, oddal simbol $v_k$:

\begin{align}
b_j(k) = P(v_k \given q_t = S_j),\qquad &1 \leq j \leq N, \\
&1 \leq k \leq M.\nonumber
\label{eq:hmm_b}
\end{align}

\item[$\boldsymbol{\pi}\dots$] Začetna porazdelitev stanj $\{\pi_i\}$, kjer velja:

\begin{equation}
\pi_i = P(q_1 = S_i),\qquad 1 \leq i \leq N.
\label{eq:hmm_pi}
\end{equation}

\end{description}

### Uporaba modela za generiranje zaporedij {#theory-hmm-gen}

Primerno definirani skriti markovski modeli lahko delujejo kot generatorji zaporedij simbolov na naslednji način:

1. izberemo začetno stanje $q_1 = S_i$ glede na $\pi$;
2. nastavimo $t = 1$;
3. izberemo $O_t = v_k$ glede na trenutno stanje $S_i$ in porazdelitev verjetnosti, ki jih določa $b_i(k)$;
4. opravimo prehod v novo stanje $q_{t+1} = S_j$ glede na prehodne verjentosti iz stanja $S_i$, ki jih določa $a_{ij}$;
5. nastavimo $t = t + 1$; če je $t < T$ se vrnemo na točko 3; sicer postopek zaključimo.

Omenjeni postopek lahko uporabimo tako za generiranje simbolov, kot za ugotavljanje, na kakšen način je določeno opazovano zaporedje najverjetneje nastalo~\cite{Rabiner1989}.

### Tri osnovna vprašanja skritih markovskih modelov {#ch:hmm:3prob}

Za uporabo skritih markovskih modelov pri reševanju praktičnih izzivov moramo najprej odgovoriti na tri osnovna vprašanja, ki smo jih povzeli po \cite{Rabiner1989}:

1. Glede na dano opazovano zaporedje $O = \obsseq{1}{2}{T}$ in model $\lambda = (A, B, \pi)$ določiti $P(O | \lambda)$ — t.j. verjetnost opazovanega zaporedja glede na model. To vprašanje lahko zastavimo tudi na drugačen način: kako dobro se določen model prilega danemu opazovanemu zaporedju? Če izbiramo med konkurenčnimi modeli nam odgovor na to vprašanje pomaga izbrati najboljšega.
2.  Glede na dano opazovano zaporedje $O = \obsseq{1}{2}{T}$ in model $\lambda$ izbrati pripadajoče zaporedje stanj $Q = q_1  q_2 \cdots q_T$, ki se najbolje prilega opazovanemu zaporedju (ga najbolj smiselno pojasnjuje). To vprašanje obravnava *skriti* del modela.
3. Prilagoditi parametre modela $\lambda = (A, B, \pi)$, tako, da maksimiziramo $P(O | \lambda)$.

Opazovana zaporedja, ki jih uporabimo za optimizacijo parametrov modela imenujemo *učna zaporedja*, ker z njimi model “učimo”. Problem učenja je v večini primerov najpomembnejši od treh, ker nam omogoča modeliranje pojavov iz resničnega sveta~\cite{Rabiner1989}.

V poglavjih \ref{ch:hmm:fb} in \ref{ch:hmm:bw} bomo predstavili odgovore na prvo in tretje vprašanje, katerih rešitev je ključna za izvedbo naše naloge.

## Algoritem *Forward-backward* {#ch:hmm:fb}

*Forward-backward* algoritem zahteva izračun vrednosti *forward* ($\alpha$) in *backward* ($\beta$).

\sloppy
\begin{description}
\item[Vrednost $\boldsymbol{\alpha_t(i)}$ \eqref{eq:fw:forw}] opisuje verjetnost, da se dani model $\lambda$ po delnem opazovanem zaporedju $\obsseq{1}{2}{t}$ znajde v stanju $S_i$. Začetna enačba \eqref{eq:fw:forw:init} in induktivni del \eqref{eq:fw:forw:loop} nam omogočata izračun te vrednosti.

\item[Vrednost $\boldsymbol{\beta_t(i)}$ \eqref{eq:fw:back}]

opisuje verjetnost delnega opazovanega zaporedja $\obsseq{t}{t+1}{T}$, glede na to, da se je bil model $\lambda$ ob času $t$ v stanju $S_i$. Izračun poteka na podoben način, le da se najprej postavi končna vrednost $1$ \eqref{eq:fw:back:init}, nato pa se izračunajo ostale vrednosti v obratnem vrstnem redu od $T-1$ do $1$ \eqref{eq:fw:back:loop}.
\end{description}
\fussy

\input{figures/forward_backward_equations}

Ko izračunamo vrednost $\alpha$ dobimo odgovor na prvo vprašanje, opisano v poglavju \ref{ch:hmm:3prob}. Enačbo \eqref{eq:hmm:prob1} bomo kasneje uporabili kot oceno primernosti modela.

\begin{equation}
P(O \given \lambda) = \sum_{i=1}^N \alpha_T(i)
\label{eq:hmm:prob1}
\end{equation}

## Algoritem *Baum-Welch* {#ch:hmm:bw}

Za opis algoritma *Baum-Welch* je potrebno najprej definirati še vrednosti $\xi$ in $\gamma$.

\begin{description}
\item[Vrednost $\boldsymbol{\xi_t(i, i)}$ \eqref{eq:bw:xi}] opisuje verjetnost, da se model $\lambda$ pri opazovanju zaporedja $O$ ob času $t$ znajde v stanju $S_i$ in v stanju $S_j$ ob času $t+1$.

\item[Vrednost $\boldsymbol{\gamma_t(i)}$ \eqref{eq:bw:gamma}] opisuje verjetnost, da se model $\lambda$ pri opazovanju zaporedja $O$ ob času $t$ znajde v stanju $S_i$.
\end{description}

\input{figures/baum_welch_gamma_xi_equations}

S pomočjo $\xi$ in $\gamma$ lahko sedaj ponovno ocenimo parametre in tako dobimo nov model $\bar{\lambda} = (\bar{A}, \bar{B}, \bar{\pi})$.

\input{figures/baum_welch_reestimate_equations}

V literaturi \cite{Li2000,Ramage2007,Bilmes1997} je dokazano, da za tako pridobljen model $\bar{\lambda}$ velja ena izmed naslednjih dveh točk:

1. model $\bar{\lambda}$ določa kritično točko kjer velja $\boldsymbol{\bar{\lambda} = \lambda}$;
2. $\boldsymbol{P(O \given \bar{\lambda}) > P(O \given \lambda)}$, kar pomeni, da smo dobili nov model $\bar{\lambda}$, ki bolje pojasnjuje zaporedje $O$ kot njegov predhodnik.

Na podlagi zgornjih dveh točk lahko model iterativno izboljšujemo tako, da $\lambda$ vsakič zamenjamo z izračuannim $\bar{\lambda}$, dokler se ne približamo kritični točki~\cite{Rabiner1989}.

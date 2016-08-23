# Skriti markovski modeli {#ch:theo}

Za verjetnostne porazdelitve, ki sestavljajo statistične modele, predpostavljamo, da približno ocenjujejo pojave iz realnega sveta. Ti približki so včasih dovolj dobri, da lahko pojave z zadostno natančnostjo napovedujemo ali tvorimo za statistično populacijo reprezentativne vzorce. Primer takih statističnih modelov so skriti markovski modeli. Uporabni so pri določanju zaporedja nukleotidov molekul DNK, prepoznavanju govora, napovedovanju gibanj na finančnih trgih, ipd. V tem poglavju bomo predstavili teoretične temelje, na katerih so nastavljeni skriti markovski modeli.

Verjetnostna teorija je ključnega pomena pri
razumevanju, izražanju in obravnavi koncepta negotovosti. Skupaj s teorijo odločanja omogočata, da se na podlagi vseh razpoložljivih informacij, pa čeprav nepopolnih ali dvoumnih, optimalno odločamo ~\cite{Bishop2006}.

V nadaljevanju bomo po \cite{Bishop2006} povzeli nekaj konceptov verjetnostne teorije, ki so ključnega pomena za razlago teoretičnih osnov skritih markovskih modelov.

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

Teorija informacij obravnava *diskretne vire informacije*, t.j. *naključne procese*, ki oddajajo informacijo zajeto v diskretnih signalih. Modeliranje diskretnih virov temelji na opazovanju nizov simbolov, ki jih viri oddajajo. Končni, neprazni množici simbolov

$$
\check{\mathbf{Z}} = \{v_1, v_2, \dots, v_K\},\;K \in \mathbb{N}
$$

\noindent pravimo tudi *abeceda vira*. Simboli, ki jih vir oddaja, ustrezajo nizu naključnih spremenljivk

$$\{X_t,\;t = 1, 2, \dots, n\}.$$

\noindent Označimo jih z $X_1, X_2, \dots, X_n$, kjer $X_n$ označuje $n$-ti simbol oddanega zaporedja. Enačba \eqref{eq:porazd} opisuje porazdelitev verjetnosti, da vir odda znak $x_1$ v trenutku $t = 1$, znak $x_2$ v trenutku $t = 2$, \dots\ in znak $x_n$ v trenutku $t=n$.

Enačba \eqref{eq:stac} definira lastnost *stacionarnosti*. Za stacionarne vire pravimo, da se njihove verjetnostne lastnosti s časom ne spreminjajo~\cite{Pavesic2010}.
 
\begin{equation}
P(X_1 = x_1, \dots, X_n = x_n) \geq 0
\label{eq:porazd}
\end{equation}

\begin{equation}
P(X_{k+1} = x_1, \dots, X_{k+n} = x_n) = P(x_1, \dots, x_n)\label{eq:stac}
\end{equation}

Lastnost *ergodičnosti* pomeni, da lahko porazdelitev verjetnosti vira\footnote{Tudi jezike lahko definiramo kot ergodične vire~\cite{Bruen2005}.} določimo na podlagi enega samega, ustrezno dolgega niza simbolov~\cite{Pavesic2010}.

Diskretne vire delimo na:

* vire *brez spomina*, za katere velja, da verjetnost v danem trenutku oddanega simbola ni odvisna od predhodno oddanega zaporedja simbolov;
* vire *s spominom*, za katere velja, da je oddaja simbola v danem trenutku odvisna od števila ($k$) predhodno oddanih simbolov. Število $k$ določa *red* vira.

Vire s spominom prvega reda imenujemo *markovski viri*\footnote{V slovenski literaturi najdemo prevoda \emph{markovov}~\cite{Pavesic2010} in \emph{markovski}~\cite{Gyergyk1988}. V tem  besedilu smo se odločili za uporabo slednjega.} \eqref{eq:markovski}. Za le-te velja, da je oddaja simbola v trenutku $t$ odvisna le od simbola, ki je oddan v trenutku $t-1$.

Enačba \eqref{eq:preh} definira še *prehodno verjetnost* $p_{ij}$, t.j. verjetnost, da je vir v trenutku $n+1$ oddal znak $x_j \in A$ pri pogoju, da je v trenutku $n$ oddal znak $x_i \in A$~\cite{Pavesic2010}.

\begin{align}
\begin{split}
&P(X_{n+1} = x_{n+1} \given (X_{n} = x_n, \dots, X_1 = x_1)) = \\
= &P(X_{n+1} = x_{n+1} \given X_{n} = x_n)
\end{split}
\label{eq:markovski}
\end{align}

\begin{equation}
p_{ij} = P(X_{n+1} = x_j \given X_n = xi)
\label{eq:preh}
\end{equation}

\begin{equation}
P = 
 \begin{bmatrix}
  p_{11} & p_{12} & \cdots & p_{1m} \\
  p_{21} & p_{22} & \cdots & p_{2m} \\
  \vdots & \vdots & \ddots & \vdots \\
  p_{m1} & p_{m2} & \cdots & p_{mm} 
 \end{bmatrix}
\label{eq:prehmat}
\end{equation}

Če privzamemo, da vsebuje abeceda $|\check{\mathbf{Z}}| = m$ simbolov, potem lahko določimo $1 \leq i, j \leq m$. Vrednosti $p_{ij}$ sestavljajo *matriko prehodnih verjetnosti* $P = [p_{ij}]$ \eqref{eq:prehmat}.

*Markovska veriga* ali *markovski model* je stohastični proces, za katerega velja markovska lastnost \eqref{eq:markovski}~\cite{Bishop2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/markov_chain.pdf}
\end{center}
\caption{Markovska veriga prvega reda.}
\label{diag:markov_chain}
\end{figure}

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/hidden_markov_model.pdf}
\end{center}
\caption{Markovska veriga z latentnimi spremenljivkami.}
\label{diag:markov_latent}
\end{figure}

## Skriti markovski modeli

Na sliki \ref{diag:markov_chain} je markovska veriga prvega reda z množico opazovanj ${x_n}$, kjer je porazdelitev $p(x_n | x_{n-1})$ posameznega opazovanja $x_n$ odvisna od izida predhodnega opazovanja $x_{n-1}$.

Slika \ref{diag:markov_latent} prikazuje markovsko verigo z latentnimi (neopazovanimi ali prikritimi) spremenljivkami $\{z_n\}$. Vsako opazovanje $\{x_n\}$ je pogojeno pripadajoči latentni spremenljivki. Le-te so vidne v stolpcih diagrama na sliki \ref{diag:hmm_trans}, ki prikazuje prehode med stanji v različnih trenutkih. To je osnova, iz katere med drugim izhajajo tudi skriti markovski modeli~\cite{Bishop2006}.

Za markovske modele velja, da so v vsakem trenutku v enem izmed $N$ stanj iz množice $Q = \{Q_1, Q_2, \dots, Q_N\}$. Ob trenutkih $t = 0, 1, \dots, T$ prehajajo med različnimi stanji $Q_n, n \in N$.

_Skriti_ markovski modeli so izpeljanka markovskih modelov, za katere opazovalci poznajo le vejrentostno funkcijo stanja. Stanje, v katerem se model v določenem trenutku nahaja, pa opazovalcem ostane skrito~\cite{Lustrek2004}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/hmm_trans.pdf}
\end{center}
\caption{Skriti markovski model, predstavljen na razprt način.}
\label{diag:hmm_trans}
\end{figure}

Za sledeče definicije smo vpeljali označbo \eqref{eq:currstate}, ki označuje, da se model ob trenutku $t$ nahaja v skritem stanju $Q_n$.

\begin{equation}
q^{[t]} = Q_n
\label{eq:currstate}
\end{equation}

Skriti markovski model $\lambda$ je definiran v obliki\footnote{Zapis običajno poenostavimo kot $\lambda = (A, B, \pi)$.}

\begin{equation}
\lambda = (A, B, \pi, N, M),
\label{eq:theory:model}
\end{equation}

\noindent kjer so $A, B, \pi, N$ in $M$ parametri, ki opisujejo model~\cite{Rabiner1989}:

\begin{description}

\item[$\boldsymbol{N}\dots$] Število stanj modela.

\item[$\boldsymbol{M}\dots$] Število različnih opazovanih simbolov oz. velikost abecede.
\item[$\boldsymbol{A}\dots$] Matrika verjetnosti prehodov stanj $A = [a_{ij}]$, ki opisuje verjetnost, da se bo sistem ob trenutku $t+1$ znašel v stanju $Q_j$ ob dejstvu, da je bil ob trenutku $t$ v stanju $Q_i$:

\begin{equation}
a_{ij} = P(q^{[t+1]} = Q_j \given q^{[t]} = Q_i),\qquad 1 \leq i, j \leq N.
\label{eq:hmm_a}
\end{equation}

\item[$\boldsymbol{B}\dots$] Matrika verjetnosti oddanih simbolov $B = [b_j(k)]$, ki opisuje verjetnost, da bo sistem, ki se nahaja v stanju $Q_j$, oddal simbol $v_k \in \check{\mathbf{Z}}$:

\begin{align}
b_j(k) = P(v_k \given q^{[t]} = Q_j),\qquad &1 \leq j \leq N, \\
&1 \leq k \leq M.\nonumber
\label{eq:hmm_b}
\end{align}

\item[$\boldsymbol{\pi}\dots$] Začetna porazdelitev stanj $\{\pi_i\}$, kjer velja:

\begin{equation}
\pi_i = P(q^{[0]} = Q_i),\qquad 1 \leq i \leq N.
\label{eq:hmm_pi}
\end{equation}

\end{description}


\noindent Parametri $T, K$ in $O$ pa opisujejo opazovana zaporedja:

\begin{description}
\item[$\boldsymbol{K}$ \dots] število vseh simbolov abecede, $K = |\check{\mathbf{Z}}|$.

\item[$\boldsymbol{T}$ \dots] dolžina opazovanega zaporedja.

\item[$\boldsymbol{O}$ \dots] opazovano zaporedje, kjer opazovanja $O_t$ predstavljajo simbole abecede $\check{\mathbf{Z}}$.
\begin{equation}
O = \obsseq{1}{2}{T}
\label{eq:obsseq}
\end{equation}
\end{description}

### Uporaba modela za tvorjenje zaporedij {#theory-hmm-gen}

Primerno definirani skriti markovski modeli lahko tvorijo zaporedja simbolov dolžine $T$ na naslednji način:

1. izberemo začetno stanje $q^{[0]} = Q_i$ glede na $\pi$;
2. nastavimo $t = 0$;
3. izberemo izhodni simbol $O_t = v_k$ glede na trenutno stanje $Q_i$ in porazdelitev verjetnosti, ki jih določa $b_i(k)$;
4. opravimo prehod v novo stanje $q^{[t+1]} = Q_j$ glede na prehodne verjentosti iz stanja $Q_i$, ki jih določa $a_{ij}$;
5. nastavimo $t = t + 1$; če je $t < T$ se vrnemo na točko 3; sicer postopek zaključimo.

Navedeni postopek lahko uporabimo tako za tvorjenje zaporedij simbolov, kot za ugotavljanje, na kakšen način je določeno opazovano zaporedje najverjetneje nastalo~\cite{Rabiner1989}.

### Temeljni problemi skritih markovskih modelov {#ch:hmm:3prob}

Pred uporabo skritih markovskih modelov za reševanje praktičnih izzivov moramo najprej rešiti temeljne probleme, ki smo jih povzeli po \cite{Rabiner1989}:

1. Glede na dano opazovano zaporedje $O$ \eqref{eq:obsseq} in model $\lambda$ \eqref{eq:theory:model} moramo določiti $P(O | \lambda)$ — t.j. verjetnost opazovanega zaporedja glede na model. Ta problem lahko zastavimo tudi kot vprašanje: kako dobro se določen model prilega danemu opazovanemu zaporedju? Če izbiramo med konkurenčnimi modeli nam odgovor na to vprašanje pomaga izbrati najboljšega.
2.  Glede na dano opazovano zaporedje $O$ in model $\lambda$ moramo izbrati pripadajoče zaporedje stanj $Q = q_1  q_2 \cdots q_T$, ki se najbolje prilega opazovanemu zaporedju (ga najbolj smiselno pojasnjuje). Ta problem obravnava *skriti* del modela.
3. Prilagoditi moramo parametre modela $\lambda$, tako da maksimiziramo $P(O | \lambda)$. Opazovana zaporedja, ki jih uporabljamo za optimizacijo parametrov modela, imenujemo *učna zaporedja*, ker z njimi model učimo.

Rešitev zadnjega izmed zgoraj naštetih problemov je običajno najpomembnejša, ker nam omogoča modeliranje pojavov iz resničnega sveta~\cite{Rabiner1989}.

V poglavjih \ref{ch:hmm:fb} in \ref{ch:hmm:bw} bomo predstavili rešitve prvega in tretjega problema, ki so ključne za izvedbo našeega dela.

## Algoritem *Forward-backward* {#ch:hmm:fb}

*Forward-backward* algoritem zahteva izračun vrednosti $\mathbf{\alpha}$ (*forward*) in  $\mathbf{\beta}$ (*backward*).

\begin{description}
\item[Vrednost \emph{forward}]
%
\[
\boldsymbol{\alpha_t(i)} = P(\obsseq{1}{2}{t}, q^{[t]} = Q_i \given \lambda)
\hspace{9.8em}\label{eq:fw:forw}
\]
%
opisuje verjetnost, da se dani model $\lambda$ po delnem opazovanem zaporedju $\obsseq{1}{2}{t}$ znajde v stanju $Q_i$. Začetna enačba
%
\begin{equation}
\alpha_1(i) = \pi_i b_i(O_1),\qquad 1 \leq i \leq N.
\label{eq:fw:forw:init}
\end{equation}
%
in induktivni del
%
\begin{align}
\alpha_{t+1}(j) = [\sum_{i=1}^N \alpha_t(i) a_{ij}] b_j(O_{t+1}),
\qquad &1 \leq t \leq T - 1, \nonumber \\
&1 \leq j \leq N.\label{eq:fw:forw:loop}
\end{align}
%
nam omogočata izračun te vrednosti.

\item[Vrednost \emph{backward}]
%
\[
\boldsymbol{\beta_t(i)} = P(\obsseq{t+1}{t+2}{T} \given q^{[t]} = Q_i, \lambda)
\hspace{8em}\label{eq:fw:back}
\]
%
opisuje verjetnost delnega opazovanega zaporedja $\obsseq{t}{t+1}{T}$, ob pogoju, da je bil model $\lambda$ ob trenutku $t$ v stanju $Q_i$. Izračun poteka na podoben način, le da se najprej postavi končna vrednost $1$:
%
\begin{equation}
\beta_T(i) = 1,\qquad 1 \leq i \leq N
\label{eq:fw:back:init},
\end{equation}
%
nato pa se izračunajo ostale vrednosti v obratnem vrstnem redu od $T-1$ do $1$:
%
\begin{align}
\beta_{t}(i) = \sum_{j=1}^N a_{ij} b_j(O_{t+1}) \beta_{t+1}(j),\qquad
&1 \leq j \leq N, \nonumber \\
&t = T-1, T-2, \dots, 1.
\label{eq:fw:back:loop}
\end{align}

\end{description}

Ko izračunamo vrednost $\alpha$, dobimo rešitev prvega problema, opisanega v poglavju \ref{ch:hmm:3prob}. S pomočjo vrednosti $\alpha$ lahko izrazimo tudi oceno primernosti modela $P(O \given \lambda)$.

\begin{equation}
P(O \given \lambda) = \sum_{i=1}^N \alpha_T(i)
\label{eq:hmm:prob1}
\end{equation}

## Algoritem *Baum-Welch* {#ch:hmm:bw}

Za opis algoritma *Baum-Welch* je potrebno najprej definirati še vrednosti $\xi$ in $\gamma$.

\begin{align}
\boldsymbol{\xi_t(i, j)} =& P(q_t = S_i, q_{t+1} = S_j \given O, \lambda) \nonumber \\
=& \frac{
  \alpha_t(i) a_{ij} b_j(O_{t+1}) \beta_{t+1}(j) }{
  \sum_{i=1}^N \sum_{j=1}^N \alpha_t(i) a_{ij} b_j(O_{t+1}) \beta_{t+1}(j) }
\label{eq:bw:xi} 
\end{align}

opisuje verjetnost, da je glede na dano zaporedje $O$ model $\lambda$ ob trenutku $t$ v stanju $Q_i$ in v stanju $Q_j$ ob trenutku $t+1$.

\begin{align}
\boldsymbol{\gamma_t(i)} =& P(q_t = S_i \given O, \lambda) \nonumber \\
=& \sum_{j=1}^N \xi_t(i, j)
\label{eq:bw:gamma}
\end{align}

opisuje verjetnost, da se model $\lambda$ pri opazovanju zaporedja $O$ ob trenutku $t$ znajde v stanju $Q_i$.

S pomočjo $\xi$ in $\gamma$ lahko izvedemo ponovno oceno parametrov modela in tako dobimo nov model $\bar{\lambda} = (\bar{A}, \bar{B}, \bar{\pi})$.

Pričakovano število prehodov iz kateregakoli stanja v stanje $Q_i$ opišemo z

$$
\sum\limits_{t=1}^{T=1} \gamma_t(i),
$$

pričakovano število prehodov iz stanja $Q_i$ v stanje $Q_j$ pa z

$$
\sum\limits_{t=1}^{T=1} \xi_t(i, j).
$$

Ocena verjetnosti, da ob začetnem trenutku $t=1$ izbrano stanje $Q_i$:

\begin{equation}
\boldsymbol{\bar{\pi}}_i\;=\;\gamma_1(i).
\label{eq:hmm:reest:pi}
\end{equation}

Nove verjetnosti prehodov stanj $\bar{a}_{ij}$ ocenimo z razmerjem med pričakovano frekvenco prehodov iz stanja $Q_i$ v stanje $Q_j$ in pričakovanim številom prehodov iz kateregakoli stanja v stanje $Q_i$:

\begin{equation}
\boldsymbol{\bar{a}}_{ij}\;=\;\frac{
\sum\limits_{t=1}^{T=1} \xi_t(i, j)
}{
\sum\limits_{t=1}^{T=1} \gamma_t(i)
}
\label{eq:hmm:reest:a}
\end{equation}

Nove verjetnosti za oddajo simbolov $\bar{b}_j(k)$ ocenimo na podlagi razmerja med pričakovanim številom pojavov simbola $v_k$ v stanju $Q_j$ in skupni frekvenci stanja $Q_j$:

\begin{equation}
\boldsymbol{\bar{b}}_j(k)\;=\;\frac{
\sum\limits_{\substack{t=1 \\ O_t = v_k}}^{T=1} \gamma_t(j)
}{
\sum\limits_{t=1}^{T=1} \gamma_t(j)
}
\label{eq:hmm:reest:b}
\end{equation}

V literaturi \cite{Li2000,Ramage2007,Bilmes1997} je dokazano, da za tako pridobljen model $\bar{\lambda}$ velja ena izmed naslednjih dveh točk:

1. $\boldsymbol{P(O \given \bar{\lambda}) > P(O \given \lambda)}$, kar pomeni, da smo dobili nov model $\bar{\lambda}$, ki bolje pojasnjuje zaporedje $O$ kot njegov predhodnik;
2. $\boldsymbol{P(O \given \bar{\lambda}) = P(O \given \lambda)}$, torej $\boldsymbol{\bar{\lambda} = \lambda}$.

Na podlagi zgornjih dveh točk lahko model iterativno izboljšujemo tako, da $\lambda$ vsakič zamenjamo z izračuannim $\bar{\lambda}$ (1. točka), dokler ne najdemo novega modela (2. točka)~\cite{Rabiner1989}.

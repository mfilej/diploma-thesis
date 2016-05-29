# Teoretične osnove skritih markovskih modelov#Teoretične osnove

Verjetnostna teorija je ključnega pomena pri
razumevanju, izražanju in obdelavi koncepta negotovosti. Skupaj z teorijo odločanja nam omogočata, da na podlagi vseh informacij, ki jih imamo na voljo, opravimo optimalne napovedi, četudi so ti podatki nepopolni ali dvoumni~\cite{Bishop2006}.

V tem delu bomo po \cite{Bishop2006} povzeli nekaj konceptov verjetnostne teorije, ki so ključnega pomena za razlago teoretičnih osnov skritih markovskih modelov.

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

## Diskretni viri informacij

Teorija informacije obravnava *diskretne vire informacije*, t.j. *naključne procese*, ki oddajajo informacijo zajeto v diskretnih signalih, njihovo matematično modeliranje pa temelji na opazovanju nizov simbolov, ki jih le-ti oddajajo. Končni, neprazni množici teh simbolov $V = \{v_1, v_2, \dots, v_K\}, K \in \mathbb{N}$ pravimo tudi *abeceda vira*. Niz naključnih spremenljivk $$\{X_t, t = 1, 2, \dots, n\},$$ ki ustrezajo simbolom, ki jih vir oddaja, označimo z $X_1, X_2, \dots, X_n$, kjer $X_n$ označuje $n$-ti simbol oddane sekvence. Enačba \eqref{eq:porazd} definira porazdelitev verjetnosti, da vir odda znak $x_1$ v trenutku $t = 1$, $x_2$ v trenutku $t = 2$, \dots\ in znak $x_n$ v trenutku $t$, enačba \eqref{eq:stac} pa definira lastnost *stacionarnosti*. Za stacionarne vire pravimo, da se njihove verjetnostne lastnosti s časom ne spreminjajo~\cite{Pavesic2010}.
 
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

Vire s spominom prvega reda imenujemo *markovski viri* \eqref{eq:markovski}. Za markovske vire velja, da je oddaja simbola v $n$-tem trenutku odvisna le od simbola, ki je oddan v trenutku $n-1$. Enačba \eqref{eq:preh} definira še *prehodno verjetnost* $p_{ij}$, t.j. verjetnost, da je vir v trenutku $n+1$ oddal znak $x_j \in A$ pri pogoju, da je v trenutku $n$ oddal znak $x_i \in A$~\cite{Pavesic2010}.

\begin{equation}
\begin{split}
P(X_{n+1} = x_{n+1} | (X_{n} = x_n, \dots, X_1 = x_1)) = \\
= P(X_{n+1} = x_{n+1} | X_{n} = x_n)
\end{split}
\label{eq:markovski}
\end{equation}

\begin{equation}
p_{ij} = P(X{n+1} = x_j | X_n = xi)
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

Za markovske modele velja, da so v vsakem trenutku v enem izmed $N$ stanj iz množice $S = \{S_1, S_2, \dots, S_N\}$. Ob časih $t = 0, 1, \dots, T$ prehajajo med različnimi stanji $S_n, n \in N$. Skriti markovski modeli so izpeljanka markoviskih modelov, kjer opazovalci poznajo le neko vejrentostno funkcijo stanja, samo stanje pa je skrito~\cite{Lustrek2004}.

\wip{hmm diagram}

Skriti markovski model $\lambda$ je definiran v obliki\footnote{Zapis običajno poenostavimo z $\lambda = (A, B, \pi)$.}

$$
\lambda = (A, B, \pi, N, M),
$$

\noindent kjer so $A, B, \pi, N$ in $M$, parametri, ki opisujejo model~\cite{Rabiner1989}.

\begin{description}

\item[$\boldsymbol{N}\dots$] Število stanj modela.

\item[$\boldsymbol{M}\dots$] Število različnih simbolov opazovanja oz. velikost abecede.
\item[$\boldsymbol{A}\dots$] Matrika verjetnosti prehodov stanj $A = [a_{ij}]$, ki opisuje verjetnost, da se bo sistem ob času $t+1$ znašel v stanju $S_j$ ob dejstvu, da je ob času $t$ bil v stanju $S_i$:

\begin{equation}
a_{ij} = P(q_{t+1} = S_j | q_t = S_i),\qquad 1 \leq i, j \leq N.
\label{eq:hmm_a}
\end{equation}

\item[$\boldsymbol{B}\dots$] Matrika verjetnosti oddanih simbolov $B = [b_j(k)]$, ki opisuje verjetnost, da bo sistem, ki se ob času $t$ nahaja v stanju $S_j$, oddal simbol $v_k$:

\begin{align}
b_j(k) = P(v_k | q_t = S_j),\qquad &1 \leq j \leq N, \\
&1 \leq k \leq M.\nonumber
\label{eq:hmm_b}
\end{align}

\item[$\boldsymbol{\pi}\dots$] Začetna porazdelitev stanj $\{\pi_i\}$, kjer velja:

\begin{equation}
\pi_i = P(q_1 = S+1),\qquad 1 \leq i \leq N.
\label{eq:hmm_pi}
\end{equation}

\end{description}

Primerno določni skriti markovski modeli lahko delujejo kot generatorji zaporedij simbolov na naslednji način:

1. izberemo začetno stanje $q_1 = S_i$ glede na $\pi$;
2. nastavimo $t = 1$;
3. izberemo $O_t = v_k$ glede na trenutno stanje $S_i$ in porazdelitev verjetnosti, ki jih določa $b_i(k)$;
4. opravimo prehod v novo stanje $q_{t+1} = S_j$ glede na prehodne verjentosti iz stanja $S_i$, ki jih določa $a_{ij}$;
5. nastavimo $t = t + 1$; če je $t < T$ se vrnemo na točko 3; sicer postopek zaključimo.

Omenjeni postopek lahko uporabimo tako za generiranje simbolov, kot za ugotavljanje, na kakšen način je določeno zaporedje opazovanja nastalo~\cite{Rabiner1989}.

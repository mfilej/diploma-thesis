# Teoretične osnove skritih markovskih modelov#Teoretične osnove

Verjetnostna teorija je ključnega pomena pri
razumevanju, izražanju in obdelavi koncepta negotovosti. Skupaj z teorijo odločanja nam omogočata, da na podlagi vseh informacij, ki jih imamo na voljo, opravimo optimalne napovedi, četudi so ti podatki nepopolni ali dvoumni~\cite{Bishop2006}.

V tem delu bomo povzeli nekaj konceptov verjetnostne teorije, ki so ključnega pomena za razlago teoretičnih osnov skritih markovskih modelov.

\wip{Izberi kljucne koncepte iz Bishop str. 14/33 - pogojna verjetnost, bayesovo pravilo}

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
P(X_{n+1} = x_{n+1} | X_{n} = x_n)
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

markovske verige

markovski modeli

skriti markovski modeli
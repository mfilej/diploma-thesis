# Implementacija rešitve

## Zahteve, omejitve in izbira orodij

Eden izmed poglavitnih ciljev pri implementaciji rešitve je bila pravilnost programa oz. njegovih rezultatov. S hitrostjo izvajanja se ne nismo obremenjevali, dokler je bila v praktičnih mejah in nam ni predstavlja znatne upočasnitve pri razvoju. Generiranje modela, ki je računsko zahtevnejše, je potrebno izvesti samo enkrat, simuliranje modela, ki bi verjetno želeli izvajati pogosteje, pa ni računsko zahtevno~\cite{Guedon2003}~\cite{Ramage2007}~\cite{Li2000}.

Da bi si zagotovili čim boljše možnosti za pravilno izvedbo rešitve smo se odločili za naslednje pristope: uporabo funkcijskega programiranja, premišljeno zasnovane podatkovne strukture (prilagojene tako razumevanju kot programskemu okolju), programsko testiranje (t.i. unit testing in property-based testing) s sklicevanjem na referenčno rešitev in statično analizo programa. V nadaljevanju bomo podrobneje predstavili vsakega od naštetih pristopv.

### Funkcijsko programiranje in podatkovne strukture

Evolucija funkcijskega programiranja se je začela z delom na lambda računu, nato pa nadaljevala s programskimi jeziki kot so Lisp, Iswim, FM, ML, nato pa z modernejšimi različicami kot so Miranda in Haskell. Za razred *funkcijskih* programskih jezikov je značilno, da izračunavanje izvajajo izključno preko vrednotenja *izrazov*~\cite{Hudak1989}.

Eden izmed načinov na katerega funkcijski programski jeziki lajšajo razumevanje programske kode je odsotnost konstruktov kot so mutabilnost podatkovnih struktur in pomanjkanje globalnega stanja. Na splošno lahko rečemo, da fukcijski programi nimajo *stranskih učinkov*, ki so pogost vzrok za programske hroščev~\cite{Hughes1989}.

Za funkcijske jezike je značilen tudi poudarek na oblikovanju in abstrakcji podatkovnih struktur~\cite{Hudak1989}, nekateri jeziki pa nudijo t.i. pattern matching, ki nam podajanje teh podatkovnih struktur znatno olajša~\{Juric2015}. Oba koncepta sta se izkazala za zelo uporabna pri implemetaciji našega programa.

Najpogostejša abstrakcija, ki se je ponavljala pri implementaciji programa so rezultati funkcij, ki sprejemajo dva ali tri argumente. Za predstavitev takšnega rezultata torej potrebujemo 2- ali 3-dimenzionalno podatkovno strukturo. 

```
          [ … … … ]                     [ […] […] […] ]
f(x, y) = [ … … … ]        f(x, y, z) = [ […] […] […] ]
          [ … … … ]                     [ […] […] […] ]
```

Nemalokrat se take podatkovne strukture predstavljajo s pomočjo polj \angl[array] ali seznamov v drugih oblikah, vendar se je v našem primeru to izkazalo za nepraktično zaradi podatkovnih tipov, ki so jih Erlang in Elixir ponujata. Seznami so povezani \angl[linked list], kar pomeni da niso primerni za indeksirano dostopanje do elementov (`list[x]`), n-terke \angl[tuples], ki to funkcionalnost podpirajo, pa ne nudijo obširnih funkcionalnosti za naštevanje~\angl[enumerate]~\cite{Thomas2014}, ki so pri implementaciji našega programa prav tako nepogrešljive.

Obeh težav smo se rešili z uporabo podatkovne strukture `map`~\{elixir/map}, ki ponuja oboje. `map` je slovar \angl[dictionary], ki v osnovi ponuja preslikavo iz ključa v vrednost \angl[key-value]. Zaradi narave okolja Erlang/OTP se `map` zelo pogosto uporablja in je zato implementacija le-tega kar se da učinkovita. Za naše potrebe lahko `map` uporabimo tako, da indekse rezultata združimo v 2-terko in jo uporabimo za ključ, sam element rezultata pa zapišemo kot vrednost.

```
                                       %{
            [0.2  0.8]                  {0, 0} => 0.2,
f(x, y) =   [0.5  0.5]      map =       {0, 1} => 0.8,
                                        {1, 0} => 0.5,
                                        {1, 1} => 0.5,
                                       }
```

Branje in zapisovanje posameznega elementa na dani poziciji je torej samo vprašanje sestavljanja pravilnega indeksa:

```
iex> map = Map.new
...> map = Map.put(map, {1, 2}, 0.5)
...> Map.get(map, {1, 2})
0.5
```

Standardna knjižnjica prav tako podpira naštevanje ali sprehod čez vse elemente:

```
iex> map = %{...}
...> Enum.map(map, fn({key, value}) -> 
...>   # tukaj imamo na voljo spremenljivko `element`
...>   # za poljubno transformacijo
...> end)
```

Da bi zagotovili konsistentnost pri uporabi teh podatkovnih struktur, smo funkcije za branje in zapisovanje enkapsulirali v svoj modul.

### Testiranje in preverjanje pravilnosti

Da bi se zavarovali pred lastnimi napakami pri programiranju rešitve smo pred pisanjem vsake funkcije zapisali njeno specifikacijo v obliki testa enote (anlg. unit test) ~\cite{Carlsson2006}. Ker je tudi specifikacija neke vrste izvršljiv program, nam omogoča, da avtomatsko preverimo, ali napisana koda ustreza specifikacijam. Testi se izvajajo dovolj hitro, da jih lahko med pisanjem vsake funkcije poženemo večkrat in tako vidimo, kdaj se bližamo uspešni rešitvi. Ko napisana koda ustreza željenim specifikacijam, lahko dodamo nove, strožje specifikacije, ali pa nadaljujemo z pisanjem naslednje funkcije~\cite{Beck2003}.

Takšni testi so nepogrešljivi tudi pri refaktoriranju ("proces, pri kateremu spreminjamo programsko kodo, na takšen način, da se spremeni interna struktura organizacija, njeno zunanje vedenje pa ostane nespremenjeno"~\cite{Li2007}), saj moramo biti pri spreminjanju kode pazljivi, da ne pride do nazadovanja \angl[regression].

Znaten del naše rešitve obsega matematične algoritme, za katere ni trivialno napisati specifikacije, saj lahko tudi pri ročnih izračunih hitro samo uvedemo napako. Zato smo se pri implementaciji odločili, da se bomo oprli na neko referenčno implementacijo in s pomočjo rezultatov, ki jih bomo dobili iz le-te, napisali specifikacije za naše funkcije. Referenčna implementacija, po kateri smo se zgledovali, je Python projekt HMM~\cite{guyz/HMM}, ki je sestavljen na dovolj prijazen način, da smo lahko različne algoritme izvajali posebej in njihove rezultate prepisali v naše specifikacije.

Zaradi nenatančne narave števil s plavajočo vejico, ki smo jih uporabili za predstavitev večine rezultatov algoritmov, je včasih pri testiranju potrebno prepustiti možnost določenega odstopanja. Določeni deli specifikacije zato namesto stroge enakosti preverjajo, da vrednosti od referenčenga rezultata niso oddaljene za več kot prepisano vrednost $\Delta$. To smo dosegli z uporabo ExUnit~\cite{elixir/exunit} funkcije `assert_in_delta` (oz. smo to funkcijo nadgradili v `assert_all_in_delta` tako, da lahko preverja več rezultatov naenkrat). Ugotovili smo, da smo lahko večino specifikacij zadostili z $\Delta$ vrednostjo $5^{-8}$.

S pomočjo funkcije `all_in_delta` smo preverjali tudi ergodičnost funkcije za prehode med stanji z določenimi verjetnostmi. Za primer, kjer sta iz nekega stanja dovoljena prehoda v stanje $A$ z verjetnostjo 0.2 in stanje $B$ z verjetnostjo 0.8, smo naprimer definirali naslednji zahtevi:

```
assert_in_delta frequencies.a, 2000, 150
assert_in_delta frequencies.b, 8000, 150
```

Zahtevamo torej, da je od $10.000$ poskusov prehoda iz začetnega stanja $2.000\pm150$ takih, kjer se je zgodil prehod v stanje $A, $8.000\pm150$ pa takih, kjer se je zgodil prehod v stanje $B.

Nekatere specifikacije je težko povzeti v nekaj trditvah \angl[assertion], ročno navajanje potrebne količine trditev bi bilo zamudno (in v določenih primerih celo nepraktično), veliko število kode, ki bi nastalo kot rezultat takšnega navajanja pa bi bilo nepregledno in težavno za spreminjanje ter vzdrževanje. V takih primerih si lahko pomagamo z orodji za preizkušanje na osnovi lastnosti \angl[property-based testing], ki nam omogočajo, da neko lastnost izrazimo na večji množici števil (npr. vsa naravna števila ali pozitivna realna števila, itd.), program pa potem v procesu preverjanja sam izbere nekaj kombinacij takih števil, za katere preveri, če zapisani pogoji držijo. Za okolje Erlang je na voljo QuickCheck, s pomočjo orodja ExCheck~\cite{parroty/excheck} pa smo ga lahko uporabili tudi v programskem okolju Elixir. QuickCheck in Excheck ponujata omejen jezik, s katerim opišemo lastnosti, ki jih želimo preveriti v našem programu. Orodji nato generirata naključne testne primere in preverita, če jim naš program zadostuje.~\cite{Li2007}

Takšen pristop testiranja smo na primer uporabili pri pisanju razširjenih logaritemskih funkcij. Razširjen logaritem je za vsa pozitivna realna števila definiran kot navaden logaritem. ExCheck nam omogoča, da to trditev zapišemo na naslednji način \footnote{	\texttt{Logzero} modul vsebuje našo implementacijo, \texttt{:math} pa je del Erlangove standardne knjižnice.}:

```
  property :ext_log do
    for_all x in such_that(x in real when x > 0) do
      Logzero.ext_log(x) == :math.log(x)
    end
  end
```

### Statična analiza

Tako kot programsko okolje Erlang/OTP, tudi Elixir sloni na konceptu dinamičnih programskih tipov (t.i. dynamic typing), ki od uporabnikov ne zahtevajo, da programsko kodo označujejo z informacijami o programskih tipih. Da bi se lahko uporabniki vseeno lahko pridobili prednosti, ki jih prinašajo orodja za statično analizo programske kode, se lahko poslužijo koncepta postopnega tipiziranja (t.i. gradual typing)~\cite{Papadakis2011}. Na ta način se informacije o programskih tipih dodajajo sproti in po želji, orodje za statično analizo pa javlja morebitne težave. Rezultat je čistejša programska koda, ki jo je lažje razumeti in vzdrževati, je robustnejša in bolje dokumentirana~\cite{Sagonas2008}.

V programskem okolju Erlang/OTP je na voljo orodje Dialyzer~\cite{Sagonas2005}, ki pa se lahko uporablja tudi v okolju Elixir s pomočjo orodja Dialyxir~\cite{jeremyjh/dialyxir}.

### Izbira programskega jezika

Elixir~\cite{Thomas2014} je sodoben, dinamičen, funkcijski programski jezik. Zgrajen je na osnovi Erlangovega navideznega stroja in ima zato kljub svoji relativni novosti na voljo zelo bogat ekosistem in več desetletij razvoja, ki jih ponuja platforma Erlang/OTP~\cite{Armstrong2007}. Nenazadnje pa izbira programskega jezika za to nalogo predstavlja predvsem avtorjevo subjektivno odločitev.

## Algoritmi za modeliranje skritih markovskih modelov#Implementacija algoritmov

Eden izmed večjih izzivov naloge je bila preslikava matematičnih algoritmov za modeliranje skritih markovskih modelov v programsko kodo. V tem delu bomo skušali opisati postopek preslikave, za bistvene algoritme bomo navedli psevdokodo, na koncu pa bomo razložili s kakšnimi težavami smo se srečevali in kako smo jih rešili. Postopek izgradnje modela bi lahko v grobem zastavili na naslednji način, kot je prikazan na sliki \ref{diag:baum_welch}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/baum_welch.pdf}
\end{center}
\caption{Potek postopne izgradnje modela}
\label{diag:baum_welch}
\end{figure}

Imamo torej glavno zanko, kjer se izvaja Baum-Welch algoritem \wip{dodaj referenco}, dokler ni zadoščeno glavnemu pogoju. Algoritem je razdeljen na dva koraka, ki ju imenujemo korak $E$\angl[estimation] in korak $M$\angl[maximization]. V koraku $E$ izračunamo vmesne spremenljivke $\alpha$, $\beta$, $\gamma$ in $\xi$, s pomočjo katerih ocenimo trenutno verjetnost modela
$$\lambda = (a, b, \pi),$$
v koraku $M$ pa na njihovi podlagi izračunamo nov model
$$\bar{\lambda} = (\bar{a}, \bar{b}, \bar{\pi}).$$

\noindent Definiramo še nekaj oznak, ki se bodo uporabljale v nadaljevanju:

\begin{description}[style=multiline,itemsep=0em]
    \item[$N \dots$] število stanj modela;
    \item[$T \dots$] dolžina opazovanega zaporedja;
    \item[$K \dots$] število vseh možnih simbolov (včasih imenovano tudi velikost abecede);
    \item[$\boldsymbol{O} \dots$] opazovana sekvenca, ki je sestavljena iz opazovanih simbolov $(o_1, o_2, \dots, o_T)$;
    \item[$\boldsymbol{V} \dots$] abeceda, sestavljena iz simbolov $(v_1, v_2, \dots, v_K)$.
\end{description}

Pomen besede *simbol* v kontekstu skritih markovskih modelov je različen glede na problemsko domeno, kjer modele uporabljamo. V primeru uporabe modelov za namen generiranja besedil lahko simbol predstavlja črko, skupino črk, besedo … Na podoben način izraz *abeceda* ni nujno povezan s črkami, kot v običajnem smislu, ampak na vse *simbole*, ki lahko nastopajo v besedilu. Ker razvijamo splošnonamenski knjižnjico, smo obdržali tudi splošno izrazoslovje.

V nadaljevanju predstavimo psevdokodo za izračun omenjenih spremenljivk.

### Korak E

Izračun spremenljivke $\alpha$ poteka v fukciji `estimate_alpha`~\eqref{koda:estimate_alpha}, ki je preslikava izreka \wip{ref}.

\input{figures/estimate_alpha_algorithm}

Podobnosti med definicijama $\alpha$ in $\beta$ se pokažeta tudi v podobnosti njunih algoritmov. `estimate_beta`~\eqref{koda:estimate_beta} se razlikuje v izrazu za izračun vsote v notranji zanki, glavna zanka pa gre tokrat od zadnjega stanja nazaj.

\input{figures/estimate_beta_algorithm}

Ko imamo vrednosti $\alpha$ in $\beta$ lahko nadaljujemo z izračunom verjetnosti modela za posamezno stanje glede na dano opazovano sekvenco. S pomočjo definicije \wip{ref} začnemo s spremenljivko $\xi$ in jo preslikamo v funkcijo `estimate_xi`~\eqref{koda:estimate_xi}.

\input{figures/estimate_xi_algorithm}

Zaradi zveze \wip{ref} med $\xi$ in $\gamma$ lahko slednjo izrazimo v funkciji `estimate_gamma`~\eqref{koda:estimate_gamma} na poenostavljen način.

\input{figures/estimate_gamma_algorithm}

S pomočjo spremenljivke $\alpha$ lahko izračunamo tudi verjetnost modela glede na dano opazovano sekvenco \wip{ref} (`compute_model_probability`~\eqref{koda:model_prob}).

\input{figures/model_prob_algorithm}

### Korak M

Cilj $M$ koraka je s pomočjo izračunanih vrednosti spremenljivk $\gamma$ in $\xi$ ponovno oceniti parametre $\bar{\pi}$, $\bar{a}$ in $\bar{b}$ za nov model.

Funkcija `reestimate_pi`~\eqref{koda:reestimate_pi} verjetnosti začetnih stanj $\bar{\pi}$ izračuna tako, da enostavno prebere izračunane vrednosti spremenljivke $\bar{\gamma}$ za prvi simbol opazovane sekvence.

\input{figures/reestimate_pi_algorithm}

Na tej točki nam preostane še preslikava enačbe za izračun nove vrednosti $\bar{a}$ \wip{ref} v funkcijo `reestimate_a`~\eqref{koda:reestimate_a} in enačbe za izračun nove vrednosti $\bar{b}$ \wip{ref} v funkcijo `reestimate_b`~\eqref{koda:reestimate_b}.

\input{figures/reestimate_a_algorithm}
\input{figures/reestimate_b_algorithm}


### Iterativna maksimizacija parametrov modela {#iter}

Do te točke smo definirali vse ključne funkcije maksimizacijo paramterov modela, sedaj pa jih bomo skupaj povezali v glavno zanko, kot je to prikazano na sliki \ref{diag:baum_welch}. V literaturi~\cite{Xu1996} najdemo dokaze, da takšna maksimizacija modela nujno vodi proti povečanju verjetnosti modela, do točke kjer verjetnost konvergira proti kritični točki. Naš program lahko torej zasnujemo tako, da iteracijo nadaljuje do te kritične točke oz. njenega približka, t.j. točke, kjer se verjetnosti prejšnjega in trenutnega modela razlikujeta za manj kot neka določena vrednost $\varepsilon$\footnote{Izbire vrednosti $\varepsilon$ prepustimo uporabnikom, ker različni problemi zahtevajo svoje vrednosti. Za relativno enostaven model smo začeli z vrednostjo $10^{-6}$.}. Da bi se zaščitili pred izbiro premajhne $\varepsilon$ vrednosti, glavno zanko še dodatno omejimo z navzgor omejenim maksimalnim številom ponovitev\footnote{Tudi ta vrednost je nastavljiva, privzeta omejitev je $100$ ponovitev.}.

\input{figures/main_loop_algorithm}

Do sedaj smo opisali temeljne algoritme našega programa, ki pa smo jih mogli do določene mere spremeniti oz. prirediti, da smo dobili željene funkcionalnosti in se izognili določenim težavam. V nadaljevanju bomo predstavili te spremembe, bistvo predstavljenih algoritmov pa se ni spremenilo, kar je tudi vidno v končni izvorni kodi.

### Izbira začetnih parametrov

Postopek iterativnoega izboljševanja parametrov modela opisan v poglavju \ref{iter} zahteva izbiro nekih začetnih parametrov, ki bodo služili kot vhod v iteracijo~\eqref{koda:main_loop}. Dobra izbira parametra lahko vpliva na to, ali bo maksimizacija pripelajla do lokalnega ali globalnega maksimuma~\cite{Rabiner1989}. V literaturi~\cite{Rabiner1989}~\cite{Bilmes1997} zasledimo dva nezahtevna pristopa, ki se izkažeta za enako dobra: naključne vrednosti in enakomerno\footnote{Prehodu v vsako stanje dodelimo enako verjetnost.} \cite{Lustrek2004} razporejene vrednosti (seveda pod pogojem, da se držimo omejitev stohastičnosti in da so verjetnosti neničelne). Izjema je $b$ parameter modela, kjer se izkaže, da je dobra začetna ocena vrednosti pomembna~\cite{Rabiner1989}. Oceno lahko pridobimo na več načinov, odvisno od tipa podatkov. V našem primeru je vhod besedilo, tako da smo za vrednosti vzeli relativne frekvence pojavljanja simbolov.

### Podpora za mnogotera opazovana zaporedja

Baum-Welch algoritem je v osnovi definiran za maksimizacijo parametrov modela glede na dano opazovano sekvenco. Ker želimo v naši nalogi algoritem uporabiti za namen generiranja besedila, moramo za uspešno učenje modela uporabiti dovolj veliko učno množico, npr. krajšo knjigo dolžine $10.000$ besed. Takšno učno zaporedje nam predstavlja dve težavi: 1) Opazovano zaporedje takšne dolžine bo v koraku $E$ Baum-Welch algoritma za bolj oddaljene simbole izračunalo zelo majhe verjetnosti, ki bodo povzročile napako podkoračitve~\angl[underflow] (s to težavo smo se večkrat srečali zato jo bomo kasneje podrobneje opisali). 2) Zapis celotnega besedila v obliki enega opazovanja sporoča odvisnost zaporedja — povedi, ki nastopijo kasneje, so odvisno od povedi, ki so nastopile prej — ki je ne želimo modelirati (bolj kot odvisnost med povedmi je za nas zanimiva odvisnost med besedami).~\cite{Zhao2011}

V literaturi zasledimo različne načine obravnave mnogoterih zaporedij, od enostavnejših, kjer ima vsako zaporedje enako težo~\cite{Rabiner1989}~\cite{Bilmes1997}, do kompleksnejših pristopov, kjer imajo lahko modeli različne uteži ali je njihova izbira celo dinamično prepuščena drugim algoritmom.~\cite{Zhao2011}~\cite{Li2000}  Zaradi narave našega problema, smo se odločili, da bomo vsako poved obravnavali kot neodvisno zaporedje. Algoritme za priredbo Baum-Welch algoritma za mnogotera zaporedja smo prevzeli iz enačb v članku \textquotedblleft{}An Erratum for \textquoteleft{}A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition\textquoteright{}\textquotedblright{}~\cite{rabinererratum}.

Algoritmi za izračun spremenljivk $\alpha\eqref{koda:estimate_alpha}, \beta\eqref{koda:estimate_beta}, \gamma\eqref{koda:estimate_gamma}, \xi\eqref{koda:estimate_xi}$ ostanejo enaki, korak $E$ kot celota pa se spremeni do te mere, da sedaj te spremenljivke računamo za vsako opazovano zaporedje  posebej. Če je $\boldsymbol{O}^{(k)}$ $k$-to zaporedje (oz. $k$-ta poved), potem moramo izračunati spremenljivke $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$.

S pomočjo teh spremenljivk najprej izračuanmo verjetnosti posameznih zaporedij glede na trenutni model $P(\boldsymbol{O}^{(k)}|\lambda)$ z nespremenjenim algoritmom \eqref{koda:model_prob}). Verjetnost celotne množice zaporedij glede na trenutni model $P(\boldsymbol{O}|\lambda)$ je nato enaka zmnožku posameznih verjetnosti~\cite{Rabiner1989}.

\begin{equation}
P(\boldsymbol{O}|\lambda) = \prod_{k=1}^K P(\boldsymbol{O}^{(k)}|\lambda)
\label{eq:multi_obs_model_prob}
\end{equation}

Algoritem za računanje verjetnosti modela~\eqref{koda:model_prob} vrača logaritem verjetnosti, zato lahko te vrednosti enostavno seštejemo.

Nazadnje se obrnemo še k posodobitvam za korak $M$, kjer smo priredili izračun algoritmov za maksimizacijo spremenljivk $\bar{\pi}~\eqref{koda:reestimate_pi}, \bar{a}~\eqref{koda:reestimate_a}$ in $\bar{b}~\eqref{koda:reestimate_b}$. Algoritmom smo dodali dodatno zanko, kjer se sprehodimo čez vsa opazovana zaporedja ($k \leftarrow 1$ do $K$), uporabo spremenljivk $\alpha, \beta, \gamma$ in $\xi$ pa smo zamenjali z novimi različicami $\alpha^k, \beta^k, \gamma^k$ in $\xi^k$. Nove vrednosti v števcih in imenovalcih enačb je bilo potrebno sešteti in tako smo dobili vrednosti za modele z mnogoterimi opazovanimi sekvencami. Pomemben korak pri preverjanju pravilnosti je bil, da se je program tudi po spremembah za primer posameznega opazovanega zaporedja še vedno obnašal na enak način kot prej (prvotne specifikacije za posamezna opazovana zaporedja smo ohranili kar se da nedotaknjene).

### Preprečevanje napake podkoračitve

Aplikacija skritih markovskih modelov na dolga opazovana zaporedja zahteva računanje z izredno majnimi verjetnostmi. Takšne majhne vrednosti privedejo do nestabilnosti pri izračunavanju števil v plavajoči vejici~\cite{Mann2006}, med drugim tudi do napake podkoračitve\angl[underflow].

Pri implementaciji našega programa smo to težavo opazili, ko so, že po nekaj iteracijah Baum-Welch algoritma, vse spremenljivke dobile vrednost $0$. Razlog tiči v tem, da ima pri veliki množici vseh možnih zaporedij besed, neko poljubno opazovano zaporedje zelo majhno pogojno verjetnost. Za spopadanje s to težavo obstajata dve pogostejši rešitvi: eden je *lestvičenje*~\angl[scaling, rescaling] pogojnih verjetnosti na podlagi skrbno izbranih faktorjev, drugi pa zamenjava pogojnih verjetnosti z vrednostmi njihovih logaritmov\footnote{Beseda \emph{logaritem} se v tej nalogi vedno nanaša na naravni logaritem.}. Prednost slednjega načina je v tem, da lahko algoritme postopoma spremenimo in vseskozi preverjamo pravilnost sprememb le s tem, da v naših specifikacijah pričakovane vrednosti zamenjamo z njihovimi logaritmi~\cite{Mann2006}.

Vse potrebne priredbe algoritmov v koraku $E$ so zelo nazorno prikazane v članku \textquotedblleft{}Numerically Stable Hidden Markov Model Implementation\textquotedblright{}~\cite{Mann2006}, zato jih tukaj ne bomo posebej navajali.

V koraku $M$ algoritmov ni potrebno spreminjati, z izjemo končnih vrednosti, ki so sedaj logaritmirane, zato na njih v zadnjem koraku uporabimo naravno eksponentno funkcijo $e^x$.

### Simulacija skritih markovskih modelov

Z uspešno maksimiziranim modelom $\lambda$ lahko pričnemo s simuliranjem. Postopek je znatno enostavnejši od maksimiziranja in poteka na naslednji način:

1. Na podlagi razporeditve verjetnosti začetnih stanj $\pi$ naključno	\footnote{Z besedo \emph{naključno} v tem odseku opisujemo naključno izbiro z upoštevanjem danih verjetnosti prehoda ali emisije.} izberemo začetno stanje $S_i$.
2. Model postavimo v stanje S_i in na podlagi verjetnosti za emisijo simbola v danem stanju $b_i(k)$ naključno izberemo simbol.
4. Če smo dosegli ciljno število znakov se ustavimo.
5. Na podlagi razporeditve verjetnosti prehoda stanj $a_{ij}$ naključno izberemo novo stanje in se vrnemo v točko 2).

Algoritem \eqref{koda:simulate_hmm} predstavi zgornje zaporedje v obliki psevdokode.

\input{figures/simulate_hmm_algorithm}

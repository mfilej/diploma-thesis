# Implementacija knjižnice {#ch:impl}

Po pregledu obstoječih rešitev v \ref{ch:comp}. poglavju smo se odločili, da implementiramo svojo knjižnico za delo s skritimi markovskimi modeli. Poglavitni razlog za to odločitev je bilo splošno pomanjkanje dokumentacije za delo z obstoječimi orodji. 

\wip{racunamo, da se bomo v procesu implementacije veliko naucili}

Eden izmed poglavitnih ciljev implementacije rešitve je bilo pravilno delovanje programa in z njim pridobljenih rezultatov. Hitrost izvajanja je bila sekundarnega pomena, dokler je bila v praktičnih mejah in ni znatno upočasnjevala razvoja.

Da bi si zagotovili čim boljše možnosti za pravilno izvedbo rešitve, smo se odločili za naslednje pristope: uporabo funkcijskega programiranja, premišljeno zasnovane podatkovne strukture (prilagojene za lažje razumevanje) in programsko testiranje (t.i. unit testing in property-based testing) s sklicevanjem na referenčno rešitev in statično analizo programa. V nadaljevanju bomo podrobneje predstavili vsakega od naštetih pristopv.

## Funkcijsko programiranje in podatkovne strukture #Funkcije in podatkovne strukture

Evolucija funkcijskega programiranja se je začela z delom na lambda računu, nadaljevala s programskimi jeziki kot so Lisp, Iswim, FM, ML, nato pa z modernejšimi različicami kot so Miranda in Haskell. Za razred *funkcijskih* programskih jezikov je značilno, da izračunavanje izvajajo izključno preko vrednotenja *izrazov*~\cite{Hudak1989}.

Eden izmed načinov s katerim funkcijski programski jeziki lajšajo razumevanje programske kode, je odsotnost konstruktov kot so mutabilnost podatkovnih struktur in odsotnost globalnega stanja. Povzamemo lahko, da se fukcijski programi izogibajo *stranskim učinkom*, ki so pogost vzrok programskih hroščev~\cite{Hughes1989}.

Za funkcijske jezike je značilen tudi poudarek na oblikovanju podatkovnih struktur~\cite{Hudak1989}. Nekateri jeziki nudijo tudi t.i. *pattern matching*, ki podajanje podatkovnih struktur znatno olajša~\cite{Juric2015}. Oba koncepta sta se izkazala za zelo uporabna pri implemetaciji našega programa.

Najpogostejša oblika podatkov pri implementaciji knjižnjice so bili (vmesni ali končni) rezultati funkcij, ki obsegajo dve ali tri razsežnosti. Za predstavitev le-teh smo potrebovali večrazsežnostno podatkovno strukturo.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/matrix2d3d.pdf}
\end{center}
\caption{Dvorazsežna in trorazsežna matrika.}
\label{diag:matrix2d3d}
\end{figure}

Take podatkovne strukture se običajno predstavljajo s pomočjo večrazsežnih polj\angl[multi-dimensional array] ali drugih oblik seznamov. V našem primeru se je to izkazalo za nepraktično zaradi podatkovnih tipov, ki so na voljo v programskih okoljih Erlang/OTP in Elixir. Na voljo so seznami povezanega tipa\angl[linked list], kar pomeni, da niso primerni za indeksirano dostopanje do elementov (`list[x]`). N-terke\angl[tuples], ki to funkcionalnost podpirajo, pa ne nudijo obširnih funkcionalnosti za naštevanje\angl[enumerate]~\cite{Thomas2014}, ki so pri implementaciji našega programa prav tako nepogrešljive.

Težavi smo odpravili z uporabo podatkovne strukture `map`~\cite{elixir/map}. `map` je slovar\angl[dictionary], ki v osnovi ponuja preslikavo iz ključa v vrednost\angl[key-value]. Zaradi narave okolja Erlang/OTP se `map` redno uporablja in je zato njegova implementacija zelo učinkovita. V našem primeru smo `map` uporabili tako, da smo indekse rezultata združili v 2-terko in jo uporabili za ključ, sam element rezultata pa zapisali kot vrednost. Primer uporabe je prikazan na sliki \eqref{fig:impl:matrix_as_map}.

\input{figures/matrix_as_map}

Za branje in zapisovanje posameznega elementa na dani poziciji je bilo dovolj, da smo pravilno sestavili indeksa:

\begin{samepage}
\begin{verbatim}
iex> map = Map.new
...> map = Map.put(map, {1, 2}, 0.5)
...> Map.get(map, {1, 2})
0.5
\end{verbatim}
\end{samepage}

Standardna knjižnica prav tako podpira naštevanje ali sprehod skozi vse elemente:

\begin{samepage}
\begin{verbatim}iex> map = %{...}
...> Enum.map(map, fn({key, value}) -> 
...>   # tukaj imamo na voljo spremenljivko `element`
...>   # za poljubno transformacijo
...> end)
\end{verbatim}
\end{samepage}

Da bi zagotovili konsistentnost pri uporabi opisanih podatkovnih struktur, smo funkcije za branje in zapisovanje vključili v zato namenjen modul.

## Testiranje in preverjanje pravilnosti

Da bi se zavarovali pred lastnimi napakami pri programiranju rešitve, smo pred implementacijo vsake funkcije zapisali njeno specifikacijo v obliki testa enote\angl[unit test] \cite{Carlsson2006}. Ker je specifikacija izvršljiv program, lahko ustreznost napisane kode samodejno preverjamo. Testi se izvajajo dovolj hitro, da jih lahko med pisanjem vsake funkcije izvršimo večkrat in tako preverimo, kdaj se bližamo uspešni rešitvi. Ko napisana koda ustreza željenim specifikacijam, lahko dodamo nove, strožje specifikacije, ali pa nadaljujemo s pisanjem naslednje funkcije~\cite{Beck2003}.

Takšni testi so nepogrešljivi tudi pri preurejanju\footnote{Proces pri katerem spreminjamo interno organiziranost programsko kode, ne da bi pri tem spremenili njeno zunanje vedenje~\cite{Li2007}.}, saj moramo biti pri spreminjanju kode pazljivi, da ne pride do nazadovanja\angl[regression].

Znaten del naše rešitve obsega matematične algoritme, za katere ni trivialno napisati specifikacije, saj lahko tudi pri ročnih izračunih hitro samo uvedemo napako. Zato smo se pri implementaciji odločili, da se bomo oprli na neko referenčno implementacijo in s pomočjo rezultatov, ki jih bomo dobili iz le-te, napisali specifikacije za naše funkcije. Referenčna implementacija, po kateri smo se zgledovali, je Python projekt HMM~\cite{guyz/HMM}, ki je sestavljen na dovolj prijazen način, da smo lahko različne algoritme izvajali posebej in njihove rezultate prepisali v naše specifikacije.

Zaradi nenatančne narave števil s plavajočo vejico, ki smo jih uporabili za predstavitev večine rezultatov algoritmov, je včasih pri testiranju potrebno prepustiti možnost določenega odstopanja. Določeni deli specifikacije zato namesto stroge enakosti preverjajo, da vrednosti od referenčenga rezultata niso oddaljene za več kot prepisano vrednost $\Delta$. To smo dosegli z uporabo ExUnit~\cite{elixir/exunit} funkcije `assert_in_delta` (oz. smo to funkcijo nadgradili v `assert_all_in_delta` tako, da lahko preverja več rezultatov naenkrat). Ugotovili smo, da smo lahko večino specifikacij zadostili z $\Delta$ vrednostjo $5^{-8}$.

S pomočjo funkcije `all_in_delta` smo preverjali tudi ergodičnost funkcije za prehode med stanji z določenimi verjetnostmi. Za primer, kjer sta iz nekega stanja dovoljena prehoda v stanje $A$ z verjetnostjo 0.2 in stanje $B$ z verjetnostjo 0.8, smo naprimer definirali naslednji zahtevi:

```
assert_in_delta frequencies.a, 2000, 150
assert_in_delta frequencies.b, 8000, 150
```

Zahtevamo torej, da je od $10.000$ poskusov prehoda iz začetnega stanja $2.000\pm150$ takih, kjer se je zgodil prehod v stanje $A, $8.000\pm150$ pa takih, kjer se je zgodil prehod v stanje $B.

Nekatere specifikacije je težko povzeti v nekaj trditvah~\angl[assertion], ročno navajanje potrebne količine trditev bi bilo zamudno (in v določenih primerih celo nepraktično), veliko število kode, ki bi nastalo kot rezultat takšnega navajanja pa bi bilo nepregledno in težavno za spreminjanje ter vzdrževanje. V takih primerih si lahko pomagamo z orodji za preizkušanje na osnovi lastnosti~\angl[property-based testing], ki nam omogočajo, da neko lastnost izrazimo na večji množici števil (npr. vsa naravna števila ali pozitivna realna števila, itd.), program pa potem v procesu preverjanja sam izbere nekaj kombinacij takih števil, za katere preveri, če zapisani pogoji držijo. Za okolje Erlang je na voljo QuickCheck, s pomočjo orodja ExCheck~\cite{parroty/excheck} pa smo ga lahko uporabili tudi v programskem okolju Elixir. QuickCheck in Excheck ponujata omejen jezik, s katerim opišemo lastnosti, ki jih želimo preveriti v našem programu. Orodji nato generirata naključne testne primere in preverita, če jim naš program zadostuje.~\cite{Li2007}

Takšen pristop testiranja smo na primer uporabili pri pisanju razširjenih logaritemskih funkcij. Razširjen logaritem je za vsa pozitivna realna števila definiran kot navaden logaritem. ExCheck nam omogoča, da to trditev zapišemo na naslednji način \footnote{	\texttt{Logzero} modul vsebuje našo implementacijo, \texttt{:math} pa je del Erlangove standardne knjižnice.}:

```
  property :ext_log do
    for_all x in such_that(x in real when x > 0) do
      Logzero.ext_log(x) == :math.log(x)
    end
  end
```

## Statična analiza

Tako kot programsko okolje Erlang/OTP, tudi Elixir sloni na konceptu dinamičnih programskih tipov (t.i. dynamic typing), ki od uporabnikov ne zahtevajo, da programsko kodo označujejo z informacijami o programskih tipih. Da bi se lahko uporabniki vseeno lahko pridobili prednosti, ki jih prinašajo orodja za statično analizo programske kode, se lahko poslužijo koncepta postopnega tipiziranja (t.i. gradual typing)~\cite{Papadakis2011}. Na ta način se informacije o programskih tipih dodajajo sproti in po želji, orodje za statično analizo pa javlja morebitne težave. Rezultat je čistejša programska koda, ki jo je lažje razumeti in vzdrževati, je robustnejša in bolje dokumentirana~\cite{Sagonas2008}.

V programskem okolju Erlang/OTP je na voljo orodje Dialyzer~\cite{Sagonas2005}, ki pa se lahko uporablja tudi v okolju Elixir s pomočjo orodja Dialyxir~\cite{jeremyjh/dialyxir}.

## Izbira programskega jezika

Elixir~\cite{Thomas2014} je sodoben, dinamičen, funkcijski programski jezik. Zgrajen je na osnovi Erlangovega navideznega stroja in ima zato kljub svoji relativni novosti na voljo zelo bogat ekosistem in več desetletij razvoja, ki jih ponuja platforma Erlang/OTP~\cite{Armstrong2007}. Nenazadnje pa izbira programskega jezika za to nalogo predstavlja predvsem avtorjevo subjektivno odločitev.

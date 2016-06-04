# Implementacija lastne rešitve {#ch:impl}

\wip{Utemeljitev, da smo se odlocili za svojo implementacijo. Navedi obstojece resitve: Python: hmmlearn~\cite{hmmlearn/hmmlearn}, GHMM~\cite{sf/ghmm}, HMM~\cite{guyz/HMM}, pommegranate~\cite{jmschrei/pomegranate}, R: HMM~\cite{r/hmm}, Haskell: markov~\cite{fmap/markov} vecina resitev ni dovoljevala dovoljsne kontrole nad parametri. Nekatere resitve so bile tezke za modifikacijo. Najvecja tezava je bila da vecina resitev se ne zna uciti na vecih sekvencah, kar je nujno za ucenje na daljsih besedilih (utemeljeno kasneje). Gledano za nazaj se je izkazala za dobro idejo za boljse razumevanje. Hkrati pa tudi bolj zapleteno kot pricakovano, za boljsi izkoristek casa in boljse rezultate bi bilo mogoce boljse vzeti katero od obstojecih.}

## Zahteve, omejitve in izbira orodij

Eden izmed poglavitnih ciljev pri implementaciji rešitve je bila pravilnost programa oz. njegovih rezultatov. S hitrostjo izvajanja se ne nismo obremenjevali, dokler je bila v praktičnih mejah in nam ni predstavlja znatne upočasnitve pri razvoju. Generiranje modela, ki je računsko zahtevnejše, je potrebno izvesti samo enkrat, simuliranje modela, ki bi verjetno želeli izvajati pogosteje, pa ni računsko zahtevno~\cite{Guedon2003,Ramage2007,Li2000}.

Da bi si zagotovili čim boljše možnosti za pravilno izvedbo rešitve smo se odločili za naslednje pristope: uporabo funkcijskega programiranja, premišljeno zasnovane podatkovne strukture (prilagojene tako razumevanju kot programskemu okolju), programsko testiranje (t.i. unit testing in property-based testing) s sklicevanjem na referenčno rešitev in statično analizo programa. V nadaljevanju bomo podrobneje predstavili vsakega od naštetih pristopv.

## Funkcijsko programiranje in podatkovne strukture

Evolucija funkcijskega programiranja se je začela z delom na lambda računu, nato pa nadaljevala s programskimi jeziki kot so Lisp, Iswim, FM, ML, nato pa z modernejšimi različicami kot so Miranda in Haskell. Za razred *funkcijskih* programskih jezikov je značilno, da izračunavanje izvajajo izključno preko vrednotenja *izrazov*~\cite{Hudak1989}.

Eden izmed načinov na katerega funkcijski programski jeziki lajšajo razumevanje programske kode je odsotnost konstruktov kot so mutabilnost podatkovnih struktur in pomanjkanje globalnega stanja. Na splošno lahko rečemo, da fukcijski programi nimajo *stranskih učinkov*, ki so pogost vzrok za programske hroščev~\cite{Hughes1989}.

Za funkcijske jezike je značilen tudi poudarek na oblikovanju in abstrakcji podatkovnih struktur~\cite{Hudak1989}, nekateri jeziki pa nudijo t.i. pattern matching, ki nam podajanje teh podatkovnih struktur znatno olajša~\cite{Juric2015}. Oba koncepta sta se izkazala za zelo uporabna pri implemetaciji našega programa.

Najpogostejša abstrakcija, ki se je ponavljala pri implementaciji programa so rezultati funkcij, ki sprejemajo dva ali tri argumente. Za predstavitev takšnega rezultata torej potrebujemo 2- ali 3-dimenzionalno podatkovno strukturo, ki jo običajno imenujemo matrika.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/matrix2d3d.pdf}
\end{center}
\caption{2- in 3-dimenzionalni matriki.}
\label{diag:matrix2d3d}
\end{figure}

Nemalokrat se take podatkovne strukture predstavljajo s pomočjo polj~\angl[array] ali seznamov v drugih oblikah, vendar se je v našem primeru to izkazalo za nepraktično zaradi podatkovnih tipov, ki so jih Erlang in Elixir ponujata. Seznami so povezani~\angl[linked list], kar pomeni da niso primerni za indeksirano dostopanje do elementov (`list[x]`), n-terke~\angl[tuples], ki to funkcionalnost podpirajo, pa ne nudijo obširnih funkcionalnosti za naštevanje~\angl[enumerate]~\cite{Thomas2014}, ki so pri implementaciji našega programa prav tako nepogrešljive.

Obeh težav smo se rešili z uporabo podatkovne strukture `map`~\{elixir/map}, ki ponuja oboje. `map` je slovar~\angl[dictionary], ki v osnovi ponuja preslikavo iz ključa v vrednost~\angl[key-value]. Zaradi narave okolja Erlang/OTP se `map` zelo pogosto uporablja in je zato implementacija le-tega kar se da učinkovita. Za naše potrebe lahko `map` uporabimo tako, da indekse rezultata združimo v 2-terko in jo uporabimo za ključ, sam element rezultata pa zapišemo kot vrednost.

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

## Testiranje in preverjanje pravilnosti

Da bi se zavarovali pred lastnimi napakami pri programiranju rešitve smo pred pisanjem vsake funkcije zapisali njeno specifikacijo v obliki testa enote~\angl{unit test} \cite{Carlsson2006}. Ker je tudi specifikacija neke vrste izvršljiv program, nam omogoča, da avtomatsko preverimo, ali napisana koda ustreza specifikacijam. Testi se izvajajo dovolj hitro, da jih lahko med pisanjem vsake funkcije poženemo večkrat in tako vidimo, kdaj se bližamo uspešni rešitvi. Ko napisana koda ustreza željenim specifikacijam, lahko dodamo nove, strožje specifikacije, ali pa nadaljujemo z pisanjem naslednje funkcije~\cite{Beck2003}.

Takšni testi so nepogrešljivi tudi pri refaktoriranju ("proces, pri kateremu spreminjamo programsko kodo, na takšen način, da se spremeni interna struktura organizacija, njeno zunanje vedenje pa ostane nespremenjeno"~\cite{Li2007}), saj moramo biti pri spreminjanju kode pazljivi, da ne pride do nazadovanja~\angl[regression].

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

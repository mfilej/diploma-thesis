# Implementacija knjižnice {#ch:impl}

Po pregledu obstoječih rešitev v \ref{ch:comp}. poglavju smo se odločili, da implementiramo svojo knjižnico za delo s skritimi markovskimi modeli. Glavni razlog za to odločitev je bilo splošno pomanjkanje dokumentacije za delo z obstoječimi orodji. Predvidevamo, da nam bo proces implementacije pomagal tudi pri razumevanju problemske domene.

Problemska domena knjižnjice, ki jo želimo implementirati, je učenje skritih markovskih modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki je dovolj dolga, da predstavlja dobro reprezentacijo pogostosti pojavljanja izrazov oz.\ besednih zvez in hkrati vsebuje tudi dovoljšen besedni zaklad. Odločili smo se, da bomo kot učne množice za ta orodja uporabili krajše knjige ali zbirke krajših vrst besedil (esejev, poezije \dots). Posamezna učna množica bo tako obsegala od 10.000 do 50.000 besed. Če predpostavimo, da bo vsaka beseda predstavljala en simbol oz. en člen opazovanega zaporedja, potem bi opazovano zaporedje iz take učne množice predstavljalo 10.000 do 50.000 simbolov. Takšna dolžina zaporedja predstavlja težavo za markovske modele, saj začnejo pri izračunu t.i. *forward* in *backward* spremenljivk (glej poglavje \ref{ch:hmm:fb}) verjetnosti opazovanih simbolov strmo padati, kar privede do napake podkoračitve (glej poglavje \ref{ch:model:underflow}) \cite{Rabiner1989}. Tej težavi se izognemo tako, da besedilo razdelimo na več delov (npr. povedi) in vsakega od teh delov obravnavamo kot krajše opazovano zaporedje, neodvisno od ostalih (podrobnosti v poglavju \ref{ch:model:multiobs}).

Eden izmed temeljnih ciljev implementacije rešitve je bilo pravilno delovanje programa in z njim pridobljenih rezultatov. Hitrost izvajanja je bila sekundarnega pomena, dokler je bila v praktičnih mejah in ni znatno upočasnjevala razvoja.

Da bi si zagotovili čim boljše možnosti za pravilno izvedbo rešitve, smo se odločili za naslednje pristope: uporabo funkcijskega programiranja, premišljeno zasnovane podatkovne strukture (prilagojene za lažje razumevanje) in programsko testiranje (t.i. *unit testing* in *property-based testing*) s sklicevanjem na referenčno rešitev in statično analizo programa. V nadaljevanju bomo podrobneje predstavili vsakega od naštetih pristopv.

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

Da bi se zavarovali pred lastnimi napakami pri programiranju rešitve, smo pred implementacijo vsake funkcije zapisali njeno specifikacijo v obliki testa enote\angl[unit test] \cite{Carlsson2006}. Ker je specifikacija izvršljiv program, smo lahko ustreznost napisane kode samodejno preverjali. Testi se izvajajo dovolj hitro, da smo jih lahko med pisanjem vsake funkcije izvršili večkrat in tako preverili, kdaj smo bližaali uspešni rešitvi. Ko je napisana koda ustrezala željenim specifikacijam, smo lahko dodali nove, strožje specifikacije, ali pa nadaljevali s pisanjem naslednje funkcije~\cite{Beck2003}.

Takšni testi so nepogrešljivi tudi pri preurejanju\footnote{Proces pri katerem spreminjamo interno organiziranost programsko kode, ne da bi pri tem spremenili njeno zunanje vedenje~\cite{Li2007}.}, saj moramo biti pri spreminjanju kode pazljivi, da ne pride do nazadovanja\angl[regression].

Naša rešitev večinoma obsega matematične algoritme, za katere ni bilo trivialno napisati specifikacije, saj bi lahko tudi z ročnim izračunavanjem hitro uvededli napake. Zato smo se oprli na referenčno implementacijo in s pomočjo pridobljenih rezultatov napisali specifikacije za naše funkcije. Referenčna implementacija, po kateri smo se zgledovali, je Python projekt HMM~\cite{guyz/HMM}, katerega preglednost in modularnost izvorne kode dovoljujeta posamično izvajanje notranjih funkcij. Pridobljene vrednosti smo prepisali v naše specifikacije.

Zaradi nenatančne narave števil s plavajočo vejico, ki smo jih uporabili za predstavitev večine rezultatov algoritmov, je bilo pri  testiranju občasno potrebno prepustiti možnost odstopanja. Določeni deli specifikacije so zato dopuščali, da so dobljene vrednosti od referenčnega rezultata odstopale za izbrano vrednost $\Delta$. To smo dosegli z uporabo ExUnit~\cite{elixir/exunit} funkcije `assert_in_delta` (to funkcijo smo nadgradili v `assert_all_in_delta` tako, da lahko preverja več rezultatov naenkrat). Ugotovili smo, da je za večino specifikacij zadostovala vrednost $\Delta = 5^{-8}$.

S pomočjo funkcije `assert_all_in_delta` smo preverili tudi ergodičnost funkcije za prehode med stanji z določenimi verjetnostmi. Za primer lahko navedemo model, ki iz določenega stanja dovoljuje prehoda v stanje $A$ z verjetnostjo 0.2 in v stanje $B$ z verjetnostjo 0.8. Specifikacija za tak model je zapisana na sliki \eqref{fig:impl:assert_ergodic}.

\input{figures/assert_ergodic}

V primerih, ko so bile specifikacije preobsežne, da bi jih ročno zapisali, smo si pomagali z orodji za t.i. *property-based testing*. Le-ta mogočajo, da posamezno lastnost istočasno preverimo na množici števil (npr. na vseh naravnih številih, vseh pozitivnih realnih številih ...). Program nato v procesu preverjanja sam izbere nekaj kombinacij takih števil, za katere preveri ujemanje s pogoji. Za okolje Erlang/OTP je na voljo orodje QuickCheck, katerega smo lahko s pomočjo orodja ExCheck~\cite{parroty/excheck} uporabili v programskem okolju Elixir. QuickCheck in ExCheck ponujata omejen jezik, s katerim opišemo lastnosti, ki smo jih želeli preveriti v našem programu. Orodji sta generirali naključne testne primere in preverili ustreznost naših rezultatov.~\cite{Li2007} Primer specifikacije je prikazan na sliki \eqref{fig:impl:excheck_extended_logarithm}.

\input{figures/excheck_extended_logarithm}

## Statična analiza

Tako kot programsko okolje Erlang/OTP, tudi Elixir temelji na konceptu dinamičnih programskih tipov (t.i. *dynamic typing*), ki ne zahtevajo označevanja z informacijami o programskih tipih. Da bi lahko uporabniki kljub temu koristili prednosti, ki jih prinašajo orodja za statično analizo programske kode, se lahko poslužijo koncepta postopnega tipiziranja (t.i. *gradual typing*)~\cite{Papadakis2011}. Na ta način se informacije o programskih tipih dodajajo po potrebi. Orodje za statično analizo na podlagi teh informacij javlja morebitne težave. Rezultat je čistejša programska koda, ki jo je lažje razumeti in vzdrževati. Je robustnejša in bolje dokumentirana~\cite{Sagonas2008}.

V programskem okolju Erlang/OTP je na voljo orodje Dialyzer~\cite{Sagonas2005}, ki pa se lahko uporablja tudi v okolju Elixir s pomočjo orodja Dialyxir~\cite{jeremyjh/dialyxir}.

## Izbira programskega jezika

Elixir~\cite{Thomas2014} je sodoben, dinamičen, funkcijski programski jezik. Zgrajen je na osnovi Erlangovega navideznega stroja, zato ima kljub svoji relativni novosti na voljo zelo bogat ekosistem in več desetletij razvoja, ki jih ponuja platforma Erlang/OTP~\cite{Armstrong2007}. Nenazadnje pa izbira programskega jezika za to nalogo predstavlja predvsem subjektivno odločitev avtorjev diplomskega dela.

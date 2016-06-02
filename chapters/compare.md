# Pregled obstoječih rešitev

V tem poglavju bomo naredili pregled nad obstoječimi orodji za generiranje skritih markovskih modelov in pregledali njihovo ustreznost za uporabo v problemski domeni generiranja besedil. Najprej bomo opisali kako smo poiskali potencialne projekte, ki bi lahko ustrezali našim potrebam. Nato bomo navedli, kako smo med najdenimi izbrali peščico najobetavnejših, ki si jih bomo kasneje podrobneje ogledali in našteli, kakšne kriterije bomo pri tej obravnavi upoštevali. Za tem bomo posamezno obravnavali vsakega od izbranih projektov. Nazadnje bomo še na kratko navedli nekaj projetkov, ki smo si jih ogledali, vendar se za njih nismo odločili.

\wip{zakaj smo morali redčiti? omejen čas, pregled VSEH projektov bi bil zamuden}

Zbiranje potencialnih projektov smo začeli z iskanjem na spletnem portalu za kolaborativni razvoj projektov GitHub\footnote{\url{https://github.com}}. Zaradi pudarka na orodjih za sodelovanje pri razvoju programske opreme je GitHub postal zelo priljubljen pri razvijalcih odprte kode~\cite{McDonald2013, Thung2013}. Skupaj z zmogljivim iskalnikom nam omogoča pregled nad velikim številom potencialno uporabnih projektov. Dodatno smo si lahko pomagali z indikatorji popularnosti in povezanosti projektov, s katerimi bomo lahko ocenili, ali je projekt vzdrževan in ali ima aktivne uporabnike. Takšni indikatorji nam dajo večjo možnost, da bomo našli projekt, ki bo deloval na sodobni strojni in programski opremi~\cite{Dabbish2012}. Iskanje nam je vrnilo preko 700 projektov.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/github_search.png}
\end{center}
\caption{\wip{gh serach}}
\label{diag:compare:ghsearch}
\end{figure}

Iz rezultatov iskanja smo najprej izločili tiste projekte, za katere je bilo po opisu razvidno, da se ne ukvarjajo s temo skirtih markovskih modelov. Za tem smo izločili še zapuščene in nedokočane projekte. Srečali smo se z velikim številom aktivnih in dodelanih projektov, ustvarjenih za neko določeno aplikacijo skritih markovskih modelov, npr. sekvenciranje DNK, napovedovanje gibanj na delniškem trgu, klasifikacijo besedil, kompresijo podatkov \dots, vendar so za naš problem preveč speifični. Ostale projekte smo si ogledali podrobneje ter preverili, ali imajo dokumentacijo in pod kakšno licenco so izdani.

Pomanjkanje dokumentacije se je izkazalo za največjo težavo pri iskanju primernega orodja. Dejavniki kot so veliko število parametrov in relacije med njimi vplivajo na to, da je obliko vhodnih podatkov brez dokumentacije zelo težko določiti. Pri nekaterih projektih smo si lahko pomagali s t.i. `README` datotekami, pri drugih pa z primeri uporabe, ki so jih avtorji priročno vključili poleg izvorne kode. Projekte, za katere iz teh treh virov nismo uspeli ugotoviti pravilnega načina uporabe smo izločili.

\wip{par besed o licencah ce se bo izkazalo da kateri potencialen projekt ni imel licence ali pa je imel prevec restriktivno}

\wip{kje razen na githubu smo se iskali - veliko projektov ima vsaj GH mirror ko ljudje pushajo kopijo - tako smo najdli par projektov ki sicer nimajo uradnega doma na GitHubu}

Preostale projekte smo podrobneje pregledali, da bi ugotovili, če ustrezajo naši problemski domeni — učenju skritih markovskih modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki so dovolj dolga, da predstavljajo dobro reprezentacijo pogostosti pojavljanja izrazov ter besednih zvez in hkrati vsebujejo tudi dovoljšen besedni zaklad. Zato smo se odločili, da bomo uporabili krajše knjige ali zbirge drugih, krajših vrst besedil (esejev, poezije, \dots). Posamezna učna množica bo tako obsegala od 10.0000 do 50.000 besed. Za našo problemsko domeno želimo tudi, da model oddaja diskretne vrednosti (simbole). Skriti markovski modeli lahko oddajajo tudi zvezne vrednosti. Projekte, ki delujejo izključno za zvezne emisije smo izločili.



  - preizkusili smo ce gre skozi

- kaj smo iskali pri izbiri
  - dokumentacija
  - da ni zapusceno (?)
  - da izgleda kot da kdo uporablja (?)
  - da je narejeno za splosno uporabo (dosti knjiznic za modele z zveznimi emisijami, mi rabimo diskretne), dosti orodij za delo z dnk sekvenciranjem, napovedovanjem stock marketa
  - hoteli smo licenco, ki dovoljuje …
- katere knjiznjice smo izbrali
- kaj bomo primerjali
  - primernost za generiranje besedila
  - multi obs
  - koliko dolge sekvence sprejme
  - licenca
  - performancna ustreznost
  - dokumentacijo
  - prednosti/slabosti


- primerjamo par kandidatov
- na koncu navedemo se kaj smo pregledali in nismo vzeli v primerjavo (wirecutter stil)

za posamezen projekt:
- za uvod citiran opis projekta z njihove strani
- wikipedia-style sidebar z url-jem, licenco, logotipom, avtorjemn

\pagebreak

## GHMM

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{lll} 
\\\toprule 
GHMM \\
\scriptsize{\url{http://ghmm.sourceforge.net}} \\\midrule
\footnotesize{Jeziki: C, python} \\\midrule
\footnotesize{Licenca: LGPL}\\ \midrule
\end{tabular}
\end{wraptable}

Projekt GHMM je prosto dostopna knjižnjica za jezik C, ki vsebuje izvedbo učinkovitih podatkovnih struktur in algoritmov za osnovne in razširjene skrite markovske modele z diskretnim in zveznim oddajanjem. Projekt vključuje tudi programsko ovojnico za programski jezik python, ki ponuja prijaznejši vmesnik in nekaj dodatnih funkcionalnosti ter grafični urejevalnik modelov imenovan HMMEd~\cite{sf/ghmm}.

Knjižnjica se uporablja za širok spekter raziskovalnih, akademskih in industrijskih projektov. Področja uporabe vključujejo finančno matematiko (analiza likvidnosti), fiziologijo (analiza EEG podatkov), računsko lingvistiko in astronomijo (klasifikacija zvezd). V literaturi~\cite{Schliep2004} najdemo navedbe, da je projekt GHMM znatno pripomogel pri načenjanju nekaterih novih raziskovalnih vprašanj.

Glede na razširjenost uporabe smo pričakovali, da bo dokumentacija za uporabo orodja GHMM obširnejša. Tudi spletna stran projekta navaja, da ima orodje veliko težavo s pomanjkanjem dokumentacije in potencialne uporabnike napoti k branju Rabinerjevega ‘Tutorial on Hidden Markov Models’~\cite{Rabiner1989}, ki je sicer odličen vir za razumevanje skritih markovskih modelov, vendar ne nudi pomoči pri uporabi knjižnjice.

S pomočjo komentarjev v programski kodi projekta smo kljub pomanjkanju dokumentacije uspelu vspostaviti enostaven model, nismo pa uspeli pridobiti natančnejšega nadzora nad postopkom učenja, da bi se izognili situacijam, ko postopek maksimizacije ostane v lokalnem maksimumu. Orodje sicer podpira tehnike, kot je npr. vrivanje šuma\angl{noise injection}, vendar samo za zvezno oddajanje, ne pa tudi za diskretno oddajanje, ki ga potrebujemo v našem primeru.

Projekt je izdan pod licenco LGPL, kar bi lahko predstavljalo težavo pri vključevanju v industrijskih okoljih, predvsem v primerih uporabe, kjer bi bila potrebne spremembe izvorne kode~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_ghmm.png}
\end{center}
\caption{Posnetek zaslona prikazuje skopo dokumentacijo projekta GHMM.}
\label{diag:compare:ghmm}
\end{figure}

\pagebreak

## Hmmlearn

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{lll} 
\\\toprule 
hmmlearn \\
\scriptsize{\url{http://hmmlearn.readthedocs.io}} \\\midrule
\footnotesize{Jezik: python} \\\midrule
\footnotesize{Licenca: BSD}\\ \midrule
\end{tabular}
\end{wraptable}

Hmmlearn je skupina algoritmov za nenadzorovano učenje in sklepanje za skrite markovske modele. Orodje je napisano v programskem jeziku python, programski vmesnik pa je oblikovan po  vzoru scikit-learn\footnote{Scikit-learn je modul za programski jezik python, ki vključuje široko paleto sodobnih algoritmov za nadzorovano in nenadzorovano strojno učenje pri srednje velikih problemih. Modul se osredotoča na enostavnost uporabe, zmogljivost, dokumentacijo in razumljiv programski vmesnik~\cite{Pedregosa2011}.} modula. Združljvost njunih programskih vmesnikov skupaj z dejstvom, da je scikit-learn zero razširnjen projetk pomeni, da je lahko postane hmmlearn zelo zanimiv za široko skupino uporabnikov.

Ob času pregleda je bila na voljo prva javna različica projekta 0.1.1, ki je bila izdana februarja 2015. Prihajajoča\footnote{Različica 0.2.0 je izšla marca 2016.} različica 0.2.0 prinaša veliko novosti, med drugim tudi sposobnost za učenje na mnogoterih opazovanih zaporedjih. Funkcionalnost je bila sicer že na voljo v t.i. razvojni različici, vendar smo tukaj naleteli na odstopanja med novimi razvojnimi vmesniki in dokumentacijo, ki je bila tarkat na voljo samo prejšnjo različico. Tako v praksi učenja modelov na mnogoterih zaporedjih s to knjižnjico nismo uspeli izvesti.

Kljub temu, da je hmmlearn še zgodaj v razvojni fazi, si zaradi obljubljenih enostavnih programskih vmesnikov, scikit-learn kompatibilnosti in že sedaj obsežne dokumentacije  v prihodnosti od tega projekta veliko obetamo in upamo, da bomo še imeli priložnost ga preizkusiti \wip{oblika stavka}.

Projekt je izdan pod zelo permisivno odprtokodno licenco BSD, ki dovoljuje uporabo v komercialne namene in je tako primerna tudi za industrijsko rabo~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_hmmlearn.png}
\end{center}
\caption{Posnetek zaslona prikazuje zgledno urejeno dokumentacijo projekta hmmlearn.}
\label{diag:compare:hmmlearn}
\end{figure}

\pagebreak

* * *

ne podpira mnogoterih obs, predstaviti dolgo besedilo kot eno sekvenco je problematicno, ker simboli proti koncu imajo prakticno nicno verjetnost

preveri python 3

primerjaj performance

mogoce prilepi kaj kode pri vsakemu

na koncu tabela primerjav
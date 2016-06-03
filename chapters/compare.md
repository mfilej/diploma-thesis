# Pregled obstoječih rešitev

V tem poglavju bomo naredili pregled nad obstoječimi orodji za generiranje skritih markovskih modelov. Najprej bomo opisali kakšne vrste funkcionalosti pričakujemo od orodja za uporabo v problemski domeni generiranja besedil. Nato bomo opisali, kako smo poiskali potencialne projekte, ki bi lahko ustrezali našim potrebam in kakšne kriterije smo uporabili, da smo med najdenimi izbrali peščico najobetavnejših, od katerih si bomo vsakega posebej podrobneje ogledali. Za vsak projekt bomo tudi opisali ustreznost za uporabo v problemski domeni generiranja besedil.  Kasneje bomo še na kratko navedli nekaj projetkov, ki smo si jih ogledali, vendar se za njih nismo odločili. Za konec bomo naredili še medsebojno primerjavo opisanih projektov in rezultate strnili v primerjalno tabelo.

Naša problemska domena je učenje skritih markovskih modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki so dovolj dolga, da predstavljajo dobro reprezentacijo pogostosti pojavljanja izrazov ter besednih zvez in hkrati vsebujejo tudi dovoljšen besedni zaklad. Zato smo se odločili, da bomo uporabili krajše knjige ali zbirge drugih, krajših vrst besedil (esejev, poezije, \dots). Posamezna učna množica bo tako obsegala od 10.0000 do 50.000 besed.

Za našo problemsko domeno želimo tudi, da model oddaja diskretne vrednosti (simbole). Skriti markovski modeli so lahko zgrajeni tako za oddajanje diskretnih simbolov kot tudi za zvezne vrednosti, vendar slednji za našo problemsko domeno niso primerni.

Zbiranje potencialnih projektov smo začeli z iskanjem na spletnem portalu za kolaborativni razvoj projektov GitHub\footnote{\url{https://github.com}}. Zaradi pudarka na orodjih za sodelovanje pri razvoju programske opreme je GitHub postal zelo priljubljen pri razvijalcih odprte kode~\cite{McDonald2013}. Ta priljubljenost je pospešila in vzpodbudila sodelovanje na odprtokodnih projektih~\cite{Thung2013}, zato smo se odločili, da iskanje takih projektov, ki bi bili aktivno vzdrževani in imeli za sabo tudi skupine aktivnih uporabnikov začnemo ravno na tem portalu. Skupaj z zmogljivim iskalnikom nam GitHub omogoča pregled nad velikim številom potencialno uporabnih projektov. Dodatno smo si lahko pomagali z indikatorji popularnosti in povezanosti projektov, s katerimi bomo lahko ocenili, če je projekt vzdrževan in ali ima aktivne uporabnike. Takšni indikatorji nam dajo večjo možnost, da bomo našli projekt, ki bo deloval na sodobni strojni in programski opremi~\cite{Dabbish2012}. Iskanje nam je vrnilo preko 700 projektov.

\wip{kje razen na githubu smo se iskali - veliko projektov ima vsaj GH mirror ko ljudje pushajo kopijo - tako smo najdli par projektov ki sicer nimajo uradnega doma na GitHubu. iskali smo tudi preko znanstvenih clankov, smo nasli nekaj projektov, vecinoma starejsih}

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/github_search.png}
\end{center}
\caption{Posnetek zaslona prikazuje iskalni vmesnik portala GitHub. Indikatorji aktivnosti, kot so število ljudi, ki je projekt označilo kot zanimiv in še pomembneje število ljudi, ki je nameravalo k nekemu projektu prispevati svoje delo, so nam pomagali izbrati perspektivnejše projekte.}
\label{diag:compare:ghsearch}
\end{figure}

Da bi naredili pregled projektov praktično izvedljiv v časovnem okviru, določenem za diplomsko nalogo, smo morali množico najdenih projektov razredčiti na hevrističen način, brez da bi vsak projekt posebej pregledali. Iz rezultatov iskanja smo najprej izločili tiste projekte, za katere je bilo po opisu razvidno, da se ne ukvarjajo s temo skirtih markovskih modelov. Za tem smo izločili še zapuščene in nedokočane projekte. Srečali smo se z velikim številom aktivnih in dodelanih projektov, ustvarjenih za neko določeno aplikacijo skritih markovskih modelov, npr. sekvenciranje DNK, napovedovanje gibanj na delniškem trgu, klasifikacijo besedil, kompresijo podatkov \dots, vendar so za naš problem preveč speifični. Ostale projekte smo si ogledali podrobneje ter preverili, ali imajo dokumentacijo in pod kakšno licenco so izdani.

Pomanjkanje dokumentacije se je izkazalo za največjo težavo pri iskanju primernega orodja. Dejavniki kot so veliko število parametrov in relacije med njimi vplivajo na to, da je obliko vhodnih podatkov brez dokumentacije zelo težko določiti. Pri nekaterih projektih smo si lahko pomagali s t.i. `README` datotekami, pri drugih pa z primeri uporabe, ki so jih avtorji priročno vključili poleg izvorne kode. Projekte, za katere iz teh treh virov nismo uspeli ugotoviti pravilnega načina uporabe smo izločili. 	\wip{Podobno kot za licence Sonnenburg2007 omeni da bi lahko s prilaganjem krajsih clankov poleg kode znatno izboljsali podrocje programske opreme za strojno ucenje.}

\wip{lahko recemo, da smo iskali projekte, ki bi bli primerni za uporabo v industriji, zato par besed o licencah ce se bo izkazalo da kateri potencialen projekt ni imel licence ali pa je imel prevec restriktivno - Sonnenburg2007 opisuje kako se lahko projekti za strojno ucenje, ce so izdani pod primerno odprtokodno licenco bolje razvijejo; Stewart2006:
) license restrictiveness and organizational sponsorship interact to influence user perceptions of the likely utility of open source software in such a way that users are most attracted to projects that are sponsored by nonmarket organizations and that employ nonrestrictive licenses
}

\wip{vecinoma smo nasli Python knjiznjice - verjeto zaradi popularnosti Pythona v znanstvenih srenjah in zaradi zelo dobrega package NumPy (se enkrat tista referenca)}

Preostale projekte smo podrobneje pregledali, da bi ugotovili, če ustrezajo zgoraj navedenim kriterijem: da modelirajo diskretne markovske modele in da imajo podporo za mnogotera opazovana zaporedja. Projekte, ki delujejo izključno za zvezne emisije smo izločili, saj za naš namen niso primerni. Prav tako smo izločili projekte brez podpore za mnogotera opazovana zaporedja.



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

\vfill
\pagebreak

## Projekt GHMM

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{l} 
\\\toprule 
GHMM \\
\scriptsize{\url{http://ghmm.sourceforge.net}} \\\midrule
\footnotesize{Jeziki: C, Python} \\\midrule
\footnotesize{Licenca: GNU LGPL}\\ \midrule
\end{tabular}
\end{wraptable}

Projekt GHMM je prosto dostopna knjižnjica za jezik C, ki vsebuje izvedbo učinkovitih podatkovnih struktur in algoritmov za osnovne in razširjene skrite markovske modele z diskretnim in zveznim oddajanjem. Projekt vključuje tudi programsko ovojnico za programski jezik Python, ki ponuja prijaznejši vmesnik in nekaj dodatnih funkcionalnosti ter grafični urejevalnik modelov imenovan HMMEd~\cite{sf/ghmm}.

Knjižnjica se uporablja za širok spekter raziskovalnih, akademskih in industrijskih projektov. Področja uporabe vključujejo finančno matematiko (analiza likvidnosti), fiziologijo (analiza EEG podatkov), računsko lingvistiko in astronomijo (klasifikacija zvezd). V literaturi~\cite{Schliep2004} najdemo navedbe, da je projekt GHMM znatno pripomogel pri načenjanju nekaterih novih raziskovalnih vprašanj.

Glede na razširjenost uporabe smo pričakovali, da bo dokumentacija za uporabo orodja GHMM obširnejša. Tudi spletna stran projekta navaja, da ima orodje veliko težavo s pomanjkanjem dokumentacije in potencialne uporabnike napoti k branju Rabinerjevega ‘Tutorial on Hidden Markov Models’~\cite{Rabiner1989}, ki je sicer odličen vir za razumevanje skritih markovskih modelov, vendar ne nudi pomoči pri uporabi knjižnjice.

S pomočjo komentarjev v programski kodi projekta smo kljub pomanjkanju dokumentacije uspelu vspostaviti enostaven model, nismo pa uspeli pridobiti natančnejšega nadzora nad postopkom učenja, da bi se izognili situacijam, ko postopek maksimizacije ostane v lokalnem maksimumu. Orodje sicer podpira tehnike, kot je npr. vrivanje šuma\angl{noise injection}, vendar samo za zvezno oddajanje, ne pa tudi za diskretno oddajanje, ki ga potrebujemo v našem primeru.

Projekt je izdan pod deloma restriktivno licenco LGPL~\cite{Comino2007}, kar bi lahko predstavljalo težavo pri vključevanju v industrijskih okoljih, predvsem v primerih uporabe, kjer bi bila potrebne spremembe izvorne kode~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_ghmm.png}
\end{center}
\caption{Posnetek zaslona prikazuje skopo dokumentacijo projekta GHMM.}
\label{diag:compare:ghmm}
\end{figure}

\vfill
\pagebreak

## Projekt hmmlearn

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{l} 
\\\toprule 
hmmlearn \\
\scriptsize{\url{http://hmmlearn.readthedocs.io}} \\\midrule
\footnotesize{Jezik: Python} \\\midrule
\footnotesize{Licenca: BSD}\\ \midrule
\end{tabular}
\end{wraptable}

Hmmlearn je skupina algoritmov za nenadzorovano učenje in sklepanje za skrite markovske modele. Orodje je napisano v programskem jeziku Python, programski vmesnik pa je oblikovan po  vzoru scikit-learn\footnote{Scikit-learn je modul za programski jezik Python, ki vključuje široko paleto sodobnih algoritmov za nadzorovano in nenadzorovano strojno učenje pri srednje velikih problemih. Modul se osredotoča na enostavnost uporabe, zmogljivost, dokumentacijo in razumljiv programski vmesnik~\cite{Pedregosa2011}.} modula. Združljvost njunih programskih vmesnikov skupaj z dejstvom, da je scikit-learn zero razširnjen projetk pomeni, da je lahko postane hmmlearn zelo zanimiv za široko skupino uporabnikov.

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

\vfill
\pagebreak

## Projekt HMM

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{l} 
\\\toprule 
hmmlearn \\
\scriptsize{\url{https://github.com/guyz/HMM}} \\\midrule
\footnotesize{Jezik: Python} \\\midrule
\footnotesize{Licenca: ni podana}\\ \midrule
\end{tabular}
\end{wraptable}

Projekt HMM je ogrodje za delo z skritimi markovskimi modeli, zgrajeno na osnovi sklopa programske opreme NumPy\footnote{NumPy je okrajšava za Numerical Python. Ta sklop programske opreme je namenjen v pomoč pri znanstvenih izračunih v programskem okolju Python in služi kot temelj številnim znanstveim knjižnjicam~\cite{Walt2011}.}. Implementacija algoritmov, tako kot mnoge druge, temelji na Rabinerjevem članku “A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition” \cite{Rabiner1989} in vključuje tako diskretne kot zvezne modele. Ena izmed prednosti ogrodja, ki jih drugi projekti ne ponujajo, je vgrajena podpora za razširitve, ki uporabnikom omogoča, da napišejo svoje verjetnostne modele. Razširitev je omogočena z uporabo delovanja, podrobnosti pa so opisane v izvorni kodi projekta v datoteki `GMHMM.py`. 

\wip{Non-linear weighing functions}

Ogrodje HMM poleg že omenjenega programskega paketa NumPy, ni odvisno od drugih programskih paketov in knjižnjic. Zaradi tega se je ogrodje izkazalo enostavnejše za namestitev od večine ostalih projektov. 

Zaradi popolnega pomanjkanju dokumentacije smo za zgled uporabe morali pobrskati po izvorni kodi. Izkazalo se je, da ima projekt v datoteki `HMM/hmm/examples/tests.py` nekaj dovolj nazornih primerov uporabe, programski vmesnik pa je dovolj ekspliciten, da smo lahko vspostavili učenje skritih markovskih modelov na podlagi besedila, kasneje pa tudi simulacijo modela. Izvorna koda je dovolj jasno napisana in smiselno organizirana, da smo lahko potrebne podrobnosti implementacije poiskali sami.
\begin{figure}
\begin{verbatim}
words = # vsebuje vhodno besedilo (učno množico)
alphabet = Alphabet(words)
hmm_factory = HMMFromMatricesFactory()
hmm = hmm_factory(alphabet, dist, A, B, pi)
seq = EmissionSequence(alphabet, words)
hmm.baumWelch(seq)
 
hmm.sample(20, 15) # Generiranje 20 zaporedij, od
                   # katerih ima vsako 15 simbolov.
\end{verbatim}
\caption{Primer uporabe ogrodja HMM za učenje na podlagi vhodnega besedila (polje \texttt{words}) in začetnih parametrov modela (večdimenzionalana NumPy polja \texttt{A} in \texttt{B} ter polje \texttt{pi}).}
\end{figure}

Poglavitna ovira pri morebitni uporabi ogrodja HMM je pomanjkanje odprtokodne licence. Projekt, ki ne vključi licence, ne moremo uporabljati, spreminjati ali deliti, če to ni eksplicitno navedeno s strani avtorjev programske opreme~\cite{web/nolicense}. Menimo tudi, da bi ustrezna, permisivna odprtokodna licenca privabila več razvijalcev k projektu in ga tako pripomogla k višji kvaliteti in širši uporabnosti~\cite{Stewart2006}.

\vfill
\pagebreak


## Projekt mshmm {#ch:compare:mshmm}

\begin{wraptable}{r}[0.5cm]{5.5cm}
\begin{tabular}{l} 
\\\toprule 
mshmm \\
\scriptsize{\url{https://cran.r-project.org/web/packages/mhsmm}} \\\midrule
\footnotesize{Jeziki: R, C} \\\midrule
\footnotesize{Licenca: GNU GPL}\\ \midrule
\end{tabular}
\end{wraptable}

Mhsmm je sklop programske opreme za sistem za statistično računanje R. Motivacija za nastanek projekta so bile raziskave na področju povezanosti razmnoževanja živine z različnimi indikatorji pristonosti škodljivcev. Skriti markovski modeli so v tem kontekstu pomagali pri dopolnjevanju pomanjkljivih podakov in združevanju ločenih opazovanih zaporedij, ki so bila vzorčena z racličnimi frekvencami~\cite{OConnell2011}. Poglavitne funkcije programskega sklopa so hkratno opazovanje različnih statističnih spremenljivk in podpora za zaporedja z manjkajočimi vrednostmi. Ključni deli programa so napisani v programskem jeziku C, kar zagotavlja hitro izvajanje.

Orodje mshmm je sposobno modelirati tudi t.i. skrite pol-markovske modele. Pri klasičnih skriti markovskih modelih je čas postanka v posameznem stanju geometrično porazdeljen (enakomerni intervali $t, t+1, \dots$; glej poglavje \ref{ch:vir}). Pri modeliranju marsikaterih realnih problemov je ta omejitev nepraktična~\cite{OConnell2011}, vendar za našo problemsko domeno abstrakcija pol-markovskih modelov ni potrebna. Kar je za našo problemsko domeno pomembno je to, da orodje ustreza našim zahtevam za oddajanje diskretnih vrednosti in podporo mnogoterih opazovanih zaporeidij. Uporabnikom orodja je dodatno omogočeno, da poleg vrste vključenih porazdelitev emisij na podlagi uporabniških razširitev implementirajo tudi lastne porazdelitve. Zaradi neizkušenosti v programskem okolju R te funkcionalnosti nismo preizkusili.

Projekt zagotavlja dokumentacijo v obliki PDF datoteke~\cite{OConnell2011}, ki sicer zelo razumno prikaže nekaj primerov uporabe programskega sklopa, vendar smo pri preizkušanju le-tega pogrešali podrobnejšo in celovitejšo dokumentacijo programskega vmesnika, kot jo pričakujemo vzdrževane programske opreme, ki je namenjena širši uporabniški množici.

Projekt je izdan pod restriktivno licenco GPL, ki lahko predstavlja oviro pri vključevanju projekta v industrijska okolja, predvsem v primerih uporabe, kjer bi bila potrebne sprememba izvorne kode~\cite{Determann2006}.

\begin{figure}[b]
\begin{center}
\includegraphics[width=\textwidth]{images/compare_r_mhsmm.pdf}
\end{center}
\caption{Izpis orodja 	\texttt{mhsmm} zelo nazorno prikaže delovanje (zveznega) skritega markovskega modela. Horizontalna črta s pomočjo barv prikazuje prehajanje med stanji, krivulja pa prikazuje vrednosti, ki jih je model oddajal.}
\label{diag:compare:r_mhsmm}
\end{figure}

\vfill
\pagebreak

## UDMHMM

\begin{wraptable}{r}[1cm]{5.5cm}
\begin{tabular}{l} 
\\\toprule 
UDMHMM \\
\scriptsize{\url{http://www.kanungo.com/software/software.html}} \\\midrule
\footnotesize{Jezik: C} \\\midrule
\footnotesize{Licenca: GNU GPL}\\ \midrule
\end{tabular}
\end{wraptable}

razsiri kratico

ful kul, ne podpira multi obs, vseeno sprejme ful dolgo sekvenco, ne da pa kontrole nad tem da bi dolocli kako se te sekvence procesirajo itd

relativno star, ni aktivnega razvoja

se izkazal za prakticno uporabnega z nekaj podporne kode

potrebuje se nekaj dodatne programske opreme za symbol- >int in obratno konverzijo

licenca na zalost gpl, precej restriktivna, modificirano kodo bi zelo tezko uporabljali v industrijske namene (cite usual)

\vfill
\pagebreak

## Ostali projekti

\wip{tu bomo opisali kar smo si se ogledali in ni prslo v postev}

Zasledili smo nekaj raziskav, ki modeliranje skritih markovskih modelov opravljajo na platfori Matlab/Octave, vendar izvorne kode pri večini ni bilo na voljo~\cite{Yun2013}. Izjema sta bila projekta iHMM~\cite{Gael2008} in H2M~\cite{Cappe2001}, ki sta omenjena v različnih znanstvenih člankih. Slednji se med drugim uporablja na področjih razpoznavanja govora~\cite{Ramesh1992} in na področju zaznavanja in klasifikacije zvokov (razločevanje med razbitjem stekla, človeškimi vzkliki, streli orožja, eksplozijami, zapiranjem vrat…) \cite{Dufaux2000}. Oba projekta sta se izkazala za neprimerna za našo problemsko domeno, ki zahteva skrite markovske modele z diskretno emisijo, projekta pa podirata samo zvezne~\cite{Cappe2001}.

Poleg projekta `mshmm` (glej poglavje \ref{ch:compare:mshmm}) je za programsko okolje R na voljo še projekta `HMM` (\url{https://cran.r-project.org/web/packages/HMM}) in `hsmm` (\url{https://cran.r-project.org/web/packages/hsmm}), ki se od `mshmm` razlikujeta v dveh ključnih vidikih~\cite{OConnell2011}. Prvi je ta, da `hsmm` ne podpira uporabniških razširitev za implementacijo novih porazdelitev emisij. Drugi vidik, ki je za našo problemsko domeno pomembnejši, pa je pomanjkanje zmožnosti za obdelavo mnogoterih opazovanih zaporedij, kar projekt naredi neprimeren za uporabo pri generaciji besedil.


* * *

ne podpira mnogoterih obs, predstaviti dolgo besedilo kot eno sekvenco je problematicno, ker simboli proti koncu imajo prakticno nicno verjetnost

preveri python 3

primerjaj performance

mogoce prilepi kaj kode pri vsakemu

mogoce kaka shema kje ce je smiselno, recimo struktura objektov/classov/klici funkcij itd - ali pa pipeline kako potekajo podatki

mogoce se potozi glede dependencijev pri ostalih, glede nato, da bomo guyz/hmm zaradi tega pohvalili

nekaj bo moglo bit dejanske primerjave. zacni z: “primerjali bomo naslednje stvari: …, … “ in nastej stvari ki smo opisali v posameznem poglavju: dokumentacija, enostavnost uporabe, (kar v tabeli spodaj) - potem z besedami opisi kaj kdo ma in kdo nima.

na koncu tabela primerjav: licenca, dokumentacija, multi-obs, delovanje na veliki mnozici, performance


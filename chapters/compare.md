# Pregled področja

V tem poglavju bomo naredili pregled nad obstoječimi orodji za generiranje skritih markovskih modelov. Najprej bomo opisali kakšne vrste funkcionalosti pričakujemo od orodja za uporabo v problemski domeni generiranja besedil. Nato bomo opisali najobetavnejše projekte, pregledali, kaj ponujajo in za vaskega posebej pregeldali, kako ustrezen je za uporabo v naši problemski domeni. Za tem bomo med temi projekti naredili še medsebojno primerjavo in rezultate strnili v primerjalno tabelo.  V primerjavo smo vključili tudi lastno implementacijo, opisano v \ref{ch:impl}. poglavju. Navedli in na kratko bomo opisali še nekaj obetavnih projetkov, ki niso ustrezali vsem kriterijm in se zato nismo odločili za podrobnejši pregled. Za konec bomo opisali, kje in kako smo projekte iskali, kako smo seznam najdenih projektov razredčili in utemeljili, zakaj smo menili, da bi ravno ti opisani projekti ustrezali našim potrebam in kakšne kriterije smo uporabili, da smo med najdenimi izbrali peščico najobetavnejših.

Naša problemska domena je učenje skritih markovskih modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki so dovolj dolga, da predstavljajo dobro reprezentacijo pogostosti pojavljanja izrazov ter besednih zvez in hkrati vsebujejo tudi dovoljšen besedni zaklad. Zato smo se odločili, da bomo kot učne množice za ta orodja uporabili krajše knjige ali zbirge drugih, krajših vrst besedil (esejev, poezije, \dots). Posamezna učna množica bo tako obsegala od 10.000 do 50.000 besed. Če predpostavimo, da bo vsaka beseda predstavljala en simbol oz. en člen opazovanega zaporedja (namesto besede bi lahko izbrali tudi skupino črk (n-gram) ali posamezno črko; dilemo bomo podrobneje opisali v poglavju \wip{referenca na poglavje}, potem bi opazovano zaporedje iz take učne množice predstavljalo 10.000 do 50.000 simbolov. Takšna dolžina zaporedja predstavlja težavo za markovske modele, ker se pri izračunu t.i. *forward* in *backward* vrednosti (glej poglavje \ref{ch:hmm:fb}) začnejo verjetnosti opazovanih simbolov strmo padati, kar privede do napake podkoračitve (glej poglavje \ref{ch:model:underflow}) \cite{Rabiner1989}. Tej težavi se izognemo tako, da besedilo razdelimo na več delov (npr. povedi) in vsakega od teh delov obravnavamo kot krajše opazovano zaporedje, neodvisno od ostlaih (podrobnosti v poglavju \ref{ch:model:multiobs}). Zato bomo pri pregledu projektov, ki bi bili primerni za našo domeno poudarek dali na take, ki lahko na vhodu vzamejo mnogotera opazovana zaporedja.

Markovske modele ločimo glede na vrsto vrednosti ki, jih opazujejo oz. oddajajo. Diskretne modele imenujemo tiste, ki oddajajo iz diskretne zaloge vrednosti, zvezne pa tiste, ki oddajajo iz zvezne zaloge vrednosti. Za našo problemsko domeno želimo, da model oddaja diskretne vrednosti, ki jim pravimo tudi simboli, zato se bomo osredotočili na projekte, ki modelirajo diskretne modele.

Izbrane projekte smo si podrobno ogledali, da bi ugotovili, če ustrezajo zgoraj navedenim kriterijem: da modelirajo diskretne markovske modele in da imajo podporo za mnogotera opazovana zaporedja. Poleg tega smo raziskali za kakšen namen so bili razviti, kakšne funkcionalnosti ponujajo in kako dostopni so za uporabo. Pregledali smo tudi dokumentacijo, ki je na voljo in pod kakšno licenco so projekti izdani.

\vfill
\pagebreak

## Projekt GHMM

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jeziki \\
\url{http://ghmm.sourceforge.net} & GNU LGPL  & Python, C \\\midrule
\end{tabular}
\end{center}

Projekt GHMM je prosto dostopna knjižnjica za jezik C, ki vsebuje izvedbo učinkovitih podatkovnih struktur in algoritmov za osnovne in razširjene skrite markovske modele z diskretnim in zveznim oddajanjem. Projekt vključuje tudi programsko ovojnico za programski jezik Python, ki ponuja prijaznejši vmesnik in nekaj dodatnih funkcionalnosti ter grafični urejevalnik modelov imenovan HMMEd~\cite{sf/ghmm}.

Knjižnjica se uporablja za širok spekter raziskovalnih, akademskih in industrijskih projektov. Področja uporabe vključujejo finančno matematiko (analiza likvidnosti), fiziologijo (analiza EEG podatkov), računsko lingvistiko in astronomijo (klasifikacija zvezd). V literaturi~\cite{Schliep2004} najdemo navedbe, da je projekt GHMM znatno pripomogel pri načenjanju nekaterih novih raziskovalnih vprašanj.

Glede na razširjenost uporabe smo pričakovali, da bo dokumentacija za uporabo orodja GHMM obširnejša. Tudi spletna stran projekta navaja, da ima orodje veliko težavo s pomanjkanjem dokumentacije in potencialne uporabnike napoti k branju Rabinerjevega ‘Tutorial on Hidden Markov Models’~\cite{Rabiner1989}, ki je sicer odličen vir za razumevanje skritih markovskih modelov, vendar ne nudi pomoči pri uporabi knjižnjice.

S pomočjo komentarjev v programski kodi projekta smo kljub pomanjkanju dokumentacije uspelu vspostaviti enostaven model, nismo pa uspeli pridobiti natančnejšega nadzora nad postopkom učenja, da bi se izognili situacijam, ko postopek maksimizacije ostane v lokalnem maksimumu. Orodje sicer podpira tehnike, kot je npr. vrivanje šuma\angl[noise injection], vendar samo za zvezno oddajanje, ne pa tudi za diskretno oddajanje, ki ga potrebujemo v našem primeru.

Projekt je izdan pod deloma restriktivno licenco LGPL~\cite{Comino2007}, kar bi lahko predstavljalo težavo pri vključevanju v industrijskih okoljih, predvsem v primerih uporabe, kjer bi bila potrebne spremembe izvorne kode~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_ghmm.png}
\end{center}
\caption{Posnetek zaslona prikazuje skopo dokumentacijo projekta GHMM.}
\label{diag:compare:ghmm}
\end{figure}

## Projekt HMM

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{https://github.com/guyz/HMM} & ni podana  & Python \\\midrule
\end{tabular}
\end{center}

Projekt HMM je ogrodje za delo z skritimi markovskimi modeli, zgrajeno na osnovi sklopa programske opreme NumPy\footnote{NumPy je okrajšava za Numerical Python. Ta sklop programske opreme je namenjen v pomoč pri znanstvenih izračunih v programskem okolju Python in služi kot temelj številnim znanstveim knjižnjicam~\cite{Walt2011}.}. Implementacija algoritmov, tako kot pri mnogih drugih projektih, temelji na Rabinerjevem članku “A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition” \cite{Rabiner1989} in vključuje tako diskretne kot zvezne modele. Ena izmed prednosti ogrodja, ki ni bila prisotna pri vseh projektih, je eksplicitna podpora za razširitve, ki uporabnikom omogoča, da napišejo svoje vrste verjetnostnih modelov. Razširitev je omogočena z uporabo delovanja, podrobnosti pa so opisane v izvorni kodi projekta v datoteki `GMHMM.py`. Poleg izvedbe celotnega verjetnostnega modela po meri se lahko odločimo tudi za delno prilagoditev z prepisom funkcij, ki opazovanim simbolom nelinearno določajo težo (privzeto je teža za vsa opazovanja enaka).

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

Poglavitna ovira pri morebitni uporabi ogrodja HMM je pomanjkanje odprtokodne licence. Takšnega projekta, ki ne vključuje licence, ne moremo uporabljati, spreminjati ali deliti, če to ni eksplicitno navedeno s strani avtorjev programske opreme~\cite{web/nolicense}. Menimo tudi, da bi ustrezna, permisivna odprtokodna licenca privabila več razvijalcev k projektu in ga tako pripomogla k višji kvaliteti in širši uporabnosti~\cite{Stewart2006}.

## Projekt hmmlearn

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{http://hmmlearn.readthedocs.io} & BSD  & Python \\\midrule
\end{tabular}
\end{center}

Hmmlearn je skupina algoritmov za nenadzorovano učenje in sklepanje za skrite markovske modele. Orodje je napisano v programskem jeziku Python, programski vmesnik pa je oblikovan po  vzoru scikit-learn\footnote{Scikit-learn je modul za programski jezik Python, ki vključuje široko paleto sodobnih algoritmov za nadzorovano in nenadzorovano strojno učenje pri srednje velikih problemih. Modul se osredotoča na enostavnost uporabe, zmogljivost, dokumentacijo in razumljiv programski vmesnik~\cite{Pedregosa2011}.} modula. Združljvost njunih programskih vmesnikov skupaj z dejstvom, da je scikit-learn zelo razširnjen projetk pomeni, da je lahko postane hmmlearn zelo zanimiv za široko skupino uporabnikov. Podobno kot `HMM` tudi `hmmlearn` uporabnikom preko mehanizma dedovanja nudi podporo za implementacijo verjetnostnih modelov po meri. Podrobnosti so opisane v dokumentaciji projekta.

Ob času pregleda je bila na voljo prva javna različica projekta 0.1.1, ki je bila izdana februarja 2015. Prihajajoča\footnote{Različica 0.2.0 je izšla marca 2016.} različica 0.2.0 prinaša veliko novosti, med drugim tudi sposobnost za učenje na mnogoterih opazovanih zaporedjih. Funkcionalnost je bila sicer že na voljo v t.i. razvojni različici, vendar smo tukaj naleteli na odstopanja med novimi razvojnimi vmesniki in dokumentacijo, ki je bila tarkat na voljo samo za prejšnjo različico. Tako v praksi učenja modelov na mnogoterih zaporedjih s to knjižnjico nismo uspeli izvesti.

Kljub temu, da je hmmlearn še zgodaj v razvojni fazi, si zaradi obljubljenih enostavnih programskih vmesnikov, scikit-learn kompatibilnosti in že sedaj obsežne dokumentacije  v prihodnosti od tega projekta veliko obetamo in upamo, da bomo še imeli priložnost ga preizkusiti \wip{oblika stavka}.

Projekt je izdan pod zelo permisivno odprtokodno licenco BSD, ki dovoljuje uporabo v komercialne namene in je tako primerna tudi za industrijsko rabo~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_hmmlearn.png}
\end{center}
\caption{Posnetek zaslona prikazuje zgledno urejeno dokumentacijo projekta hmmlearn.}
\label{diag:compare:hmmlearn}
\end{figure}

## Projekt mhsmm {#ch:compare:mhsmm}

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{https://cran.r-project.org/web/packages/mhsmm} & GNU GPL  & R \\\midrule
\end{tabular}
\end{center}

Mhsmm je sklop programske opreme za sistem za statistično računanje R. Motivacija za nastanek projekta so bile raziskave na področju povezanosti razmnoževanja živine z različnimi indikatorji pristonosti škodljivcev. Skriti markovski modeli so v tem kontekstu pomagali pri dopolnjevanju pomanjkljivih podakov in združevanju ločenih opazovanih zaporedij, ki so bila vzorčena z racličnimi frekvencami~\cite{OConnell2011}. Poglavitne funkcije programskega sklopa so hkratno opazovanje različnih statističnih spremenljivk in podpora za zaporedja z manjkajočimi vrednostmi. Ključni deli programa so napisani v programskem jeziku C, kar zagotavlja hitro izvajanje.

Orodje mhsmm je sposobno modelirati tudi t.i. skrite pol-markovske modele. Pri klasičnih skriti markovskih modelih je čas postanka v posameznem stanju geometrično porazdeljen (enakomerni intervali $t, t+1, \dots$; glej poglavje \ref{ch:vir}). Pri modeliranju marsikaterih realnih problemov je ta omejitev nepraktična~\cite{OConnell2011}, vendar za našo problemsko domeno abstrakcija pol-markovskih modelov ni potrebna. Kar je za našo problemsko domeno pomembno je to, da orodje ustreza našim zahtevam za oddajanje diskretnih vrednosti in podporo mnogoterih opazovanih zaporeidij. Uporabnikom orodja je dodatno omogočeno, da poleg vrste vključenih porazdelitev emisij na podlagi uporabniških razširitev implementirajo tudi lastne porazdelitve. Zaradi neizkušenosti v programskem okolju R te funkcionalnosti nismo preizkusili.

Funkcionalnost, ki je pri preostalih projektih nismo zasledili, je sposobnost prikaza emisij modela na zalo nazoren, grafični način. Primer izpisa je prikazan na sliki \ref{diag:compare:r_mhsmm}.

\begin{figure}[b]
\begin{center}
\includegraphics[width=\textwidth]{images/compare_r_mhsmm.pdf}
\end{center}
\caption{Izpis orodja 	\texttt{mhsmm} zelo nazorno prikaže delovanje (zveznega) skritega markovskega modela. Horizontalna črta s pomočjo barv prikazuje prehajanje med stanji, krivulja pa prikazuje vrednosti, ki jih je model oddajal.}
\label{diag:compare:r_mhsmm}
\end{figure}

Dokumentacijo projekta najdemo v obliki datoteke PDF~\cite{OConnell2011}, ki sicer zelo razumno prikaže nekaj primerov uporabe programskega sklopa, vendar smo pri preizkušanju le-tega pogrešali podrobnejšo in celovitejšo dokumentacijo programskega vmesnika, kot jo pričakujemo vzdrževane programske opreme, ki je namenjena širši uporabniški množici.

Projekt je izdan pod restriktivno licenco GPL, ki lahko predstavlja oviro pri vključevanju projekta v industrijska okolja, predvsem v primerih uporabe, kjer bi bila potrebne sprememba izvorne kode~\cite{Determann2006}.

## Projekt UMDHMM

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{http://www.kanungo.com/software/software.html} & GNU GPL  & C \\\midrule
\end{tabular}
\end{center}

*UMDHMM Hidden Markov Model Toolkit* \cite{Kanungo1999} je projekt Marylandske univerze, ki implementira algoritme Forward-Backward, Viterbi in Baum-Welch za delo z skritimi markovskimi modeli.

Za razliko od ostalih projektov, ki smo jih pregledali, UMDHMM ne ponuja funkcij v obliki knjižnjice, ki bi jih lahko uporabniki klicali iz lastne programske kode. Glavni vmesnik za uporabo omenjenih algoritmov so programi, namenjeni uporabi preko vmesnika z ukazno vrstico. Projekt obsega programe `genseq`, `testvit`, `esthmm` in `testfor`.

\begin{description}
\item[Program \tt{esthmm}] je jedro projekta, ki na podlagi podanega zaporedja simbolov z uporabo algoritma Baum-Welch (glej poglavje \ref{ch:hmm:bw}) naredi oceno parametrov za skriti markovski model.
\item[Program \tt{genseq}] uprabi parametre modela, ki jih je generiral program \texttt{esthmm} in na njihovi podlagi generira naključno zaporedje simbolov.
\item[Program \tt{testvit}] z uporabo algoritma Viterbi oceni, katero zaporedje stanj je najbolj verjetno za neko dano zaporedje simbolov.
\item[Program \tt{testfor}] z uporabo algoritma Forward (glej poglavje \ref{ch:hmm:fb}) izračuna verjetnost opazovanega zaporedja glede na model; $P(O \given \lambda)$.
\end{description}

Za primer (prikazan na sliki \ref{fig:compare:umdhmm}) vzemimo uporabo programa za ocenjevanja parametrov modela. Podati je potrebno parametra $N$ in $M$, ki določata število stanj modela  in število simbolov, ki jih model oddaja. Zaporedje, ki predstavlja učno množico za model je shranjeno v datoteki \texttt{input.seq} v obliki zaporedja številk stanj. Rezultat bo izpisan na standardni izhod v obliki parametrov modela $\lambda = (A, B, \pi, N, M)$ \eqref{eq:theory:model}.

\input{figures/compare_umdhmm_example}

Preprostost vmesnik z ukazno vrstico nam je omogočila, da smo na podlagi vhodnega zaporedja na enostaven način zgradili model in pričeli z simulacijo. Hkrati tak vmesnik pomeni, da nimamo tako podrobnega nadzora nad vnosom vhodnih podatkov, kot bi ga imeli z neposrednim klicem funkcij programskega vmesnika. Program kot vhod sprejme eno zaporedje, uporabnik pa nima nadzora nad tem, kako se to zaporedje razdeli pred učenjem modela. V projektu smo sicer našli navedbe, da program podpira učenje modela na podlagi mnogoterih opazovanih zaporedij, vendar  zaradi omenjenega pomanjkanja nadzora nismo uspeli ugotoviti po kakšnem principu se zaporedja obravnavajo.

V literaturi~\cite{Zhou2005} smo našli navedbe, da se projekt uporablja za predikcijo pri modeliranju in analizi struktur beljakovinskih molekul. Pri analizi avtorji navajajo, da  program UMDHMM delno spremenili, vendar izvorna koda ni bila na voljo (čeprav licenca GPL, pod katero je projekt izdan, to zahteva~\cite{Determann2006}), da bi te spremembe lahko pregledali.

Za branje dokumentacije nas projekt napoti na priloženo PDF datoteko, ki pa vsebuje samo splošne informacije o teoriji skritih markovskih modelov, ne poda pa navodil za uporabo priloženih programov. Vsakega izmed programov lahko v ukazni vrstici poženemo brez parametrov in tako dobimo kratek priročnik uporabe, npr:

```
$ esthmm
Usage1: esthmm [-v] -N <num_states> -M <num_symbols> <file.seq>
Usage2: esthmm [-v] -S <seed> -N <num_states> -M <num_symbols> <file.seq>
Usage3: esthmm [-v] -I <mod.hmm> <file.seq>
  N - number of states
  M - number of symbols
  S - seed for random number genrator
  I - mod.hmm is a file with the initial model parameters
  file.seq - file containing the obs. seqence
  v - prints out number of iterations and log prob
```

## Primerjava

\input{figures/comparison_table}

Ugotovili smo, da vsi pregledani projekti podpirajo skrite markovske modele z diskretnim oddajanje vrednosti. Z izjemo projektov `UMDHMM` in ‘Lawrence’ enako velja tudi za zvezno oddajanje vrednosti. Vsi projekti imajo tudi podporo za mnogotera opazovana zaporedja, čeprav v času pregleda različica knjižnjice `hmmlearn` še ni bila pripravljena za uporabo. Projekta `mhsmm` in `GHMM` ponujata tudi grafični prikaz markovskih modelov. Slednji dodatno ponuja tudi grafičnim vmesnik za gradnjo in urejanje modelov.

Projekta `hmmlearn` in `HMM` sta izvedena izključno v programskem jeziku Python, projekt `GHMM` pa ponuja programsko ovojnico za integracijo z jedrom, izvedenim v programskem jeziku C. Priljubljenost jezika Python na tem področju gre najverjetneje pripisati splošni priljubljenosti v znanstvenih in akademskih okoljih ter razširjenosti in zrelosti knjižnjic za numerično in znanstveno računanje NumPy in SciPy~\cite{Walt2011}.

Z izjemo `UMDHMM` so vsi ostali projekti izvedeni kot knjižnjice (angl. *library*), ki jih lahko kličemo iz lastne programske kode (v tistih primerih, kjer licence to dovoljujejo). Čeprav se nekateri projekti ne opredeljujejo kot knjžnjice ampak kot ogrodja (angl. *framework*) ali sklopi programske opreme (angl. *package*) to na naše preverjanje ni imelo bistvenega vpliva. Poleg zmožnosti uporabe v lastni programski kodi smo si ogledali tudi odprtost za razširitve. V tem pogledu sta najbolj odprti knjižnjici `HMM` in `hmmlearn`, ki eksplicitno podpirata možnost 
implementacije verjetnostnih modelov po meri. Delno razširljivost nudi tudi projekt `mhsmm`, ki omogoča razširitve z porazdelitvami verjetnosti oddajanja po meri.

Na področju dokumentacije je najbolj informativen projekt `hmmlearn`. Po tem izgledu smo skušali temeljito dokumentirati tako izvorno kodo kot tudi primere uporabe projekta `Lawrence`. Pri nekaterih projektih smo pomanjkanje dokumentacije lahko nadoknadili s primeri uporabe in deloma tudi z branjem izvorne kode. Kljub temu bi bili bolje dokumentirani projekti veliko lažji za uporabo in privlačnejši za širšo množico uporabnikov~\cite{Sonnenburg2007}.

edini tezaven projekt je HMM ker nima licence. Ostali imajo vsi odprtokodne licence, ki dovoljuje uporabo vsaj v odprtokodnih okoljih. Najbol permisiven je hmmlearn z BSD licenco, ki predpisuje zelo malo omejitev in dovoljuje vključitev tudi v zaprtokodne in profitne projekte. Po tem izgledu smo tudi projektu `Lawrence` odprli pod podobno licenco (MIT) \cite{Stewart2006}.

\wip{hmmlearn najnovejsi in najobetavnejsi}

## Ostali projekti

Omenili bomo še nekaj projektov, ki niso bili ustrezni za primerjavo, vendar za njih menimo, da so na tem prodročju dovolj pomembni in so zato vredni omembe.

Zasledili smo nekaj raziskav, ki modeliranje skritih markovskih modelov opravljajo na platfori Matlab/Octave, vendar izvorne kode pri večini ni bilo na voljo~\cite{Yun2013}. Izjema sta bila projekta iHMM~\cite{Gael2008} in H2M~\cite{Cappe2001}, ki sta omenjena v citiranih znanstvenih člankih. Slednji se med drugim uporablja na področjih razpoznavanja govora~\cite{Ramesh1992} in na področju zaznavanja in klasifikacije zvokov (razločevanje med razbitjem stekla, človeškimi vzkliki, streli orožja, eksplozijami, zapiranjem vrat…) \cite{Dufaux2000}. Oba projekta sta se izkazala za neprimerna za našo problemsko domeno, ki zahteva skrite markovske modele z diskretno emisijo, projekta pa podirata samo zvezne~\cite{Cappe2001}.

Poleg projekta `mhsmm` (glej poglavje \ref{ch:compare:mhsmm}) je za programsko okolje R na voljo še projekta `HMM` (\url{https://cran.r-project.org/web/packages/HMM}) in `hsmm` (\url{https://cran.r-project.org/web/packages/hsmm}), ki se od `mhsmm` razlikujeta v dveh ključnih vidikih~\cite{OConnell2011}. Prvi je ta, da `hsmm` ne podpira uporabniških razširitev za implementacijo novih porazdelitev emisij. Drugi vidik, ki je za našo problemsko domeno pomembnejši, pa je pomanjkanje zmožnosti za obdelavo mnogoterih opazovanih zaporedij, kar projekt naredi neprimeren za uporabo pri generaciji besedil.

## Kako smo izbirali

Zbiranje potencialnih projektov smo začeli z iskanjem na spletnem portalu za kolaborativni razvoj projektov GitHub\footnote{\url{https://github.com}}. Zaradi pudarka na orodjih za sodelovanje pri razvoju programske opreme je GitHub postal zelo priljubljen pri razvijalcih odprte kode~\cite{McDonald2013}. Ta priljubljenost je pospešila in vzpodbudila sodelovanje na odprtokodnih projektih~\cite{Thung2013}, zato smo se odločili, da iskanje takih projektov, ki bi bili aktivno vzdrževani in imeli za sabo tudi skupine aktivnih uporabnikov začnemo ravno na tem portalu. Skupaj z zmogljivim iskalnikom nam GitHub omogoča pregled nad velikim številom potencialno uporabnih projektov. Dodatno smo si lahko pomagali z indikatorji popularnosti in povezanosti projektov, s katerimi bomo lahko ocenili, če je projekt vzdrževan in ali ima aktivne uporabnike. Takšni indikatorji nam dajo večjo možnost, da bomo našli projekt, ki bo deloval na sodobni strojni in programski opremi~\cite{Dabbish2012}. Našli smo tudi projekte, ki ne domujejo na portalu GitHub, ampak imajo tam urejeno zrcalno shrambo. Iskanje nam je vrnilo preko 700 projektov.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/github_search.png}
\end{center}
\caption{Posnetek zaslona prikazuje iskalni vmesnik portala GitHub. Indikatorji aktivnosti, kot so število ljudi, ki je projekt označilo kot zanimiv in še pomembneje število ljudi, ki je nameravalo k nekemu projektu prispevati svoje delo, so nam pomagali izbrati perspektivnejše projekte.}
\label{diag:compare:ghsearch}
\end{figure}

Poleg portala GitHub smo iskanje opravili še na nekaj drugih mestih. Za delno uspešno se je izkazalo iskanje projektov preko znanstvenih člankov, ki smo jih iskali na portalih Google Scholar (\url{scholar.google.com}), CiteSeerX (\url{citeseerx.ist.psu.edu}), arXiv (\url{arxiv.org}), Microsoft Academic Search (\url{academic.research.microsoft.com/}), …

Da bi naredili pregled projektov praktično izvedljiv v časovnem okviru, določenem za diplomsko nalogo, smo morali množico najdenih projektov razredčiti na hevrističen način, brez da bi vsak projekt posebej pregledali. Iz rezultatov iskanja smo najprej izločili tiste projekte, za katere je bilo po opisu razvidno, da se ne ukvarjajo s temo skirtih markovskih modelov. Za tem smo izločili še zapuščene in nedokočane projekte. Srečali smo se z velikim številom aktivnih in dodelanih projektov, ustvarjenih za neko določeno aplikacijo skritih markovskih modelov, npr. sekvenciranje DNK, napovedovanje gibanj na delniškem trgu, klasifikacijo besedil, kompresijo podatkov \dots, vendar so za naš problem preveč speifični. Kot smo omenili na začetku poglavja smo projekte, ki delujejo izključno za zvezne emisije smo izločili, saj za naš namen niso primerni. Prav tako smo izločili projekte brez podpore za mnogotera opazovana zaporedja. Ostale projekte smo si ogledali podrobneje ter preverili, ali imajo dokumentacijo in pod kakšno licenco so izdani.

Pomanjkanje dokumentacije se je izkazalo za največjo težavo pri iskanju primernega orodja. Dejavniki kot so veliko število parametrov in relacije med njimi vplivajo na to, da je obliko vhodnih podatkov brez dokumentacije zelo težko določiti. Pri nekaterih projektih smo si lahko pomagali s t.i. `README` datotekami, pri drugih pa z primeri uporabe, ki so jih avtorji priročno vključili poleg izvorne kode. Projekte, za katere iz teh treh virov nismo uspeli ugotoviti pravilnega načina uporabe smo izločili. Kot je ugotovil 	Sonnenburg~\cite{Sonnenburg2007}, bi bilo področje programske opreme za strojno učenje veliko bogatejše, če bi projekti poleg izvorne kode priložili krajši članek z opisom uporabe.

Želeli smo izpostaviti predvsem projekte, ki bi bili uporabni za namen generiranja besedil, hkrati pa bi uporabni za čimširšo množico. To poleg že omenjene dokumentacije vključuje tudi licenco, ki dovoljuje uporabo projekta čimširši ciljni publiki — to pomeni posameznikom in vsem ostalim uporabnikom odprte kode, ki želijo projekt uporabiti v lastne, neprofitne namene, kot tudi razvijalcem v industriji, ki bi želeli projekte uporabiti v profitne namene. V literaturi najdemo navedbe, da se projekti za strojno učenje, ki so izdani pod permisivnimi licencami, bolje razvijejo~\cite{Sonnenburg2007} ter da nerestriktivne licence na odprtokodnih orodjih na lažje privabijo potencialne uporabnike~\cite{Stewart2006}.


* * *

kaj bi lahko se primerjali:
- primerjaj performance
- gui
- dump/load
- scaling
- delovanje na veliki mnozici, kako dolge sekvence sprejme
- mogoce prilepi kaj kode pri vsakemu (del api-ja, funkcije, al pa  opis po modulih kaj omogoca kateri)
- kateri vmesniki omogocajo da das kar simbole, kateri zahtevajo da zakodiras v indekse
- prednosti/slabosti

mogoce kaka shema kje ce je smiselno, recimo struktura objektov/classov/klici funkcij itd - ali pa pipeline kako potekajo podatki

mogoce se potozi glede dependencijev pri ostalih, glede nato, da bomo guyz/hmm zaradi tega pohvalili

nekaj bo moglo bit dejanske primerjave. zacni z: “primerjali bomo naslednje stvari: …, … “ in nastej stvari ki smo opisali v posameznem poglavju: dokumentacija, enostavnost uporabe, (kar v tabeli spodaj) - potem z besedami opisi kaj kdo ma in kdo nima.

# Pregled področja

V tem poglavju bomo opravili pregled obstoječih orodij za generiranje skritih markovskih modelov. Najprej bomo opisali, kakšne vrste funkcionalosti pričakujemo od orodja, da bi ga uporabili v problemski domeni generiranja besedil. Nato bomo opisali najobetavnejše projekte, pregledali vrste funkcionalnosti, ki jih ponujajo, in za vaskega posebej navedli njegovo ustreznost za uporabo v naši problemski domeni. Nadaljevali bomo s primerjavo projektov, v katero smo vključili tudi lastno implementacijo, opisano v \ref{ch:impl}. poglavju. Rezultate bomo prikazali v primerjalni tabeli.  Na kratko bomo opisali in navedli še nekaj drugih obetavnih projetkov, ki ne ustrezajo vsem kriterijem in jih zato tudi nismo podrobneje pregledali. Za konec bomo opisali, kje in kako smo projekte iskali in kako smo seznam najdenih projektov razredčili. Utemeljili bomo, zakaj menimo, da so projekti, ki smo jih izbrali, najbolj ustrezni.

Naša problemska domena je učenje skritih markovskih modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki je dovolj dolga, da predstavlja dobro reprezentacijo pogostosti pojavljanja izrazov oz.\ besednih zvez in hkrati vsebuje tudi dovoljšen besedni zaklad. Odločili smo se, da bomo kot učne množice za ta orodja uporabili krajše knjige ali zbirke krajših vrst besedil (esejev, poezije \dots). Posamezna učna množica bo tako obsegala od 10.000 do 50.000 besed. Če predpostavimo, da bo vsaka beseda predstavljala en simbol oz. en člen opazovanega zaporedja\footnote{Namesto besede bi lahko izbrali tudi skupino črk (n-gram) ali posamezno črko; dilemo bomo podrobneje opisali v poglavju \wip{referenca na poglavje}}, potem bi opazovano zaporedje iz take učne množice predstavljalo 10.000 do 50.000 simbolov. Takšna dolžina zaporedja predstavlja težavo za markovske modele, saj začnejo pri izračunu t.i. *forward* in *backward* spremenljivk (glej poglavje \ref{ch:hmm:fb}) verjetnosti opazovanih simbolov strmo padati, kar privede do napake podkoračitve (glej poglavje \ref{ch:model:underflow}) \cite{Rabiner1989}. Tej težavi se izognemo tako, da besedilo razdelimo na več delov (npr. povedi) in vsakega od teh delov obravnavamo kot krajše opazovano zaporedje, neodvisno od ostalih (podrobnosti v poglavju \ref{ch:model:multiobs}). Zato bomo pri pregledu projektov, ki bi bili primerni za našo domeno, poudarek dali na tiste, ki lahko na vhodu zajemajo mnogotera opazovana zaporedja.

Markovske modele ločimo glede na vrsto vrednosti, ki jih opazujejo oz. oddajajo. Diskretne modeli so tisti, ki oddajajo iz diskretne zaloge vrednosti, zvezni pa tisti, ki oddajajo iz zvezne zaloge vrednosti. Za našo problemsko domeno želimo, da model oddaja diskretne vrednosti, ki jim pravimo tudi simboli. V našem diplomskem delu se bomo zato osredotočili izključno na projekte, ki modelirajo diskretne modele.

Izbrane projekte smo podrobno preučili, da bi ugotovili, če ustrezajo zgoraj navedenim kriterijem, torej da modelirajo diskretne markovske modele in da imajo podporo za mnogotera opazovana zaporedja. Poleg tega smo raziskali, za kakšen namen so bili razviti, kakšne funkcionalnosti ponujajo in kako dostopni so za uporabo. Pregledali smo tudi dokumentacijo, ki je na voljo, in licenco, pod katero so projekti izdani.

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

Projekt GHMM je prosto dostopna knjižnica za jezik C, ki vsebuje izvedbo učinkovitih podatkovnih struktur in algoritmov za osnovne ali razširjene skrite markovske modele z diskretnim in zveznim oddajanjem. Projekt vključuje tudi programsko ovojnico za programski jezik Python, ki ponuja prijaznejši vmesnik in nekaj dodatnih funkcionalnosti. V projektu najdemo še grafični urejevalnik modelov, imenovan HMMEd~\cite{sf/ghmm}.

Knjižnica se uporablja za širok spekter raziskovalnih, akademskih in industrijskih projektov. Področja uporabe vključujejo finančno matematiko (analiza likvidnosti), fiziologijo (analiza EEG podatkov), računsko lingvistiko in astronomijo (klasifikacija zvezd). V literaturi~\cite{Schliep2004} lahko zasledimo, da je projekt GHMM znatno pripomogel pri načenjanju nekaterih novih raziskovalnih vprašanj.

Glede na razširjenost uporabe smo pričakovali, da bo dokumentacija za uporabo orodja GHMM obširnejša. Tudi na spletni strani projekta je navedeno, da ima orodje veliko težavo s pomanjkanjem dokumentacije. Potencialne uporabnike namesto tega napotuje k branju Rabinerjevega članka A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition~\cite{Rabiner1989}, ki je sicer odličen vir za razumevanje skritih markovskih modelov, vendar ne nudi pomoči pri uporabi knjižnice.

S pomočjo komentarjev v programski kodi projekta smo, kljub pomanjkanju dokumentacije, uspeli vzpostaviti enostaven model, nismo pa uspeli pridobiti natančnejšega nadzora nad postopkom učenja, da bi se izognili situacijam, ko postopek maksimizacije ostane v lokalnem maksimumu. Orodje sicer podpira tehnike, kot je npr. vrivanje šuma\angl[noise injection], vendar samo za zvezno, ne pa tudi za diskretno oddajanje, ki ga potrebujemo v našem primeru.

Projekt je izdan pod deloma restriktivno licenco LGPL~\cite{Comino2007}, kar bi lahko predstavljalo težavo pri vključevanju v industrijska okolja, predvsem v primerih, ko je za uporabo potrebna sprememba izvorne kode~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_ghmm.png}
\end{center}
\caption{Posnetek zaslona pomanjkljive dokumentacije projekta GHMM.}
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

Projekt HMM je ogrodje za delo z skritimi markovskimi modeli, zgrajeno na osnovi sklopa programske opreme NumPy\footnote{NumPy je okrajšava za Numerical Python. Ta sklop programske opreme je namenjen znanstvenim izračunom v programskem okolju Python in služi kot temelj številnim znanstveim knjižnicam~\cite{Walt2011}.}. Implementacija algoritmov, tako kot pri mnogih drugih projektih, temelji na Rabinerjevem članku A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition~\cite{Rabiner1989}. Projekt vključuje tako diskretne kot zvezne modele. Ena izmed prednosti ogrodja, ki ni bila prisotna pri vseh projektih, je eksplicitna podpora za razširitve, ki uporabnikom omogoča, da napišejo svoje vrste verjetnostnih modelov. Razširitev je omogočena z uporabo dedovanja, podrobnosti pa so opisane v izvorni kodi projekta v datoteki `GMHMM.py`. Poleg celotnih, po meri izvedenih, verjetnostnih modelov, se lahko odločimo tudi za delno prilagoditev s prepisom funkcij, ki opazovanim simbolom nelinearno določajo težo (teža je privzeto enaka za vsak opazovan simbol).

Ogrodje HMM je odvisno izključno od omenjenega programskega paketa NumPy. Iz tega razloga se je ogrodje izkazalo enostavnejše za namestitev od večine ostalih projektov. 

Zaradi popolnega pomanjkanja dokumentacije smo za zgled uporabe morali pobrskati po izvorni kodi. Izkazalo se je, da ima projekt v datoteki `HMM/hmm/examples/tests.py` nekaj dovolj nazornih primerov uporabe. Tudi programski vmesnik je dovolj intuitiven, da smo lahko vspostavili učenje skritih markovskih modelov na podlagi besedila. Izvedli smo tudi simulacijo modela. Izvorna koda je dovolj jasno napisana in smiselno organizirana, da smo lahko potrebne podrobnosti implementacije poiskali sami.
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

Poglavitna ovira pri morebitni uporabi ogrodja HMM je pomanjkanje odprtokodne licence. Programske opreme, ki licence ne vključuje, ne moremo uporabljati, spreminjati ali deliti, če to ni eksplicitno navedeno s strani avtorjev~\cite{web/nolicense}. Menimo tudi, da bi ustrezna, permisivna odprtokodna licenca k projektu privabila več razvijalcev in tako pripomogla k njegovi višji kakovosti in širši uporabnosti~\cite{Stewart2006}.

## Projekt hmmlearn

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{http://hmmlearn.readthedocs.io} & BSD  & Python \\\midrule
\end{tabular}
\end{center}

Hmmlearn je skupina algoritmov za nenadzorovano\angl[unsupervised] učenje skritih markovskih modelov. Orodje je napisano v programskem jeziku Python, programski vmesnik pa je oblikovan po  vzoru scikit-learn\footnote{Scikit-learn je modul za programski jezik Python, ki vključuje široko paleto sodobnih algoritmov za nadzorovano in nenadzorovano strojno učenje pri srednje velikih problemih. Modul se osredotoča na enostavnost uporabe, zmogljivost, dokumentacijo in razumljiv programski vmesnik~\cite{Pedregosa2011}.} modula. Združljvost njunih programskih vmesnikov skupaj in dejstvo, da je scikit-learn zelo razširnjen projetk, pomeni, da lahko hmmlearn postane zelo zanimiv za široko skupino uporabnikov. Podobno kot `HMM` tudi `hmmlearn` uporabnikom, preko mehanizma dedovanja, nudi podporo za implementacijo verjetnostnih modelov po meri. Podrobnosti so opisane v dokumentaciji projekta.

Ob času pregleda je bila na voljo prva javna različica projekta 0.1.1, ki je bila izdana februarja 2015. Prihajajoča\footnote{Različica 0.2.0 je izšla marca 2016.} različica 0.2.0 prinaša veliko novosti, med drugim tudi sposobnost za učenje na mnogoterih opazovanih zaporedjih. Funkcionalnost je bila sicer že na voljo v t.i. razvojni različici, vendar smo tukaj naleteli na odstopanja med novimi razvojnimi vmesniki in dokumentacijo, ki je bila tarkat na voljo samo za prejšnjo različico. To je razlog, da s to knjižnico učenja modelov na mnogoterih zaporedjih v praksi nismo uspeli izvesti.

Kljub temu da je hmmlearn še v zgodnji razvojni fazi, si od tega projekta, zaradi enostavnih programskih vmesnikov, scikit-learn kompatibilnosti in že sedaj obsežne dokumentacije,  v prihodnosti veliko obetamo. Upamo, da ga bomo lahko v prihodnosti še preizkusili.

Projekt je izdan pod zelo permisivno odprtokodno licenco BSD, kar naredi projekt primeren za rabo v vseh okoljih, vključno z uporabo v komercialne namene~\cite{Determann2006}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/compare_hmmlearn.png}
\end{center}
\caption{Posnetek zaslona zgledno urejene dokumentacije projekta hmmlearn.}
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

Mhsmm je sklop programske opreme, zgrajen za sistem za statistično računanje R. Motivacija za nastanek projekta so bile raziskave povezanosti med uspešnostjo razmnoževanja živine in različnih indikatorjev pristonosti škodljivcev. Skriti markovski modeli so bili uporabljeni za dopolnjevanje pomanjkljivih podatkov in združevanje ločenih opazovanih zaporedij, ki so bila vzorčena z različnimi frekvencami. Poglavitne funkcije programskega sklopa so hkratno opazovanje različnih statističnih spremenljivk in podpora za zaporedja z manjkajočimi vrednostmi. Ključni deli programa so napisani v programskem jeziku C, kar zagotavlja njegovo hitrejše izvajanje~\cite{OConnell2011}.

Orodje mhsmm je sposobno modelirati tudi t.i. skrite pol-markovske modele. Pri klasičnih skritih markovskih modelih je čas postanka v posameznem stanju geometrično porazdeljen (enakomerni intervali $t, t+1, \dots$; glej poglavje \ref{ch:vir}). Pri modeliranju marsikaterih realnih problemov je ta porazdelitev nepraktična~\cite{OConnell2011}. Za našo problemsko domeno abstrakcija pol-markovskih modelov ni potrebna. Naša problemska domena zahteva, da model oddaja diskretne vrednosti in je sposoben opazovanja mnogoterih zaporedij.

Orodje uporabnikom omogoča, da poleg vrste vključenih porazdelitev implementirajo tudi porazdelitve po meri. Dodatne porazdelitve se implementirajo s pomočjo uporabniških razširitev. Zaradi neizkušenosti v programskem okolju R te funkcionalnosti nismo preizkusili.

Sposobnost, ki je pri preostalih projektih nismo zasledili, je prikaz emisij modela na zalo nazoren, grafičen način. Primer izpisa je prikazan na sliki~\ref{diag:compare:r_mhsmm}.

\begin{figure}[b]
\begin{center}
\includegraphics[width=\textwidth]{images/compare_r_mhsmm.pdf}
\end{center}
\caption{Izpis orodja 	\texttt{mhsmm} zelo nazorno prikaže delovanje (zveznega) skritega markovskega modela. Horizontalna črta s pomočjo barv prikazuje prehajanje med stanji, krivulja pa prikazuje vrednosti, ki jih je model oddajal.}
\label{diag:compare:r_mhsmm}
\end{figure}

Dokumentacijo projekta najdemo v obliki datoteke PDF~\cite{OConnell2011}, ki sicer zelo razumno prikaže nekaj primerov uporabe programskega sklopa. Pri preizkušanju le-tega smo pričakovali podrobnejšo in celovitejšo dokumentacijo programskega vmesnika. kot jo pričakujemo od programske opreme, ki je namenjena širši množici uporabnikov.\wip{Popravi obliko povedi}.

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

*UMDHMM Hidden Markov Model Toolkit* \cite{Kanungo1999} je projekt Marylandske univerze, ki implementira algoritme za delo s skritimi markovskimi modeli Forward-Backward, Viterbi in Baum-Welch.

Za razliko od ostalih projektov, ki smo jih pregledali, UMDHMM ne ponuja funkcij v obliki knjižnice, ki bi jih lahko uporabniki klicali iz lastne programske kode. Glavni vmesnik za uporabo omenjenih algoritmov so programi, namenjeni uporabi preko ukazne vrstice. Projekt obsega programe `genseq`, `testvit`, `esthmm` in `testfor`.

\begin{description}
\item[Program \tt{esthmm}] je jedro projekta, ki na podlagi podanega zaporedja simbolov z uporabo algoritma Baum-Welch (glej poglavje \ref{ch:hmm:bw}), naredi oceno parametrov za skriti markovski model.
\item[Program \tt{genseq}] uprabi parametre modela, ki jih je generiral program \texttt{esthmm}, in na njihovi podlagi generira naključno zaporedje simbolov.
\item[Program \tt{testvit}] z uporabo algoritma Viterbi oceni, katero zaporedje stanj je najbolj verjetno za neko dano zaporedje simbolov.
\item[Program \tt{testfor}] z uporabo algoritma Forward (glej poglavje \ref{ch:hmm:fb}) izračuna $P(O \given \lambda)$ — verjetnost opazovanega zaporedja glede na model.
\end{description}

Za primer (prikazan na sliki \ref{fig:compare:umdhmm}) vzemimo uporabo programa za ocenjevanje parametrov modela. Podati je potrebno parametra $N$ in $M$, ki določata število stanj modela  in število simbolov, ki jih model oddaja. Zaporedje, ki predstavlja učno množico za model, je zapisano v datoteki \texttt{input.seq} v obliki zaporedja številk stanj. Rezultat bo izpisan na standardni izhod v obliki parametrov modela $\lambda = (A, B, \pi, N, M)$ \eqref{eq:theory:model}.

\input{figures/compare_umdhmm_example}

Preprostost vmesnika z ukazno vrstico nam je omogočila, da smo na podlagi vhodnega zaporedja na enostaven način zgradili model in pričeli z simulacijo. Slabost tega vmesnika je pomanjkanje podrobnega nadzora nad vnosom vhodnih podatkov, ki bi ga npr. omogočala knjižnica z zbirko funkcij. Program kot vhod sprejme eno zaporedje. Uporabnik nima nadzora nad tem, kako se le-ta pred učenjem modela razdeli. V projektu smo sicer našli navedbe, da program podpira učenje modela na podlagi mnogoterih opazovanih zaporedij, vendar  zaradi omenjenega pomanjkanja nadzora, nismo uspeli ugotoviti, po kakšnem principu se zaporedja obravnavajo.

V literaturi~\cite{Zhou2005} je navedeno, da se projekt uporablja za predikcijo nastajanja in analizo struktur beljakovinskih molekul. Strokovnjaki navajajo, da so program UMDHMM delno prilagodili. Kljub temu, da licenca GPL, pod katero je projekt izdan, to zahteva, spremenjena izvorna koda ni na voljo~\cite{Determann2006}.

Za branje dokumentacije nas projekt napoti na priloženo datoteko PDF, ki pa vsebuje samo splošne informacije o teoriji skritih markovskih modelov, ne poda pa navodil za uporabo priloženih programov. Vsakega izmed programov lahko v ukazni vrstici poženemo brez parametrov in tako dobimo kratek priročnik uporabe, npr:

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
V poglavju bomo primerjali projekte po sposobnostih oddajanja diskretnih in zveznih vrednosti, podpori za mnogotera opazovana zaporedja, razširljivosti programskih modulov, načinu uporabe projekta, kvaliteti dokumentacije, licenci, pod katero je izdana izvorna koda in jeziku, v katerem je projekt napisan (tabela \ref{tab:compare}).

Ugotovili smo, da vsi pregledani projekti podpirajo skrite markovske modele z oddajanjem diskretnih vrednosti. Enako velja tudi za zvezno oddajanje vrednosti, z izjemo projektov `UMDHMM` in `Lawrence`. Vsi projekti imajo tudi podporo za mnogotera opazovana zaporedja, čeprav v času pregleda, različica knjižnice `hmmlearn` še ni bila pripravljena za uporabo. Projekta `mhsmm` in `GHMM` ponujata tudi grafični prikaz markovskih modelov. Slednji dodatno ponuja grafični vmesnik za gradnjo in urejanje modelov.

Projekta `hmmlearn` in `HMM` sta izvedena izključno v programskem jeziku Python, projekt `GHMM` pa ponuja programsko ovojnico za integracijo z jedrom, izvedenim v programskem jeziku C. Priljubljenost jezika Python na področju skritih markovskih modelov gre najverjetneje pripisati splošni priljubljenosti v znanstvenih in akademskih okoljih ter razširjenosti in zrelosti knjižnic za numerično in znanstveno računanje NumPy in SciPy~\cite{Walt2011}.

Z izjemo `UMDHMM` so vsi ostali projekti izvedeni kot knjižnice (angl. *library*), ki jih lahko kličemo iz lastne programske kode (v primerih, ko licence to dovoljujejo). Čeprav se nekateri projekti ne opredeljujejo kot knjižnice, ampak kot ogrodja (angl. *framework*) oz. sklopi programske opreme (angl. *package*), to na naše preverjanje ni imelo bistvenega vpliva. Poleg zmožnosti uporabe v lastni programski kodi, smo si ogledali tudi odprtost za razširitve. V tem pogledu sta najbolj odprti knjižnici `HMM` in `hmmlearn`, ki eksplicitno podpirata možnost implementacije verjetnostnih modelov po meri. Delno razširljivost nudi tudi projekt `mhsmm`, ki omogoča razširitve s porazdelitvami verjetnosti oddajanja po meri.

Dokumentacija projekta `hmmlearn` je po naših ugotovitvah najbolj informativna. Po zgledu dotičnega projekta smo skušali temeljito dokumentirati tako izvorno kodo kot tudi primere uporabe projekta `Lawrence`. Pri nekaterih projektih smo sicer pomanjkanje dokumentacije lahko nadoknadili s primeri uporabe in deloma tudi z branjem izvorne kode, vendar pa bi konkretnejša dokumentacija zagotovila večjo uporabnost projektov. S tem bi projekti postali privlačnejši tudi za širšo množico uporabnikov~\cite{Sonnenburg2007}.

`HMM` je edini izmed pregledanih projektov, ki nima licence. To pomeni, da ga brez avtorjevega dovoljenja ne smemo uporabljati, spreminjati ali deliti. Vsi ostali imajo odprtokodne licence, ki dovoljujejo uporabo projekta vsaj v odprtokodnih okoljih. Najbolj permisiven je `hmmlearn` z BSD licenco, ki predpisuje zelo malo omejitev in dovoljuje vključitev v zaprtokodne in profitne projekte. Po tem zgledu smo tudi projekt `Lawrence` odprli pod licenco MIT. \cite{Stewart2006}.

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
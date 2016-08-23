# Pregled področja {#ch:comp}

Ena večjih težav pri učenju predmeta digitalna forenzika je priprava nalog za študente. Naloge se študentom dodelijo v obliki zgodbe, ki opisuje kriminalno dejanje in slike diska, ki predstavlja evidenco primera. Težavo prepisovanja, ki se pojavi pri večjih skupinah, se lahko prepreči tako, da se vsakemu študentu dodeli individualizirana naloga. Da bi lahko dosegli avtomatizirano tvorjenje novih nalog bi potrebovali dovolj velik korpus, da bi na podlagi le-tega lahko izvedli učenje NLG sistema. Naborov podatkov takšne velikosti žal ni prosto na voljo. Motivacija naše diplomske naloge je tvorjenje variacij zgodb na podlagi omejenega števila vhodnih besedil. Kot dokaz koncepta smo za problemsko domeno vzeli tvorjenje kratkih povedi oz. stavkov.

V tem poglavju bomo opravili pregled obstoječih orodij za delo s skritimi markovskimi modeli. Najprej bomo opisali, kakšne vrste funkcionalosti pričakujemo od orodja, ki ga želimo uporabiti v problemski domeni tvorjenja stavkov. Nato bomo opisali kako smo izbrali nekaj najobetavnejših projektov, jih pregledali, primerjali vrste funkcionalnosti, ki jih le-ti ponujajo, in za vaskega posebej navedli njegovo ustreznost za uporabo v naši problemski domeni. Navedli bomo še nekaj drugih obetavnih projetkov, ki ne ustrezajo vsem kriterijem in jih zato tudi nismo podrobneje pregledali. 

## Kvalitativni kriteriji

Markovske modele ločimo glede na vrsto vrednosti, ki jih opazujejo oz. oddajajo. Diskretne modeli so tisti, ki oddajajo iz diskretne zaloge vrednosti, zvezni pa tisti, ki oddajajo iz zvezne zaloge vrednosti. Za našo problemsko domeno želimo, da model oddaja diskretne vrednosti, ki jim pravimo tudi simboli. V našem diplomskem delu se bomo zato osredotočili izključno na projekte, ki modelirajo diskretne modele.

V poglavju \ref{ch:model:multiobs} smo razložili potrebo po podpori za mnogotera opazovana zaporedja. Le-to bomo zahtevali tudi pri pregledovanju projektov.

Za vsak projekt smo pregledali tudi ustreznost dokumentacijo. Ker gre za knjižnjice in uporabniške umesnike z ukazno vrstico način uporabe ni očiten. Vmesniki za pravilno rabo zahtevajo določeno mero dokumentacije. Pri nekaterih projektih smo si lahko pomagali s t.i. `README` datotekami, pri drugih pa s primeri uporabe, ki so jih avtorji priročno vključili poleg izvorne kode. V določenih primerih nam je bila v pomoč tudi sama izvorna koda. Kriterij pri preverjanju projektov je bila naša uspešnost pri uporabi njihovi uporabi za namen učenja na podlagi korpusa in tvorjenja stavkov (gledali smo na zmožnost tvorjenja, ne na kvaliteto nastalih besedil). 	Sonnenburg~\cite{Sonnenburg2007} je ugotovil, da bi bilo področje programske opreme za strojno učenje bogatejše, če bi projekti poleg izvorne kode vsebovali tudi krajši članek z opisom uporabe.

Na zadnje smo pregledali tudi licenco, pod katero so projekti izdani. Za uspešno uporabo potrebujemo licenco, ki nam bo dovoljevala prosto uporabo.

Povzetek kvalitativnih kriterijev pri pregledu projektov:

* podpora za diskretne skrite markovske modele;
* podpora za mnogotera opazovana zaporedja;
* dokumentacija, ki nam omogoča praktično uporabo orodja;
* licenca, ki nam omogoča prosto uporabo orodja.

## Zbiranje projektov

Projekte smo iskali na spletnem portalu za kolaborativni razvoj programske opreme GitHub (\url{https://github.com}) in portalih za iskanje znanstvenih člankov Google Scholar (\url{scholar.google.com}), CiteSeerX (\url{citeseerx.ist.psu.edu}), arXiv (\url{arxiv.org}) ter Microsoft Academic Search (\url{academic.research.microsoft.com}).

V nadaljevanju bomo podrobneje opisali najdene projekte, ki so bili glede na naše kriterije najbolj ustrezni.

## Projekt hmmlearn {#ch:comp:hmmlearn}

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{http://hmmlearn.readthedocs.io} & BSD  & Python \\\midrule
\end{tabular}
\end{center}

Hmmlearn~\cite{hmmlearn/hmmlearn} je skupina algoritmov za nenadzorovano\angl[unsupervised] učenje skritih markovskih modelov. Orodje je napisano v programskem jeziku Python, programski vmesnik pa je oblikovan po  vzoru scikit-learn\footnote{Scikit-learn je modul za programski jezik Python, ki vključuje široko paleto sodobnih algoritmov za nadzorovano in nenadzorovano strojno učenje pri srednje velikih problemih. Modul se osredotoča na enostavnost uporabe, zmogljivost, dokumentacijo in razumljiv programski vmesnik~\cite{Pedregosa2011}.}~\cite{Scikitlearn2011} modula. Združljvost njunih programskih vmesnikov skupaj z dejstvom, da je scikit-learn zelo razširnjen projekt, pomeni, da lahko projekt hmmlearn postane zelo zanimiv za široko skupino uporabnikov. Projekt uporabnikom, preko mehanizma dedovanja, nudi podporo za implementacijo verjetnostnih modelov po meri. Podrobnosti so opisane v dokumentaciji projekta.

Ob času pregleda je bila na voljo prva javna različica projekta 0.1.1, ki je bila izdana februarja 2015. Prihajajoča\footnote{Različica 0.2.0 je izšla marca 2016.} različica 0.2.0 prinaša veliko novosti, med drugim tudi sposobnost za učenje na mnogoterih opazovanih zaporedjih. Funkcionalnost je bila sicer že na voljo v t.i. razvojni različici, vendar smo tukaj naleteli na odstopanja med novimi razvojnimi vmesniki in dokumentacijo, ki je bila tarkat na voljo samo za prejšnjo različico. To je razlog, da s to knjižnico učenja modelov na mnogoterih zaporedjih v praksi nismo uspeli izvesti.

Kljub temu da je hmmlearn še v zgodnji razvojni fazi, si od tega projekta, zaradi enostavnih programskih vmesnikov, scikit-learn kompatibilnosti in že sedaj obsežne dokumentacije,  v prihodnosti veliko obetamo. Upamo, da ga bomo lahko v prihodnosti še preizkusili.

Projekt je izdan pod neomejujočo odprtokodno licenco BSD, kar naredi projekt primeren za rabo v vseh okoljih, vključno z uporabo v komercialne namene~\cite{Determann2006}.

\begin{samepage}
\section{Projekt UMDHMM}\label{ch:comp:umdhmm}

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{http://www.kanungo.com/software/software.html} & GNU GPL  & C \\\midrule
\end{tabular}
\end{center}
\end{samepage}

*UMDHMM Hidden Markov Model Toolkit* \cite{Kanungo1999} je projekt Univerze v Marylandu, ki implementira algoritme za delo s skritimi markovskimi modeli Forward-Backward, Viterbi in Baum-Welch.

Za razliko od ostalih projektov, ki smo jih pregledali, UMDHMM ne ponuja funkcij v obliki knjižnice, ki bi jih lahko uporabniki klicali iz lastne programske kode. Glavni vmesnik za uporabo omenjenih algoritmov so programi, namenjeni uporabi preko ukazne vrstice. Projekt obsega programe `genseq`, `testvit`, `esthmm` in `testfor`.

\begin{description}
\item[Program \tt{esthmm}] je jedro projekta, ki na podlagi podanega zaporedja simbolov z uporabo algoritma Baum-Welch (glej poglavje \ref{ch:hmm:bw}), naredi oceno parametrov za skriti markovski model.
\item[Program \tt{genseq}] uprabi parametre modela, ki jih je določil program \texttt{esthmm}, in na njihovi podlagi tvori naključno zaporedje simbolov.
\item[Program \tt{testvit}] z uporabo algoritma Viterbi oceni, katero zaporedje stanj je najbolj verjetno za neko dano zaporedje simbolov.
\item[Program \tt{testfor}] z uporabo algoritma Forward (glej poglavje \ref{ch:hmm:fb}) izračuna $P(O \given \lambda)$ — verjetnost opazovanega zaporedja glede na model.
\end{description}

Za primer (prikazan na sliki \ref{fig:compare:umdhmm}) vzemimo uporabo programa za ocenjevanje parametrov modela. Podati je potrebno parametra $N$ in $M$, ki določata število stanj modela  in število simbolov, ki jih model oddaja. Zaporedje, ki predstavlja učno množico za model, je zapisano v datoteki \texttt{input.seq} v obliki zaporedja številk stanj. Rezultat bo izpisan na standardni izhod v obliki parametrov modela $\lambda = (A, B, \pi, N, M)$.

\input{figures/compare_umdhmm_example}

Preprostost vmesnika z ukazno vrstico nam je omogočila, da smo na podlagi vhodnega zaporedja na enostaven način zgradili model in pričeli z simulacijo. Slabost tega vmesnika je pomanjkanje podrobnega nadzora nad vnosom vhodnih podatkov, ki bi ga npr. omogočala knjižnica z zbirko funkcij. Program kot vhod sprejme eno zaporedje. Uporabnik nima nadzora nad tem, kako se le-ta pred učenjem modela razdeli. V projektu smo sicer našli navedbe, da program podpira učenje modela na podlagi mnogoterih opazovanih zaporedij, vendar  zaradi omenjenega pomanjkanja nadzora, nismo uspeli ugotoviti, po kakšnem principu se zaporedja obravnavajo.

V literaturi~\cite{Zhou2005} je navedeno, da se projekt uporablja za predikcijo nastajanja in analizo struktur beljakovinskih molekul. Strokovnjaki navajajo, da so program UMDHMM delno prilagodili. Kljub temu, da licenca GPL, pod katero je projekt izdan, to zahteva, spremenjena izvorna koda ni na voljo~\cite{Determann2006}.

Za branje dokumentacije nas projekt napoti na priloženo datoteko PDF, ki pa vsebuje samo splošne informacije o teoriji skritih markovskih modelov, ne poda pa navodil za uporabo priloženih programov. Vsakega izmed programov lahko v ukazni vrstici poženemo brez parametrov in tako dobimo kratek priročnik uporabe, npr:

```
$ esthmm
Usage1: esthmm [-v] -N <num_states> -M <num_symbols> <file.seq>
Usage2: esthmm [-v] -S <seed> -N <num_states> -M <num_symbols> 
<file.seq>
Usage3: esthmm [-v] -I <mod.hmm> <file.seq>
  N - number of states
  M - number of symbols
  S - seed for random number genrator
  I - mod.hmm is a file with the initial model parameters
  file.seq - file containing the obs. seqence
  v - prints out number of iterations and log prob
```

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

Projekt je izdan pod delno omejujočo licenco LGPL~\cite{Comino2007}, kar bi lahko predstavljalo težavo pri vključevanju v industrijska okolja, predvsem v primerih, ko je za uporabo potrebna sprememba izvorne kode~\cite{Determann2006}.

## Projekt HMM

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{https://github.com/guyz/HMM} & ni podana  & Python \\\midrule
\end{tabular}
\end{center}

Projekt HMM je ogrodje za delo z skritimi markovskimi modeli, zgrajeno na osnovi sklopa programske opreme NumPy\footnote{NumPy je okrajšava za Numerical Python. Ta sklop programske opreme je namenjen znanstvenim izračunom v programskem okolju Python in služi kot temelj številnim znanstveim knjižnicam~\cite{Walt2011}.}. Implementacija algoritmov, tako kot pri mnogih drugih projektih, temelji na Rabinerjevem članku \cite{Rabiner1989}. Projekt vključuje tako diskretne kot zvezne modele. Ena izmed prednosti ogrodja, ki ni bila prisotna pri vseh projektih, je eksplicitna podpora za razširitve, ki uporabnikom omogoča, da napišejo svoje vrste verjetnostnih modelov. Razširitev je omogočena z uporabo dedovanja, podrobnosti pa so opisane v izvorni kodi projekta v datoteki `GMHMM.py`. Poleg celotnih, po meri izvedenih, verjetnostnih modelov, se lahko odločimo tudi za delno prilagoditev s prepisom funkcij, ki opazovanim simbolom nelinearno določajo težo (teža je privzeto enaka za vsak opazovan simbol).

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
 
hmm.sample(20, 15) # Tvorjenje 20 zaporedij, od
                   # katerih ima vsako 15 simbolov.
\end{verbatim}
\caption{Primer uporabe ogrodja HMM za učenje na podlagi vhodnega besedila.}
\label{fig:compare:hmmuse}
\end{figure}

Slika \ref{fig:compare:hmmuse} prikazuje primer uporabe ogrodja  za učenje na podlagi vhodnega besedila (polje \texttt{words}) in začetnih parametrov modela (večrazsežnih NumPy polj \texttt{A} in \texttt{B} ter polja \texttt{pi}).

Poglavitna ovira pri morebitni uporabi ogrodja HMM je pomanjkanje odprtokodne licence. Programske opreme, ki licence ne vključuje, ne moremo uporabljati, spreminjati ali deliti, če to ni eksplicitno navedeno s strani avtorjev~\cite{web/nolicense}. Menimo tudi, da bi ustrezna, permisivna odprtokodna licenca k projektu privabila več razvijalcev in tako pripomogla k njegovi višji kakovosti in širši uporabnosti~\cite{Stewart2006}.

## Projekt mhsmm {#ch:compare:mhsmm}

\begin{center}
\begin{tabular}{ccc}
\footnotesize
\\\toprule
URL naslov & Licenca & Jezik \\
\url{https://cran.r-project.org/web/packages/mhsmm} & GNU GPL  & R \\\midrule
\end{tabular}
\end{center}

Mhsmm je sklop programske opreme, zgrajen za sistem za statistično računanje R. Motivacija za nastanek projekta so bile raziskave povezanosti med uspešnostjo razmnoževanja živine in različnih indikatorjev prisotnosti škodljivcev v kmetijstvu. Skriti markovski modeli so bili uporabljeni za dopolnjevanje pomanjkljivih podatkov in združevanje ločenih opazovanih zaporedij, ki so bila vzorčena z različnimi frekvencami. Poglavitne funkcije programskega sklopa so hkratno opazovanje različnih statističnih spremenljivk in podpora za zaporedja z manjkajočimi vrednostmi. Ključni deli programa so napisani v programskem jeziku C, kar zagotavlja njegovo hitrejše izvajanje~\cite{OConnell2011}.

Orodje mhsmm lahko modelira tudi t.i. skrite pol-markovske modele. Pri klasičnih skritih markovskih modelih je čas postanka v posameznem stanju geometrično porazdeljen (enakomerni intervali $t, t+1, \dots$; glej poglavje \ref{ch:theo:vir}). Pri modeliranju marsikaterih realnih problemov je ta porazdelitev nepraktična~\cite{OConnell2011}. Za našo problemsko domeno abstrakcija pol-markovskih modelov ni potrebna. Naša problemska domena zahteva, da model oddaja diskretne vrednosti in je sposoben opazovanja mnogoterih zaporedij.

Orodje uporabnikom omogoča, da poleg vrste vključenih porazdelitev implementirajo tudi porazdelitve po meri. Dodatne porazdelitve se implementirajo s pomočjo uporabniških razširitev. Zaradi neizkušenosti v programskem okolju R te funkcionalnosti nismo preizkusili.

Sposobnost, ki je pri preostalih projektih nismo zasledili, je prikaz tvorjenih vrednosti pri simulaciji modela na zelo nazoren, grafičen način. Primer izpisa je prikazan na sliki~\ref{diag:compare:r_mhsmm}. Horizontalna črta z barvami prikazuje prehajanje med stanji, krivulja pa tvorjene vrednosti.

\begin{figure}[b]
\begin{center}
\includegraphics[width=\textwidth]{images/compare_r_mhsmm.pdf}
\end{center}
\caption{Grafični prikaz simulacije skritega markovskega modela z orodjem \texttt{mhsmm}.}
\label{diag:compare:r_mhsmm}
\end{figure}

Dokumentacijo projekta najdemo v obliki datoteke PDF~\cite{OConnell2011}, ki nazorno prikaže nekaj primerov uporabe programskega sklopa. Pri preizkušanju le-tega smo ugotovili, da bi projekt potreboval celovetejšo dokumentacijo programskega vmesnika, ki bi razložila uporabo tudi za funkcije, ki v primerih uporabe niso omenjene.

Projekt je izdan pod restriktivno licenco GPL, ki lahko predstavlja oviro pri vključevanju projekta v industrijska okolja, predvsem v primerih uporabe, kjer bi bila potrebne sprememba izvorne kode~\cite{Determann2006}.

## Primerjava

\input{figures/comparison_table}

V nadaljevanju bomo opisane projekte primerjali na podlagi kriterijev, določenih v uvodu poglavja (tabela \ref{tab:compare}).

Ugotovili smo, da vsi pregledani projekti podpirajo skrite markovske modele z oddajanjem diskretnih vrednosti. Enako velja tudi za zvezno oddajanje vrednosti, z izjemo projekta `UMDHMM`. Vsi projekti imajo tudi podporo za mnogotera opazovana zaporedja, čeprav v času pregleda, različica knjižnice `hmmlearn` še ni bila pripravljena za uporabo. Projekta `mhsmm` in `GHMM` ponujata tudi grafični prikaz markovskih modelov. Slednji dodatno ponuja grafični vmesnik za gradnjo in urejanje modelov.

Projekta `hmmlearn` in `HMM` sta izvedena izključno v programskem jeziku Python, projekt `GHMM` pa ponuja programsko ovojnico za integracijo z jedrom, izvedenim v programskem jeziku C. Priljubljenost jezika Python na področju skritih markovskih modelov gre najverjetneje pripisati splošni priljubljenosti v znanstvenih in akademskih okoljih ter razširjenosti in zrelosti knjižnic za numerično in znanstveno računanje NumPy in SciPy~\cite{Walt2011}.

Z izjemo `UMDHMM` so vsi ostali projekti izvedeni kot knjižnice, ki jih lahko kličemo iz lastne programske kode (v primerih, ko licence to dovoljujejo). Čeprav se nekateri projekti ne opredeljujejo kot knjižnice, ampak kot ogrodja oz. sklopi programske opreme\angl[package], to na naše preverjanje ni imelo bistvenega vpliva. Poleg zmožnosti uporabe v lastni programski kodi, smo si ogledali tudi odprtost za razširitve. V tem pogledu sta najbolj odprti knjižnici `HMM` in `hmmlearn`, ki izrecno podpirata možnost implementacije verjetnostnih modelov po meri. Delno razširljivost nudi tudi projekt `mhsmm`, ki omogoča razširitve s porazdelitvami verjetnosti oddajanja po meri.

Dokumentacija projekta `hmmlearn` je po naših ugotovitvah najbolj informativna. Pri nekaterih projektih smo sicer pomanjkanje dokumentacije lahko nadoknadili s primeri uporabe in deloma tudi z branjem izvorne kode, vendar pa bi konkretnejša dokumentacija zagotovila večjo uporabnost projektov. S tem bi projekti postali privlačnejši tudi za širšo množico uporabnikov~\cite{Sonnenburg2007}.

`HMM` je edini izmed pregledanih projektov, ki nima licence. To pomeni, da ga brez avtorjevega dovoljenja ne smemo uporabljati, spreminjati ali deliti. Vsi ostali imajo odprtokodne licence, ki dovoljujejo uporabo projekta vsaj v odprtokodnih okoljih. Najbolj permisiven je `hmmlearn` z BSD licenco, ki predpisuje zelo malo omejitev in dovoljuje vključitev v zaprtokodne in profitne projekte \cite{Stewart2006}.

## Ostali projekti

Omenili bomo še nekaj projektov, ki niso bili ustrezni za primerjavo, vendar za njih menimo, da so vredni omembe.

Zasledili smo nekaj raziskav, ki modeliranje skritih markovskih modelov opravljajo na platformi Matlab/Octave, vendar izvorne kode pri večini ni bilo na voljo~\cite{Yun2013}. Izjema sta bila projekta iHMM in H2M, ki sta opisana v literaturi. \cite{Gael2008,Cappe2001} H2M se med drugim uporablja na področjih razpoznavanja govora~\cite{Ramesh1992} in na področju zaznavanja ter klasifikacije zvokov (razbitje stekla, človeški vzkliki, streli orožja, eksplozije, zapiranje vrat …) \cite{Dufaux2000}. Oba prjekta sta se za našo problemsko domeno izkazala kot neprimerna, saj podpirata samo zvezne markovske modele, naša domena pa zahteva uporabno diskretnih~\cite{Cappe2001}.

Poleg projekta `mhsmm` (glej poglavje \ref{ch:compare:mhsmm}) sta za programsko okolje R na voljo še projekta `HMM` (\url{https://cran.r-project.org/web/packages/HMM}) in `hsmm` (\url{https://cran.r-project.org/web/packages/hsmm}), ki se od `mhsmm` razlikujeta v dveh ključnih vidikih~\cite{OConnell2011}. Prvi je ta, da `hsmm` ne podpira uporabniških razširitev za implementacijo novih porazdelitev emisij. Drugi vidik, ki je za našo problemsko domeno pomembnejši, pa je pomanjkanje zmožnosti za obdelavo mnogoterih opazovanih zaporedij, zaradi česa je projekt neprimeren za uporabo pri tvorjenju besedil.

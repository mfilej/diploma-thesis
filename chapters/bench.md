# Ovrednotenje {#ch:bench}

Sistemi za tvorjenje naravnih besedil se običajno ocenjujejo kvantitativno, tj. z merjenjem vpliva besedila na opravljanje določenega opravila (št. potrebnih popravkov besedila; hitrost branja), z anketiranjem ljudi z lestvicami stališč likertovega tipa ali samodejnim izračunavanjem podobnosti tvorjenih besedil s korpusom. Prva dva načina lahko podata dobro oceno NLG sistema, vendar zahtevata veliko človeškega truda in časa. Samodejno izračunavanje lahko po drugi strani oceno ponudi hitro in učinkovito, vendar moramo biti pri tem pozorni, da pri tvorjenih besedilih ne iščemo popolnega skladanja s korpusom, saj to ni cilj NLG sistemov. Naravni jezik omogoča, da lahko v večini primerov posamezen pomen izrazimo na več različnih načinov~\cite{Sambaraju2011}.

Na področju strojnega prevajanja je bil razvit sistem BLEU (iz katerega izhajata tudi sistema NIST in ROGUE), ki tvorjeno besedilo oceni na podlagi števila vsebovanih n-gramov, ki se pojavijo tudi v enem izmed možnih prevodov. \cite{Papineni2002,Belz2006}

Ker se pri tvorjenju besedil s skritimi markovskimi modeli besede izbirajo izključno iz obstoječih besed v korpusu, bi takšen način ocenjevanja za tvorjeno besedilo vedno podal popolno oceno. Zato smo se, kot smo omenili v uvodu, odločili, da bomo za merilo primerjave tvorjenih besedil izbrali pogostost pojavljanja določenih besednih vrst. Izbrali smo glagole, ker pričakujemo, da konstantnost njihovega pojavljanja izmed vseh besednih vrst najbolje opisuje naravo jezika. V povprečju pričakujemo po en glavni glagol za vsak stavek.

Našo rešitev smo primerjali z dvema drugima rešitvama iz \ref{ch:comp}. poglavja. Izbrali smo hmmlearn \eqref{ch:comp:hmmlearn} in umdhmm \eqref{ch:comp:umdhmm}, ker se medsebojno razlikujeta po pristopu učenja modelov, zato smo pričakovali, da se bodo razlike med modeli pokazale ravno tukaj.

Da bi ugotovili morebiten vpliv spreminjanja parametrov skritih markovskih modelov na tvorjena modela, smo se odločili, da pri vseh treh rešitvah uporabimo modele z 1, 3, 5, 8 in 12 stanji. Na koncu smo izvedli še primerjavo tvorjenih besedil z izvornim korpusom. Skupno smo torej primerjali 16 besedil.

## Izbira korpusa

Učno množico smo izvlekli iz korpusa slovenskega pisnega jezika ccKRES~\cite{ccKres2013}, ki je označen v skladu s priporočili za zapis besedil TEI P5~\cite{Tei2008}. XML zapis vsebuje označbe za povedi, besede, ločila itn. Besede so dodatno označene z informacijami o besednih vrstah, številu, spolu … \cite{Erjavec2003}

Korpus vsebuje raznolike besedilne vrste. Da bi se izognili neobičajnim oblikam povedi, smo izločili TV sporede, kuharske recepte in športne rezultate … To smo storili tako, da smo izbrali izključno povedi, ki se začnejo z veliko začetnico in končajo s končnim ločilom (piko, klicajem ali vprašajem). Izločili smo tudi povedi, ki vsebujejo velike začetnice, ki niso na začetku povedi. Preostale povedi smo segmentirali na mestih, zaznamovanih z vejicami, in tako dobili segmente, ki približno ustrezajo stavkom (z izjemami, kot so vrinjeni stavki in podobno). Segmente smo nato prilagodili za učenje modelov, tako da smo velike črke pretvorili v male in izločili vsa ločila. Tako pridobljeno učno množico segmentov smo shranili v tekstovno datoteko s po enim segmentom na vrstico.

## Kvantitativna analiza

Zbiranje podatkov in primerjavo modelov smo avtomatizirali s programom\footnote{Izvorna koda programa je dostopna na naslovu \url{http://miha.filej.net/diploma-thesis/analysis}.}, ki izvede naslednje korake:

1. Iz učne množice besedil naključno izbere 5.000 vrstic.
2. Na izbranih vrsticah izmeri porazdelitev števila besed.
3. Na izbranih vrsticah izmeri pogostost pojavljanja glagolov (na podlagi označb v TEI dokumentih).
4. Izbrane vrstice uporabi za učenje modelov.
5. Vsak naučen model uporabi za tvorjenje 5.000 stavkov, katerih dolžine naključno izbere glede na podatke, pridobljene v 2. koraku.
6. Za tvorjena besedila izmeri pogostost pojavljanja glagolov (kot v 3. koraku). Meritve, katere bomo v nadaljevanju uporabili za analizo, zapiše v datoteko.

Pridobljene meritve so prikazane v tabeli \ref{tab:bench:measurements}.

\input{figures/bench_measurements}

\begin{hypothesis}% Hipoteza 1
Število skritih stanj modela ima statistično pomemben vpliv na pogostost pojavljanja glagolov v stavkih.
\label{h:bench:1}
\end{hypothesis}

Zanimalo nas je, ali ima število skritih stanj modela zaznaven vpliv na tvorjeno besedilo. Za vsako orodje smo opravili ločen $\chi^2$ preizkus. Uporabili smo podatke v tabeli \ref{tab:bench:measurements}. Rezultati preizkusa so prikazani v tabeli \ref{tab:bench:state_comparison}. Glede na visoke $p$ vrednosti hipoteze za nobeno od orodij ne moremo potrditi. Iz tega sledi, da število skritih stanj modela nima zaznavnega vpliva na tvorjeno besedilo.

\input{figures/bench_state_comparison}

\begin{hypothesis}% Hipoteza 2
Pogostost pojavljanja glagolov v stavkih pri tvorjenih besedilih je primerljiva s pogostostjo pojavljanja glagolov v korpusu.
\label{h:bench:2}
\end{hypothesis}

Zanimalo nas je, ali je kateri od modelov sposoben tvorjenja besedil, ki bi se po pogostosti pojavljanja glagolov prilegala korpusu. Za vsako tvorjeno besedilo smo opravili $\chi^2$ preizkus neodvisnosti od korpusa. Rezultati so prikazani v tabeli \ref{tab:bench:models_vs_corpus}. Glede na $p$ vrednosti ugotavljamo, da hipoteze za nobenega od modelov ne moremo potrditi. Iz tega sledi, da noben izmed modelov ni tvoril besedila, ki bi bilo po pogostosti pojavljanja glagolov v stavkih primerljivo s korpusom.

\input{figures/bench_models_vs_corpus}

\begin{hypothesis}% Hipoteza 3
Lastna implementacija tvori besedila, ki so po pogostosti pojavljanja glagolov v stavkih primerljiva ostalim orodjem.
\label{h:bench:3}
\end{hypothesis}

Zanimalo nas je, ali so besedila, tvorjena z lastno implementacijo, primerljiva z besedili, tvorjenimi z drugimi orodji. Ker smo pri \ref{h:bench:1}. hipotezi ugotovili, da število skritih stanj modela nima zaznavnega vpliva, smo v tem koraku vsak model predstavili s povprečnimi vrednostmi, pridobljenimi čez vsa števila skritih stanj. Podatki so prikazani v tabeli \ref{tab:bench:model_averages_comparison}.

Na podlagi rezultatov $\chi^2$ preizkusov neodvisnosti v tabeli \ref{tab:bench:nxn_comparison} lahko hipotezo potrdimo za našo implementacijo in orodje hmmlearn. Iz tega lahko sklepamo, da omenjeni rešitvi tvorita besedila s podobno pogostostjo pojavljanja glagolov v stavkih.

Rezultati za orodje UMDHMM kažejo veliko mero neodvisnosti od ostalih dveh orodij. Menimo, da je to posledica neskladanja v pogostosti pojavljanja stavkov brez glagolov (2. stolpec v tabeli \ref{tab:bench:model_averages_comparison}). Pri enem in več glagolov na stavek so si vsa orodja podobna, kar potrjujejo visoke $p$ vrednosti v tabeli \ref{tab:bench:state_comparison}.

\input{figures/bench_model_averages_comparison}
\input{figures/bench_nxn_comparison}

Podatke iz tabele \ref{tab:bench:model_averages_comparison} smo prikazali tudi na grafu na sliki \ref{graph:bench:models_graph}.

\begin{figure}
\begin{center}
\includegraphics[width=\textwidth]{images/bench_model_comparison.png}
\end{center}
\caption{Pogostost pojavljanja glagolov pri različnih modelih.}
\label{graph:bench:models_graph}
\end{figure}

## Kvalitativna analiza lastne implementacije

S kvantitativno analizo smo pokazali, da naša implementacija tvori besedila, ki so po pogostosti pojavljanja glagolov v povedih (v primerjavi s korpusom) vsaj tako dobra kot ostali dve orodji. Poleg tega menimo, da je naša knjižnica temeljito dokumentirana in da pri uporabi dovoljuje veliko mero prostosti in fleksibilnosti.

* URL naslov knjižnice: \url{http://miha.filej.net/diploma-thesis/lib}
* URL naslov dokumentacije: \url{http://miha.filej.net/diploma-thesis/doc}

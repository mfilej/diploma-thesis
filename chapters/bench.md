# Ovrednotenje {#ch:bench}

Sistemi za tvorjenje naravnih besedil se običajno ocenjujejo kvantitativno, t.j. z merjenjem vpliva besedila na opravljanje določenega opravila (št. potrebnih popravkov besedila; hitrost branja), z anketiranjem ljudi z lestvicami stališč likertovega tipa ali samodejnim izračunavanjem podobnosti tvorjenih besedil s korpusom. Prva dva načina lahko podata dobro oceno NLG sistema, vendar zahtevata veliko človeškega truda in časa. Samodejno izračunavanje lahko po drugi strani oceno ponudi hitro in učinkovito, vendar moramo biti pri tem pozorni, da pri tvorjenih besedilih ne iščemo popolnega skladanja s korpusom, saj to ni cilj NLG sistemov. Naravni jezik omogoča, da lahko v večini primerov posamezen pomen izrazimo na več različnih načinov~\cite{Sambaraju2011}.

Na področju strojnega prevajanja je bil razvit sistem BLEU (iz katerega izhajata tudi sistema NIST in ROGUE), ki tvorjeno besedilo oceni na podlagi števila vsebovanih n-gramov, ki se pojavijo tudi v enem izmed možnih prevodov. \cite{Papineni2002,Belz2006}

Ker se pri tvorjenju besedil s skritimi markovskimi modeli  besede izbirajo izključno iz obstoječih besed v korpusu, bi takšen način ocenjevanja za tvorjeno besedilo vedno podal idealno oceno. Zato smo se, kot smo omenili v uvodu, odločili, da bomo za merilo primerjave tvorjenih besedil izbrali pogostost pojavljanja določenih besednih vrst. Izbrali smo glagole, ker pričakujemo, da konstantnost njihovega pojavljanja izmed vseh besednih vrst najbolje opisuje naravo jezika. V povprečju pričakujemo po en glavni glagol za vsak stavek.

Našo rešitev smo primerjali z dvemi drugimi rešitvami iz \ref{ch:comp}. poglavja. Izbrali smo hmmlearn \eqref{ch:comp:hmmlearn} in umdhmm \eqref{ch:comp:umdhmm}, ker se medsebojno razlikujeta po pristopu učenja modelov, zato smo pričakovali, da se bodo razlike med modeli pokazale ravno tukaj.

Da bi ugotovili morebiten vpliv spreminjanja parametrov skritih markovskih modelov na tvorjena modela, smo se odločili, da pri vseh treh rešitvah uporabimo modele z 1, 3, 5, 8 in 12 stanji. Na koncu smo izvedli še primerjavo tvorjenih besedil z izvornim korpusom. Skupno smo torej primerjali 16 besedil.

## Izbira korpusa

Učno množico smo izvlekli iz korpusa slovenskega pisnega jezika ccKRES~\cite{ccKres2013}, ki je označen v skladu s priporočili za zapis besedil TEI P5~\cite{Tei2008}. XML zapis vsebuje označbe za povedi, besede, ločila, itn. Besede so dodatno označene z informacijami o besednih vrstah, številu, spolu … \cite{Erjavec2003}

Korpus vsebuje raznolike besedilne vrste. Da bi se izognili neobičajnim oblikam povedi, smo izločili TV sporede, kuharske recepte in športne rezultate … To smo storili tako, da smo izbrali izključno povedi, ki se začnejo z veliko začenico in končajo s končnim ločilom (piko, klicajem ali vprašajem). Izločili smo tudi povedi, ki vsebujejo velike začetnice, ki niso na začetku povedi. Preostale povedi smo segmentirali na mestih, zaznamovanih z vejicami, in tako dobili segmente, ki približno ustrezajo stavkom (z izjemami, kot so vrinjeni stavki in podobno). Segmente smo nato prilagodili za učenje modelov, tako da smo velike črke pretvorili v male in izločili vsa ločila. Tako pridobljeno učno množico segmentov smo shranili v tekstovno datoteko s po enim segmentom na vrstico.

## Kvantitativna analiza

Zbiranje podatkov in primerjavo modelov smo avtomatizirali s programom, ki izvede naslednje korake:

1. Iz učne množice besedil naključno izbere 5.000 vrstic.
2. Na izbranih vrsticah izmeri porazdelitev števila besed.
3. Na izbranih vrsticah izmeri pogostost pojavljanja glagolov (na podlagi označb v TEI dokumentih).
4. Izbrane vrstice uporabi za učenje modelov.
5. Vsak naučen model tvori 5.000 stavkov, katerih dolžine naključno izbere glede na podatke, pridobljene v 2. koraku.
6. Za tvorjena besedila izmeri pogostost pojavljanja glagolov (kot v 3. koraku). Meritve zapiše v datoteko, jih bomo v nadaljevanju uporabili za analizo.

Pridobljene meritve so prikazane v tabeli \ref{tab:bench_measurements}.

\input{figures/bench_measurements}

% Hipoteza 1 %

\begin{hypothesis}
Število skritih stanj modela ima statistično pomemben vpliv na pogostost pojavljanja glagolov v stavkih.
\end{hypothesis}

Zanimalo nas je, ali ima število skritih stanj modela zaznaven vpliv na tvorjeno besedilo. Za vsako orodje smo opravili ločen $\chi^2$ preizkus. Uporabili smo podatke v tabeli \ref{tab:bench:measurements}. Rezultati preizkusa so prikazani v   tabeli \ref{tab:bench:state_comparison}. Glede na pridobljene rezultate smo ugotovili, da hipoteze za nobeno od orodij ne moremo potrditi. Iz tega sledi, da število skritih stanj modela nima zaznavnega vpliva na tvorjeno besedilo.

\input{figures/bench_state_comparison}

% Hipoteza 2 %

\begin{hypothesis}
Pogostost pojavljanja glagolov v stavkih pri tvorjenih besedilih je primerljiva s pogostostjo pojavljanja glagolov v korpusu.
\end{hypothesis}

Zanimalo nas je, ali je keteri od modelov sposoben tvorjenja besedil, ki bi se po pogostosti pojavljanja glagolov prilegala korpusu. Za vsako tvorjeno besedilo smo opravili $\chi^2$ preizkus neodvisnosti proti korpusu. Rezultati so prikazani v tabeli \ref{tab:bench:models_vs_corpus}. Glede na visoke $p$ vrednosti ugotavljamo, da hipoteze za nobenega od modelov ne moramo potrditi. Iz tega sledi, da noben model ni tvoril besedila, ki bi bilo primerljivo po pogostosti pojavljanja glagolov v stavkih.

\input{figures/bench_models_vs_corpus}

% Hipoteza 3 %

\begin{hypothesis}
Lastna implementacija tvori besedila, ki so po pogostosti pojavljanja glagolov v stavkih primerljiva z ostalimi orodji.
\end{hypothesis}

Zanimalo nas je, ali so besedila, tvorjena z lastno implementacijo, primerljiva z besedili, tvorjenimi z drugimi orodji. Glede na p-vrednosti v tabeli \ref{tab:bench_state_comparison} sklepamo, da

Zaradi majhnega vpliva števila stanj modela na izid smo se odločili, da izide za posamezno orodje prikažemo na podlagi pričakovanih vrednosti. Podatki so skupaj z rezultati za korpus prikazani v tabeli \ref{tab:bench_model_table} in na sliki \ref{fig:bench_model_comparison}.

Opravili smo $\chi^2$ preizkus hipoteze neodvisnosti. Rezultati so hipotezo potrdili za vsa tvorjena besedila (tabela \ref{tab:bench_model_comparison}). Iz tega sledi, da so razlike v številu glagolov na stavek med tvorjenimi besedili in izvornim korpusom statistično pomembne. Na podlagi rezultatov lahko sklepamo, da porazdelitve glagolov v besedilih, tvorjenih s skritimi markovskimi modeli, niso podobne porazdelitvi glagolov v korpusu.

\input{figures/bench_models}
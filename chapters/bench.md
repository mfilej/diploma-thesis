# Ovrednotenje {#ch:bench}

V tem poglavju smo želeli priti do naslednjih ugotovitev: kako se tvorjena besedila primerjajo z naravnim jezikom; ali spreminjanje parametrov pri učenju markovskih modelov znatno vpliva na tvorjena besedila; in kako se besedila, tvorjena z različnimi markovskimi modeli primerjajo med seboj.

Sistemi za tvorjenje naravnih besedil se običajno ocenjujejo kvantitativno, t.j. z merjenjem vpliva besedila na opravljanje določenega opravila (št. potrebnih popravkov besedila; hitrost branja), z anketiranjem ljudi z lestvicami stališč likertovega tipa, ali samodejnim izračunavanjem podobnosti tvorjenih besedil s korpusom. Prva dva načina lahko podata dobro oceno NLG sistema, vendar zahtevata veliko človeškega truda in časa. Samodejno izračunavanje lahko po drugi strani oceno ponudi hitro in učinkovito, vendar moramo biti pri tem pozorni, da pri tvorjenih besedilih ne iščemo popolnega skladanja s korpusom, saj le-to ni cilj NLG sistemov (naravni jezik omogoča, da lahko v večini primerov nek pomen izrazimo na več različnih načinov).  \cite{Sambaraju2011} Na področju strojnega prevajanja je bil razvit sistem BLEU (iz katerega izhajata tudi sistema NIST in ROGUE), ki v tvorjeno besedilo oceni na podlagi števila vsebovanih n-gramov, ki se pojavijo tudi v enem izmed možnih prevodov. \cite{Papineni2002,Belz2006}

Ker se pri tvorjenju besedil s skritimi markovskimi modeli  besede izbirajo izključno iz obstoječih besed v korpusu, bi takšen način ocenjevanja za tvorjeno besedilo podal vedno idealno oceno. Zato smo se, kot smo omenili v uvodu, odločili, da bomo kot merilo za primerjavo tvorjenih besedil izbrali meritev pogostosti pojavljanja določenih besednih vrst. Med besednimi vrstami smo se odločili za glagole, ker pričakujemo, da konstantnost njihovega pojavljanja izmed vseh besednih vrst najbolje opisuje naravo jezika. V povprečju pričakujemo po en glavni glagol za vsak stavek.

Lastno rešitev smo hoteli primerjati z dvemi drugimi rešitvami iz \ref{ch:comp}. poglavja. Izbrali smo hmmlearn \eqref{ch:comp:hmmlearn} in umdhmm \eqref{ch:comp:umdhmm}, ker se medsebojno razlikujeta po pristopu učenja modelov in zato pričakujemo, da bi se morebitne razlike med modeli tukaj prikazale.

Da bi ugotovili morebiten vpliv spreminjanja parametrov skritih markovskih modelov na tvorjena modela, smo se odločili, da bomo poizkusili pri vseh treh rešitvah uporabiti modele z 1, 3, 5, 8 in 12 stanji.

Na koncu bomo izvedli primerjavo tvorjeih besedil z izvornim korpusom. Skupno bomo torej primerjali 16 beesdil.

Učno množico smo izvklekli iz korpusa slovenskega pisnega jezika ccKRES~\cite{ccKres2013}. Korpus je označen v skladu s priporočili za zapis besedil TEI P5~\cite{Tei2008}. XML zapis vsebuje označbe za povedi, besede, ločila, itn. Besede so dodatno označene z informacijami o besednih vrstah, številu, spolu, … \cite{Erjavec2003}

Korpus vsebuje raznolike vrste besedil. Hoteli smo se osredotočiti na povedi in izločiti oblike besedil, kot so TV sporedi, kuharski recepti, športni rezultati. Izbrali smo samo povedi, ki se začnejo z veliko začenico in končajo z ločilom (. ali ! ali ?). Iz teh povedi smo izločili tiste, ki vsebujejo velike začetnice (razen prve črke v povedi), da bi izločili lastna imena in kratice. Preostale povedi smo segmentirali na mestih, zaznamovanih z vejicami in tako dobili segmente, ki približno ustrezajo stavkom (z izjemami, kot so vrinjeni stavki in podobno). Segmente smo nato prilagodili za učenje modelov tako, da smo velike črke pretvorili v male in izločili preostala ločila. Tako pridobljeno učno množico segmentov smo shranili v tekstovno datoteko s po enim segmentom na vrstico.

Zbiranje podatkov za primerjavo modelov smo avtomatizirali s programom, ki izvede naslednje korake:

1. Iz učne množice besedil naključno izbere 5.000 vrstic.
2. Na izbranih vrsticah izmeri porazdelitev števila besed.
3. Na vrsticah prav tko izmeri porazdelitev števila glagolov (na podlagi označb v TEI dokumentih).
4. Izbrane vrstice uporabi za učenje modelov.
5. Vsak naučen model se uporabi za tvorjenje 5.000 stavkov z dolžinami, ki so naključno izbrane glede na podatke pridobljene v 2. koraku.
6. Za tvorjena besedila se izmeri število glagolov na stavek, kot v 3. koraku. Meritve se zapišejo v datoteko, ki bo kasneje uporabljena za analizo.

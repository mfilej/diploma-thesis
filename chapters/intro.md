# Uvod

V želji po večji produktivnosti, zmanjševanju obsega dela in višji kakovosti življenja avtomatizacija pronica v vsa področja človeškega življenja. Stroji prevzemajo nove odgovornosti v vseh panogah, med drugim tudi v jezikoslovju.

Obdelava naravnega jezika (NLP) je področje računalništva, jezikoslovja in umetne inteligence, ki se že desetletja ukvarja z reševanjem mnogih izzivov v povezavi z naravnim oz. človeškim jezikom, kot so na primer strojno prevajanje, prepoznavanje in tvorjenje govora, optično prepoznavanje znakov (OCR), preverjanje slovnične pravilnosti, analiza čustvenosti, zlogovanje besed ter tvorjenje besedil.

Tvorjenje naravnega jezika (NLG) je proces sestavljanja besedil, ki zvenijo naravno in bi za njih lahko sklepali, da jih je proizvedel človek~\cite{Kondadadi2013}.

Nastopa lahko v različnih obsegih. Ljudi lahko popolnoma nadomesti, kot na primer pri verbalizaciji vremenske napovedi, ki jo lahko stroji opravijo povsem samostojno. Poveča lahko človeško storilnost, recimo s pisanjem osnutkov dokumentov ali s strnjevanjem besedil v obnove. Ne nazadnje lahko pozitivno vpliva tudi na kakovost življenja (tvorjenje besedil, ki pomagajo lajšati anksioznost; verbalizacija grafov, tabel in drugih nebesednih oblik za slabovidne ljudi). Drugi primeri uporabe NLG sistemov vključujejo obnavljanje in strjevanje zdravniških, inženirskih, finančnih, športnih … podatkov; tvorjenje osnutkov dokumentov, kot so navodila za uporabo, pravni dokumenti, poslovna pisma …~\cite{Clark2013}

Na slovenskem spletu je bila med leti 2007 in 2015 na voljo Virtualna davčna asistentka VIDA. Ta pogovorni sistem je uporabnikom omogočal, da s pisnim postavljanjem vprašanj v naravnem jeziku dobijo odgovore na splošna in najpogostejša vprašanja iz področja dohodnine~\cite{Krek2009}.

Motivacija za tvorjenje naravnega jezika v okviru našega diplomskega dela je priprava besedil za predmet digitalna forenzika~\cite{FeleZorz}. Gre za zgodbe, ki opisujejo okoliščine namišljenega kaznivega dejanja. Za čim boljšo izkušnjo študentov pri reševanju nalog bi bilo popolno, da bi bila vsaka zgodba unikatna. Ker pa je pisanje zgodb dolgotrajen proces, bi sestavljanje takšnega števila besedil za profesorje in asistente predstavljalo preobsežno količino dela. Če bi imeli NLG sistem, ki bi bil zmožen tvorjenja unikatnih zgodb, bi lahko študentom omogočili bolj kakovostno izkušnjo, hkrati pa olajšali delo profesorjem in asistentom. Ker vzorca zgodb, na podlagi katerega bi izvedli učenje modelov, ni bilo na voljo, smo v diplomskem delu uporabili splošni korpus slovenskega pisnega jezika.

NLG sistemi se delijo na statistične sisteme in na sisteme, osnovane na znanju\angl[knowledge-based]. Slednji so za tvorjenje odvisni od znanja iz neke določene domene. Čeprav so taki sistemi sposobni proizvesti kakovostno besedilo, zahtevajo pri izgradnji veliko truda in sodelovanja s končnimi uporabniki sistema. Poleg tega lahko taki sistemi pokrivajo samo domeno, za katero so bili zgrajeni. Na drugi strani so statistični sistemi enostavnejši za izgradnjo in lažji za prilagoditev na druge domene. Slabost statističnih sistemov je njihova izpostavljenost napakam — zaradi manjšega števila omejitev v postopku tvorjenja lahko proizvedejo tudi besedila brez smisla~\cite{Kondadadi2013}.

Področje tvorjenja naravnega jezika je ena izmed zadnjih panog računalniškega jezikoslovja, ki so privzele statistične metode~\cite{Mairesse2010}.

V diplomskem delu bomo ugotavljali, ali so skriti markovski modeli lahko primerna statistična metoda za tvorjenje naravnega jezika.

## Struktura naloge

Najprej bomo opravili kratek pregled področij verjetnostne teorije in teorije informacije, ki omogočajo teoretično podlago za skrite markovske modele in predstavili, kako lahko s takimi modeli tvorimo zaporedja. Predstavili bomo vprašanja, ki se pojavijo pri uporabi skritih markovskih modelov v praksi in odgovorili na tista, ki so ključna za izvedbo naše naloge.

Enačbe, pridobljene iz odgovorov, bomo v \ref{ch:model}. poglavju preslikali v psevdokodo, ki nam bo omogočila delo s skritimi markovskimi modeli. Opisali bomo, s katerimi težavami smo se srečali pri preslikavi matematičnih enačb in kako smo jih rešili.

V \ref{ch:comp}. poglavju bomo opravili pregled področja obstoječih orodij za delo s skritimi markovskimi modeli. Opisali bomo, kako smo orodja izbrali, jih pregledali, preverili njihovo ustreznost za našo problemsko domeno, na koncu pa jih na kratko medsebojno primerjali. V \ref{ch:impl}. poglavju bomo razložili, zakaj smo se odločili za implementacijo lastne knjižnice za delo s skritimi markovskimi modeli. Opisali bomo, kako smo se naloge lotili in kako smo izbrali orodja ter pristope. Navedli bomo poglavitne težave pri implementaciji in njihove rešitve.

V \ref{ch:bench}. poglavju bomo preverili, kako se skriti markovski modeli obnesejo pri tvorjenju naravnih besedil. Uporabili bomo lastno implementacijo skritih markovskih modelov in dve izmed orodij, pregledanih v \ref{ch:comp}. poglavju. Izbrali smo korpus slovenskega pisnega jezika, ga pripravili za učenje modelov, zgradili modele in jih uporabili za tvorjenje besedil. Nastala besedila smo primerjali med seboj in z izvornim korpusom. Za merilo primerjave smo izbrali število glagolov na stavek. Preverili smo, ali različna orodja in spreminjanje parametrov pri teh privedejo do različnih rezultatov.



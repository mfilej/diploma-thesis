# Uvod

V želji po večji produktivnosti in višji kvaliteti ter zmanjševanju truda avtomatizacija pronica v vsa področja človeškega življenja. Dan za dnem stroji prevzemajo nove odgovornosti v vseh panogah in jezikoslovje pri tem ni izjema. Računalništvo skuša rešiti mnoge izzive v zvezi z naravnim oz. človeškim jezikom in eden izmed teh je tvorjenje naravnega jezika — torej besedil, za katera bi lahko rekli, da jih je proizvedel človek.

Kot na ostalih področjih avtomatizacije lahko tvorjenje besedil človeka popolnoma nadomesti, npr. pri pisanju vremenske napovedi. S pisanjem osnutkov dokumentov ali s strnjevanjem besedi v obnove lahko ljudi naredi učinkovitejše oz. jim prihrani nekaj dela. Tvorjenje besedil, ki pomagajo lajšati anksioznost ali opisovanje grafov (in drugih “nebesednih” oblik) za slabovidne ljudi, pa lahko znatno izboljšta kvaliteto njihovih življenj.

Tvorjenje naravnega jezika\angl[natural language generation — NLG], je proces sestavljanja besedil, ki zvenijo naravno ~\cite{Kondadadi2013}. Primeri uporabe NLG sistemov vključujejo:

* obnovo in strjevanje zdravniških, inžinirskih, finančnih, športnih … podatkov;
* tvorjenje osnutkov dokumentov, kot so navodila za uporabo, pravni dokumenti, poslovna pisma …
* tvorjenje besedil, ki so namenjena prepričevanju oz. motiviranju uporabnikov, npr. za zmanjševanje anksioznosti pri ljudeh;
* podporo ljudem s posebnimi potrebami, npr. branje grafov za slabovidne ali v pomoč pri sestavljanju besedil za ljudi, ki ne govorijo~\cite{Clark2013}.

NLG sistemi se delijo na statistične sisteme in na sisteme, osnovane na znanju. Slednji so za tvorjenje odvisni od znanja iz neke določene domene. Čeprav so taki sistemi sposobni proizvesti kvalitetno besedilo, zahtevajo pri izgradnji veliko truda in sodelovanja z končnimi uporabniki sistema. Poleg tega lahko taki sistemi pokrivajo samo domeno, za katero so bili zgrajeni. Na drugi strani so statistčni sistemi enostavnejši za izgradnjo in lažji za prilagoditev na druge domene. Slabost statističnih sistemov je, da so bolj izpostavljeni napakam — zaradi manjšega števila omejitev v postopku tvorjenja lahko proizvedejo lahko tudi besedila brez smisla~\cite{Kondadadi2013}.

Področje tvorjenja naravnega jezika je ena izmed zadnjih panog računalniškega jezikoslovja, ki so privzele statistične metode~\cite{Mairesse2010}.

V diplomski nalogi smo ugotavljali, ali so skriti markovski modeli lahko primerna statistična metoda za tvorjenje naravnega jezika.

Najpej smo opravili kratek pregled področij verjetnostne teorije in teorije informacije, ki omogočajo teoretično podlago za skrite markovske modele in predstavili, kako lahko s takimi modeli tvorimo zaporedja. Predstavili bomo vprašanja, ki se pojavijo pri uporabi skritih markovskih modelov v praksi in odgovorili na tista, ki so ključna za izvedbo naše naloge. Enačbe, pridobljene iz odgovorov, bomo v \ref{ch:model}. poglavju preslikali v psevdokodo, ki nam bo omogočila delo s skritimi markovskimi modeli. Opisali bomo s katerimi težavami smo se srečali pri preslikavi matematičnih enačb in kako smo jih rešili. V \ref{ch:comp}. poglavju bomo opravili pregled področja obstoječih orodij za delo s skritimi markovskimi modeli. Opisali bomo, kako smo orodja izbrali, jih pregledali, preverili njihovo ustreznost za našo problemsko domeno, na koncu pa jih na kratko medsebojno primerjali. V \ref{ch:impl}. poglavju bomo razložili, zakaj smo se odločili za implementacijo lastne knjižnjice za delo s skritimi markovskimi modeli. Opisali bomo, kako smo se naloge lotili in kako smo izbrali orodja ter pristope. Navedli bomo poglavitne težave pri implementaciji in njihove rešitve. V \wip{6.} poglavju bomo preverili, kako se skriti markovski modeli obnesejo pri tvorjenju naravnih besedil. Uporabili bomo lastno implementacijo skritih markovskih modelov in dve izmed orodij, pregledanih v \ref{ch:comp} poglavju. Izbrali smo korpus slovenskega pisnega jezika, ga pripravili za učenje modelov, zgradili modele in jih uporabili za tvorjenje besedil. Nastala besedila smo primerjali med seboj in z izvornim korpusom. Za merilo primerjave smo izbrali število glagolov na stavek. Preverili smo, ali različna orodja in spreminjanje parametrov pri le-teh privedejo do različnih rezultatov.



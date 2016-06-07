# Uvod

V želji po večji produktivnosti in višji kvaliteti ter zmanjševanju truda avtomatizacija pronica v vsa področja človeškega življenja. Dan za dnem stroji prevzemajo nove odgovornosti v vseh panogah in jezikoslovje pri tem ni izjema. Računalništvo skuša rešiti mnoge izzive v zvezi z naravnim oz. človeškim jezikom in eden izmed teh je generiranje naravnega jezika — torej besedil, za katera bi lahko rekli, da jih je proizvedel človek.

Kot na ostalih področjih avtomatizacije lahko generiranje besedil človeka popolnoma nadomesti, npr. pri pisanju vremenske napovedi. S pisanjem osnutkov dokumentov ali s strnjevanjem besedi v obnove lahko ljudi naredi učinkovitejše oz. jim prihrani nekaj dela. Generiranje besedil, ki pomagajo lajšati anksioznost ali opisovanje grafov (in drugih “nebesednih” oblik) za slabovidne ljudi, pa lahko znatno izboljšta kvaliteto njihovih življenj.

Cilj diplomske naloge je ugotoviti, ali lahko skrite markovske modele učimo na podlagi besedila.

# Generiranje naravnega jezika

Generiranje naravnega jezika (angl. natural language generation — NLG), je proces generiranja besedil, ki zvenijo naravno ~\cite{Kondadadi2013}. Primeri oporabe NLG sistemov vključujejo:

* obnovo in strjevanje zdravniških, inžinirskih, finančnih, športnih … podatkov;
* generiranje osnutkov dokumentov, kot so navodila za uporabo, pravni dokumenti, poslovna pisma …
* generiranje besedil, ki so namenjena prepričevanju oz. motiviranju uporabnikov, npr. za zmanjševanje anksioznosti pri ljudeh;
* podporo ljudem s posebnimi potrebami, npr. branje grafov za slabovidne ali v pomoč pri sestavljanju besedil za ljudi, ki ne govorijo~\cite{Clark2013}.

V panogi računalniškega jezikoslovja je generiranje naravnega jezika eno izmed zadnjih področji, ki so začela uporabljati statistične metode oz. modele. NLG sistemi se namreč delijo na statistične sisteme in na sisteme, osnovane na znanju. Slednji so za generiranje odvisni od znanja iz neke določene domene. Čeprav so taki sistemi sposobni proizvesti kvalitetno besedilo, zahtevajo pri izgradnji veliko truda in sodelovanja z končnimi uporabniki sistema. Poleg tega lahko taki sistemi pokrivajo samo domeno, za katero so bili zgrajeni. Na drugi strani so statistčni sistemi enostavnejši za izgradnjo in lažji za prilagoditev na druge domene. Slabost statističnih sistemov je, da so bolj izpostavljeni napakam — zaradi manjšega števila omejitev v postopku generiranja lahko proizvedejo lahko tudi besedila brez smisla~\cite{Kondadadi2013}.

Področje generiranja naravnega jezika je ena izmed zadnjih panog računalniškega jezikoslovja, ki so privzele statistične metode~\cite{Mairesse2010}.
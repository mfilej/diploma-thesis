# Pregled obstoječih rešitev

V tem poglavju bomo naredili pregled nad obstoječimi orodji za generiranje skritih markovskih modelov in pregledali njihovo ustreznost za uporabo v problemski domeni generiranja besedil. Najprej bomo opisali kako smo poiskali potencialne projekte, ki bi lahko ustrezali našim potrebam. Nato bomo navedli, kako smo med najdenimi izbrali peščico najobetavnejših, ki si jih bomo kasneje podrobneje ogledali in našteli, kakšne kriterije bomo pri tej obravnavi upoštevali. Za tem bomo posamezno obravnavali vsakega od izbranih projektov. Nazadnje bomo še na kratko navedli nekaj projetkov, ki smo si jih ogledali, vendar se za njih nismo odločili.

\wip{premakni nizje}

Zbiranje potencialnih projektov smo začeli z iskanjem na spletnem portalu za kolaborativni razvoj projektov GitHub\footnote{\url{https://github.com}}. Zaradi pudarka na orodjih za sodelovanje pri razvoju programske opreme je GitHub postal zelo priljubljen pri razvijalcih odprte kode~\cite{McDonald2013, Thung2013}. Skupaj z zmogljivim iskalnikom nam omogoča pregled nad velikim številom potencialno uporabnih projektov. Dodatno smo si lahko pomagali z indikatorji popularnosti in povezanosti projektov, s katerimi bomo lahko ocenili, ali je projekt vzdrževan in ali ima aktivne uporabnike. Takšni indikatorji nam dajo večjo možnost, da bomo našli projekt, ki bo deloval na sodobni strojni in programski opremi~\cite{Dabbish2012}.

\wip{GH search screenshot}


zakaj github, zakaj zvezdice, zakaj readme, zakaj dokumentacija
v zadnjih letih privabil veliko razvijalcev in projektov ker ima funkcije za sodelovanje (collaboration tools)

Kako smo izbrali …

Kriteriji/zahteve (naštej)

kriteriji/zahteve (razloži vsakega posebej)

Za izbrane projekte za generiranje skritih markovskih modelov bomo preverili, če so ustrezne za učenje modelov na podlagi daljših besedil. Za učenje modelov želimo uporabiti besedilo ali množico besedil nekega avtorja, ki so dovolj dolga, da predstavljajo dobro reprezentacijo pogostosti pojavljanja izrazov ter besednih zvez in hkrati vsebujejo tudi dovoljšen besedni zaklad. Zato smo se odločili, da bomo uporabili krajše knjige ali zbirge drugih, krajših vrst besedil (esejev, poezije, \dots). Posamezna učna množica bo tako obsegala od 10.0000 do 50.000 besed.

Za vsakega izmed izbranih projektov

- kako smo izbirali
  - github/google search
    - zakaj github: dobro iskanje, dobeer pregled nad aktivnostjo, stevilom uporabnikov
  - da ima vsaj readme ali examples/ dir
  - da kdo sploh uporablja
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


- primerjamo par kandidatov
- na koncu navedemo se kaj smo pregledali in nismo vzeli v primerjavo (wirecutter stil)


python ghmm
http://ghmm.sourceforge.net/documentation.html

> If you want more fine-grained control over the learning procedure, you can do single steps and monitor the relevant diagnostics yourself, or employ meta-heuristics such as noise-injection to avoid getting stuck in local maxima. [Currently for continous emissions only]

ne podpira mnogoterih obs, predstaviti dolgo besedilo kot eno sekvenco je problematicno, ker simboli proti koncu imajo prakticno nicno verjetnost
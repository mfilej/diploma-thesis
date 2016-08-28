# Sklepne ugotovitve

V diplomskem delu smo predstavili probleme, ki se pojavljajo pri uporabi skritih markovskih modelov v praksi. Njihove rešitve smo zapisali v obliki psevdokode. Predstavili smo tudi nadgradnje rešitev, ki omogočajo tvorjenje besedil s skritimi markovskimi modeli. Pregledali smo obstoječe rešitve za delo s skritimi markovskimi modeli in njihovo ustreznost za uporabo na področju tvorjenja besedil. Implementirali smo knjižnico za delo s skritimi markovskimi modeli. Postopek implementacije smo opisali in navedli tudi težave, ki se pri tem pojavljajo (npr. napaka podkoračitve). Nekaj izmed rešitev smo skupaj z lastno implementacijo preizkusili pri učenju na podlagi izbranega korpusa slovenskega pisnega jezika. 
Na nastalih besedilih smo opravili statistično analizo na podlagi pogostosti pojavljanja glagolov v stavkih.

Prišli smo do naslednjih ugotovitev:
1. Število skritih stanj v skritem markovskem modelu nima znatnega vpliva na tvorjeno besedilo.
2. Nobeno izmed orodij ni sposobno tvorjenja besedil, ki bi bila podobna izvornemu korpusu.
3. Lastna implementacija je sposobna tvoriti besedila s podobnimi karakteristikami kot ostala orodja. 

Tvorjena besedila imajo zaradi (statistične) narave tvorjenja zaporedij besed le redko smisel. Zaradi tega menimo, da skriti markovski modeli sami po sebi niso dovolj zmogljivi za tvorjenje naravnih besedil na podlagi splošnega pisnega jezika, ki smo ga uporabili v diplomskem delu. Zaradi sposobnosti proizvajanja velikega števila variacij v besedilih pa bi lahko bili uporabni pri izbiri besed kot del širšega sistema za tvorjenje naravnega jezika.

V prihodnosti želimo skrite markovske modele uporabiti pri pripravi besedil za predmet digitalna forenzika. Pričakujemo, da bo uporaba na ožji problemski domeni privedla do uporabnih rezultatov.

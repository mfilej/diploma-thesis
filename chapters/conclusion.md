# Sklepne ugotovitve

V diplomskem delu smo predstavili probleme, ki se pojavljajo pri uporabi skritih markovskih modelov v praksi. Njihove rešitve smo zapisali v obliki psevdokode. Predstavili smo tudi nadgradnje rešitev, ki omogočajo tvorjenje besedil s skritimi markovskimi modeli. Opisali smo postopek implementacije knjižnjice za delo s skritimi markovskimi modeli in tudi težave, ki se pri tem pojavljajo (npr. napaka podkoračitve). Pregledali smo obstoječe rešitve za delo s skritimi markovskimi modeli in njihovo ustreznost za uporabo na področju tvorjenja besedil. Nekaj izmed rešitev smo skupaj z lastno implementacijo preizkusili pri učenju na podlagi izbranega korpusa slovenskega pisnega jezika. 
Nastala besedilih in izvornem korpusu smo opravili statistično analizo na podlagi pogostosti pojavljanja glagolov v stavkih.

Pri primerjavi tvorjenih besedil smo ugotovili, da število skritih stanj modela nima statistično pomembnega vpliva na tvorjeno besedilo.

Pri primerjavi tvorjenih besedil z korpusom smo ugotovili, da je razlika pri vseh tvorjenih besedilih statistično pomembna (ni podobnosti).

Nastali stavki imajo zaradi (statistične) narave tvorjenja zaporedij besed le redko smisel. Zaradi tega menimo, da skriti markovski modeli sami po sebi niso dovolj zmogljivi za tvorjenje naravnih besedil. Zaradi sposobnosti proizvajanja velikega števila variacij v besedilih pa bi lahko bi pa bili uporabni pri izbiri besed kot del širšega sistema za tvorjenje naravnega jezika.
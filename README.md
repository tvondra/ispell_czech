Česká data pro ispell
=====================

Tento slovník vychází ze slovníku Petrem Kolářem z (Petr.Kolar@vslib.cz)
a dostupného na adrese

    ftp://ftp.tul.cz/pub/unix/ispell/ispell-czech-20040229.tar.gz

Tento slovník je UTF-8 variantou slovníku určenou jak pro ispell tak pro
český fulltext v PostgreSQL (založený na ispellu). To je také důvodem
změny koncovky generovaných souborů na .affix/.dict.

Současně byla změněna licence na GPLv3.


Části slovníku
--------------

Slovník je rozdělen na následující části:

* **hlavni.cat** - Pravidelná skloňovaná podstatná jména a přídavná jména,
  (včetně těch, která mají kromě pravidelných tvarů jeden nebo více tvarů
  nepravidelných), všechna slovesa, a příslovce odvozená od přídavných jmen
  flagem R
* **nepravid.cat** - Nepravidelná podstatná jména a přídavná jména (jsou
  uvedeny všechny tvary bez flagů)
* **nesklon.cat** - Nesklonná podstatná a přídavná jména (mají jediná tvar)
* **zajmena.cat** - Zájmena
* **cislovk.cat** - Číslovky
* **prislovc.cat** - Příslovce (kromě příslovcí odvozených z přídavných jmen
  flagem R)
* **predlozk.cat** - Předložky (včetně víceslovných)
* **spojky.cat** - Spojky (včetně víceslovných)
* **citoslov.cat** - Citoslovce
* **castice.cat** - Částice
* **zkratky.cat** - Iniciálové zkratky a zkratky typu např., apod.
* **nezaraz.cat** - Dosud nezařazená slova
* **krestni.cat** - Křestní jména
* **prijmeni.cat** - Česká příjmení
* **narstjaz.cat** - Jména národů, států a jazyků
* **obce.cat** - Jména obcí v ČR
* **geogr.cat** - Zeměpisná jména v ČR i ve světě, jména měst mimo ČR
* **cizi.cat** - Cizí jména
* **nazvy.cat** - Ostatní názvy


Vytvoření slovníku
------------------

Zdrojový soubor czech.dict pro vytvoření slovníku pro ispell se získá takto:

    make czech.dict

Sloučený soubor se zpracuje příkazem buildhash:

    buildhash czech.dict czech.affix czech.hash

který vytvoří slovník pro ispell.


Použití a rozšiřování slovníku
------------------------------

Po zkopírování souboru czech.affix a czech.hash do adresáře, ve kterém
ispell očekává slovníky, lze ispell používat příkazem

    ispell -d czech kontrolovaný_soubor

Pokud při nalezení neznámého slova při kontrole textu zvolíte možnost
I)nsert, přidá se slovo do souboru $HOME/.ispell_czech. Chcete-li pomoci
s vytvářením slovníku, zašlete tento soubor (pokud možno vyčištěný od
nespisovných a cizích slov a případných HTML značek nebo příkazů pro
TeX) na adresu tv@fuzzy.cz.

Pokud chcete pouze přispět k rozšíření slovníku a nechcete text zdlouhavě
interaktivně kontrolovat, můžete použít příkaz

    ispell -d czech -l < kontrolovaný_soubor > výstup

který pracuje neinteraktivně a uloží do souboru výstup všechna slova
ze vstupního souboru, která nejsou obsažena ve slovníku spell checkeru.
Tento výstupní soubor zašlete pro účely rozšiřování slovníku. Zasílejte
pouze slovníky vzniklé kontrolou současných převážně spisovných textů
(Mácha nebo Neruda pravděpodobně není na závadu, ale třeba Bible Kralická
už vhodná není).

Rozdělení zdrojového slovníku na části je provedeno z toho důvodu, aby
bylo možné slovník snadno doplňovat (zatím ovšem pomůže více, když pošlete
syrový seznam neznámých slov).

Soubor výstup se sloučí se souborem hlavni.cat, retrográdně setřídí
(slova se setřídí jako by byla napsaná pozpátku, aby se snadno doplňovaly
flagy):

    perl retro.p hlavni.cat výstup | perl sort.p | perl retro.p > hlavni1.cat

V souboru hlavni1.cat je pak třeba (na řádcích, které neobsahují žádné
lomítko) doplnit flagy. Slova, která do souboru nepatří (příslovce apod.),
se potom přemístí do jiných souborů. Na závěr se připojí dosud nezařazená
slova do nezaraz.cat a výsledkem je nová verze souboru hlavni.cat:

    grep -v / hlavni1.cat >> nezaraz.cat
    grep / hlavni1.cat > hlavni.cat

Pro doplňování flagů lze použít i skript blemma - viz soubor ceskeaff.txt.
Jeho účinnost je však poměrně nízká a chybovost poměrně velká.

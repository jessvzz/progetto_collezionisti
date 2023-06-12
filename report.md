# Laboratorio di Basi di Dati:  *Progetto "Collectors"*

**Gruppo di lavoro**:

| Matricola | Nome | Cognome | Contributo al progetto |
|:---------:|:----:|:-------:|:----------------------:|
|288804|Francesca|Ciccarelli|                       |
|246996|Federico|Falcone|                        |
|278439|Gea|Viozzi|    |

**Data di consegna del progetto**: gg/mm/aaaa

## Analisi dei requisiti

Il database "Collectors" memorizza informazioni relative a collezioni di dischi.
Nel database andranno registrati i dati relativi ai collezionisti (nickname, email, anagrafica) e i dati relativi alle loro collezioni (ogni collezionista può creare più collezioni, ognuna con un nome distinto).
Ogni collezione è formata da dischi, per i quali abbiamo differenziato la tipologia come CD, vinile, musicassetta, EP e digitale. Abbiamo inoltre indicato titolo, anno di uscita, etichetta, stato di conservazione e barcode (se presente). Ogni disco è caratterizzato inoltre da una o più immagini che possono trovarsi su fronte, retro, facciate interne, libretti ecc.
Ogni disco è composto da brani (tracce), dove andranno specificati titolo, durata, esecutore/i, compositore/i e genere.
Il collezionista può inoltre possedere una o più copie di uno stesso disco, magari a seguito di scambi o perchè ne prevede la rivendita.
I collezionisti possono condividere la propria collezione con specifici utenti o in maniera pubblica; ogni collezione avrà quindi un flag provato/pubblico e la lista di collezionisti con cui è condivisa.

In seguito riportiamo un glossario dei termini:

|Termine|Descrizione|Collegamenti|
|:-----:|:---------:|:----------:|
|Collezionista|Utente che può creare collezioni e che può decidere se condividerle con altri utenti. Include anche i collezionisti con cui vengono condivise le collezioni.|Collezioni|
|Collezione|Insieme di dischi posseduti dal collezionista.|Collezionista, Disco|
|Disco|Oggetto contenuto in una collezione, che può essere gestito in diverse copie.|Collezione, Etichetta, Brano|
|Brano|Unità che compone un disco.|Disco, Artista|


## Progettazione concettuale

Nel file "Allegato1" riportiamo il diagramma E-R realizzato.
Di seguito riportiamo il dizionario relativo al diagramma E-R:

**Entità**
|Entità|Descrizione|Attributi|Identificatore|
|:----:|:---------:|:-------:|:------------:|
|Collezionista|Utente che crea collezioni|email, nickname, anagrafica(1)|nickname|
|Collezione|Insieme di dischi posseduti dal collezionista|nome,flag(2)|nome,nickname|
|Disco|Oggetto contenuto in una collezione|titolo,anno_uscita,tipo(3),barcode,stato_di_conservazione|CONTROLLARE PERCHE ALL'INIZIO ARTISTA NON HA CHIAVE|
|Brano|Traccia che compone il disco|ISRC,durata,titolo,genere(4)|ISRC|
|Artista|Colui che compone e/o esegue il brano|anagrafica(5)|VEDERE COME SOPRA|
|Solista|Singola persona che forma l'artista|nome_dArte||
|Gruppo|Insieme di persone che formano l'artista|nome_dArte||
|Etichetta|Azienda che produce un disco|nome,p_iva|nome|
|Immagine|Figura presente sul disco|sorgente, collocazione|sorgente|

(1): nome, cognome

(2): privato, pubblico

(3): CD, vinile, EP, musicassetta, digitale

(4): rock, pop, metal, blues, musica classica, altro

(5): nome, cognome

**Relazioni**
|Relazione|Descrizione|Entità coinvolte|Attributi|
|:-------:|:---------:|:--------------:|:-------:|
|crea|Associa un collezionista in quanto possessore e creatore ad una collezione|Collezionista (1,N), Collezione (1,1)||
|condivide|Associa una collezione ad un collezionista con il quale è condivisa|Collezionista (0,N), Collezione (1,1)|stato_di_attivazione|
|contiene|Associa una collezione con un disco|Collezione (0,N), Disco (1,1)|quantita|
|pubblica|Associa un disco con un artista|Disco (1,1), Artista (1,N)||
|compone|Associa un artista ad un brano in quanto compositore|Artista (1,N), Brano (1,N)||
|esegue|Associa un artista ad un brano in quanto esecutore|Artista (1,N), Brano (1,N)||
|forma|Associa un brano ad un disco|Brano (1,1), Disco (1,1)||
|produce|Associa un disco ad un'etichetta|Disco (1,1), Etichetta (1,N)||
|raffigura|Associa un disco ad un'immagine|Disco (0,N), Immagine (1,1)||

**Generalizzazioni**
|Classe Padre|Classi Figlie|Tipologia della generalizzazione|
|:----------:|:-----------:|:------------------------------:|
|Artista|Solista, Gruppo|Totale|

### Formalizzazione dei vincoli non esprimibili nel modello ER

- Il nickname di ogni *Collezionista* deve essere unico;
- Il nome della *Collezione* creata dall'*Artista* deve essere unico;
- Il nome dell'*Etichetta* deve essere unico;
- Il codice *ISRC*, chiave dell'entità *Brano*, deve essere lungo 12 caratteri; ***SUL DATABASE RISULTA DA 12?***
- Il numero di collezioni condivise non può superare il numero di collezioni totali possedute dal collezionista;
- Un collezionista non può condividere la stessa collezione con un utente con cui è gia condivisa;
- Una collezione non può essere formata da un numero di dischi superiore a quelli posseduti;

## Progettazione logica

### Ristrutturazione ed ottimizzazione del modello ER

Nel file "Allegato2" riportiamo il diagramma E-R ristrutturato.
Le ristrutturazioni che sono state effettuate sono le seguenti:

**Eliminazione degli attributi multivalore**
- L'attributo *anagrafica* dell'entità *Collezionista* è stato esploso in due nuovi attributi: *nome*, *cognome*;
- L'attributo *anagrafica* dell'entità *Artista* è stato esploso in due nuovi attributi: *nome*, *cognome*;
- L'attributo *par_tecnici* dell'entità *Immagine* è stato esploso nei seguenti nuovi attributi: *nonme_file*, *dimensione_file*, *formato_file*.

**Eliminazione delle gerarchie**
- La generalizzazione totale con classe padre *Artista* e classi figlie *Solista* e *Gruppo* è stata eliminata aggiungendo un attributo booleano "gruppo" ad *Artista*: esso sarà True se l'artista considerato è un gruppo, False se è un solista.

**Fusione/Decomposizione di entità e relazioni**
- È possibile possedere più copie di uno stesso disco, ed ogni copia può avere uno stato di conservazione diverso; per questo motivo è stata creata una nuova entità chiamata *Copia*, legata all'entità *Disco* tramite la relazione *quantizza*, che ha gli attributi *stato_di_conservazione* e *barcode*. La relazione *quantizza* in particolare comprende anche l'attributo *quantità* per tenere traccia del numero di copie possedute;
- L'attributo *tipo* legato all'entità *Disco* è specifico per ogni copia dei dischi che possiede il collezionista, poichè è possibile possedere lo stesso disco in fomati/tipi diversi (ad esempio un CD ed un vinile); per questo motivo è stata creata una nuova entità *Tipo* con l'attributo *nome*, legata a *Copia* tramite la relazione *descrive*;
- Le relazioni *esegue* e *compone* che legano gli attributi *Artista* e *Brano* rappresentano le stesse informazioni, distinguendo solo se l'artista considerato è il compositore e/o essecutore del brano. È stato ristrutturato considerando una singola relazione *appartiene* che ha come attributo un flag enum(esecutore/compositore) ***ATTENZIONEEEEEEEEE!!!! SE È SIA ESECUTORE SIA COMPOSITORE?***
- L'attributo *genere* relativo all'entità *Brano* può contenere un'ampia lista di generi musicali in continuo aggiornamento. Per gestire la nascita di nuovi generi musicali, è stata creata un'entità *Genere*, legata a *Brano* tramite la relazione *caratterizza*, che ha come attributo *nome*.

**Altre ristrutturazioni**
- L'entità debole *Disco* fa riferimento all'entità forte *Etichetta* ma, poichè un disco è solitamente associato all'artista e non alla casa discografica che lo produce, si preferisce rendere *Disco* debole con l'entità *Artista* tramite la relazione *pubblica* (che ha cardinalità sempre (1,1));
-***COLLEZIONISTA POSSIEDE DISCO PERCHÈ LO ABBIAMO MESSO? NON MI RICORDO***

### Traduzione del modello ER nel modello relazionale

Riportiamo qui di seguito il modello relazionale relativo allo scherma E-R ristrutturato.

**Entità**
|Entità|Attributi|Chiave primaria|Chiavi esterne|
|:----:|:-------:|:-------------:|:------------:|
|Collezionista|<ins>ID</ins>, nickname, nome, cognome|ID||
|Collezione|<ins>ID, ID_collezionista </ins>, nome, flag|ID|ID_collezionista|
|Artista|<ins>ID<\ins>, nome_dArte, nome, cognome, gruppo|ID||
|Disco|<ins>ID, ID_artista <\ins>, titolo, anno_uscita, barcode, ID_etichetta, ID_collezione|ID|ID_artista|
|Tipo|<ins>ID<\ins>,nome|ID||
Copia|<ins>ID, ID_disco<\ins>, stato_di conservazione, ID_tipo|ID|ID_disco|
Genere|<ins>ID<\ins>, nome|ID||
|Brano|<ins>ID<\ins>, ISRC, durata, titolo, ID_genere, ID_disco|ID||
|Etichetta|<ins>ID<\ins>, p_iva, nome|ID||
|Immagine|<ins>ID<\ins>, sorgente, nome, dimensione, formato, collocazione, ID_disco|ID||

**Relazioni**

|Relazioni|Attributi|Chiave primaria|
|:-------:|:-------:|:-------------:|
|condivisa|<ins>ID_collezionista, ID_collezione<\ins>, data_inizio|ID_collezionista, ID_collezione|
|contiene|<ins>ID_collezione, ID_disco<\ins>|ID_collezione, ID_disco|
|quantizza|***NON L'AVEVAMO TOLTO???||
|appartiene|<ins>ID_artista, ID_brano<\ins>, flag|ID_artista, ID_brano|


## Progettazione fisica

### Implementazione del modello relazionale

- Inserite qui lo *script SQL* con cui **creare il database** il cui modello relazionale è stato illustrato nella sezione precedente. Ricordate di includere nel codice tutti
  i vincoli che possono essere espressi nel DDL. 

- Potete opzionalmente fornire anche uno script separato di popolamento (INSERT) del database su cui basare i test delle query descritte nella sezione successiva.

### Implementazione dei vincoli

- Nel caso abbiate individuato dei **vincoli ulteriori** che non sono esprimibili nel DDL, potrete usare questa sezione per discuterne l'implementazione effettiva, ad esempio riportando il codice di procedure o trigger, o dichiarando che dovranno essere implementati all'esterno del DBMS.

### Implementazione funzionalità richieste

- Riportate qui il **codice che implementa tutte le funzionalità richieste**, che si tratti di SQL o di pseudocodice o di entrambi. *Il codice di ciascuna funzionalità dovrà essere preceduto dal suo numero identificativo e dal testo della sua definizione*, come riportato nella specifica.

- Se necessario, riportate anche il codice delle procedure e/o viste di supporto.

#### Funzionalità 1

> Definizione come da specifica

```sql
CODICE
```

#### Funzionalità 2

> Definizione come da specifica

```sql
CODICE
```

## Interfaccia verso il database

- Opzionalmente, se avete deciso di realizzare anche una **(semplice) interfaccia** (a linea di comando o grafica) in un linguaggio di programmazione a voi noto (Java, PHP, ...) che manipoli il vostro database , dichiaratelo in questa sezione, elencando
  le tecnologie utilizzate e le funzionalità invocabili dall'interfaccia. 

- Il relativo codice sorgente dovrà essere *allegato *alla presente relazione.

-----

**Raccomandazioni finali**

- Questo documento è un modello che spero possa esservi utile per scrivere la documentazione finale del vostro progetto di Laboratorio di Basi di Dati.

- Cercate di includere tutto il codice SQL nella documentazione, come indicato in questo modello, per facilitarne la correzione. Potete comunque allegare alla documentazione anche il *dump* del vostro database o qualsiasi altro elemento che ritenete utile ai fini della valutazione.

- Ricordate che la documentazione deve essere consegnata, anche per email, almeno *una settimana prima* della data prevista per l'appello d'esame. Eventuali eccezioni a questa regola potranno essere concordate col docente.

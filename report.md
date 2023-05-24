# Laboratorio di Basi di Dati:  *Progetto "Collectors"*

**Gruppo di lavoro**:

| Matricola | Nome | Cognome | Contributo al progetto |
|:---------:|:----:|:-------:|:----------------------:|
|288804|Francesca|Ciccarelli|                       |
|246996|Federico|Falcone|                        |
|           |Gea|Viozzi|    |

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
|Disco|Oggetto contenuto in una collezione|titolo,anno_uscita,tipo(3),barcode,stato_conservazione|VEDERE SE ARTISTA O ETICHETTA|
|Brano|Traccia che compone il disco|ISRC,durata,titolo,genere(4)|ISRC|
|Artista|Colui che compone e/o esegue il brano|anagrafica(5)|VEDERE COME SOPRA|
|Etichetta|Azienda che produce un disco|nome,sede,p_iva|nome|
|Immagine|Figura presente sul disco|sorgente, collocazione, par_tecnici(6)|sorgente|


- Commentate gli elementi non visibili nella figura (ad esempio il contenuto degli attributi composti) nonché le scelte/assunzioni che vi hanno portato a creare determinate strutture, se lo ritenete opportuno.

### Formalizzazione dei vincoli non esprimibili nel modello ER

- Elencate gli altri **vincoli** sui dati che avete individuato e che non possono essere espressi nel diagramma ER.

## Progettazione logica

### Ristrutturazione ed ottimizzazione del modello ER

- Riportate qui il modello **ER ristrutturato** ed eventualmente ottimizzato. 

- Discutete le scelte effettuate, ad esempio nell'eliminare una generalizzazione o nello scindere un'entità.

### Traduzione del modello ER nel modello relazionale

- Riportate qui il **modello relazionale** finale, derivato dal modello ER ristrutturato della sezione precedente e che verrà implementato in SQL in quella successiva. 

- Nel modello evidenziate le chiavi primarie e le chiavi esterne.

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

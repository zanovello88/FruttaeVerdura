# Progetto Frutta e Verdura - Applicazione Web E-commerce

## Descrizione Generale

Il progetto "Frutta e Verdura" è un'applicazione web sviluppata per la gestione di un e-commerce specializzato nella vendita di prodotti ortofrutticoli. L'applicazione permette agli utenti di navigare nel catalogo dei prodotti, aggiungere articoli al carrello, effettuare ordini e gestire il proprio profilo. Inoltre, include funzionalità amministrative per la gestione dei prodotti, degli ordini e degli utenti.

L'obiettivo del progetto è dimostrare l'implementazione di un sistema e-commerce completo utilizzando tecnologie web moderne, con particolare attenzione all'integrazione con un database relazionale per la persistenza dei dati.

## Tecnologie Utilizzate

- **Linguaggio di Programmazione**: Java (versione 11)
- **Framework Web**: Jakarta EE (Servlet API 5.0, JSP)
- **Server Applicativo**: Apache Tomcat 10.1.0
- **Database**: Microsoft SQL Server
- **Build Tool**: Apache Maven
- **Architettura**: MVC (Model-View-Controller) con pattern DAO (Data Access Object)
- **Frontend**: HTML, CSS, JavaScript (con JSP per la generazione dinamica)
- **Logging**: Java Util Logging

## Struttura del Progetto

Il progetto segue un'architettura a tre livelli:

1. **Presentazione (View)**: Pagine JSP per l'interfaccia utente
2. **Logica di Business (Controller)**: Servlet Java per la gestione delle richieste
3. **Persistenza (Model)**: Classi DAO per l'accesso al database per ciascuna entità (Utente, Prodotto, Ordine, Carrello, Showcase)

### Componenti Principali

- **Dispatcher Servlet**: Punto di ingresso unico per tutte le richieste, che instrada le azioni ai controller appropriati
- **Controller**: Gestiscono la logica di business (HomeManagement, CartManagement, UserManagement, etc.)
- **DAO (Data Access Object)**: Incapsulano l'accesso al database per ciascuna entità
- **Modelli (MO)**: Classi Java che rappresentano le entità del dominio

## Database e Operazioni SQL

Il progetto utilizza Microsoft SQL Server come sistema di gestione di database relazionale. Il database è denominato "ecommerce" e contiene le seguenti tabelle principali:

- `utente`: Informazioni sugli utenti registrati
- `prodotto`: Catalogo dei prodotti disponibili
- `cart`: Carrello degli acquisti degli utenti
- `[order]`: Ordini effettuati (il nome è racchiuso tra parentesi quadre per essere una parola riservata in SQL Server)
- `showcase`: Vetrina dei prodotti in evidenza

### Operazioni SQL Utilizzate

#### INSERT
L'operazione INSERT viene utilizzata per aggiungere nuovi record alle tabelle:

- **Prodotti**: In `ProdottoDAOSQLServerImpl.java`, per inserire nuovi prodotti nel catalogo
- **Carrello**: In `CartDAOSQLServerImpl.java`, per aggiungere prodotti al carrello di un utente
- **Ordini**: In `OrderDAOSQLServerImpl.java`, per registrare nuovi ordini
- **Vetrina**: In `ShowcaseDAOSQLServerImpl.java`, per aggiungere prodotti alla vetrina

Esempio di query INSERT per un prodotto:
```sql
INSERT INTO prodotto (nome, descrizione, prezzo, quantita_disponibile, ...) VALUES (?, ?, ?, ?, ...)
```

#### UPDATE
L'operazione UPDATE viene utilizzata per modificare record esistenti:

- **Aggiornamento quantità carrello**: In `CartDAOSQLServerImpl.java`, per modificare la quantità di prodotti nel carrello
- **Modifica prodotti**: In `ProdottoDAOSQLServerImpl.java`, per aggiornare informazioni sui prodotti
- **Aggiornamento stato ordini**: In `OrderDAOSQLServerImpl.java`, per cambiare lo stato degli ordini
- **Soft delete**: Invece di DELETE fisici, il progetto utilizza UPDATE per marcare record come "deleted"

Esempio di query UPDATE per aggiornare un prodotto:
```sql
UPDATE prodotto SET nome=?, descrizione=?, prezzo=? WHERE id_prod=?
```

#### DELETE
Il progetto non utilizza DELETE fisici per mantenere l'integrità dei dati e permettere il recupero. Invece, implementa un "soft delete" attraverso UPDATE:

- **Eliminazione prodotti**: In `ProdottoDAOSQLServerImpl.java`, imposta `deleted='1'` invece di rimuovere il record
- **Svuotamento carrello**: In `CartDAOSQLServerImpl.java`, marca gli elementi del carrello come eliminati

Esempio di soft delete:
```sql
UPDATE prodotto SET deleted='1' WHERE id_prod=?
```

#### JOIN
Il progetto utilizza un'operazione JOIN esplicita per il report dettagliato degli ordini:

- **Report Dettagliato Ordini**: In `OrderDAOSQLServerImpl.java` e `OrderDAOMySQLJDBCImpl.java`, implementato il metodo `findOrderDetailsJoin()` che combina dati da tre tabelle

Esempio di query JOIN per recuperare i dettagli completi degli ordini:
```sql
SELECT o.order_id, u.nome as user_name, u.email as user_email,
       p.nome as product_name, o.quantity, p.prezzo as unit_price,
       o.total_amount, o.timestamp, o.status
FROM [order] o
INNER JOIN utente u ON o.utente_id = u.id_utente
INNER JOIN prodotto p ON o.product_id = p.id_prod
WHERE o.deleted = '0'
ORDER BY o.timestamp DESC
```

Questa operazione consente agli amministratori di visualizzare una vista consolidata di tutti gli ordini con informazioni complete su cliente, prodotto e importo, facilitando l'analisi e il monitoraggio delle vendite.

## Funzionalità Principali

1. **Gestione Utenti**: Registrazione, login, modifica profilo
2. **Catalogo Prodotti**: Visualizzazione prodotti, ricerca, filtri
3. **Carrello Acquisti**: Aggiunta/rimozione prodotti, modifica quantità
4. **Checkout e Ordini**: Processo di acquisto, gestione ordini
5. **Amministrazione**: Gestione prodotti, ordini, utenti (per amministratori)
6. **Vetrina**: Prodotti in evidenza sulla homepage
7. **Report Dettagliato Ordini (JOIN)**: Visualizzazione consolidata di tutti gli ordini con JOIN su ordine, utente e prodotto
8. **Pulizia Ordini Archiviati (DELETE)**: Eliminazione di ordini più vecchi di N mesi (filtrato per utente)

## Configurazione e Deployment

- **Build**: `mvn clean package`
- **Deployment**: Copia del file WAR in `webapps/` di Tomcat
- **Configurazione Database**: Modificabile in `Configuration.java`
- **URL Applicazione**: `http://localhost:8080/FruttaeVerdura/Dispatcher`

## Conclusioni

Questo progetto dimostra l'implementazione completa di un'applicazione web e-commerce utilizzando Java EE, con particolare attenzione alla separazione dei livelli architetturali e all'integrazione con un database relazionale. La scelta di SQL Server come DBMS permette di esplorare le specificità di questo sistema, mentre l'uso di operazioni CRUD (Create, Read, Update, Delete) copre tutti gli aspetti fondamentali della manipolazione dei dati.</content>
<parameter name="filePath">/Users/francescozanovello/Desktop/FruttaeVerdura/README.md
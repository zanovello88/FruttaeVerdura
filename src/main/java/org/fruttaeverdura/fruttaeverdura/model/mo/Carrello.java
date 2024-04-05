package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Carrello {
    private Long id_carrello;
    private String stato_carrello;
    private Timestamp data_creazione;
    private BigDecimal totale;
    private boolean deleted_car;

    /*N:1*/
    private Utente[] utenti;
    /*N:M*/
    private Prodotto[] prodotti;

    public Utente getutenti(int index) {return this.utenti[index];}
    public void setutenti(int index, Utente utenti){this.utenti[index]=utenti;}
    public Prodotto getprodotti(int index) {return this.prodotti[index];}
    public void setprodotti(int index, Prodotto prodotti){this.prodotti[index]=prodotti;}
    public Long getid_carrello() {return id_carrello;}
    public void setid_carrello(Long id_carrello){this.id_carrello=id_carrello;}
    public String getstato_carrello() {return stato_carrello;}
    public void setstato_carrello(String stato_carrello){this.stato_carrello=stato_carrello;}
    public Timestamp getdata_creazione() {return data_creazione;}
    public void setdata_creazione(Timestamp data_creazione){this.data_creazione=data_creazione;}
    public BigDecimal gettotale() {return totale;}
    public void settotale(BigDecimal totale){this.totale=totale;}
    public boolean isdeleted_car() {return deleted_car;}
    public void setdeleted_car(boolean deleted_car){this.deleted_car=deleted_car;}
}

package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.sql.Timestamp;

public class Ordine {
    private Long id_ordine;
    private Timestamp data_ordine;
    private String stato_ordine;
    private boolean deleted_ordine;
    private boolean consegnato;
    private String indirizzo_o;
    private String stato_o;
    private String citta_o;
    private Long cap_o;

    /*N:1*/
    private Utente utente;
    /*1:1*/
    private Pagamento pagamento;

    public Utente getutente() {return utente;}
    public void setutente(Utente utente){this.utente=utente;}
    public Pagamento getpagamento() {return pagamento;}
    public void setpagamento(Pagamento pagamento){this.pagamento=pagamento;}
    public Long getid_ordine() {return id_ordine;}
    public void setid_ordine(Long id_ordine){this.id_ordine=id_ordine;}
    public Timestamp getdata_ordine() {return data_ordine;}
    public void setdata_ordine(Timestamp data_ordine){this.data_ordine=data_ordine;}
    public String getstato_ordine() {return stato_ordine;}
    public void setstato_ordine(String stato_ordine){this.stato_ordine=stato_ordine;}
    public boolean isdeleted_ordine() {return deleted_ordine;}
    public void setdeleted_ordine(boolean deleted_ordine){this.deleted_ordine=deleted_ordine;}
    public boolean isconsegnato() {return consegnato;}
    public void setconsegnato(boolean consegnato){this.consegnato=consegnato;}
    public String getindirizzo_o() {return indirizzo_o;}
    public void setindirizzo_o(String indirizzo_o){this.indirizzo_o=indirizzo_o;}
    public String getstato_o() {return stato_o;}
    public void setstato_o(String stato_o){this.stato_o=stato_o;}
    public String getcitta_o() {return citta_o;}
    public void setcitta_o(String citta_o){this.citta_o=citta_o;}
    public Long getcap_o() {return cap_o;}
    public void setcap_o(Long cap_o){this.cap_o=cap_o;}
}

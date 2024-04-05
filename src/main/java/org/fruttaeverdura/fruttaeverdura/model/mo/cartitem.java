package org.fruttaeverdura.fruttaeverdura.model.mo;

public class cartitem {
    private Long id_cartitem;
    private int quantita;
    private boolean deleted_cartitem;

    /*1:1*/
    private Prodotto prodotto;
    private Carrello carrello;

    public Long getId_cartitem() {return id_cartitem;}
    public void setId_cartitem(Long id_cartitem){this.id_cartitem=id_cartitem;}
    public Prodotto getprodotto() {return prodotto;}
    public void setprodotto(Prodotto prodotto){this.prodotto=prodotto;}
    public Carrello getcarrello() {return carrello;}
    public void setcarrello(Carrello carrello){this.carrello=carrello;}
    public int getquantita() {return quantita;}
    public void setquantita(int quantita){this.quantita = quantita;}
    public boolean isdeleted_cartitem() {return deleted_cartitem;}
    public void setdeleted_cartitem(boolean deleted_cartitem){this.deleted_cartitem=deleted_cartitem;}
}

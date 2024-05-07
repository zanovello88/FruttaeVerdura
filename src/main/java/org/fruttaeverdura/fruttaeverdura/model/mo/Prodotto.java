package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.math.BigDecimal;

public class Prodotto {
    private Long id_prod;
    private String nome_prod;
    private String sede_acquisto;
    private String descrizione;
    private BigDecimal prezzo;
    private int quantita_disponibile;
    private String categoria;
    private boolean deleted_prod;
    private boolean blocked_prod;
    private String img_path;

    /*1:N*/
    private Cart[] carts;

    public Cart[] getCarts() { return carts; }

    public void setCarts(Cart[] carts) {this.carts = carts; }

    public Cart getCarts(int index) { return this.carts[index]; }

    public void setCarts(int index, Cart carts) {this.carts[index] = carts; }
    public Long getid_prod() {return id_prod;}
    public void setid_prod(Long id_prod){this.id_prod=id_prod;}
    public String getnome_prod() {return nome_prod;}
    public void setnome_prod(String nome_prod){this.nome_prod=nome_prod;}
    public String getsede_acquisto() {return sede_acquisto;}
    public void setsede_acquisto(String sede_acquisto){this.sede_acquisto=sede_acquisto;}
    public String getdescrizione() {return descrizione;}
    public void setdescrizione(String descrizione){this.descrizione=descrizione;}
    public BigDecimal getprezzo() {return prezzo;}
    public void setprezzo(BigDecimal prezzo){this.prezzo=prezzo;}
    public int getquantita_disponibile() {return quantita_disponibile;}
    public void setquantita_disponibile(int quantita_disponibile){this.quantita_disponibile = quantita_disponibile;}
    public String getcategoria() {return categoria;}
    public void setcategoria(String categoria){this.categoria=categoria;}
    public boolean isdeleted_prod() {return deleted_prod;}
    public void setdeleted_prod(boolean deleted_prod){this.deleted_prod=deleted_prod;}
    public boolean isblocked_prod() {return blocked_prod;}
    public void setblocked_prod(boolean blocked_prod){this.blocked_prod=blocked_prod;}
    public String getimg_path() {return img_path;}
    public void setimg_path(String img_path){this.img_path=img_path;}
}

package org.fruttaeverdura.fruttaeverdura.model.mo;

public class Utente {
    private Long id_utente;
    private String username;
    private String email;
    private String password;
    private String nome;
    private String cognome;
    private String indirizzo;
    private String stato;
    private String citta;
    private Long cap;
    private boolean admin;
    private boolean blocked;
    private boolean deleted;

    /*1:N*/
    private Ordine[] ordini;
    private Carrello carrello;

    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}
    public Ordine getordini(int index) {return this.ordini[index];}
    public void setordini(int index, Ordine ordini){this.ordini[index]=ordini;}
    public Carrello getcarrello() {return carrello;}
    public void setcarrello(Carrello carrello){this.carrello=carrello;}
    public Long getid_utente() {return id_utente;}
    public void setid_utente(Long id_utente){this.id_utente=id_utente;}
    public String getemail() {return email;}
    public void setemail(String email){this.email=email;}
    public String getPassword() {return password;}
    public void setPassword(String password){this.password=password;}
    public String getNome() {return nome;}
    public void setNome(String nome){this.nome=nome;}
    public String getCognome() {return cognome;}
    public void setCognome(String cognome){this.cognome=cognome;}
    public String getindirizzo() {return indirizzo;}
    public void setindirizzo(String indirizzo){this.indirizzo=indirizzo;}
    public String getstato() {return stato;}
    public void setstato(String stato){this.stato=stato;}
    public String getcitta() {return citta;}
    public void setcitta(String citta){this.citta=citta;}
    public Long getcap() {return cap;}
    public void setcap(Long cap){this.cap=cap;}
    public boolean isadmin() {return admin;}
    public void setadmin(boolean admin){this.admin=admin;}
    public boolean isblocked() {return blocked;}
    public void setblocked(boolean blocked){this.blocked=blocked;}
    public boolean isdeleted() {return deleted;}
    public void setdeleted(boolean deleted){this.deleted=deleted;}
}

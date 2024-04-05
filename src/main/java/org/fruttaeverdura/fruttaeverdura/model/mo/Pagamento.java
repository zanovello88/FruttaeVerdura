package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.math.BigDecimal;

public class Pagamento {
    private Long id_pagamento;
    private String numero_carta;
    private String scadenza;
    private int cvv;
    private BigDecimal importo;
    private String nome_carta;

    /*1:1*/
    private Ordine ordine;

    public Ordine getordine() {return ordine;}
    public void setordine(Ordine ordine){this.ordine=ordine;}
    public Long getid_pagamento() {return id_pagamento;}
    public void setid_pagamento(Long id_pagamento){this.id_pagamento=id_pagamento;}
    public String getnumero_carta() {return numero_carta;}
    public void setnumero_carta(String numero_carta){this.numero_carta=numero_carta;}
    public String getscadenza() {return scadenza;}
    public void setscadenza(String scadenza){this.scadenza=scadenza;}
    public int getcvv() {return cvv;}
    public void setcvv(int cvv){this.cvv = cvv;}
    public BigDecimal getimporto() {return importo;}
    public void setimporto(BigDecimal importo){this.importo=importo;}
    public String getnome_carta() {return nome_carta;}
    public void setnome_carta(String nome_carta){this.nome_carta=nome_carta;}

}

package org.fruttaeverdura.fruttaeverdura.model.mo;

public class Cart {

    private Long cart_id;
    /* N:1 */
    private Utente user;
    private Prodotto prodotto;
    private Long quantity;
    private boolean deleted;

    public Long getCartId() { return cart_id; }

    public void setCartId(Long cart_id) { this.cart_id = cart_id; }

    public Utente getUser() { return user; }

    public void setUser(Utente user) { this.user = user; }

    public Prodotto getProdotto() { return prodotto; }

    public void setProdotto(Prodotto prodotto) {this.prodotto = prodotto; }

    public Long getQuantity() { return quantity; }

    public void setQuantity(Long quantity) {this.quantity = quantity; }

    public boolean isDeleted() { return deleted; }

    public void setDeleted(boolean deleted) { this.deleted = deleted; }

}

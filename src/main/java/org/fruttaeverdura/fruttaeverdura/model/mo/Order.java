package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {

    private Long order_id;

    /* N:1 */
    private Utente user;
    private Prodotto prodotto;

    private Long quantity;
    private String status;
    private Timestamp timestamp;
    private boolean deleted;
    private BigDecimal total_amount;


    public Long getOrderId() {return order_id; }

    public void setOrderId(Long order_id) {this.order_id = order_id; }

    public Utente getUser() { return user; }

    public void setUser(Utente user) { this.user = user; }

    public Prodotto getProduct() { return prodotto; }

    public void setProduct(Prodotto prodotto) { this.prodotto = prodotto; }

    public Long getQuantity() { return quantity; }

    public void setQuantity(Long quantity) { this.quantity = quantity; }

    public String getStatus() { return status; }

    public void setStatus(String status) { this.status = status; }

    public Timestamp getTimestamp() { return timestamp; }

    public void setTimestamp(Timestamp time) { this.timestamp = time; }

    public BigDecimal getTotalAmount() { return total_amount; }

    public void setTotalAmount(BigDecimal total_amount) { this.total_amount = total_amount; }

    public boolean isDeleted() { return deleted; }

    public void setDeleted(boolean deleted) { this.deleted = deleted; }

}

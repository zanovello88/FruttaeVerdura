package org.fruttaeverdura.fruttaeverdura.model.mo;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Classe che rappresenta i dettagli di un ordine combinando dati da più tabelle (JOIN)
 * Contiene informazioni sull'ordine, l'utente che lo ha effettuato e il prodotto ordinato
 */
public class OrderDetail {
    private Long order_id;
    private String user_name;
    private String user_email;
    private String product_name;
    private Long quantity;
    private BigDecimal unit_price;
    private BigDecimal total_amount;
    private Timestamp timestamp;
    private String status;

    // Costruttore completo
    public OrderDetail(Long order_id, String user_name, String user_email, String product_name,
                       Long quantity, BigDecimal unit_price, BigDecimal total_amount,
                       Timestamp timestamp, String status) {
        this.order_id = order_id;
        this.user_name = user_name;
        this.user_email = user_email;
        this.product_name = product_name;
        this.quantity = quantity;
        this.unit_price = unit_price;
        this.total_amount = total_amount;
        this.timestamp = timestamp;
        this.status = status;
    }

    // Getter e Setter
    public Long getOrder_id() {
        return order_id;
    }

    public void setOrder_id(Long order_id) {
        this.order_id = order_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_email() {
        return user_email;
    }

    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(BigDecimal unit_price) {
        this.unit_price = unit_price;
    }

    public BigDecimal getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(BigDecimal total_amount) {
        this.total_amount = total_amount;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "order_id=" + order_id +
                ", user_name='" + user_name + '\'' +
                ", user_email='" + user_email + '\'' +
                ", product_name='" + product_name + '\'' +
                ", quantity=" + quantity +
                ", unit_price=" + unit_price +
                ", total_amount=" + total_amount +
                ", timestamp=" + timestamp +
                ", status='" + status + '\'' +
                '}';
    }
}

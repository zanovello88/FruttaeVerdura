package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.mo.Order;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public interface OrderDAO {

    public Order create(
            Utente user,
            Prodotto prodotto,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    );

    public List<Order> findOrders(Utente user);

    public List<Order> findBySingleOrder(Utente user, Timestamp timestamp);

    public void updateStatus(Utente user, Timestamp timestamp, String status);
}

package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.mo.Order;
import org.fruttaeverdura.fruttaeverdura.model.mo.OrderDetail;
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

    // new method uses primary key instead of timestamp
    public List<Order> findByOrderId(Utente user, Long orderId);

    /**
     * physically deletes orders older than the specified number of months
     * (only records previously marked deleted='0' are considered).
     * This operation is intended for admin cleanup.
     */
    public void deleteOldOrders(Utente user, int months);

    // update order status using the order's primary key (order_id)
    public void updateStatus(Utente user, Long orderId, String status);

    /**
     * Returns order details combining data from order, utente, and prodotto tables using JOIN.
     * Used for admin reports to see complete order information including customer and product details.
     */
    public List<OrderDetail> findOrderDetailsJoin();
}

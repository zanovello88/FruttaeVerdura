package org.fruttaeverdura.fruttaeverdura.model.dao.sqlserverJDBCImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.OrderDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import org.fruttaeverdura.fruttaeverdura.model.mo.Order;
import org.fruttaeverdura.fruttaeverdura.model.mo.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class OrderDAOSQLServerImpl implements OrderDAO {

    Connection conn;

    public OrderDAOSQLServerImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Order create(
            Utente user,
            Prodotto prodotto,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    ){

        PreparedStatement ps;
        Order order = new Order();
        order.setUser(user);
        order.setProduct(prodotto);
        order.setQuantity(quantity);
        order.setStatus(status);
        order.setTimestamp(timestamp);
        order.setTotalAmount(total_amount);

        try {
            String sql
                    = " INSERT INTO [order] "
                    + "   ( utente_id,"
                    + "     product_id,"
                    + "     quantity,"
                    + "     status,"
                    + "     timestamp,"
                    + "     total_amount,"
                    + "     deleted "
                    + "   ) "
                    + " VALUES (?,?,?,?,?,?,'0')";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, order.getUser().getid_utente());
            ps.setLong(i++, order.getProduct().getid_prod());
            ps.setLong(i++, order.getQuantity());
            ps.setString(i++, order.getStatus());
            ps.setTimestamp(i++, order.getTimestamp());
            ps.setBigDecimal(i++, order.getTotalAmount());

            ps.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return order;
    }

    @Override
    public List<Order> findOrders(Utente user) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM [order]"
                    + " WHERE "
                    + " deleted ='0' AND"
                    + " utente_id = ? "
                    + " ORDER BY timestamp DESC ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public List<Order> findBySingleOrder(Utente user, Timestamp timestamp) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM [order]"
                    + " WHERE "
                    + " deleted ='0' AND"
                    + " timestamp = ? AND"
                    + " utente_id = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public List<Order> findByOrderId(Utente user, Long orderId) {
        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {
            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM [order]"
                    + " WHERE "
                    + " deleted ='0' AND"
                    + " order_id = ? AND"
                    + " utente_id = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, orderId);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public void deleteOldOrders(Utente user, int months) {
        PreparedStatement ps;
        try {
            Long user_id = user.getid_utente();
            String sql = "DELETE FROM [order] "
                    + " WHERE deleted='0' AND utente_id = ? AND timestamp < DATEADD(month, -?, GETDATE())";
            ps = conn.prepareStatement(sql);
            ps.setLong(1, user_id);
            ps.setInt(2, months);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void updateStatus(Utente user, Long orderId, String status) {

        PreparedStatement ps;

        try {
            Long user_id = user.getid_utente();
            String sql
                    = " UPDATE [order] "
                    + " SET status = ?"
                    + " WHERE deleted ='0' AND order_id = ? AND utente_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, status);
            ps.setLong(i++, orderId);
            ps.setLong(i++, user_id);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Order read(ResultSet rs) {
        Order order = new Order();
        Utente user = new Utente();
        order.setUser(user);
        Prodotto prodotto = new Prodotto();
        order.setProduct(prodotto);

        try {
            order.setOrderId(rs.getLong("order_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.getUser().setid_utente(rs.getLong("utente_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.getProduct().setid_prod(rs.getLong("product_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.setQuantity(rs.getLong("quantity"));
        } catch (SQLException sqle) {
        }
        try {
            order.setStatus(rs.getString("status"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTimestamp(rs.getTimestamp("timestamp"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTotalAmount(rs.getBigDecimal("total_amount"));
        } catch (SQLException sqle) {
        }
        try {
            order.setDeleted(rs.getString("deleted").equals("1"));
        } catch (SQLException sqle) {
        }
        return order;
    }

    @Override
    public List<OrderDetail> findOrderDetailsJoin() {
        ArrayList<OrderDetail> orderDetails = new ArrayList();

        try {
            String sql = "SELECT o.order_id, u.nome as user_name, u.email as user_email, "
                    + "p.nome as product_name, o.quantity, p.prezzo as unit_price, "
                    + "o.total_amount, o.timestamp, o.status "
                    + "FROM [order] o "
                    + "INNER JOIN utente u ON o.utente_id = u.id_utente "
                    + "INNER JOIN prodotto p ON o.product_id = p.id_prod "
                    + "WHERE o.deleted = '0' "
                    + "ORDER BY o.timestamp DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail od = new OrderDetail(
                        rs.getLong("order_id"),
                        rs.getString("user_name"),
                        rs.getString("user_email"),
                        rs.getString("product_name"),
                        rs.getLong("quantity"),
                        rs.getBigDecimal("unit_price"),
                        rs.getBigDecimal("total_amount"),
                        rs.getTimestamp("timestamp"),
                        rs.getString("status")
                );
                orderDetails.add(od);
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return orderDetails;
    }
}
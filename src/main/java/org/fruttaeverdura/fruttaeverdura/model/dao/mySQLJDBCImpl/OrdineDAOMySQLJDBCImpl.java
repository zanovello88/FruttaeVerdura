package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.OrdineDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Ordine;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAOMySQLJDBCImpl implements OrdineDAO {
    Connection conn;
    public OrdineDAOMySQLJDBCImpl(Connection conn){this.conn = conn;}
    @Override
    public Ordine create(
            //Long id_ordine,
            Timestamp data_ordine,
            String stato_ordine,
            //boolean deleted_ordine,
            boolean consegnato,
            String indirizzo_o,
            String stato_o,
            String citta_o,
            Long cap_o)throws DuplicatedObjectException, DataTruncationException{
        PreparedStatement ps;
        Ordine order = new Ordine();
        order.setdata_ordine(data_ordine);
        order.setstato_ordine(stato_ordine);
        order.setconsegnato(consegnato);
        order.setindirizzo_o(indirizzo_o);
        order.setstato_o(stato_o);
        order.setcitta_o(citta_o);
        order.setcap_o(cap_o);

        try {

            String sql
                    = " SELECT * "
                    + " FROM ordine "
                    + " WHERE "
                    + " data_ordine = ? AND"
                    + " stato_ordine = ? AND"
                    + " consegnato = ? AND"
                    + " indirizzo_o = ? AND"
                    + " stato_o = ? AND"
                    + " citta_o = ? AND"
                    + " cap_o = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setTimestamp(i++, order.getdata_ordine());
            ps.setString(i++, order.getstato_ordine());
            ps.setBoolean(i++, order.isconsegnato());
            ps.setString(i++, order.getindirizzo_o());
            ps.setString(i++, order.getstato_o());
            ps.setString(i++, order.getcitta_o());
            ps.setLong(i++, order.getcap_o());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_id_ordine = null;
            exist = resultSet.next();

            // leggo deleted e id_ordine solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_id_ordine = resultSet.getLong("id_ordine");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("OrdineDAOJDBCImpl.create: Tentativo di inserimento di un ordine già esistente.");
            }

            if (exist && deleted){
                sql
                        = " UPDATE ordine "
                        + " SET deleted = 'N' "
                        + " WHERE id_ordine = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_id_ordine);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO ordine "
                        + "     (data_ordine,"
                        + "     stato_ordine,"
                        + "     consegnato,"
                        + "     indirizzo_o,"
                        + "     stato_o,"
                        + "     citta_o,"
                        + "     cap_o"
                        + "   ) "
                        + " VALUES (?,?,?,?,?,?,?)";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setTimestamp(i++, order.getdata_ordine());
                ps.setString(i++, order.getstato_ordine());
                ps.setBoolean(i++, order.isconsegnato());
                ps.setString(i++, order.getindirizzo_o());
                ps.setString(i++, order.getstato_o());
                ps.setString(i++, order.getcitta_o());
                ps.setLong(i++, order.getcap_o());


                try {
                    ps.executeUpdate();
                } catch(SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return order;
    }
    @Override
    public void update(Ordine order) throws DuplicatedObjectException{
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void delete(Ordine order) {
        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE ordine "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " id_ordine=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, order.getid_ordine());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public List<Ordine> findOrders(Utente user) {

        PreparedStatement ps;
        Ordine order;
        ArrayList<Ordine> order_tuples = new ArrayList<Ordine>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " Id_user = ? "
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
    public List<Ordine> findBySingleOrder(Utente user, Timestamp timestamp) {

        PreparedStatement ps;
        Ordine order;
        ArrayList<Ordine> order_tuples = new ArrayList<Ordine>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " user_id = ? ";

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
    public void updateStatus(Utente user, Timestamp timestamp, String status) {

        PreparedStatement ps;
        Ordine order;
        ArrayList<Ordine> order_tuples = new ArrayList<Ordine>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " Id_user = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();

            sql
                    = " UPDATE `order` "
                    + " SET "
                    + " status = ?"
                    + " WHERE "
                    + " deleted ='N' AND"
                    + " timestamp = ? AND"
                    + " Id_user = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, status);
            ps.setTimestamp(i++, timestamp);
            ps.setLong(i++, user_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    Ordine read(ResultSet rs) {

        Ordine order = new Ordine();
        try {
            order.setdata_ordine(rs.getTimestamp("data_ordine"));
        } catch (SQLException sqle) {
        }
        try {
            order.setstato_ordine(rs.getString("stato_ordine"));
        } catch (SQLException sqle) {
        }
        try {
            order.setdeleted_ordine(rs.getBoolean("deleted_order"));
        } catch (SQLException sqle) {
        }
        try {
            order.setconsegnato(rs.getBoolean("consegnato"));
        } catch (SQLException sqle) {
        }
        try {
            order.setindirizzo_o(rs.getString("indirizzo_o"));
        } catch (SQLException sqle) {
        }
        try {
            order.setstato_o(rs.getString("stato_o"));
        } catch (SQLException sqle) {
        }
        try {
            order.setcitta_o(rs.getString("citta_o"));
        } catch (SQLException sqle) {
        }
        try {
            order.setcap_o(rs.getLong("cap_o"));
        } catch (SQLException sqle) {
        }

        return order;
    }
}

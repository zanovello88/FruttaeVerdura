package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.CarrelloDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Carrello;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;

import java.math.BigDecimal;
import java.sql.*;

public class CarrelloDAOMySQLJDBCImpl implements CarrelloDAO {
    Connection conn;
    public CarrelloDAOMySQLJDBCImpl(Connection conn){this.conn = conn;}
    @Override
    public Carrello create(
            Long id_carrello,
            String stato_carrello,
            Timestamp data_creazione,
            BigDecimal totale,
            boolean deleted_car) throws DuplicatedObjectException, DataTruncationException {

        PreparedStatement ps;
        Carrello ca = new Carrello();
        ca.setid_carrello(id_carrello);
        ca.setstato_carrello(stato_carrello);
        ca.setdata_creazione(data_creazione);
        ca.settotale(totale);
        ca.setdeleted_car(deleted_car);

        try {

            String sql
                    = " SELECT * "
                    + " FROM carrello "
                    + " WHERE "
                    + " id_carrello = ? AND"
                    + " stato_carrello = ? AND"
                    + " data_creazione = ? AND"
                    + " totale = ? AND"
                    + " deleted_car = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, ca.getid_carrello());
            ps.setString(i++, ca.getstato_carrello());
            ps.setTimestamp(i++, ca.getdata_creazione());
            ps.setBigDecimal(i++, ca.gettotale());
            ps.setBoolean(i++, ca.isdeleted_car());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_id_carrello = null;
            exist = resultSet.next();

            // leggo deleted e id_carrello solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("deleted").equals("Y");
                retrived_id_carrello = resultSet.getLong("id_carrello");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("CarrelloDAOJDBCImpl.create: Tentativo di inserimento di un carrello già esistente.");
            }

            if (exist && deleted){
                sql
                        = " UPDATE carrello "
                        + " SET deleted = 'N' "
                        + " WHERE id_carrello = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_id_carrello);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO carrello "
                        + "     (id_carrello,"
                        + "     stato_carrello,"
                        + "     data_creazione,"
                        + "     totale,"
                        + "     deleted_car"
                        + "   ) "
                        + " VALUES (?,?,?,?,'N')";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, ca.getid_carrello());
                ps.setString(i++, ca.getstato_carrello());
                ps.setTimestamp(i++, ca.getdata_creazione());
                ps.setBigDecimal(i++, ca.gettotale());
                ps.setBoolean(i++, ca.isdeleted_car());

                try {
                    ps.executeUpdate();
                } catch(SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return ca;
    }
    @Override
    public void update(Carrello ca) throws DuplicatedObjectException{
        throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public void delete(Carrello ca) {
        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE carrello "
                    + " SET deleted='Y' "
                    + " WHERE "
                    + " id_carrello=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, ca.getid_carrello());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    Carrello read(ResultSet rs) {

        Carrello ca = new Carrello();
        try {
            ca.setid_carrello(rs.getLong("id_carrello"));
        } catch (SQLException sqle) {
        }
        try {
            ca.setstato_carrello(rs.getString("stato_carrello"));
        } catch (SQLException sqle) {
        }
        try {
            ca.setdata_creazione(rs.getTimestamp("data_creazione"));
        } catch (SQLException sqle) {
        }
        try {
            ca.settotale(rs.getBigDecimal("totale"));
        } catch (SQLException sqle) {
        }
        try {
            ca.setdeleted_car(rs.getBoolean("deleted_car"));
        } catch (SQLException sqle) {
        }

        return ca;
    }
}

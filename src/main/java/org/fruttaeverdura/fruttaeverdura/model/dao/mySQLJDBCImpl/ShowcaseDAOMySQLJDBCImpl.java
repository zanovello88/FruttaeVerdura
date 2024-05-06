package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;
import java.util.ArrayList;

import org.fruttaeverdura.fruttaeverdura.model.mo.Showcase;
import org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.dao.ShowcaseDAO;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

public class ShowcaseDAOMySQLJDBCImpl implements ShowcaseDAO {
    Connection conn;

    public ShowcaseDAOMySQLJDBCImpl(Connection conn) { this.conn = conn; }

    @Override
    public Showcase create(Long id_prod) throws DuplicatedObjectException {

        PreparedStatement ps;
        Showcase showcase = new Showcase();
        showcase.setId_prod(id_prod);
        String sql;

        try {
            sql
                    = " SELECT COUNT(*)num "
                    + " FROM showcase "
                    + " WHERE deleted = '0' ";
            ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            int conta = 0;

            if (rs.next()){
                conta = rs.getInt("num");
            }
            rs.close();

            if(conta >= 3){
                throw new RuntimeException("Limite showcase raggiunto.");
            }

            sql
                    = " SELECT * "
                    + " FROM showcase "
                    + " WHERE "
                    + " id_prod = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, showcase.getId_prod());
            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_showcase_id = null;
            exist = resultSet.next();
            if (exist) {
                deleted = resultSet.getString("deleted").equals("1");
                retrived_showcase_id = resultSet.getLong("idshowcase");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("ShowcaseDAOJDBCImpl.create: Tentativo di inserimento di un prodotto già in vetrina.");
            }

            if (exist && deleted) {
                sql
                        = " UPDATE showcase "
                        + " SET deleted = '0' "
                        + " WHERE idshowcase = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_showcase_id);
                ps.executeUpdate();
            } else {
                sql
                        = " INSERT INTO showcase "
                        + " (id_prod, "
                        + " deleted) "
                        + " VALUES (?,'0')";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, showcase.getId_prod());
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return showcase;
    }

    @Override
    public List<Showcase> findAll() {

        PreparedStatement ps;
        Showcase showcase;
        ArrayList<Showcase> showcases = new ArrayList<Showcase>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM showcase"
                    + " WHERE "
                    + " deleted ='0'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                showcase = read(resultSet);
                showcases.add(showcase);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return showcases;
    }

    @Override
    public void delete(Prodotto prodotto) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE showcase "
                    + " SET deleted='1' "
                    + " WHERE "
                    + " id_prod=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, prodotto.getid_prod());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    Showcase read(ResultSet rs) {
        Showcase showcase = new Showcase();
        try {
            showcase.setShowcaseId(rs.getLong("idshowcase"));
        } catch (SQLException sqle) {
        }
        try {
            showcase.setId_prod(rs.getLong("id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            showcase.setDeleted(rs.getString("deleted").equals("1"));
        } catch (SQLException sqle) {
        }
        return showcase;
    }
}

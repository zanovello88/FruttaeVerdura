package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import java.math.BigDecimal;
import java.security.Permission;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

public class ProdottoDAOMySQLJDBCImpl implements ProdottoDAO {
    Connection conn;

    public ProdottoDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Prodotto create(
            //Long id_prod
            String nome_prod,
            String sede_acquisto,
            String descrizione,
            BigDecimal prezzo,
            int quantita_disponibile,
            String categoria,
            //boolean deleted_prod
            //boolean blocked,
            String img_path) throws DuplicatedObjectException, DataTruncationException {

        PreparedStatement ps;
        Prodotto prod = new Prodotto();
        prod.setnome_prod(nome_prod);
        prod.setsede_acquisto(sede_acquisto);
        prod.setdescrizione(descrizione);
        prod.setprezzo(prezzo);
        prod.setquantita_disponibile(quantita_disponibile);
        prod.setcategoria(categoria);
        //prod.setblocked_prod(blocked);
        prod.setimg_path(img_path);

        try {

            String sql
                    = " SELECT * "
                    + " FROM prodotto "
                    + " WHERE "
                    + " Nome = ? AND"
                    + " Sede_acquisto = ? AND"
                    + " Descrizione = ? AND"
                    + " Prezzo = ? AND"
                    + " Quantità_disp = ? AND "
                    + " Categoria = ? AND "
                    + " img_path = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, prod.getnome_prod());
            ps.setString(i++, prod.getsede_acquisto());
            ps.setString(i++, prod.getdescrizione());
            ps.setBigDecimal(i++, prod.getprezzo());
            ps.setInt(i++, prod.getquantita_disponibile());
            ps.setString(i++, prod.getcategoria());
            //ps.setBoolean(i++, prod.isblocked_prod());
            ps.setString(i++, prod.getimg_path());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_prod_id = null;
            exist = resultSet.next();

            // leggo deleted e prod_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("Deleted").equals("1");
                retrived_prod_id = resultSet.getLong("Id_prod");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("ProdottoDAOJDBCImpl.create: Tentativo di inserimento di un prodotto già esistente.");
            }

            if (exist && deleted){
                sql
                        = " UPDATE prodotto "
                        + " SET Deleted = '0' "
                        + " WHERE Id_prod = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_prod_id);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO prodotto "
                        + "     (Nome,"
                        + "     Sede_acquisto,"
                        + "     Descrizione,"
                        + "     Prezzo,"
                        + "     Quantità_disp,"
                        + "     Categoria,"
                        + "     img_path "
                        + "   ) "
                        + " VALUES (?,?,?,?,?,?,?)";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, prod.getnome_prod());
                ps.setString(i++, prod.getsede_acquisto());
                ps.setString(i++, prod.getdescrizione());
                ps.setBigDecimal(i++, prod.getprezzo());
                ps.setInt(i++, prod.getquantita_disponibile());
                ps.setString(i++, prod.getcategoria());
                ps.setString(i++, prod.getimg_path());

                try {
                    ps.executeUpdate();
                } catch(SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }
    @Override
    public void modify(Prodotto prodotto) throws DuplicatedObjectException, DataTruncationException {
        PreparedStatement ps;
        try {

            String sql
                    = " SELECT Id_prod "
                    + " FROM prodotto "
                    + " WHERE "
//                    + " deleted ='N' AND "
                    + " Nome = ? AND"
                    + " Sede_acquisto = ? AND"
                    + " Descrizione = ? AND"
                    + " Prezzo = ? AND"
                    + " Quantità_disp = ? AND "
                    + " Categoria = ? AND "
                    + " img_path = ? AND "
                    + " Id_prod <> ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, prodotto.getnome_prod());
            ps.setString(i++, prodotto.getsede_acquisto());
            ps.setString(i++, prodotto.getdescrizione());
            ps.setBigDecimal(i++, prodotto.getprezzo());
            ps.setInt(i++, prodotto.getquantita_disponibile());
            ps.setString(i++, prodotto.getcategoria());
            ps.setString(i++, prodotto.getimg_path());
            ps.setLong(i++, prodotto.getid_prod());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_id_prod = null;
            exist = resultSet.next();

            // leggo deleted e id_prod solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("Deleted").equals("1");
                retrived_id_prod = resultSet.getLong("Id_prod");
            }

            if (exist) {
                throw new DuplicatedObjectException("ProdottoDAOJDBCImpl.create: Un prodotto con queste caratteristiche e' gia presente nel db.");
            }

            if (exist && deleted){
                sql = "update prodotto set Deleted='0' where Id_prod=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_id_prod);
                ps.executeUpdate();
            }

            sql
                    = " UPDATE prodotto "
                    + " SET "
                    + " Nome = ?,"
                    + " Sede_acquisto = ?,"
                    + " Descrizione = ? ,"
                    + " Prezzo = ? ,"
                    + " Quantità_disp = ? , "
                    + " Categoria = ? , "
                    + " img_path = ? "
                    + " WHERE "
                    + " Id_prod = ? ";


            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setString(i++, prodotto.getnome_prod());
            ps.setString(i++, prodotto.getsede_acquisto());
            ps.setString(i++, prodotto.getdescrizione());
            ps.setBigDecimal(i++, prodotto.getprezzo());
            ps.setInt(i++, prodotto.getquantita_disponibile());
            ps.setString(i++, prodotto.getcategoria());
            ps.setString(i++, prodotto.getimg_path());
            ps.setLong(i++, prodotto.getid_prod());

            try {
                ps.executeUpdate();
            } catch(SQLException e) {
                throw new DataTruncationException("Importo massimo consentito: sei cifre intere e due decimali.");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void updateAvalaibility(Long id_prod, int quantita_disponibile) {
        PreparedStatement ps;
        try {

            Prodotto prod = null;
            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "Id_prod = ? AND "
                    + "Deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_prod);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                prod = read(resultSet);
            }
            resultSet.close();

            sql
                    = " UPDATE prodotto "
                    + " SET "
                    + " Quantità_disp = ? "
                    + " WHERE "
                    + " Id_prod = ? ";

            int i = 1;
            ps = conn.prepareStatement(sql);
            ps.setInt(i++, prod.getquantita_disponibile() - quantita_disponibile);
            ps.setLong(i++, id_prod);

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void delete(Prodotto prod) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE prodotto "
                    + " SET deleted='1' "
                    + " WHERE "
                    + " Id_prod=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, prod.getid_prod());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public Prodotto findByProdId(Long id_prod) {

        PreparedStatement ps;
        Prodotto prod = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "Id_prod = ? AND "
                    + "Deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_prod);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                prod = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }
    @Override
    public List<Prodotto> findByName(String name) {

        PreparedStatement ps;
        Prodotto prod;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();
        name = "%" + name + "%";

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "nome LIKE ? AND "
                    + "deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, name);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                prod = read(resultSet);
                products.add(prod);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }
    @Override
    public List<Prodotto> findAll() {

        PreparedStatement ps;
        Prodotto product;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto"
                    + " WHERE "
                    + " deleted ='0'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                product = read(resultSet);
                products.add(product);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }
    Prodotto read(ResultSet rs) {
        Prodotto prod = new Prodotto();
        try {
            prod.setid_prod(rs.getLong("Id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setnome_prod(rs.getString("Nome"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setsede_acquisto(rs.getString("sede_acquisto"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setdescrizione(rs.getString("descrizione"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setprezzo(rs.getBigDecimal("prezzo"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setquantita_disponibile(rs.getInt("quantità_disp"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setcategoria(rs.getString("categoria"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setdeleted_prod(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setblocked_prod(rs.getBoolean("blocked"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setimg_path(rs.getString("img_path"));
        } catch (SQLException sqle) {
        }
        return prod;
    }
}

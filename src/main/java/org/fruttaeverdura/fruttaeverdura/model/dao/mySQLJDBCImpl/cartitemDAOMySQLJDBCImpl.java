package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.cartitemDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Carrello;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import org.fruttaeverdura.fruttaeverdura.model.mo.cartitem;
import org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.CarrelloDAO;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class cartitemDAOMySQLJDBCImpl implements cartitemDAO{
    Connection conn;

    public cartitemDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }
    @Override
    public cartitem create(
            int quantita,
            Prodotto prod,
            Carrello ca)throws DuplicatedObjectException, DataTruncationException{
        PreparedStatement ps;
        cartitem car = new cartitem();
        car.setquantita(quantita);
        car.setprodotto(prod);
        car.setcarrello(ca);

        //controllo se esiste gia' una tupla con id_prod e id_user
        try {

            String sql
                    = " SELECT * "
                    + " FROM cartitem "
                    + " WHERE "
                    + " deleted ='N' AND "
                    + " id_utente = ? AND"
                    + " id_prod = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, car.getcarrello().getid_carrello());
            ps.setLong(i++, car.getprodotto().getid_prod());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            Long oldquantity = null;
            Long existing_id_cartitem = null;
            exist = resultSet.next();
            if (exist){
                existing_id_cartitem = (resultSet.getLong("id_cartitem"));
                oldquantity = (resultSet.getLong("quantity"));
            }

            resultSet.close();

            if (exist) {
                try{
                    Long newquantity = oldquantity + 1;
                    sql
                            = " UPDATE cartitem "
                            + " SET "
                            + " quantity = ?"
                            + " WHERE "
                            + "   id_cartitem = ? ";

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, newquantity);
                    ps.setLong(i++, existing_id_cartitem);

                    ps.executeUpdate();

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                throw new DuplicatedObjectException("CartitemDAOJDBCImpl.create: Tentativo di creazione di un oggetto nel carrello gia esistente");
            }
            sql
                    = " INSERT INTO cartitem "
                    + "     (id_carrello,"
                    + "     id_prod,"
                    + "     quantita,"
                    + "     deleted "
                    + "   ) "
                    + " VALUES (?,?,1,'N')";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, car.getcarrello().getid_carrello());
            ps.setLong(i++, car.getprodotto().getid_prod());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return car;

    }
    @Override
    public void update(cartitem car){
        throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public void delete(cartitem car) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    cartitem read(ResultSet rs) {
        cartitem car = new cartitem();
        Carrello ca = new Carrello();
        car.setcarrello(ca);
        Prodotto prod = new Prodotto();
        car.setprodotto(prod);

        try {
            car.getcarrello().setid_carrello(rs.getLong("id_carrello"));
        } catch (SQLException sqle) {
        }
        try {
            car.getprodotto().setid_prod(rs.getLong("id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            car.setquantita(rs.getInt("quantita"));
        } catch (SQLException sqle) {
        }
        try {
            car.setdeleted_cartitem(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        return car;
    }

}

package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import org.fruttaeverdura.fruttaeverdura.model.dao.CartDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Cart;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOMySQLJDBCImpl implements CartDAO {
    Connection conn;

    public CartDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Cart create(
            Utente user,
            Prodotto prodotto, long quantity) throws DuplicatedObjectException {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);
        cart.setQuantity(quantity);

        //controllo se esiste gia' una tupla con prod_id e user_id
        try {

            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='0' AND "
                    + " user_id = ? AND"
                    + " prod_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getid_utente());
            ps.setLong(i++, cart.getProdotto().getid_prod());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            Long oldquantity = null;
            Long existing_cart_id = null;
            exist = resultSet.next();
            if (exist){
                existing_cart_id = (resultSet.getLong("cart_id"));
                oldquantity = (resultSet.getLong("quantity"));
            }

            resultSet.close();

            if (exist) {
                try{
                    Long newquantity = oldquantity + 1;
                    sql
                            = " UPDATE cart "
                            + " SET "
                            + " quantity = ?"
                            + " WHERE "
                            + "   cart_id = ? ";

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, newquantity);
                    ps.setLong(i++, existing_cart_id);

                    ps.executeUpdate();

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                throw new DuplicatedObjectException("CartDAOJDBCImpl.create: Tentativo di creazione di un oggetto nel carrello gia esistente");
            }
            sql
                    = " INSERT INTO cart "
                    + "     (user_id,"
                    + "     prod_id,"
                    + "     quantity,"
                    + "     deleted "
                    + "   ) "
                    + " VALUES (?,?,1,'0')";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, cart.getUser().getid_utente());
            ps.setLong(i++, cart.getProdotto().getid_prod());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;

    }

    @Override
    public Cart remove(
            Utente user,
            Prodotto prodotto) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);

        try {

            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='0' AND "
                    + " user_id = ? AND"
                    + " prod_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getid_utente());
            ps.setLong(i++, cart.getProdotto().getid_prod());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long oldquantity = (resultSet.getLong("quantity"));
            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            Long newquantity = oldquantity - 1;
            // se newquantity è = a 0 allora elimino la tupla, altrimenti la aggiorno

            if(newquantity==0) {

                //elimino la tupla , setto anche la quantità = 0
                sql
                        = " UPDATE cart "
                        + " SET "
                        + " deleted = '1', "
                        + " quantity = 0"
                        + " WHERE "
                        + "   cart_id = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, existing_cart_id);

                ps.executeUpdate();
            }

            //aggiorno la tupla con la nuova quantità
            sql
                    = " UPDATE cart "
                    + " SET "
                    + " quantity = ?"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, newquantity);
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    public Cart removeBlock(
            Utente user,
            Prodotto prodotto) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);

        try {

            // recupero il cart_id
            String sql
                    = " SELECT * "
                    + " FROM cart "
                    + " WHERE "
                    + " deleted ='0' AND "
                    + " user_id = ? AND"
                    + " prod_id = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getid_utente());
            ps.setLong(i++, cart.getProdotto().getid_prod());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            //elimino la tupla , setto anche la quantità = 0
            sql
                    = " UPDATE cart "
                    + " SET "
                    + " deleted = '1', "
                    + " quantity = 0"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    @Override
    public List<Cart> findCart(Utente user) {

        PreparedStatement ps;
        Cart cart;
        ArrayList<Cart> carts = new ArrayList<Cart>();

        try {

            Long user_id = user.getid_utente();
            String sql
                    = " SELECT *"
                    + " FROM cart"
                    + " WHERE "
                    + " deleted ='0' AND"
                    + " user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                cart = read(resultSet);
                carts.add(cart);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return carts;
    }

    @Override
    public void deleteCart( Utente user ) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);

        try {


            //elimino le tuple con user_id corretto, setto anche la quantità = 0
            String sql
                    = " UPDATE cart "
                    + " SET "
                    + " deleted = '1', "
                    + " quantity = 0"
                    + " WHERE "
                    + "   user_id = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user.getid_utente());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Cart read(ResultSet rs) {
        Cart cart = new Cart();
        Utente user = new Utente();
        cart.setUser(user);
        Prodotto prodotto = new Prodotto();
        cart.setProdotto(prodotto);

        try {
            cart.setCartId(rs.getLong("cart_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getUser().setid_utente(rs.getLong("user_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getProdotto().setid_prod(rs.getLong("prod_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setQuantity(rs.getLong("quantity"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setDeleted(rs.getString("deleted").equals("1"));
        } catch (SQLException sqle) {
        }
        return cart;
    }
}
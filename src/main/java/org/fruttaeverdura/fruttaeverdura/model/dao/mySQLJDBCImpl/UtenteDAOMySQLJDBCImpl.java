package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.dao.UtenteDAO;

public class UtenteDAOMySQLJDBCImpl implements UtenteDAO {
    Connection conn;

    public UtenteDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Utente create(
            Long id_utente,
            String username,
            String email,
            String password,
            String nome,
            String cognome,
            String indirizzo,
            String stato,
            String citta,
            Long cap,
            String admin,
            String blocked,
            String card_n,
            Long cvc,
            String exp_date
            /*boolean deleted*/) throws DuplicatedObjectException/*MysqlDataTruncation*/{

        PreparedStatement ps;
        Utente user = new Utente();
        user.setUsername(username);
        user.setPassword(password);
        user.setemail(email);
        user.setNome(nome);
        user.setCognome(cognome);


        try {
            //controllo se USERNAME esiste già in una tupla
            String sql
                    = " SELECT * "
                    + " FROM utente "
                    + " WHERE "
                    + " Username = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, user.getUsername());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;

            exist = resultSet.next();
            //se esiste
            if (exist) {
                deleted = resultSet.getString("Username").equals(user.getUsername());
            }

            resultSet.close();
            if(exist && deleted) {
                throw new DuplicatedObjectException("UserDAOJDBCImpl.create: Tentativo di inserimento di un username già esistente.");
            }
            else {
                sql
                        = " INSERT INTO utente "
                        + "     (Nome,"
                        + "     Cognome,"
                        + "     Email,"
                        + "     Password,"
                        + "     Admin,"
                        + "     Deleted,"
                        + "     Indirizzo,"
                        + "     Stato,"
                        + "     Città,"
                        + "     Blocked,"
                        + "     CAP,"
                        + "     Username,"
                        + "     card_n,"
                        + "     cvc,"
                        + "     exp_date "
                        + "   ) "
                        + " VALUES (?,?,?,?,'N','N','/','/','/','N',0,?,'mancante',0,'mancante')";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, user.getNome());
                ps.setString(i++, user.getCognome());
                ps.setString(i++, user.getemail());
                ps.setString(i++, user.getPassword());
                ps.setString(i++, user.getUsername());

                ps.executeUpdate();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    @Override
    public void update(Utente user) throws DuplicatedObjectException {

        PreparedStatement ps;
        String sql;
        try {
            // controllo solo sull'username, il resto non mi interessa
            // controllo se l'username (modificato) è già presente in una tupla
            sql
                    = " SELECT COUNT(*)Username "
                    + " FROM utente "
                    + " WHERE "
                    + " Id_utente != ? AND "
                    + " Username = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user.getid_utente());
            ps.setString(i++, user.getUsername());

            ResultSet resultSet = ps.executeQuery();
            int count = 0;

            if(resultSet.next()){
                count = resultSet.getInt(1);
            }

            resultSet.close();
            if(count != 0) {
                throw new DuplicatedObjectException("UtenteDAOJDBCImpl.create: Tentativo di inserimento di un username già esistente.");
            }
            else {
                //se non esiste prosegui con modifica
                sql
                        = " UPDATE utente "
                        + " SET "
                        + " Nome = ? , "
                        + " Cognome = ? , "
                        + " Email = ? ,"
                        + " Password = ? ,"
                        + " Indirizzo = ? , "
                        + " Città = ? , "
                        + " CAP = ? , "
                        + " Username = ? ,"
                        + " card_n = ? , "
                        + " cvc = ? , "
                        + " exp_date = ? "
                        + " WHERE "
                        + " Id_utente = ?";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, user.getNome());
                ps.setString(i++, user.getCognome());
                ps.setString(i++, user.getemail());
                ps.setString(i++, user.getPassword());
                ps.setString(i++, user.getindirizzo());
                ps.setString(i++, user.getcitta());
                ps.setLong(i++, user.getcap());
                ps.setString(i++, user.getUsername());
                ps.setString(i++, user.getCard_n());
                ps.setLong(i++, user.getCvc());
                ps.setString(i++, user.getExp_date());
                ps.setLong(i++, user.getid_utente());

                ps.executeUpdate();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void delete(Utente user) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE utente "
                    + " SET Deleted='Y' "
                    + " WHERE "
                    + " Id_utente=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getid_utente());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public Utente findLoggedUser() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
    @Override
    public List<Utente> searchByUsername(String username) {

        PreparedStatement ps;
        Utente user;
        ArrayList<Utente> users = new ArrayList<Utente>();

        try {

            String sql
                    = "SELECT * "
                    + "FROM utente "
                    + "WHERE "
                    + "Username=? AND "
                    + "Deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
                users.add(user);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return users;
    }

    @Override
    public Utente findByUsername(String username) {

        PreparedStatement ps;
        Utente user = null;

        try {

            String sql
                    = " SELECT * "
                    + "   FROM utente "
                    + " WHERE "
                    + "   Username = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;

    }
    @Override
    public List<Utente> findAll() {

        PreparedStatement ps;
        Utente user;
        ArrayList<Utente> users = new ArrayList<Utente>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM utente"
                    + " WHERE "
                    + " deleted ='N'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                user = read(resultSet);
                users.add(user);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }
    @Override
    public Utente findByUserId(Long user_id) {

        PreparedStatement ps;
        Utente user = null;

        try {

            String sql
                    = " SELECT * "
                    + " FROM utente "
                    + " WHERE "
                    + " Id_utente = ? AND "
                    + "Deleted = 'N'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user_id);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                user = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return user;
    }
    @Override
    public void setAdminStatusOn(Utente user) {

        PreparedStatement ps;
        try {

            String sql
                    = " UPDATE utente "
                    + " SET Admin='Y' "
                    + " WHERE "
                    + " Id_utente=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getid_utente());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void setAdminStatusOff(Utente user) {

        PreparedStatement ps;
        try {

            String sql
                    = " UPDATE utente "
                    + " SET Admin='N' "
                    + " WHERE "
                    + " Id_utente=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getid_utente());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void deleteSpedizione(Utente user) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE utente "
                    + " SET Città = null, "
                    + " CAP = null, "
                    + " Indirizzo = null "
                    + " WHERE Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getid_utente());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public void deleteCarta(Utente user) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE utente "
                    + " SET card_n = 'mancante', "
                    + " cvc = 0, "
                    + " exp_date = 'mancante' "
                    + " WHERE Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, user.getid_utente());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    Utente read(ResultSet rs) {

        Utente user = new Utente();
        try {
            user.setid_utente(rs.getLong("Id_utente"));
        } catch (SQLException sqle) {
        }
        try {
            user.setNome(rs.getString("Nome"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCognome(rs.getString("Cognome"));
        } catch (SQLException sqle) {
        }
        try {
            user.setemail(rs.getString("Email"));
        } catch (SQLException sqle) {
        }
        try {
            user.setPassword(rs.getString("Password"));
        } catch (SQLException sqle) {
        }
        try {
            user.setAdmin(rs.getString("Admin"));
        } catch (SQLException sqle) {
        }
        try {
            user.setDeleted(rs.getString("Deleted"));
        } catch (SQLException sqle) {
        }
        try {
            user.setindirizzo(rs.getString("Indirizzo"));
        } catch (SQLException sqle) {
        }
        try {
            user.setstato(rs.getString("Stato"));
        } catch (SQLException sqle) {
        }
        try {
            user.setcitta(rs.getString("Città"));
        } catch (SQLException sqle) {
        }
        try {
            user.setBlocked(rs.getString("Blocked"));
        } catch (SQLException sqle) {
        }
        try {
            user.setcap(rs.getLong("CAP"));
        } catch (SQLException sqle) {
        }
        try {
            user.setUsername(rs.getString("Username"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCard_n(rs.getString("card_n"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCvc(rs.getLong("cvc"));
        } catch (SQLException sqle) {
        }
        try {
            user.setExp_date(rs.getString("exp_date"));
        } catch (SQLException sqle) {
        }
        return user;
    }
}
package org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.lang.Object;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.dao.CarrelloDAO;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.dao.UtenteDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO;

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
            String blocked
            /*boolean deleted*/) throws DuplicatedObjectException{

        PreparedStatement ps;
        Utente user = new Utente();
        user.setNome(nome);
        user.setCognome(cognome);
        user.setemail(email);
        user.setPassword(password);
        user.setUsername(username);

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
                throw new DuplicatedObjectException("UtenteDAOJDBCImpl.create: Tentativo di inserimento di un username già esistente.");
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
                        + "     Cap,"
                        + "     Username "
                        + "   ) "
                        + " VALUES (?,?,?,?,'N','N','/','/','/','N',1, ?)";

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
                    + " user_id != ? AND "
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
                        + " Username = ? ,"
                        + " Email = ? ,"
                        + " Password = ? ,"
                        + " Nome = ? , "
                        + " Cognome = ? , "
                        + " Indirizzo = ? , "
                        + " Stato = ? , "
                        + " Citta = ? , "
                        + " Cap = ? , "
                        + " WHERE "
                        + " Id_utente = ?";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, user.getUsername());
                ps.setString(i++, user.getemail());
                ps.setString(i++, user.getPassword());
                ps.setString(i++, user.getNome());
                ps.setString(i++, user.getCognome());
                ps.setString(i++, user.getindirizzo());
                ps.setString(i++, user.getstato());
                ps.setString(i++, user.getcitta());
                ps.setLong(i++, user.getcap());
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
    Utente read(ResultSet rs) {

        Utente user = new Utente();
        try {
            user.setid_utente(rs.getLong("Id_utente"));
        } catch (SQLException sqle) {
        }
        try {
            user.setUsername(rs.getString("Username"));
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
            user.setNome(rs.getString("Nome"));
        } catch (SQLException sqle) {
        }
        try {
            user.setCognome(rs.getString("Cognome"));
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
            user.setcap(rs.getLong("CAP"));
        } catch (SQLException sqle) {
        }
        try {
            user.setAdmin(rs.getString("Admin"));
        } catch (SQLException sqle) {
        }
        try {
            user.setAdmin(rs.getString("Blocked"));
        } catch (SQLException sqle) {
        }
        return user;
    }
}
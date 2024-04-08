package org.fruttaeverdura.fruttaeverdura.model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;

import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
public interface UtenteDAO {

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
            boolean admin,
            boolean blocked
            /*bolean deleted*/)throws DuplicatedObjectException;
    public void update(Utente utente)throws DuplicatedObjectException;
    public void delete(Utente utente);
    public Utente findLoggedUser();
    public Utente findByUsername(String username);
    /*public Utente findByUserId(Long id_utente);
    public void setAdminStatusOn(User user);
    public void setAdminStatusOff(User user);*/
}

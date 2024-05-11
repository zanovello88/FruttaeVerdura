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
            String admin,
            String blocked,
            String card_n,
            Long cvc,
            String exp_date
            /*bolean deleted*/)throws DuplicatedObjectException;
    public void update(Utente utente)throws DuplicatedObjectException;
    public void delete(Utente utente);
    public Utente findLoggedUser();
    public Utente findByUsername(String username);

    List<Utente> searchByUsername(String username);

    public List<Utente> findAll();
    public Utente findByUserId(Long user_id);
    public void setAdminStatusOn(Utente user);
    public void setAdminStatusOff(Utente user);
    public void deleteSpedizione(Utente user);
    public void deleteCarta(Utente user);
}

package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Ordine;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;

import java.sql.Timestamp;

public interface OrdineDAO {
    public Ordine create(
            //Long id_ordine,
            Timestamp data_ordine,
            String stato_ordine,
            //boolean deleted_ordine,
            boolean consegnato,
            String indirizzo_o,
            String stato_o,
            String citta_o,
            Long cap_o
    )throws DuplicatedObjectException, DataTruncationException;
    public void update(Ordine ordine)throws DuplicatedObjectException;
    public void delete(Ordine ordine);
    /*public List<Order> findOrders(User user);
    public List<Order> findBySingleOrder(User user, Timestamp timestamp);
    public void updateStatus(User user, Timestamp timestamp, String status);*/
}

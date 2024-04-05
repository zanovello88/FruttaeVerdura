package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Carrello;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;

import java.math.BigDecimal;
import java.sql.Timestamp;

public interface CarrelloDAO {
    public Carrello create(
            Long id_carrello,
            String stato_carrello,
            Timestamp data_creazione,
            BigDecimal totale,
            boolean deleted_car
    )throws DuplicatedObjectException, DataTruncationException;
    public void update(Carrello carrello)throws DuplicatedObjectException;
    public void delete(Carrello carrello);
    /*implementa qui ulteriori metodi*/
}

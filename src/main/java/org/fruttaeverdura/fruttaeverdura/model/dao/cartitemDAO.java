package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Carrello;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.cartitem;

public interface cartitemDAO {
    public cartitem create(
            //Long id_cartitem
            int quantita,
            //boolean deleted_cartitem
            Prodotto prodotto,
            Carrello carrello
    )throws DuplicatedObjectException, DataTruncationException;
    public void update(cartitem car);
    public void delete(cartitem car);
    /*implementa qui ulteriori metodi*/
}

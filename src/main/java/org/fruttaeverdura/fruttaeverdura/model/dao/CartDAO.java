package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Cart;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

import java.util.List;

public interface CartDAO {

    public Cart create(
            Utente user,
            Prodotto prodotto,
            long quantity
    ) throws DuplicatedObjectException;

    public List<Cart> findCart(Utente user);

    public Cart remove(Utente user, Prodotto prodotto);

    public Cart removeBlock(Utente user, Prodotto prodotto);

    public void deleteCart(Utente user);
}

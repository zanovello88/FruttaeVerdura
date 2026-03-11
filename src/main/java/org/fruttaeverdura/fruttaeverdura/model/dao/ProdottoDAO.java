package org.fruttaeverdura.fruttaeverdura.model.dao;

import java.math.BigDecimal;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import java.util.List;

public interface ProdottoDAO {
    /**
     * Atomically decrements the available quantity of the given product by
     * the specified amount if enough stock exists.  Returns true on success,
     * false if insufficient quantity was available.  This operation should
     * be executed inside a database transaction to provide concurrency
     * protection.
     */
    public boolean reserveStock(Long prodId, int amount);
    Prodotto create(
            //Long id_prod,
            String nome_prod,
            String sede_acquisto,
            String descrizione,
            BigDecimal prezzo,
            int quantita_disponibile,
            String categoria,
            //boolean deleted_prod,
            //boolean blocked_prod,
            String img_path
    )throws DuplicatedObjectException, DataTruncationException;
    public void updateAvalaibility(Long id_prod, int quantita_disponibile);
    public void delete(Prodotto prodotto);
    public List<Prodotto> findAll();
    public Prodotto findByProdId(Long id_prod);

    public List<Prodotto> findByName(String nome_prod);
    public void modify(Prodotto prodotto)  throws DuplicatedObjectException, DataTruncationException;

}

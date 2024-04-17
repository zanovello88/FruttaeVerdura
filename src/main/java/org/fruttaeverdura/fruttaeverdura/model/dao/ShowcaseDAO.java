package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Showcase;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;

import java.util.List;

public interface ShowcaseDAO {

    public Showcase create(
            Long id_prod) throws DuplicatedObjectException;

    public List<Showcase> findAll();

    public void delete(Prodotto prodotto);
}

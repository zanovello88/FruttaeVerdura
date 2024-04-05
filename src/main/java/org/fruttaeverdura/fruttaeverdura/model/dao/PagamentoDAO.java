package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;

import java.math.BigDecimal;

public interface PagamentoDAO {
    public Pagamento create(
            //Long id_pagamento,
            String numero_carta,
            String scadenza,
            int cvv,
            BigDecimal importo,
            String nome_carta
    )throws DuplicatedObjectException, DataTruncationException;
    public void update(Pagamento pagamento)throws DuplicatedObjectException;
    public void delete(Pagamento pagamento);
    /*aggiungere in seguito ulteriori metodi*/
}

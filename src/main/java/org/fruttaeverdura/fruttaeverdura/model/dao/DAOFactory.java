package org.fruttaeverdura.fruttaeverdura.model.dao;

import org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl.MySQLJDBCDAOFactory;
import org.fruttaeverdura.fruttaeverdura.model.dao.CookieImpl.CookieDAOFactory;
import org.fruttaeverdura.fruttaeverdura.model.mo.Carrello;
import org.fruttaeverdura.fruttaeverdura.model.mo.Pagamento;

import java.util.Map;

public abstract class DAOFactory {
    // List of DAO types supported by the factory
    public static final String MYSQLJDBCIMPL = "MySQLJDBCImpl";
    public static final String COOKIEIMPL= "CookieImpl";

    public abstract void beginTransaction();
    public abstract void commitTransaction();
    public abstract void rollbackTransaction();
    public abstract void closeTransaction();

    /*Indicare per ogni mo creato*/
    public abstract UtenteDAO getUtenteDAO();
    public abstract ProdottoDAO getProdottoDAO();
    public abstract PagamentoDAO getPagamentoDAO();
    public abstract OrdineDAO getOrdineDAO();
    public abstract cartitemDAO getcartitemDAO();
    public abstract CarrelloDAO getCarrelloDAO();

    public static DAOFactory getDAOFactory(String whichFactory, Map factoryParameters) {

        if (whichFactory.equals(MYSQLJDBCIMPL)) {
            return new MySQLJDBCDAOFactory(factoryParameters);
        } else if (whichFactory.equals(COOKIEIMPL)) {
            return new CookieDAOFactory(factoryParameters);
        } else {
            return null;
        }
    }
}

package org.fruttaeverdura.fruttaeverdura.controller;

import org.fruttaeverdura.fruttaeverdura.model.dao.*;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.*;
import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class CheckoutManagement {

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;
        String viewUrl = "checkoutManagement/view";

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            cartRetrieve(daoFactory, sessionDAOFactory, request);

            List<Cart> carts = (List<Cart>) request.getAttribute("carts");
            for(int i = 0; i < carts.size(); i++) {
                if(carts.get(i).getQuantity() > carts.get(i).getProdotto().getquantita_disponibile()) {
                    applicationMessage = "Errore: la quantita' richiesta di " + carts.get(i).getProdotto().getnome_prod() + " eccede la quantita' disponibile in magazzino";
                    viewUrl = "cartManagement/view";
                }
            }

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("user", user);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }
    }

    public static void order(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Utente loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            OrderDAO orderDAO = daoFactory.getOrderDAO();

            cartRetrieve(daoFactory, sessionDAOFactory, request);
            List<Cart> carts = (List<Cart>) request.getAttribute("carts");

            Long user_id = loggedUser.getid_utente();
            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente current_user = userDAO.findByUserId(user_id);
            Date date = new Date();
            Timestamp ts = new Timestamp(date.getTime());

            BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");


            String status = "Processamento ordine";

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();

            for (int i = 0; i < carts.size(); i++) {

                long quantity = carts.get(i).getQuantity();

                //creo l'ordine
                orderDAO.create(
                        current_user,
                        carts.get(i).getProdotto(),
                        quantity,
                        status,
                        ts,
                        total_amount
                );

                //sottraggo dal db la quantita' di prodotti acquistati
                prodottoDAO.updateAvalaibility(carts.get(i).getProdotto().getid_prod(), (int) quantity);

            }

            //svuoto il carrello
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());
            CartDAO cartDAO = daoFactory.getCartDAO();
            cartDAO.deleteCart(user);

            applicationMessage = "Ordine effettuato. tieni d'occhio gli ordini effettuati nell'area utente.";

            productRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseProductRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }
    }

    private static void productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        ProdottoDAO ProdottoDAO = daoFactory.getProdottoDAO();
        products = ProdottoDAO.findAll();
        request.setAttribute("products", products);

    }

    private static void showcaseRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ShowcaseDAO showcaseDAO = daoFactory.getShowcaseDAO();
        List<Showcase> showcases;
        showcases = showcaseDAO.findAll();
        request.setAttribute("showcases", showcases);

    }

    private static void showcaseProductRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        showcaseRetrieve(daoFactory, sessionDAOFactory, request);

        List<Prodotto> products = new ArrayList<Prodotto>();

        try {
            List<Showcase> showcases = (List<Showcase>)request.getAttribute("showcases");
            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto;

            for(int i = 0; i < showcases.size(); i++) {

                prodotto = prodottoDAO.findByProdId(showcases.get(i).getId_prod());
                products.add(prodotto);
            }
        } catch(Exception e) {  }

        if(!products.isEmpty()) {
            request.setAttribute("showcase_products", products);
        }

    }

    private static void cartRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        Utente user = userDAO.findByUserId(loggedUser.getid_utente());

        CartDAO cartDAO = daoFactory.getCartDAO();
        List<Cart> carts;
        carts = cartDAO.findCart(user);

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        Prodotto prodotto = null;
        ArrayList<Prodotto> produts = new ArrayList<Prodotto>() ;

        BigDecimal total_amount = BigDecimal.ZERO;
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal shipping = BigDecimal.ZERO;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            prodotto=prodottoDAO.findByProdId(carts.get(i).getProdotto().getid_prod());
            Long quantity = carts.get(i).getQuantity();
            produts.add(prodotto);
            subtotal = subtotal.add(prodotto.getprezzo().multiply(new BigDecimal(quantity)));
            carts.get(i).setProdotto(prodotto);
        }

        total_amount = subtotal.multiply(new BigDecimal("1.10"));
        shipping = total_amount.subtract(subtotal);

        request.setAttribute("total_amount", total_amount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("carts", carts);
    }

}
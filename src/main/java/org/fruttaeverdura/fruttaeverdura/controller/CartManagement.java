package org.fruttaeverdura.fruttaeverdura.controller;

import  org.fruttaeverdura.fruttaeverdura.model.dao.*;
import  org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import  org.fruttaeverdura.fruttaeverdura.model.mo.*;
import  org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartManagement {

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;

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

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "cartManagement/view");

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

    public static void AddProduct(HttpServletRequest request, HttpServletResponse response) {

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

            Long id_prod = Long.parseLong(request.getParameter("id_prod"));
            String viewUrl = new String(request.getParameter("viewUrl"));

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto = prodottoDAO.findByProdId(id_prod);

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());

            CartDAO cartDAO = daoFactory.getCartDAO();
            try {

                cartDAO.create(
                        user,
                        prodotto,
                        1);

            } catch (DuplicatedObjectException e) {
                logger.log(Level.INFO, "Tentativo di inserimento di un nuovo prodotto gia presente nel carrello");
            }

            productRetrieve(daoFactory, sessionDAOFactory, request);
            cartRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseProductRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);


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

    public static void RemoveProduct(HttpServletRequest request, HttpServletResponse response) {

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

            Long id_prod = Long.parseLong(request.getParameter("id_prod"));
            String viewUrl = new String(request.getParameter("viewUrl"));

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto = prodottoDAO.findByProdId(id_prod);

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());

            CartDAO cartDAO = daoFactory.getCartDAO();

            //rimuovo
            cartDAO.remove(user, prodotto);

            productRetrieve(daoFactory, sessionDAOFactory, request);
            cartRetrieve(daoFactory, sessionDAOFactory, request);
            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);


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

    public static void RemoveProductBlock(HttpServletRequest request, HttpServletResponse response) {

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

            Long id_prod = Long.parseLong(request.getParameter("id_prod"));
            String viewUrl = new String(request.getParameter("viewUrl"));

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto = prodottoDAO.findByProdId(id_prod);

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());

            CartDAO cartDAO = daoFactory.getCartDAO();

            //rimuovo
            cartDAO.removeBlock(user, prodotto);

            productRetrieve(daoFactory, sessionDAOFactory, request);
            cartRetrieve(daoFactory, sessionDAOFactory, request);
            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);


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

    public static void DeleteCart(HttpServletRequest request, HttpServletResponse response) {

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

            String viewUrl = new String(request.getParameter("viewUrl"));

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getid_utente());

            CartDAO cartDAO = daoFactory.getCartDAO();

            //rimuovo
            cartDAO.deleteCart(user);


            productRetrieve(daoFactory, sessionDAOFactory, request);
            cartRetrieve(daoFactory, sessionDAOFactory, request);
            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);


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
        ArrayList<Prodotto> products = new ArrayList<Prodotto>() ;

        BigDecimal total_amount = BigDecimal.ZERO;
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal shipping = BigDecimal.ZERO;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            prodotto=prodottoDAO.findByProdId(carts.get(i).getProdotto().getid_prod());
            Long quantity = carts.get(i).getQuantity();
            products.add(prodotto);
            subtotal = subtotal.add(prodotto.getprezzo().multiply(new BigDecimal(quantity)));
            carts.get(i).setProdotto(prodotto);
        }

        //qui calcolo le spese di spedizione che consideriamo il 10% dell'ordine, moltiplico il totale per 1.10 e poi a questo sottraggo il costo del totale in modo da ottenere le spese di spedizione da mostrare a video
        total_amount = subtotal.multiply(new BigDecimal("1.10"));
        shipping = total_amount.subtract(subtotal);

        request.setAttribute("total_amount", total_amount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("carts", carts);
    }

    private static void productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        products = prodottoDAO.findAll();
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
            request.setAttribute("showcase_wines", products);
        }

    }

}

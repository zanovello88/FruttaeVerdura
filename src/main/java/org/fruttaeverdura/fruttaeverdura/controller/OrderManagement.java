package org.fruttaeverdura.fruttaeverdura.controller;

import org.fruttaeverdura.fruttaeverdura.model.dao.*;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.*;
import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.Date;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class OrderManagement {

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

            orderRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/view");

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

    public static void orderView(HttpServletRequest request, HttpServletResponse response) {

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

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            singleOrderRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/singleOrder");

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

    public static void setDelivered(HttpServletRequest request, HttpServletResponse response) {

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

            singleOrderRetrieve(daoFactory, sessionDAOFactory, request);
            String status = "Ordine consegnato";
            boolean setDeliveredSwitch = true;
            request.setAttribute("setDeliveredSwitch", setDeliveredSwitch);

            OrderDAO orderDAO = daoFactory.getOrderDAO();
            List<Order> order_tuples = (List<Order>)request.getAttribute("order_tuples");
            orderDAO.updateStatus(order_tuples.get(0).getUser(), order_tuples.get(0).getTimestamp(), status);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "orderManagement/view");

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

    private static void cartRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        Utente user = userDAO.findByUserId(loggedUser.getid_utente());

        CartDAO cartDAO = daoFactory.getCartDAO();
        List<Cart> carts;
        carts = cartDAO.findCart(user);
        request.setAttribute("carts", carts);

        //test
        ProdottoDAO productDAO = daoFactory.getProdottoDAO();
        Prodotto product = null;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>() ;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            product=productDAO.findByProdId(carts.get(i).getProdotto().getid_prod());
            products.add(product);
            carts.get(i).setProdotto(product);
        }

    }

    private static void productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        products = prodottoDAO.findAll();
        request.setAttribute("products", products);
    }

    private static void singleOrderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) throws ParseException {

        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();
        Utente user = userDAO.findByUserId(loggedUser.getid_utente());

        Timestamp order_timestamp = new java.sql.Timestamp(Long.parseLong(request.getParameter("order_date")));

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findBySingleOrder(user, order_timestamp);
        request.setAttribute("order_tuples", order_tuples);

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        Prodotto prodotto = null;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();

        int i = 0;
        for (i = 0; i < order_tuples.size(); i++) {
            prodotto = prodottoDAO.findByProdId(order_tuples.get(i).getProduct().getid_prod());
            products.add(prodotto);
            order_tuples.get(i).setProduct(prodotto);
        }
    }

    private static void orderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        Utente user = userDAO.findByUserId(loggedUser.getid_utente());

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findOrders(user);

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        Prodotto prodotto = null;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>() ;

        for (int i = 0; i < order_tuples.size(); i++) {
            prodotto=prodottoDAO.findByProdId(order_tuples.get(i).getProduct().getid_prod());
            products.add(prodotto);
            order_tuples.get(i).setProduct(prodotto);
        }

        request.setAttribute("order_tuples", order_tuples);
    }
}

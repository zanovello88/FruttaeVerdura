package org.fruttaeverdura.fruttaeverdura.controller;

import org.fruttaeverdura.fruttaeverdura.model.dao.*;
import org.fruttaeverdura.fruttaeverdura.model.mo.Order;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserManagement {

    private UserManagement() {
    }

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;

        Logger logger = LogService.getApplicationLogger();

        try     {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            List<Utente> users = usersRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(users.size() < 8) {
                maxViewSize = users.size();
            } else{
                maxViewSize = 8;
            }
            try {
                maxViewSize = Integer.parseInt(request.getParameter("maxViewSize"));
            } catch(NumberFormatException | NullPointerException e) { }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("maxViewSize", maxViewSize);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/userManagement");

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

    public static void setAdmin(HttpServletRequest request, HttpServletResponse response) {

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

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            Long user_id = Long.parseLong(request.getParameter("user_id"));

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(user_id);

            try {
                if(user.getAdmin().equals("Y")) {
                    userDAO.setAdminStatusOff(user);
                } else {
                    userDAO.setAdminStatusOn(user);
                }
            } catch (Exception e) {
                applicationMessage = "Errore nel settaggio dello stato di amministratore: " + e;
                logger.log(Level.INFO, "Impossibile settare lo stato di amministratore dell'utente");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            usersRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/userManagement");

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

    public static void delete(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;

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

            Long user_id = Long.parseLong(request.getParameter("user_id"));

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(user_id);

            //faccio la delete e catcho la Null pointer exception che avviene nel
            //caso un utente aggiorni la pagina dopo aver cliccato sul pulsante cestino
            try{
                userDAO.delete(user);
            }
            catch(NullPointerException e){
                request.setAttribute("viewUrl", "adminManagement/userManagement");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            usersRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/userManagement");

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

    public static void searchView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;

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

            userSearch(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("viewUrl", "adminManagement/userManagement");

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

    public static void orderModView(HttpServletRequest request, HttpServletResponse response) {

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
            request.setAttribute("viewUrl", "adminManagement/orderModView");

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

    public static void singleOrderModView(HttpServletRequest request, HttpServletResponse response) {

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
            request.setAttribute("viewUrl", "adminManagement/singleOrderModView");

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
    public static void changeStatus(HttpServletRequest request, HttpServletResponse response) {

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

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            String status = request.getParameter("status");
            singleOrderRetrieve(daoFactory, sessionDAOFactory, request);

            OrderDAO orderDAO = daoFactory.getOrderDAO();
            List<Order> order_tuples = (List<Order>)request.getAttribute("order_tuples");
            orderDAO.updateStatus(order_tuples.get(0).getUser(), order_tuples.get(0).getTimestamp(), status);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/view");

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

    private static List<Utente> usersRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        List<Utente> users;
        UtenteDAO UserDAO = daoFactory.getUtenteDAO();
        users = UserDAO.findAll();
        request.setAttribute("users", users);
        return users;
    }


    private static void userSearch(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        List<Utente> users;
        UtenteDAO UserDAO = daoFactory.getUtenteDAO();
        users = UserDAO.searchByUsername(request.getParameter("searchString"));
        request.setAttribute("users", users);

    }

    private static void singleOrderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) throws ParseException {

        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente user = userDAO.findByUserId(Long.parseLong(request.getParameter("user_id")));
        request.setAttribute("user", user);

        Timestamp order_timestamp = new java.sql.Timestamp(Long.parseLong(request.getParameter("order_date")));

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findBySingleOrder(user, order_timestamp);
        request.setAttribute("order_tuples", order_tuples);

        ProdottoDAO prodDAO = daoFactory.getProdottoDAO();
        Prodotto prod = null;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();

        int i = 0;
        for (i = 0; i < order_tuples.size(); i++) {
            prod = prodDAO.findByProdId(order_tuples.get(i).getProduct().getid_prod());
            products.add(prod);
            order_tuples.get(i).setProduct(prod);
        }
    }

    private static void orderRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {


        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente user = userDAO.findByUserId(Long.parseLong(request.getParameter("user_id")));
        request.setAttribute("user", user);

        OrderDAO orderDAO = daoFactory.getOrderDAO();
        List<Order> order_tuples;
        order_tuples = orderDAO.findOrders(user);
        request.setAttribute("order_tuples", order_tuples);

        //test
        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        Prodotto prodotto = null;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>() ;

        int i=0;
        for (i = 0; i < order_tuples.size(); i++) {
            prodotto=prodottoDAO.findByProdId(order_tuples.get(i).getProduct().getid_prod());
            products.add(prodotto);
            order_tuples.get(i).setProduct(prodotto);
        }
    }
}

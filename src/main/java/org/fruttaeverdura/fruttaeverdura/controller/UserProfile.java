package org.fruttaeverdura.fruttaeverdura.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import org.fruttaeverdura.fruttaeverdura.model.mo.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;

import org.fruttaeverdura.fruttaeverdura.model.dao.*;
import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

public class UserProfile {

    private UserProfile() {
    }

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

            userRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "userProfile/view");

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
/*
    public static void editProfileView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            userRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "userProfile/editView");

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

    public static void modify(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        User loggedUser;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            Long cap;
            Long cvc;

            try {
                if (!request.getParameter("cap").isEmpty()){
                    cap = Long.parseLong(request.getParameter("cap"));
                    user.setCap(cap);
                }
                if (!request.getParameter("cvc").isEmpty()){
                    cvc = Long.parseLong(request.getParameter("cvc"));
                    user.setCvc(cvc);
                }

                user.setUsername(request.getParameter("username"));
                user.setPassword(request.getParameter("password"));
                user.setEmail(request.getParameter("email"));
                user.setName(request.getParameter("name"));
                user.setSurname(request.getParameter("surname"));
                user.setPhone(request.getParameter("phone"));
                user.setCity(request.getParameter("city"));
                //user.setCap(cap);
                user.setStreet(request.getParameter("street"));
                user.setCivic(request.getParameter("civic"));
                user.setCard_n(request.getParameter("card_n"));
                //user.setCvc(cvc);
                user.setExp_date(request.getParameter("exp_date"));


                userDAO.update(user);

                applicationMessage = "Modifiche effettuate con successo!";
                request.setAttribute("viewUrl", "userProfile/view");
            } catch (DuplicatedObjectException e){
                applicationMessage = "Username già in uso.";
                logger.log(Level.INFO, "Tentativo di inserimento di un username già esistente.");
                request.setAttribute("viewUrl", "userProfile/editView");
            } catch (NumberFormatException e){
                applicationMessage = "Errore: inserimento di valori inesatti.";
                request.setAttribute("viewUrl", "userProfile/editView");
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            userRetrieve(daoFactory, sessionDAOFactory, request);
            request.setAttribute("language",language);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);

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

    public static void deleteProfile(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User oldUser;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            oldUser = sessionUserDAO.findLoggedUser();
            sessionUserDAO.delete(null);

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            userRetrieve(daoFactory, sessionDAOFactory, request);

            UserDAO userDAO = daoFactory.getUserDAO();

            try{
                userDAO.delete(oldUser);
            }
            catch(Exception e){
                logger.log(Level.SEVERE, "DAO Error", e);
            }

            wineRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseWineRetrieve(daoFactory, sessionDAOFactory, request);

            int arrayPos;
            try {
                arrayPos = Integer.parseInt(request.getParameter("arrayPos"));
            } catch(NumberFormatException e) {
                arrayPos = 0;
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("arrayPos", arrayPos);
            request.setAttribute("language",language);
            request.setAttribute("loggedOn",false);
            request.setAttribute("loggedUser", null);
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

    public static void deleteCarta(HttpServletRequest request, HttpServletResponse response){
        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            userRetrieve(daoFactory, sessionDAOFactory, request);

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            try {
                userDAO.deleteCarta(user);
                applicationMessage = "Modifiche effettuate con successo.";

            }catch (Exception e){
                logger.log(Level.SEVERE, "Dao Error", e);
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language", language);
            request.setAttribute("loggedOn", loggedUser != null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "userProfile/view");

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

    public static void deleteSpedizione(HttpServletRequest request, HttpServletResponse response){
        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        User loggedUser;
        String applicationMessage = null;
        Language language;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UserDAO sessionUserDAO = sessionDAOFactory.getUserDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            LanguageDAO sessionLanguageDAO = sessionDAOFactory.getLanguageDAO();
            language = sessionLanguageDAO.findlanguage();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            userRetrieve(daoFactory, sessionDAOFactory, request);

            UserDAO userDAO = daoFactory.getUserDAO();
            User user = userDAO.findByUserId(loggedUser.getUserId());

            try {
                userDAO.deleteSpedizione(user);
                applicationMessage = "Modifiche effettuate con successo.";

            }catch (Exception e){
                logger.log(Level.SEVERE, "Dao Error", e);
            }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("language", language);
            request.setAttribute("loggedOn", loggedUser != null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "userProfile/view");

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

    private static void wineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        WineDAO wineDAO = daoFactory.getWineDAO();
        List<Wine> wines;
        wines = wineDAO.findAll();
        request.setAttribute("wines", wines);
    }

    private static void showcaseRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ShowcaseDAO showcaseDAO = daoFactory.getShowcaseDAO();
        List<Showcase> showcases;
        showcases = showcaseDAO.findAll();
        request.setAttribute("showcases", showcases);

    }

    private static void showcaseWineRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        showcaseRetrieve(daoFactory, sessionDAOFactory, request);

        List<Wine> wines = new ArrayList<Wine>();

        try {
            List<Showcase> showcases = (List<Showcase>)request.getAttribute("showcases");
            WineDAO wineDAO = daoFactory.getWineDAO();
            Wine wine;

            for(int i = 0; i < showcases.size(); i++) {

                wine = wineDAO.findByWineId(showcases.get(i).getWineId());
                wines.add(wine);
            }
        } catch(Exception e) {  }

        if(!wines.isEmpty()) {
            request.setAttribute("showcase_wines", wines);
        }

    }
*/
    private static void userRetrieve (DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
        Utente loggedUser = sessionUserDAO.findLoggedUser();

        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        Utente user = userDAO.findByUserId(loggedUser.getid_utente());
        request.setAttribute("user", user);
    }

}
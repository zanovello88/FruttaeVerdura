package org.fruttaeverdura.fruttaeverdura.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl.ProdottoDAOMySQLJDBCImpl;
import org.fruttaeverdura.fruttaeverdura.services.config.Configuration;
import org.fruttaeverdura.fruttaeverdura.services.logservice.LogService;

import org.fruttaeverdura.fruttaeverdura.model.mo.Utente;
import org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto;
import org.fruttaeverdura.fruttaeverdura.model.dao.DAOFactory;
import org.fruttaeverdura.fruttaeverdura.model.dao.UtenteDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DataTruncationException;
import org.fruttaeverdura.fruttaeverdura.model.dao.exception.DuplicatedObjectException;
import java.math.BigDecimal;
public class ProductManagement extends HttpServlet {
    private ProdottoDAO prodottoDAO;
    private ProductManagement() { }

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

            List<Prodotto> products = productRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(products.size() < 8) {
                maxViewSize = products.size();
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
            request.setAttribute("viewUrl", "productManagement/view");

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

    public static void viewManagement(HttpServletRequest request, HttpServletResponse response) {

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

            List<Prodotto> products = productRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(products.size() < 8) {
                maxViewSize = products.size();
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
            request.setAttribute("viewUrl", "adminManagement/productManagement");

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

    public static void insertView(HttpServletRequest request, HttpServletResponse response) {

            DAOFactory sessionDAOFactory=null;
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

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/prodInsModView");

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
        public static void insert(HttpServletRequest request, HttpServletResponse response) {

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

                ProdottoDAO productDAO = daoFactory.getProdottoDAO();

                BigDecimal price = new BigDecimal(request.getParameter("Prezzo"));
                int quantita_disponibile = Integer.parseInt(request.getParameter("Quantità_disp"));
                boolean blocked = Boolean.parseBoolean(request.getParameter("Blocked"));

                String photo = request.getParameter("img_path");
                //se la foto non è inserita metto di deafault questa
                if(photo.isEmpty()){
                    photo = "https://media.istockphoto.com/id/1472933890/vector/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=Rdn-lecwAj8ciQEccm0Ep2RX50FCuUJOaEM8qQjiLL0=" ;
                }

                //se la denominazione non è inserita metto di default questa
                String acq = request.getParameter("Sede_acquisto");
                if (acq.isEmpty()){
                    acq = "---";
                }

                //se l'annata non è inserita metto di default questa
                String des = request.getParameter("Descrizione");
                if (des.isEmpty()){
                    des = "---";
                }

                try {

                    ProdottoDAO.create(
                            request.getParameter("Nome"),
                            request.getParameter("Sede_acquisto"),
                            request.getParameter("Descrizione"),
                            price,
                            quantita_disponibile,
                            request.getParameter("Categoria"),
                            blocked,
                            photo
                    );

                } catch (DuplicatedObjectException e) {
                    applicationMessage = "Prodotto già esistente";
                    logger.log(Level.INFO, "Tentativo di inserimento di prodotto già esistente");
                } catch (DataTruncationException e) {
                    applicationMessage = "importo massimo consentito: sei cifre intere e due decimali.";
                }

                productRetrieve(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("applicationMessage", applicationMessage);
                request.setAttribute("viewUrl", "adminManagement/productManagement");

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

        public static void modifyView(HttpServletRequest request, HttpServletResponse response) {

            DAOFactory sessionDAOFactory=null;
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

                Long id_prod = Long.parseLong(request.getParameter("id_prod"));

                ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
                Prodotto prod = ProdottoDAO.findByProdId(id_prod);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("wine", prod);
                request.setAttribute("viewUrl", "adminManagement/wineInsModView");

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

                Long id_prod = Long.parseLong(request.getParameter("id_prod"));

                ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
                Prodotto prodotto = prodottoDAO.findByProdId(id_prod);

                String photo = request.getParameter("img_path");
                //se la foto non è inserita metto di deafault questa
                if(photo.isEmpty()){
                    photo = "https://media.istockphoto.com/id/1472933890/vector/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=Rdn-lecwAj8ciQEccm0Ep2RX50FCuUJOaEM8qQjiLL0=" ;
                }

                //se la denominazione non è inserita metto di default questa
                String den = request.getParameter("denominazione");
                if (den.isEmpty()){
                    den = "---";
                }

                //se l'annata non è inserita metto di default questa
                String ann = request.getParameter("annata");
                if (ann.isEmpty()){
                    ann = "---";
                }

                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int avalaibility = Integer.parseInt(request.getParameter("avalaibility"));
                Float alcool = Float.parseFloat(request.getParameter("alcool"));

                wine.setName(request.getParameter("name"));
                wine.setProductImage(photo);
                wine.setPrice(price);
                wine.setDenominazione(den);
                wine.setAnnata(ann);
                wine.setAvalaibility(avalaibility);
                wine.setVitigni(request.getParameter("vitigni"));
                wine.setProvenance(request.getParameter("provenance"));
                wine.setFormat(request.getParameter("format"));
                wine.setAlcool(alcool);
                wine.setCategory(request.getParameter("category"));
                wine.setDescription(request.getParameter("description"));

                try {
                    wineDAO.modify(wine);
                    applicationMessage = "Modifica avvenuta correttamente";
                } catch (DuplicatedObjectException e) {
                    applicationMessage = "Vino già esistente";
                    logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
                } catch (DataTruncationException e) {
                    applicationMessage = "Errore nella modifica del prezzo: importo massimo consentito: sei cifre intere e due decimali.";
                    logger.log(Level.INFO, "Importo massimo consentito: sei cifre intere e due decimali.");
                }

                wineRetrieve(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                wineRetrieve(daoFactory, sessionDAOFactory, request);

                request.setAttribute("language",language);
                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("applicationMessage", applicationMessage);
                request.setAttribute("viewUrl", "adminManagement/wineManagement");

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
*/
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

                Long id_prod = Long.parseLong(request.getParameter("id_prod"));

                ProdottoDAO prodDAO = daoFactory.getProdottoDAO();
                Prodotto prod = prodDAO.findByProdId(id_prod);

                //faccio la delete e catcho la Null pointer exception che avviene nel
                //caso un utente aggiorni la pagina dopo aver cliccato sul pulsante cestino
                try{
                    prodDAO.delete(prod);
                }
                catch(NullPointerException e){
                    request.setAttribute("viewUrl", "adminManagement/view");
                }

                productRetrieve(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/productManagement");

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

                prodSearch(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/productManagement");

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

    public static List<Prodotto> productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        products = prodDAO.findAll();
        request.setAttribute("products", products);
        return products;

    }
/*
        private static void categoryRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

            ProdottoDAO wineDAO = daoFactory.getProdottoDAO();
            List<Prodotto> products;
            products = wineDAO.filterByCategory(request.getParameter("category"));
            request.setAttribute("wines", products);

        }
*/
        private static void prodSearch(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

            ProdottoDAO wineDAO = daoFactory.getProdottoDAO();
            List<Prodotto> products;
            products = wineDAO.findByName(request.getParameter("searchString"));
            request.setAttribute("products", products);
        }

    }


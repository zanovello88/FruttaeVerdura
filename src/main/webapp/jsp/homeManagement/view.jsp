<%-- Created by IntelliJ IDEA.
User: francescozanovello
Date: 03/04/24
Time: 11:54
To change this template use File | Settings | File Templates. da creare, pagina principale --%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@ page import="java.util.logging.Level" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.services.logservice.LogService" %>
<%@ page import="java.util.logging.Logger" %>

<%
    Logger logger = LogService.getApplicationLogger();
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Home";

    //gestisco ricerca
        boolean defaultMode = true;
        boolean searchMode = false;
        boolean showcaseMode = false;
        String searchedItem = "";
        try {
            if(request.getAttribute("searchMode") != null) {
                searchMode = (Boolean) request.getAttribute("searchMode");
            }
        } catch (NullPointerException e) {
            logger.log(Level.SEVERE, "JSP Error (searchMode)", e);
        }

        try {
            if(request.getAttribute("showcaseMode") != null) {
                showcaseMode = (Boolean)request.getAttribute("showcaseMode");
            }
        } catch (NullPointerException e) {
            logger.log(Level.SEVERE, "JSP Error (showcaseMode)", e);
        }

        if(searchMode) {
            searchedItem = (String) request.getAttribute("searchedItem");
        }
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="/include/htmlHead.inc"%>
        <style>
            /* Stile per il contenitore della barra di ricerca */
            .search-container {
                width: 100%;
                display: flex;
                justify-content: center; /* Centra la barra di ricerca */
                background-color: #ccc;
                padding: 10px;
            }

            /* Stile per il form di ricerca */
            .search-form {
                width: 80%; /* Larghezza del form */
                max-width: 400px;
                display: flex;
                align-items: center;
            }

            /* Stile per l'input di ricerca */
            .search-input {
                flex: 1;
                height: 30px;
                padding: 5px;
                border: 2px solid #000;
                border-radius: 4px;
                font-size: 14px;
                outline: none;
            }

            /* Stile per il pulsante di ricerca */
            .search-button {
                padding: 5px 8px;
                border: none;
                background-color: transparent;
                cursor: pointer;
            }

            /* Stile per l'icona di ricerca */
            .search-icon {
                width: 18px;
                height: 18px;
                fill: #000;
            }

            /* Stile per il pulsante di ricerca al passaggio del mouse */
            .search-button:hover {
                background-color: #ddd;
            }
        </style>
        <script language="javascript">

            function productViewFunc(wine_id) {
                f = document.productView;
                f.wine_id.value = wine_id;
                f.requestSubmit();
            }

            function searchFunc(name) {
                f = document.searchForm;
                f.searchString.value = name;
                f.requestSubmit();
            }

            function AddToCart(wine_id) {
                alert("Aggiunto al carrello");
                document.AddToCartForm.wine_id.value = wine_id;
                document.AddToCartForm.requestSubmit();
            }

            function mainOnLoadHandler() {}

        </script>
    </head>
    <body>
        <%@include file="/include/header.inc"%>
        <div class="search-container">
            <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
                <input type="hidden" name="controllerAction" value="HomeManagement.searchView">
                <input type="text" name="searchString" placeholder="Ricerca" class="search-input">
                <button type="submit" form="searchForm" class="search-button">
                    <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 56.966 56.966">
                        <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                    </svg>
                </button>
            </form>
        </div>

        <main>
            <%if (loggedOn) {%>
            Benvenuto <%=loggedUser.getNome()%> <%=loggedUser.getCognome()%>!<br/>
            Clicca sulla voce "Prodotti" per vedere i nostri prodotti.
            <%} else {%> Benvenuto. Fai il login per vedere i tuoi ordini.<br/> <%}%>
        </main>
        <%@include file="/include/footer.inc"%>
    </body>
</html>

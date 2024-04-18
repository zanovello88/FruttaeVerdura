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
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Home";
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
        <main>
            <%if (loggedOn) {%>
            Benvenuto <%=loggedUser.getNome()%> <%=loggedUser.getCognome()%>!<br/>
            Clicca sulla voce "Prodotti" per vedere i nostri prodotti.
            <%} else {%> Benvenuto. Fai il login per vedere i tuoi ordini.<br/> <%}%>
        </main>
        <%@include file="/include/footer.inc"%>
    </body>
</html>

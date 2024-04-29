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
            .button-container-new {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px 0;
            }

            .button-new {
                width: 200px;
                margin: 10px 0;
                padding: 15px 0;
                font-size: 16px;
                background-color: #73ad21;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .button-new:hover {
                background-color: #5c891a;
            }

            /* Aggiungiamo un po' di ombra per dare profondità */
            .button-new {
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            /* Cambiamo il colore del testo quando il mouse è sopra */
            .button-new:hover {
                color: #fff;
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
        <%@include file="/include/header.jsp"%>
        <main>
            <%if (loggedOn) {%>
            Benvenuto <%=loggedUser.getNome()%> <%=loggedUser.getCognome()%>!<br/>
            Clicca sulla voce "Prodotti" per vedere i nostri prodotti.
            <%} else {%>
            Benvenuto. Fai il login per vedere i tuoi ordini.<br/>
            <%}%>
            <h2 style="text-align: center">Scegli cosa desideri ricercare:</h2>
            <div class="button-container-new">
                <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=frutta#frutta-title';">Frutta</button>
                <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=verdura#verdura-title';">Verdura</button>
                <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=altro#altro-title';">Altro</button>
            </div>
        </main>
        <%@include file="/include/footer.inc"%>
    </body>
</html>

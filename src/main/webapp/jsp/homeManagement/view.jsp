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
            max-width: 42%;
            margin: 0 auto; /* Per centrare la sezione */
            display: flex;
            flex-direction: column;
            align-items: center; /* Per allineare i tasti al centro */
        }

        .button-section {
            width: 100%; /* Larghezza al 100% della sezione */
            margin: 20px auto; /* Spazio superiore e inferiore tra le sezioni */
            display: flex;
            justify-content: center; /* Per allineare i tasti al centro orizzontalmente */
            align-items: center;
        }

        .button-new {
            width: 20%;
            padding: 20px 0;
            font-size: 20px;
            font-weight: bold;
            color: white;
            background-color: #73ad21; /* Colore verde originale */
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            background-size: cover;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .button-new:hover {
            background-color: #5c891a; /* Cambia il colore in hover */
        }

        /* Aggiungi stili specifici per ogni categoria */
        .button-section.fruit {
            height: 400px;
            background-image: url('https://media.istockphoto.com/id/529664572/it/foto/sfondo-di-frutta.jpg?s=612x612&w=0&k=20&c=6z2iU_nFIRI4MYnhy1qJUIeSoILsPY2JCxIQJutPF8M=');
        }

        .button-section.vegetable {
            height: 400px;
            background-image: url('https://media.istockphoto.com/id/1488823634/it/foto/verdure-fresche-biologiche-e-spezie.jpg?s=612x612&w=0&k=20&c=F3Ap-qYpmqzO31O7Vk0u396NIx2ROlgD-hB-1At9o2A=');
        }

        .button-section.other {
            height: 400px;
            background-image: url('https://media.istockphoto.com/id/1692605340/it/foto/conserve-alimentari-e-prodotti-freschi.jpg?s=612x612&w=0&k=20&c=SLUvveKPdwgeZoblw0xBpIl4NGu1zDb9GlNcGQJtxog=');
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
        <div class="button-section fruit">
            <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=frutta#frutta-title';">Frutta</button>
        </div>
        <div class="button-section vegetable">
            <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=verdura#verdura-title';">Verdura</button>
        </div>
        <div class="button-section other">
            <button class="button-new" onclick="location.href='Dispatcher?controllerAction=ProductManagement.view&categoria=altro#altro-title';">Altro</button>
        </div>
    </div>
</main>
<%@include file="/include/footer.inc"%>
</body>
</html>
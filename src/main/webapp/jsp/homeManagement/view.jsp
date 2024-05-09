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
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.controller.ShowcaseManagement" %>
<%@ page import="java.util.List" %>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Home";
    ShowcaseManagement.view(request, response);
    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <style>
        .product-showcase-container {
            max-width: 80%;
            margin: 0 auto;
            padding: 10px;
            background-color: #f9f9f9;
            border: 2px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        .section-title {
            text-align: center;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .product-showcase {
            display: flex;
            overflow-x: auto;
            scroll-snap-type: x mandatory;
            padding-bottom: 5px;
        }

        .product-item {
            width: 50vw;
            flex-shrink: 0;
            scroll-snap-align: start;
            margin-right: 10px;
            background-color: #fff;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .product-item img {
            width: 100%;
            height: auto;
            border-top-left-radius: 6px;
            border-top-right-radius: 6px;
        }

        .product-details {
            padding: 5px;
        }

        .product-details h3 {
            margin-top: 5px;
            font-size: 16px;
            text-align: center;
        }

        .product-details p {
            font-size: 12px;
            text-align: center;
        }
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
        .story-section {
            margin: 40px auto;
            max-width: 800px;
            padding: 0 20px;
        }

        .story-section h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .story-section p {
            font-size: 16px;
            color: #333;
            line-height: 1.6;
        }

        .section-divider {
            border: none;
            height: 1px;
            background-color: #ccc;
            margin: 20px auto; /* Spazio sopra e sotto al divisore */
            width: 90%; /* Larghezza del divisore */
        }
        .contact-section {
            background-color: #f9f9f9;
            padding: 50px 20px;
            text-align: center;
        }

        .section-title-2 {
            color: #73ad21;
            font-size: 24px;
            margin-bottom: 30px;
        }

        .contact-details {
            margin-bottom: 30px;
        }

        .contact-details p {
            margin: 10px 0;
        }

        .map-container {
            max-width: 100%;
            margin: 0 auto;
        }
    </style>
    <script language="javascript">

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = id_prod;
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
    <br>
    <h2 class="section-title">Prodotti in Vetrina</h2>

    <div class="product-showcase-container">
        <h2 class="section-title" style="color: #73ad21;">Questa settimana in offerta:</h2>
        <div class="product-showcase">
            <% for (Prodotto product : products) { %>
            <div class="product-item">
                <a href="javascript:productViewFunc(<%=product.getid_prod()%>)">
                    <img src="<%= product.getimg_path() %>" alt="<%= product.getnome_prod() %>">
                </a>
                <div class="product-details">
                    <h3 style="color: #333; font-size: 18px;"><%= product.getnome_prod() %></h3>
                    <p style="color: #666; font-size: 14px;"><%= product.getsede_acquisto() %></p>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <hr class="section-divider">

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

    <hr class="section-divider">

    <div class="story-section">
        <h2 class="section-title" style="color: #73ad21;">La nostra storia</h2>
        <p style="text-align: center">
            Benvenuti nel negozio online di frutta e verdura fondato da Lorenzo.
            Cresciuto tra i banchi del mercato,
            Lorenzo ha trasformato la sua passione per la freschezza in un successo duraturo.
            Da Solesino (Padova) a tutto il mondo, la nostra missione consiste nel offrire prodotti d'eccellenza,
            selezionati con cura e trattati con amore. Scopri i sapori della natura nel nostro negozio virtuale!
        </p>
    </div>

    <hr class="section-divider">

    <div class="contact-section">
        <h2 class="section-title-2">Contatti e Dove trovarci</h2>
        <div class="contact-details">
            <p><strong>Indirizzo:</strong> Via XXVIII Aprile 95, 35047, Solesino, Padova</p>
            <p><strong>Telefono:</strong> +39 0123 456789</p>
            <p><strong>Email:</strong> info@fruttaeverdura.it</p>
        </div>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d175.78029843141724!2d11.743928078913349!3d45.17728219824533!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sit!2sit!4v1715260378173!5m2!1sit!2sit" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>


    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>
</main>
<%@include file="/include/footer.inc"%>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 18/04/24
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@ page import="java.util.List" %>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    String menuActiveLink = prodotto.getnome_prod();
%>

<!DOCTYPE html>
<html>
<head>
    <script language="javascript">

        function AddToCart(id_prod) {
            alert("Aggiunto al carrello");
            document.AddToCartForm.id_prod.value = id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = wine_id;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        img {
            max-width: 100%;
            height: 200px; /* Adjust the height as needed */
            object-fit: cover; /* Ensures the image covers the specified height and width */
            border-radius: 8px;
            display: block;
            margin: 0 auto; /* Centers the image horizontally */
        }
        h1 {
            font-size: 24px;
            margin-top: 0;
            color: #333;
        }
        p {
            font-size: 16px;
            line-height: 1.6;
            color: #666;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .description {
            margin-top: 20px;
            border-top: 1px solid #ccc;
            padding-top: 20px;
        }
    </style>
    <%@include file="/include/htmlHead.inc"%>
</head>
<body class="bg-gray-500">
<%@include file="/include/header.inc"%>
<main class="w-full ">
    <%--PRODUCT DATA--%>
        <div class="container">
            <div id="image-section">
                <img src="<%=prodotto.getimg_path()%>" alt="Product Image">
            </div>
            <div id="info-section">
                <h1><%=prodotto.getnome_prod()%></h1>
                <p>
                    <span class="font-medium text-lg">Sede acquisto:</span> <%=prodotto.getsede_acquisto()%>
                </p>
                <%if (prodotto.getcategoria().equals("altro")) {%>
                <p class="price">
                    <%=prodotto.getprezzo()%> &euro; al pezzo
                </p>
                <%} else {%>
                <p class="price">
                    <%=prodotto.getprezzo()%> &euro;/Kg
                </p>
                <%}%>
                <% if(!loggedOn) { %>
                <div class="w-full mx-auto bg-gray-100 rounded-md mt-12 py-4 px-8 flex items-center justify-start">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" class="text-gray-500 mr-4">
                        <path class="heroicon-ui fill-current" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm0-9a1 1 0 011 1v4a1 1 0 01-2 0v-4a1 1 0 011-1zm0-4a1 1 0 110 2 1 1 0 010-2z"/>
                    </svg>
                    <p class="text-gray-700">
                        Accedi per aggiungere un prodotto al carrello
                    </p>
                </div>
                <% } %>
                <% if(loggedOn) { %>
                <a class="btn" href="javascript:AddToCart(<%=prodotto.getid_prod()%>)">Aggiungi al carrello</a>
                <% } %>
            </div>
            <div class="description">
                <h2>Descrizione</h2>
                <p><%=prodotto.getdescrizione()%></p>
            </div>
        </div>

    <form name="AddToCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="CartManagement.AddWine"/>
        <input type="hidden" name="viewUrl" value="homeManagement/view"/>
    </form>

    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>

</main>
<div class="w-full bottom-0">
    <%@include file="/include/footer.inc"%>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.dao.ProdottoDAO" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.dao.mySQLJDBCImpl.ProdottoDAOMySQLJDBCImpl" %>
<%@ page import="java.util.ArrayList" %>
<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Prodotti";

    Prodotto prodotto = (Prodotto) request.getAttribute("wine");
    List<Prodotto> products = null;
    boolean preferencesEnable = false;
    try {
        products = (List<Prodotto>) request.getAttribute("products");
        if(!products.isEmpty() && products != null) {
            preferencesEnable = true;
        }
    } catch (NullPointerException e) { }
    int i;
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <meta charset="UTF-8">
    <title>Visualizza Prodotti</title>
    <style>
        /* Stili CSS per la pagina */
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .product {
            display: flex;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .product img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }
        .product-details {
            flex-grow: 1;
        }
        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .product-description {
            color: #666;
            margin-bottom: 10px;
        }
        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #2ecc71;
        }
    </style>
    <script language="javascript">

        function AddToCart(wine_id) {
            alert("Aggiunto al carrello");
            document.AddToCartForm.wine_id.value = wine_id;
            document.AddToCartForm.requestSubmit();
        }

        function AddToWishlist(wine_id) {
            alert("Aggiunto alla wishlist");
            document.AddToWishlistForm.wine_id.value = wine_id;
            document.AddToWishlistForm.requestSubmit();
        }

        function productViewFunc(wine_id) {
            f = document.productView;
            f.wine_id.value = wine_id;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
</head>
<body>
<%@include file="/include/header.inc"%>
<div class="container">
    <h1>Lista Prodotti</h1>
    <%-- Iterate through the products and display them --%>
    <%for(i = 0; i < products.size(); i++){%>
        <div class="product">
            <a href="javascript:productViewFunc(<%=products.get(i).getid_prod()%>)">
            <img src=<%=products.get(i).getimg_path()%> alt="${prodotto.getnome_prod()}">
            <div class="product-details">
                <div class="product-name"><%=products.get(i).getnome_prod()%></div>
                <div class="product-description"><%=products.get(i).getdescrizione()%></div>
                <div class="product-price"><%=products.get(i).getprezzo()%> €</div>
            </div>
            </a>
        </div>
    <%}%>

    <form name="AddToCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="CartManagement.AddWine"/>
        <input type="hidden" name="viewUrl" value="homeManagement/view"/>
    </form>

    <form name="AddToWishlistForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="WishlistManagement.AddWine"/>
        <input type="hidden" name="viewUrl" value="homeManagement/view"/>
    </form>

    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>
</div>
</body>
<%@include file="/include/footer.inc"%>
</html>
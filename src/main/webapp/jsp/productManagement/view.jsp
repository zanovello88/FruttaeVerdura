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
<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Prodotti";

    List<Prodotto> contacts = (List<Prodotto>) request.getAttribute("contacts");
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
</head>
<body>
<%@include file="/include/header.inc"%>
<div class="container">
    <h1>Lista Prodotti</h1>
    <%-- Iterate through the products and display them --%>
    <c:forEach var="prodotto" items="${prodotti}">
        <div class="product">
            <img src="${prodotto.getimg_path()}" alt="${prodotto.getnome_prod()}">
            <div class="product-details">
                <div class="product-name">${prodotto.getnome_prod()}</div>
                <div class="product-description">${prodotto.getdescrizione()}</div>
                <div class="product-price">${prodotto.getprezzo()} €</div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
<%@include file="/include/footer.inc"%>
</html>
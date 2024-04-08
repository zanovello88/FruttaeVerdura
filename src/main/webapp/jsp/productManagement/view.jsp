<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 08/04/24
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Prodotti";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="/include/htmlHead.inc"%>
    <title>Lista Prodotti</title>
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
    <c:forEach var="wine" items="${wines}">
        <div class="product">
            <img src="${wine.productImage}" alt="${wine.name}">
            <div class="product-details">
                <div class="product-name">${wine.name}</div>
                <div class="product-description">${wine.description}</div>
                <div class="product-price">${wine.price} €</div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
<%@include file="/include/footer.inc"%>
</html>


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
<%@ page import="org.fruttaeverdura.fruttaeverdura.services.logservice.LogService" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="java.util.logging.Level" %>
<%
    Logger logger = LogService.getApplicationLogger();
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Prodotti";

    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");

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
        .product-sold {
            color: #666;
            margin-bottom: 10px;
        }
        .product-price {
            font-size: 16px;
            font-weight: bold;
            color: #2ecc71;
        }
        .btn-container {
            display: flex;
            align-items: center; /* Centra verticalmente il pulsante */
            margin-left: auto;
        }

        .btn {
            padding: 10px 20px; /* Aumenta il padding */
            font-size: 16px; /* Aumenta la dimensione del testo */
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* Stile per il contenitore della barra di ricerca */
         .search-container {
             width: 100%;
             display: flex;
             justify-content: center; /* Centra la barra di ricerca */
             background-color: #ccc;
             padding-top: 10px;
             padding-bottom: 10px;
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

        function AddToCart(id_prod) {
            alert("Aggiunto al carrello");
            document.AddToCartForm.id_prod.value = id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function searchFunc(name) {
            f = document.searchForm;
            f.searchString.value = name;
            f.requestSubmit();
        }

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = id_prod;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
</head>
<body>
<%@include file="/include/header.jsp"%>
    <div class="search-container">
        <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
            <input type="hidden" name="controllerAction" value="HomeManagement.searchView">
            <input type="text" name="searchString" placeholder="Ricerca qui un prodotto" class="search-input">
            <button type="submit" form="searchForm" class="search-button">
                <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 56.966 56.966">
                    <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                </svg>
            </button>
        </form>
    </div>
<%if (!searchedItem.isEmpty()) {%>
    <div class="container mx-auto flex flex-wrap pb-12">
        <nav id="page-title" class="w-full z-30 top-0 px-6 py-1">
            <div class="w-full container mx-auto flex flex-wrap items-center justify-center mt-0 px-2 py-3">
                <%if(searchMode && !products.isEmpty()){%>
                <h2 class="uppercase tracking-wide no-underline hover:no-underline font-extrabold text-black text-2xl">Risultato ricerca per '<%=searchedItem%>'</h2>
                <%}%>
                <%if(searchMode && products.isEmpty()){%>
                <div class="w-full flex justify-center">
                    <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl">Nessun risultato per '<%=searchedItem%>'</h2>
                </div>
                <%}%>
            </div>
        </nav>
    </div>
<%}%>

    <div class="container">
        <h1>Lista Prodotti</h1>
        <%-- Iterate through the products and display them --%>
        <h2 id="frutta-title" style="text-align: center">Frutta</h2>
        <% for(i = 0; i < products.size(); i++) { %>
        <% if (products.get(i).getcategoria().equals("frutta")) { %>
        <div class="product">
            <a href="javascript:productViewFunc(<%= products.get(i).getid_prod() %>)">
                <img src="<%= products.get(i).getimg_path() %>" alt="<%= products.get(i).getnome_prod() %>">
                <div class="product-details">
                    <div class="product-name"><%= products.get(i).getnome_prod() %></div>
                    <div class="product-sold"><%= products.get(i).getsede_acquisto() %></div>
                    <div class="product-price"><%= products.get(i).getprezzo() %> €/kg</div>
                </div>
            </a>
            <% if (loggedOn) { %>
            <div class="btn-container">
                <a class="btn" href="javascript:AddToCart(<%= products.get(i).getid_prod() %>)">
                    Aggiungi al carrello
                    <svg width="16px" height="16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/>
                    </svg>
                </a>
            </div>
            <% } %>
        </div>
        <% } %>
        <% } %>

        <h2 id="verdura-title" style="text-align: center">Verdura</h2>
        <%for(i = 0; i < products.size(); i++){%>
        <%if (products.get(i).getcategoria().equals("verdura")) {%>
        <div class="product">
            <a href="javascript:productViewFunc(<%=products.get(i).getid_prod()%>)">
                <img src=<%=products.get(i).getimg_path()%>  alt="<%=products.get(i).getnome_prod()%>">
                <div class="product-details">
                    <div class="product-name"><%=products.get(i).getnome_prod()%></div>
                    <div class="product-sold"><%=products.get(i).getsede_acquisto()%></div>
                    <div class="product-price"><%=products.get(i).getprezzo()%> €/kg</div>
                </div>
            </a>
            <% if (loggedOn) { %>
            <div class="btn-container">
                <a class="btn" href="javascript:AddToCart(<%= products.get(i).getid_prod() %>)">
                    Aggiungi al carrello
                    <svg width="16px" height="16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/>
                    </svg>
                </a>
            </div>
            <% } %>
        </div>
        <%}%>
        <%}%>
        <h2 id="altro-title" style="text-align: center">Altro</h2>
        <%for(i = 0; i < products.size(); i++){%>
        <%if (products.get(i).getcategoria().equals("altro")) {%>
        <div class="product">
            <a href="javascript:productViewFunc(<%=products.get(i).getid_prod()%>)">
                <img src=<%=products.get(i).getimg_path()%>  alt="<%=products.get(i).getnome_prod()%>">
                <div class="product-details">
                    <div class="product-name"><%=products.get(i).getnome_prod()%></div>
                    <div class="product-sold"><%=products.get(i).getsede_acquisto()%></div>
                    <div class="product-price"><%=products.get(i).getprezzo()%> €</div>
                </div>
            </a>
            <% if (loggedOn) { %>
            <div class="btn-container">
                <a class="btn" href="javascript:AddToCart(<%= products.get(i).getid_prod() %>)">
                    Aggiungi al carrello
                    <svg width="16px" height="16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"/>
                    </svg>
                </a>
            </div>
            <% } %>
        </div>
        <%}%>
        <%}%>

        <form name="AddToCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="id_prod"/>
            <input type="hidden" name="controllerAction" value="CartManagement.AddProduct"/>
            <input type="hidden" name="viewUrl" value="productManagement/view"/>
        </form>

    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>
</div>
</body>
<%@include file="/include/footer.inc"%>
</html>

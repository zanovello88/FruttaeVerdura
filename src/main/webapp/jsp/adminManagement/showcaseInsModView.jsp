<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 20/04/24
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Aggiunta prodotti in vetrina";
    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");
%>

<!DOCTYPE html>

<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <style>
        body {
            background-color: #f3f4f6;
            font-family: Arial, sans-serif;
        }

        main {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header h1 {
            color: #333;
            font-size: 24px;
            margin: 0;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .product {
            width: calc(33.333% - 20px);
            margin: 10px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .product:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product h2 {
            color: #555;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .product p {
            color: #777;
            font-size: 14px;
        }

        .add-btn {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .add-btn:hover {
            background-color: #45a049;
        }
        .search-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px; /* Aggiunto margine inferiore per spaziare il contenuto */
        }

        .search-input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .search-btn {
            padding: 10px 15px;
            background-color: #007bff; /* Cambio colore a blu */
            border: none;
            border-radius: 5px;
            margin-left: 5px; /* Aggiunto margine sinistro per separare l'input dal pulsante */
            cursor: pointer;
            transition: background-color 0.3s ease; /* Aggiunta transizione al cambio di colore */
        }

        .search-btn:hover {
            background-color: #0056b3; /* Cambio colore a blu più scuro al passaggio del mouse */
        }

        /* Stile per l'icona all'interno del pulsante */
        .search-btn svg {
            fill: #fff; /* Colore bianco per l'icona */
            width: 20px; /* Dimensione dell'icona */
            height: 20px;
        }

    </style>
    <script language="javascript">

        function insert(id_prod) {
            f = document.insertForm;
            f.id_prod.value = id_prod;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main>
    <div class="header">
        <h1>Lista prodotti</h1>
    </div>
    <div class="search-container">
        <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
            <input type="hidden" name="controllerAction" value="ShowcaseManagement.searchView">
            <input type="text" name="searchString" placeholder=" Cerca nome prodotto" class="search-input">
            <button type="submit" form="searchForm" class="search-btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 21a9 9 0 110-18 9 9 0 010 18zm0-2a7 7 0 100-14 7 7 0 000 14z"/><path d="M11.293 12.707a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414l4 4a1 1 0 010 1.414z"/></svg>
            </button>
        </form>
    </div>
    <div class="product-container">
        <%for (i = 0; i < products.size(); i++) {%>
        <div class="product">
            <h2><%=products.get(i).getnome_prod()%></h2>
            <p>Quantita' disponibile in magazzino: <%=products.get(i).getquantita_disponibile()%></p>
            <button class="add-btn"><a href="javascript:insert(<%=products.get(i).getid_prod()%>)">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-black" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
                </a></button>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.insert"/>
    </form>
</main>
<%@include file="/include/footer.inc"%>
</body>
</html>

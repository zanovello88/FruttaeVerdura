<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Showcase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Vetrina";
    List<Showcase> showcases = (List<Showcase>) request.getAttribute("showcases");
    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <style>
        /* Stile generale */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f3f4f6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Stili per gli elementi della pagina */
        p {
            margin: 0;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        button, input[type="button"] {
            cursor: pointer;
        }

        /* Stili per le sezioni specifiche */

        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
        }

        .product-item {
            width: calc(33.33% - 20px);
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 10px;
            box-sizing: border-box;
        }

        .product-item p {
            font-weight: bold;
        }

        .product-item img {
            max-width: 100%;
            height: auto;
        }

        /* Stili per i form */
        .form-container {
            margin-top: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 20px;
            box-sizing: border-box;
        }

        .form-container input[type="text"], .form-container input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        .form-container input[type="submit"] {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        /* Aggiunta transizione al passaggio del mouse */
        .delete-icon svg {
            transition: fill 0.3s ease;
        }

        .delete-icon:hover svg {
            fill: red;
        }
        .plus-icon svg {
            transition: fill 0.3s ease;
        }
        .plus-icon:hover svg {
            fill: deepskyblue;
        }
    </style>
    <script language="javascript">

        function insertShowcase() {
            document.insertForm.requestSubmit();
        }

        function deleteElement(id_prod) {
            document.deleteForm.id_prod.value = id_prod;
            document.deleteForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main>
    <div>
        <h1>Vetrina</h1>
    </div>

    <div class="form-container">
        <p>Prodotti presenti in vetrina</p>
        <div class="plus-icon">
        <a href="javascript:insertProdForm.requestSubmit()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>
    </div>
    <br>
    <div class="container product-list">
        <%for (i = 0; i < showcases.size(); i++) {%>
        <div class="product-item">
            <p><%=products.get(i).getnome_prod()%></p>
            <div class="delete-icon">
                <a href="javascript:deleteElement(<%=showcases.get(i).getId_prod()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertProdForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.delete"/>
    </form>

</main>
<div>
    <%@include file="/include/footer.inc"%>
</div>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 30/04/24
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Prodotti";
    List<Prodotto> products = (List<Prodotto>) request.getAttribute("products");

    int maxViewSize;
    if(products.size() < 8) {
        maxViewSize = products.size();
    } else{
        maxViewSize = 8;
    }
    try {
        maxViewSize = (Integer) request.getAttribute("maxViewSize");
    } catch (NullPointerException e) {}

%>

<!DOCTYPE html>

<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        main {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }

        p {
            margin: 0;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }

        input[type="text"] {
            height: 20px;
            padding: 7px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button[type="submit"] {
            padding: 8px 12px;
            border-radius: 5px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .card {
            width: calc(33% - 20px);
            margin-bottom: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .card p {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

    </style>
    <script language="javascript">

        function insertProd() {
            document.insertForm.requestSubmit();
        }

        function deleteProd(id_prod) {
            document.deleteForm.id_prod.value = id_prod;
            document.deleteForm.requestSubmit();
        }

        function modifyProd(id) {
            document.modifyForm.id_prod.value = id;
            document.modifyForm.requestSubmit();
        }

        function searchFunc(name) {
            f = document.searchForm;
            f.searchString.value = name;
            f.requestSubmit();
        }

        function maxViewSizeInc(maxViewSize) {

            <%if((maxViewSize + 8) > products.size()) {%>
            document.loadMoreForm.maxViewSize.value = <%=products.size()%>;
            <%} else {%>
            document.loadMoreForm.maxViewSize.value = maxViewSize + 8;
            <%}%>
            document.loadMoreForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main>
    <div class="container">
        <h3>Leggenda: </h3>
        <div><p>Clicca su</p>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M9 4.58V4c0-1.1.9-2 2-2h2a2 2 0 012 2v.58a8 8 0 011.92 1.11l.5-.29a2 2 0 012.74.73l1 1.74a2 2 0 01-.73 2.73l-.5.29a8.06 8.06 0 010 2.22l.5.3a2 2 0 01.73 2.72l-1 1.74a2 2 0 01-2.73.73l-.5-.3A8 8 0 0115 19.43V20a2 2 0 01-2 2h-2a2 2 0 01-2-2v-.58a8 8 0 01-1.92-1.11l-.5.29a2 2 0 01-2.74-.73l-1-1.74a2 2 0 01.73-2.73l.5-.29a8.06 8.06 0 010-2.22l-.5-.3a2 2 0 01-.73-2.72l1-1.74a2 2 0 012.73-.73l.5.3A8 8 0 019 4.57zM7.88 7.64l-.54.51-1.77-1.02-1 1.74 1.76 1.01-.17.73a6.02 6.02 0 000 2.78l.17.73-1.76 1.01 1 1.74 1.77-1.02.54.51a6 6 0 002.4 1.4l.72.2V20h2v-2.04l.71-.2a6 6 0 002.41-1.4l.54-.51 1.77 1.02 1-1.74-1.76-1.01.17-.73a6.02 6.02 0 000-2.78l-.17-.73 1.76-1.01-1-1.74-1.77 1.02-.54-.51a6 6 0 00-2.4-1.4l-.72-.2V4h-2v2.04l-.71.2a6 6 0 00-2.41 1.4zM12 16a4 4 0 110-8 4 4 0 010 8zm0-2a2 2 0 100-4 2 2 0 000 4z"/></svg>
            <p>per modificare un prodotto</p></div>
        <div><p>Clicca su</p>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
            <p>per eliminare un prodotto</p></div>
    </div>
    <div class="container">
            <div class="search-form">
                <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
                    <input type="hidden" name="controllerAction" value="ProductManagement.searchView">
                    <input type="text" name="searchString" placeholder="Cerca nome prodotto" class="search-input">
                    <button type="submit" form="searchForm">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 56.966 56.966" width="16px" height="16px">
                            <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                        </svg>
                    </button>
                </form>
            </div>
    </div>
    <div class="container">
        <p>Lista prodotti,<br> clicca sul + per aggiungere un nuovo prodotto</p>
        <a href="javascript:insertProd()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>
    <div class="container">
        <%for (i = 0; i < maxViewSize; i++) {%>
        <div class="card">
            <div>
                <section>
                    <p><%=products.get(i).getnome_prod()%></p>
                </section>
                <section>
                    <p>Quantita' disponibile in magazzino <%=products.get(i).getquantita_disponibile()%></p>
                </section>
            </div>
            <div>
                <a href="javascript:modifyProd(<%=products.get(i).getid_prod()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M9 4.58V4c0-1.1.9-2 2-2h2a2 2 0 012 2v.58a8 8 0 011.92 1.11l.5-.29a2 2 0 012.74.73l1 1.74a2 2 0 01-.73 2.73l-.5.29a8.06 8.06 0 010 2.22l.5.3a2 2 0 01.73 2.72l-1 1.74a2 2 0 01-2.73.73l-.5-.3A8 8 0 0115 19.43V20a2 2 0 01-2 2h-2a2 2 0 01-2-2v-.58a8 8 0 01-1.92-1.11l-.5.29a2 2 0 01-2.74-.73l-1-1.74a2 2 0 01.73-2.73l.5-.29a8.06 8.06 0 010-2.22l-.5-.3a2 2 0 01-.73-2.72l1-1.74a2 2 0 012.73-.73l.5.3A8 8 0 019 4.57zM7.88 7.64l-.54.51-1.77-1.02-1 1.74 1.76 1.01-.17.73a6.02 6.02 0 000 2.78l.17.73-1.76 1.01 1 1.74 1.77-1.02.54.51a6 6 0 002.4 1.4l.72.2V20h2v-2.04l.71-.2a6 6 0 002.41-1.4l.54-.51 1.77 1.02 1-1.74-1.76-1.01.17-.73a6.02 6.02 0 000-2.78l-.17-.73 1.76-1.01-1-1.74-1.77 1.02-.54-.51a6 6 0 00-2.4-1.4l-.72-.2V4h-2v2.04l-.71.2a6 6 0 00-2.41 1.4zM12 16a4 4 0 110-8 4 4 0 010 8zm0-2a2 2 0 100-4 2 2 0 000 4z"/></svg>
                </a>
                <a href="javascript:deleteProd(<%=products.get(i).getid_prod()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
        <div>
            <%if(maxViewSize == products.size()){%>
            <p>Altri</p>
            <%} else {%>
            <a href="javascript:maxViewSizeInc(<%=maxViewSize%>)">Altri</a>
            <%}%>
        </div>
    </div>

    <%-- APPLICATION FORM--%>

    <form name="insertForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ProductManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.delete"/>
    </form>
    <form name="modifyForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.modifyView"/>
    </form>

    <form name="loadMoreForm" method="post" action="Dispatcher">
        <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>"/>
        <input type="hidden" name="controllerAction" value="ProductManagement.viewManagement"/>
    </form>

</main>
<div>
    <%@include file="/include/footer.inc"%>
</div>
</body>
</html>

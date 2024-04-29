<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 20/04/24
  Time: 16:32
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
    String menuActiveLink = "Interfaccia di amministrazione";
%>

<!DOCTYPE html>

<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <script language="javascript">
        function mainOnLoadHandler() {}
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f3f3f3;
        }
        nav {
            background-color: #333;
            overflow: hidden;
        }

        nav a {
            float: left;
            display: block;
            color: #ffffff;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 17px;
        }

        nav a:hover {
            background-color: #ddd;
            color: #333;
        }

        .container {
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }

        h1 {
            text-align: center;
        }
    </style>
</head>
<body class="bg-green-50">
<%@include file="/include/adminHeader.jsp"%>
<nav>
    <a href="javascript:prodManagementForm.requestSubmit()">Gestione Prodotti</a>
    <a href="javascript:showcaseManagementForm.requestSubmit()">Gestione Vetrina</a>
    <a href="javascript:userManagementForm.requestSubmit()">Gestione Utenti</a>
</nav>

<div class="container">
    <h2>Benvenuto nell'area di amministrazione</h2>
    <p>Da qui puoi gestire i prodotti, la vetrina e gli utenti del tuo e-commerce di frutta e verdura.</p>
</div>
    <form name="prodManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="WineManagement.view"/>
    </form>

    <form name="userManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserManagement.view"/>
    </form>
    <form name="showcaseManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.view"/>
    </form>

</body>
<div>
    <%@include file="/include/footer.inc"%>
</div>
</html>

<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 03/04/24
  Time: 11:54
  To change this template use File | Settings | File Templates.
  da creare, pagina principale
--%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Home";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
</head>
<body>
<%@include file="/include/header.inc"%>
<main>
    <%if (loggedOn) {%>
    Benvenuto <%=loggedUser.getNome()%> <%=loggedUser.getCognome()%>!<br/>
    Clicca sulla voce "Prodotti" per vedere i nostri prodotti.
    <%} else {%>
    Benvenuto.
    Fai il login per vedere i nostri prodotti, e vedere i tuoi ordini.<br/>
    Se non sei registrato fai click qui
    <button style="background-color: #73ad21;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;"
            onclick="location.href='Dispatcher?controllerAction=HomeManagement.registerView'">Registrati
    </button>
    <%}%>
</main>
<%@include file="/include/footer.inc"%>
</html>

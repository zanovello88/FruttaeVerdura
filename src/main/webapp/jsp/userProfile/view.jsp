<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 10/05/24
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    Utente user = (Utente)request.getAttribute("user");
    String menuActiveLink = user.getNome();%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <script language="javascript">

        function mainOnLoadHandler() {}

        function deletePrompt() {
            let deleteConfirmation = confirm("Sei sicuro di voler cancellare il profilo?");
            return deleteConfirmation;
        }

        function deleteProfile() {
            if(deletePrompt()) {
                document.deleteProfileForm.requestSubmit();
            }
        }

    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        main {
            margin: 20px auto;
            max-width: 800px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            align-items: center
        }

        #main-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        #info-section {
            text-align: center;
        }

        #info-section h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        #info-section p {
            font-size: 16px;
            margin-bottom: 5px;
        }

        #info-section span {
            font-weight: bold;
            color: #333;
        }

        .product-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #73ad21; /* Verde */
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .product-link:hover {
            background-color: #5f8c17; /* Verde più scuro al passaggio del mouse */
        }
        .product-link-r {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #ff0000;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .product-link-r:hover {
            background-color: #ad0000;
        }

    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>
<main>
    <%--USER DATA--%>
        <div id="main-container">
            <div id="info-section">
                <h1><%=user.getNome()%></h1>
                <p><span>Nome Utente:</span> <%=user.getUsername()%></p>
                <p><span>Nome:</span> <%=user.getNome()%></p>
                <p><span>Cognome:</span> <%=user.getCognome()%></p>
                <% if(user.getemail() != null) { %>
                <p><span>Email:</span> <%=user.getemail()%></p>
                <% } %>
            </div>
        </div>
    <div style="text-align: center">
        <a href="javascript:editProfileViewForm.requestSubmit()" class="product-link">
            Modifica profilo
        </a>
        <a href="javascript:deleteProfile()" class="product-link-r">
            Cancella profilo
        </a>
    </div>

    <form id="deleteProfileForm" name="deleteProfileForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteProfile"/>
    </form>

    <form id="editProfileViewForm" name="editProfileViewForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.editProfileView"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</body>
</html>
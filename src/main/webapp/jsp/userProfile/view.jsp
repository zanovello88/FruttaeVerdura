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
</head>
<body class="bg-gray-500">
<%@include file="/include/header.jsp"%>
<main class="w-full bg-gray-500 ">
    <%--USER DATA--%>
    <div>
        <div id="main-container" class="flex flex-row px-32">
            <div id="info-section" class="w-1/2 pt-12 pb-6">
                <h1 class="pt-3 flex items-center justify-between text-gray-900 font-bold text-2xl"><%=user.getNome()%></h1>
                <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            NomeUtente
                        </span><%=user.getUsername()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                       <span class="font-medium text-lg">
                           Nome
                       </span> <%=user.getNome()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            Cognome
                        </span><%=user.getCognome()%>
                </p>
                <%if(user.getemail() != null) {%>
                <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            Email
                        </span><%=user.getemail()%>
                </p>
                <%}%>
                <%--<%if(user.getPhone() != null) {%>
                <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            <%if (languageString.equals("ita")){%>Telefono<%}if (languageString.equals("eng")){ %>Phone<% }%>
                        </span><%=user.getPhone()%>
                </p>
                <%}%>--%>
            </div>
        </div>
    </div>
    <div class="flex flex-row flex-no-wrap justify-center mx-4 px-4 mb-12">
        <a class="bg-gray-700 hover:bg-gray-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-40" href="javascript:editProfileViewForm.requestSubmit()">
            Modifica profilo
        </a>
        <a class="bg-red-400 hover:bg-gray-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-28" href="javascript:deleteProfile()">
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
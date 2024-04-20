<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 20/04/24
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
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
    <script language="javascript">

        function insertShowcase() {
            document.insertForm.requestSubmit();
        }

        function deleteElement(wine_id) {
            document.deleteForm.wine_id.value = wine_id;
            document.deleteForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center bg-gray-500">
    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-bold text-black text-xl">Vetrina</p>
    </div>

    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-medium text-black text-xl">Vini presenti in vetrina</p>
        <a class="ml-2 mt-1" href="javascript:insertWineForm.requestSubmit()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>
    <br>
    <div class="container mx-auto flex flex-wrap justify-center pb-12">
        <%for (i = 0; i < showcases.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col border justify-center">
            <p class="float-left pt-3 text-gray-900 font-medium pr-4 "><%=products.get(i).getnome_prod()%></p>
            <div class="float-right flex flex-no-wrap flex-row ">
                <a class="ml-2" href="javascript:deleteElement(<%=showcases.get(i).getId_prod()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertWineForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.delete"/>
    </form>

</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
</html>
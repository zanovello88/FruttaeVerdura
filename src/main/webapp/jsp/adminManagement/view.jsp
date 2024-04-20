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
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center"  >
    <div class="my-6">
        <%--                 Utenti                   --%>
        <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
            <a class="bg-black hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:userManagementForm.requestSubmit()">
                <p class="uppercase font-bold text-white text-2xl pr-2">Gestione Utenti</p>
                <svg fill="#000000" width="40px" height="40px" viewBox="0 0 24 24" id="user" data-name="Flat Color" xmlns="http://www.w3.org/2000/svg" class="icon flat-color"><path id="primary" d="M21,20a2,2,0,0,1-2,2H5a2,2,0,0,1-2-2,6,6,0,0,1,6-6h6A6,6,0,0,1,21,20Zm-9-8A5,5,0,1,0,7,7,5,5,0,0,0,12,12Z" style="fill: rgb(255, 255, 255);"></path></svg>
            </a>
        </div>
        <%--                 Vini                   --%>
        <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
            <a class="bg-black hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:wineManagementForm.requestSubmit()">
                <p class="uppercase font-bold text-white text-2xl pr-2">Gestione Vini</p>
                <svg style="fill: rgb(255, 255, 255)" width="40px" height="40px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" version="1.1">
                    <g>
                        <rect height="6" width="12" y="1" x="6" fill="#ecf0f1"/>
                        <path d="m11 14h2v2h-2z" fill="#7f8c8d"/>
                        <path d="m6 1v1 7c0 3.314 2.6863 6 6 6 3.314 0 6-2.686 6-6v-7-1h-1v1 6.4688c0 3.0582-2.239 5.5312-5 5.5312-2.7614 0-5-2.473-5-5.5312v-6.4688-1h-1z" fill="#bdc3c7"/>
                        <path d="m7 6v1 1 0.4688c0 3.0582 2.2386 5.5312 5 5.5312 2.761 0 5-2.473 5-5.5312v-0.4688-1-1h-10z" fill="#e74c3c"/>
                        <path d="m11 16h2v6h-2z" fill="#95a5a6"/>
                        <path d="m7 22h10v1h-10z" fill="#bdc3c7"/>
                        <path d="m7 6h10v1h-10z" fill="#c0392b"/>
                        <path d="m7 2v7c0 2.761 2.2386 5 5 5 2.761 0 5-2.239 5-5v-7h-1v4.0312 2.9688c0 2.209-1.791 4-4 4-2.2091 0-4-1.791-4-4v-2.9688-4.0312h-1z" fill="#ecf0f1"/>
                    </g>
                </svg>
            </a>
        </div>
        <%--                 Showcase                   --%>
        <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
            <a class="bg-black hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:showcaseManagementForm.requestSubmit()">
                <p class="uppercase font-bold text-white text-2xl pr-2">Gestione Vetrina</p>
                <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M6 6c0-1.4 0-2.1.272-2.635a2.5 2.5 0 0 1 1.093-1.093C7.9 2 8.6 2 10 2h4c1.4 0 2.1 0 2.635.272a2.5 2.5 0 0 1 1.092 1.093C18 3.9 18 4.6 18 6v12c0 1.4 0 2.1-.273 2.635a2.5 2.5 0 0 1-1.092 1.092C16.1 22 15.4 22 14 22h-4c-1.4 0-2.1 0-2.635-.273a2.5 2.5 0 0 1-1.093-1.092C6 20.1 6 19.4 6 18V6zm14 0a1 1 0 1 1 2 0v12a1 1 0 1 1-2 0V6zM3 5a1 1 0 0 0-1 1v12a1 1 0 1 0 2 0V6a1 1 0 0 0-1-1z" fill="#000000" style="fill: rgb(255, 255, 255)"/></svg>                </a>
        </div>
    </div>

    <form name="wineManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="WineManagement.view"/>
    </form>

    <form name="userManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserManagement.view"/>
    </form>
    <form name="couponManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="CouponManagement.view"/>
    </form>

    <form name="showcaseManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.view"/>
    </form>

</main>
<div class="fixed w-full bottom-0 bg-yellow-300">
    <%@include file="/include/adminFooter.jsp"%>
</div>
</html>

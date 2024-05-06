<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 29/04/24
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Utenti";
    List<Utente> users = (List<Utente>) request.getAttribute("users");

    int maxViewSize;
    if(users.size() < 8) {
        maxViewSize = users.size();
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
    <script language="javascript">

        function searchFunc(name) {
            f = document.searchForm;
            f.searchString.value = name;
            f.requestSubmit();
        }

        function setAdmin(id) {
            document.setAdminForm.user_id.value = id;
            document.setAdminForm.requestSubmit();
        }

        function orderManagement(user_id) {
            document.orderManagementForm.user_id.value = user_id;
            document.orderManagementForm.requestSubmit();
        }

        function deleteUser(id) {
            document.deleteForm.user_id.value = id;
            document.deleteForm.requestSubmit();
        }

        function maxViewSizeInc(maxViewSize) {

            <%if((maxViewSize + 8) > users.size()) {%>
            document.loadMoreForm.maxViewSize.value = <%=users.size()%>;
            <%} else {%>
            document.loadMoreForm.maxViewSize.value = maxViewSize + 8;
            <%}%>
            document.loadMoreForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
    <style>
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
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center bg-gray-500">
    <h1>Lista Utenti</h1>
    <div class="search-container">
        <form id="searchForm" name="searchForm" action="Dispatcher" method="post" class="search-form">
            <input type="hidden" name="controllerAction" value="UserManagement.searchView">
            <input type="text" name="searchString" placeholder="Trova nome utente" class="search-input">
            <button type="submit" form="searchForm" class="search-button">
                <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 56.966 56.966">
                    <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                </svg>
            </button>
        </form>
    </div>
    <div class="container">
        <h3>Leggenda: </h3>
        <p>Clicca su
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M11.85 17.56a1.5 1.5 0 01-1.06.44H10v.5c0 .83-.67 1.5-1.5 1.5H8v.5c0 .83-.67 1.5-1.5 1.5H4a2 2 0 01-2-2v-2.59A2 2 0 012.59 16l5.56-5.56A7.03 7.03 0 0115 2a7 7 0 11-1.44 13.85l-1.7 1.71zm1.12-3.95l.58.18a5 5 0 10-3.34-3.34l.18.58L4 17.4V20h2v-.5c0-.83.67-1.5 1.5-1.5H8v-.5c0-.83.67-1.5 1.5-1.5h1.09l2.38-2.39zM18 9a1 1 0 01-2 0 1 1 0 00-1-1 1 1 0 010-2 3 3 0 013 3z"/></svg>
            per rendere amministratore o utente registrato</p>
        <p>Clicca su
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
            per eliminare utente</p>
    </div>
    <div class="container mx-auto flex flex-wrap pb-12">
        <%for (i = 0; i < users.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col border" >
            <div class="float-left flex flex-no-wrap justify-between items-center ">
                <div class="flex flex-col flex-wrap justify-start items-start">
                    <div class="flex flex-row flex-no-wrap justify-center items-center">
                        <a href="javascript:orderManagement(<%=users.get(i).getid_utente()%>)" class="pt-3 text-gray-900 font-bold pr-4"><%=users.get(i).getNome()%> <%=users.get(i).getCognome()%></a>
                        <%if(users.get(i).getAdmin().equals("Y")){%>
                        <p class="pt-3 text-green-600 font-bold ml-1">Amministratore</p>
                        <%}%>
                    </div>
                    <p class="pt-3 text-gray-900 font-normal text-sm pr-4">
                        <span class="font-medium">Nome Utente</span> <%=users.get(i).getUsername()%>
                        <span class="font-medium">Id Utente</span> (<%=users.get(i).getid_utente()%>)
                    </p>
                </div>
            </div>
            <div class="float-right flex flex-no-wrap flex-row">
                <%if(!users.get(i).getAdmin().equals("N")){%>
                <a href="javascript:setAdmin(<%=users.get(i).getid_utente()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-green-600" d="M11.85 17.56a1.5 1.5 0 01-1.06.44H10v.5c0 .83-.67 1.5-1.5 1.5H8v.5c0 .83-.67 1.5-1.5 1.5H4a2 2 0 01-2-2v-2.59A2 2 0 012.59 16l5.56-5.56A7.03 7.03 0 0115 2a7 7 0 11-1.44 13.85l-1.7 1.71zm1.12-3.95l.58.18a5 5 0 10-3.34-3.34l.18.58L4 17.4V20h2v-.5c0-.83.67-1.5 1.5-1.5H8v-.5c0-.83.67-1.5 1.5-1.5h1.09l2.38-2.39zM18 9a1 1 0 01-2 0 1 1 0 00-1-1 1 1 0 010-2 3 3 0 013 3z"/></svg>
                </a>
                <%}else{%>
                <a href="javascript:setAdmin(<%=users.get(i).getid_utente()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-gray-700" d="M11.85 17.56a1.5 1.5 0 01-1.06.44H10v.5c0 .83-.67 1.5-1.5 1.5H8v.5c0 .83-.67 1.5-1.5 1.5H4a2 2 0 01-2-2v-2.59A2 2 0 012.59 16l5.56-5.56A7.03 7.03 0 0115 2a7 7 0 11-1.44 13.85l-1.7 1.71zm1.12-3.95l.58.18a5 5 0 10-3.34-3.34l.18.58L4 17.4V20h2v-.5c0-.83.67-1.5 1.5-1.5H8v-.5c0-.83.67-1.5 1.5-1.5h1.09l2.38-2.39zM18 9a1 1 0 01-2 0 1 1 0 00-1-1 1 1 0 010-2 3 3 0 013 3z"/></svg>
                </a>
                <%}%>
                <a class="ml-2" href="javascript:deleteUser(<%=users.get(i).getid_utente()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
        <div class="w-full m-4 flex justify-center items-center">
            <%if(maxViewSize == users.size()){%>
            <p class="bg-blue-400 text-white font-bold py-2 px-4 rounded-full">Altro</p>
            <%} else {%>

            <a class="bg-blue-400 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full"
               href="javascript:maxViewSizeInc(<%=maxViewSize%>)">
                Altri
            </a>
            <%}%>
        </div>
    </div>

    <%--        APPLICATION FORM--%>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.delete"/>
    </form>

    <form name="setAdminForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.setAdmin"/>
    </form>

    <form name="orderManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.orderModView"/>
    </form>

    <form name="loadMoreForm" method="post" action="Dispatcher">
        <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>"/>
        <input type="hidden" name="controllerAction" value="UserManagement.view"/>
    </form>

</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/footer.inc"%>
</div>

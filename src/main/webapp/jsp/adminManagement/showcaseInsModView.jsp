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
    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function insert(wine_id) {
            f = document.insertForm;
            f.wine_id.value = wine_id;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center bg-gray-500">
    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-bold text-black text-xl">Lista prodotti></p>
    </div>
    <div class="w-full flex justify-center">
        <div class="w-1/6 flex flex-row flex-no-wrap justify-between items-center m-4 p-2">
            <div class="flex items-center" id="store-nav-content">
                <div class="pt-2 relative mx-auto text-gray-600">
                    <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="ShowcaseManagement.searchView">
                        <input type="text" name="searchString" placeholder=" Cerca nome vino" class="border-2 border-gray-300 bg-white h-10 px-5 pr-16 rounded-lg text-sm  focus:outline-none">
                        <button type="submit" form="searchForm" class="absolute right-0 top-0 mt-5 mr-4">
                            <svg class="text-gray-600 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px"
                                 viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                                 width="512px" height="512px">
                                <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container mx-auto flex flex-wrap pb-12">
        <%for (i = 0; i < products.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col border">
            <div class="order-1 w-full flex flex-col flex-wrap items-center justify-between py-6 px-4">
                <section id="wine-info" class="w-full flex pb-2">
                    <p class="float-left text-gray-900 font-bold pr-4"><%=products.get(i).getnome_prod()%></p>
                </section>
                <section id="wine-avalaibility" class="pt-2 w-full flex p-1 border-t border-gray-400">
                    <p>Quantita' disponibile in magazzino: <%=products.get(i).getquantita_disponibile()%></p>
                </section>
            </div>
            <div class="order-2 float-right flex flex-no-wrap flex-row mx-4">
                <a href="javascript:insert(<%=products.get(i).getid_prod()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-black" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>                </a>
            </div>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.insert"/>
    </form>
</main>
<%@include file="/include/footer.inc"%>
</html>
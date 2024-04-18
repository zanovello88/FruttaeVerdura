<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 18/04/24
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@ page import="java.util.List" %>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    String menuActiveLink = prodotto.getnome_prod();
%>

<!DOCTYPE html>
<html>
<head>
    <script language="javascript">

        function AddToCart(id_prod) {
            alert("Aggiunto al carrello");
            document.AddToCartForm.id_prod.value = id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function productViewFunc(id_prod) {
            f = document.productView;
            f.id_prod.value = wine_id;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
    <%@include file="/include/htmlHead.inc"%>
</head>
<body class="bg-gray-500">
<%@include file="/include/header.inc"%>
<main class="w-full ">
    <%--PRODUCT DATA--%>
    <div id="main-container" class="flex flex-col px-32 mb-8">
        <%if(!loggedOn){%>
        <div class="w-1/2 mx-auto container bg-gray-100 rounded-md mt-12 py-4 flex flex-row justify-start">
            <div class="ml-4 mr-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-gray-500" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm0-9a1 1 0 011 1v4a1 1 0 01-2 0v-4a1 1 0 011-1zm0-4a1 1 0 110 2 1 1 0 010-2z"/></svg>
            </div>
            <p>Accedi per aggiungere un prodotto al carrello</p>
        </div>
        <%}%>
        <div class="flex flex-row">
            <div id="image-section" class="float w-1/2 py-12 pr-8 mt-5 md:flex-shrink-0">
                <img class="float-right rounded-md w-1/2 max-w-md" src="<%=prodotto.getimg_path()%>" alt="stock wine image">
            </div>
            <section id="info-section" class="w-1/2 py-12">
                <h1 class="pt-3 text-gray-900 font-bold text-2xl"><%=prodotto.getnome_prod()%></h1>
                <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Sede acquisto
                    </span><%=prodotto.getsede_acquisto()%>
                </p>
                <%--<p class="pt-3 text-gray-900 font-regular">
                   <span class="font-medium text-lg">
                       Alcool
                   </span> <%=wine.getAlcool()%>%
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        <%if (languageString.equals("ita")){%>Formato<%}if (languageString.equals("eng")){ %>Size<% }%>
                    </span><%=wine.getFormat()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        <%if (languageString.equals("ita")){%>Annata<%}if (languageString.equals("eng")){ %>Wine age<% }%>
                    </span><%=wine.getAnnata()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        <%if (languageString.equals("ita")){%>Denominazione<%}if (languageString.equals("eng")){ %>Designation of Origin<% }%>
                    </span><%=wine.getDenominazione()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        <%if (languageString.equals("ita")){%>Provenienza<%}if (languageString.equals("eng")){ %>Provenance<% }%>
                    </span><%=wine.getProvenance()%>
                </p>--%>
                <p class="pt-3 text-gray-900 text-3xl">
                    <%=prodotto.getprezzo()%> &euro;
                </p>
                <%if(loggedOn){%>
                <div class="float">
                    <a class="zoom-animation float-left bg-gray-700 hover:bg-blue-dark text-white font-bold px-4 py-2 mt-6 rounded-full w-28" href="javascript:AddToCart(<%=prodotto.getid_prod()%>)">
                        Aggiungi al carrello
                    </a>
                </div>
                <%}%>
            </section>
        </div>
        <section class="mx-auto container p-4 border-t border-gray-300">
            <h1 class="my-4 pt-3 text-gray-900 font-bold text-2xl">
                Descrizione
            </h1>
            <p><%=prodotto.getdescrizione()%></p>
        </section>
    </div>

    <form name="AddToCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="CartManagement.AddWine"/>
        <input type="hidden" name="viewUrl" value="homeManagement/view"/>
    </form>

    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>

</main>
<div class="w-full bottom-0">
    <%@include file="/include/footer.inc"%>
</div>
</body>
</html>

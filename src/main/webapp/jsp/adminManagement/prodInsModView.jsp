<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 30/04/24
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Inserimento vino nel catalogo";

    Wine wine = (Wine) request.getAttribute("wine");
    String action=(wine != null) ? "modify" : "insert";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>

    <script language="javascript">
        var status="<%=action%>"

        function DynamicFormCheck(e) {
            var EventTriggerName = (e.target.name);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo " + EventTriggerName + " richiede un numero");
        }

        function StaticFormCheck(){
            var prezzoValue = (document.insModForm.price.value);
            var avalaibilityValue = (document.insModForm.avalaibility.value);
            var alcoolValue = (document.insModForm.alcool.value);

            if(isNaN(prezzoValue)){
                alert("Il campo PREZZO richiede un numero");
                return false;
            }

            if(isNaN(avalaibilityValue)){
                alert("Il campo QUANTITY richiede un numero");
                return false;
            }

            if(isNaN(alcoolValue)){
                alert("Il campo ALCOOL richiede un numero");
                return false;
            }
            return true;
        }

        function submitWine() {
            if (StaticFormCheck()) {
                // alert("campi ok");
                document.insModForm.controllerAction.value = "WineManagement."+status;
                document.insModForm.requestSubmit();
            }
        }

        function goback() {
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler() {
            // document.insModForm.addEventListener("submit", submitWine);
            document.insModForm.Invia.addEventListener("click", submitWine);
            document.insModForm.backButton.addEventListener("click", goback);
            document.insModForm.price.addEventListener("change", DynamicFormCheck);
            document.insModForm.avalaibility.addEventListener("change", DynamicFormCheck);
            document.insModForm.alcool.addEventListener("change", DynamicFormCheck);

        }
    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="flex flex-col justify-center items-center pt-8 pb-8">
    <h1 class="my-4 uppercase tracking-wide no-underline hover:no-underline font-bold text-black text-xl"><%if (languageString.equals("ita")){%>Gestione <%}if (languageString.equals("eng")){ %>Managment<% }%> <%=(action.equals("modify")) ? "Modifica vino" : "Nuovo Vino"%></h1>
    <section id="insModFormSection" class="w-1/3">
        <form name="insModForm" action="Dispatcher" method="post">
            <div class="field">
                <label for="name"><span class="font-medium"><%if (languageString.equals("ita")){%>Nome<%}if (languageString.equals("eng")){ %>Name<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="name" name="name"
                       value="<%=(action.equals("modify")) ? wine.getName() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="product_image"><span class="font-medium"><%if (languageString.equals("ita")){%>URL/Path dell'immagine del prodotto<%}if (languageString.equals("eng")){ %>URL/Path of product's image<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="product_image" name="product_image"
                       value="<%=(action.equals("modify")) ? wine.getProductImage() : ""%>"
                       size="20" maxlength="256"/>
            </div>
            <div class="field">
                <label for="price"><span class="font-medium"><%if (languageString.equals("ita")){%>Prezzo<%}if (languageString.equals("eng")){ %>Price<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="price" name="price"
                       value="<%=(action.equals("modify")) ? wine.getPrice() : ""%>"
                       required size="20" maxlength="8"/>
            </div>
            <div class="field">
                <label for="denominazione"><span class="font-medium"><%if (languageString.equals("ita")){%>Denominazione<%}if (languageString.equals("eng")){ %>Denomination<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="denominazione" name="denominazione"
                       value="<%=(action.equals("modify")) ? wine.getDenominazione() : ""%>"
                       size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="annata"><span class="font-medium"><%if (languageString.equals("ita")){%>Annata<%}if (languageString.equals("eng")){ %>Vine's Age<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text"  id="annata" name="annata"
                       value="<%=(action.equals("modify")) ? wine.getAnnata() : ""%>"
                       size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="avalaibility"><span class="font-medium"><%if (languageString.equals("ita")){%>Quantita<%}if (languageString.equals("eng")){ %>Availability<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="avalaibility" name="avalaibility"
                       value="<%=(action.equals("modify")) ? wine.getAvalaibility() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="vitigni"><span class="font-medium"><%if (languageString.equals("ita")){%>Vitigni<%}if (languageString.equals("eng")){ %>Vines<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="vitigni" name="vitigni"
                       value="<%=(action.equals("modify")) ? wine.getVitigni() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="provenance"><span class="font-medium"><%if (languageString.equals("ita")){%>Provenienza<%}if (languageString.equals("eng")){ %>Provenance<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="provenance" name="provenance"
                       value="<%=(action.equals("modify")) ? wine.getProvenance() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="format"><span class="font-medium"><%if (languageString.equals("ita")){%>Formato<%}if (languageString.equals("eng")){ %>Format<% }%></span></label>
                <input type="radio" id="format" name="format" value="750 ml" <%=(action.equals("modify") && wine.getCategory().equals("750 ml")) ? "checked" : ""%>/> 750 ml
                <input type="radio" id="format1" name="format" value="1.50 l" <%=(action.equals("modify") && wine.getCategory().equals("1.50 l")) ? "checked" : ""%>/> 1.50 l
            </div>
            <div class="field">
                <label for="category"><span class="font-medium"><%if (languageString.equals("ita")){%>Categoria<%}if (languageString.equals("eng")){ %>Category<% }%></span></label>
                <input type="radio" id="category" name="category" value="Bianco" <%=(action.equals("modify") && wine.getCategory().equals("Bianco")) ? "checked" : ""%>/> Bianco
                <input type="radio" id="category1" name="category" value="Rosso" <%=(action.equals("modify") && wine.getCategory().equals("Rosso")) ? "checked" : ""%> /> Rosso
                <input type="radio" id="category2" name="category" value="Champagne" <%=(action.equals("modify") && wine.getCategory().equals("Champagne")) ? "checked" : ""%> /> Champagne
                <input type="radio" id="category3" name="category" value="Altro" <%=(action.equals("modify") && wine.getCategory().equals("Altro")) ? "checked" : ""%> /> Altro
            </div>
            <div class="field">
                <label for="alcool"><span class="font-medium">Alcool</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="number" id="alcool" name="alcool" min="5.0" max="20.0" step="0.5"
                       value="<%=(action.equals("modify")) ? wine.getAlcool() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="description"><span class="font-medium"><%if (languageString.equals("ita")){%>Descrizione<%}if (languageString.equals("eng")){ %>Description<% }%></span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="description" name="description"
                       value="<%=(action.equals("modify")) ? wine.getDescription() : ""%>"
                       required size="20" maxlength="2048"/>
            </div>
            <div class="field my-4">
                <input type="button" name ="Invia" class="bg-gray-700 hover:bg-green-500 hover:text-black text-white font-bold py-2 px-4 rounded-full w-20" value="<%if (languageString.equals("ita")){%>Invia<%}if (languageString.equals("eng")){ %>Done<% }%>"/>
                <input type="button" name="backButton" class="bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-24 ml-2" value="<%if (languageString.equals("ita")){%>Annulla<%}if (languageString.equals("eng")){ %>Back<% }%>"/>
            </div>
            <%if (action.equals("modify")) {%>
            <input type="hidden" name="wine_id" value="<%=wine.getWineId()%>"/>
            <%}%>
            <input type="hidden" name="controllerAction"/>
        </form>
    </section>

    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
    </form>

</main>
<%@include file="/include/adminFooter.jsp"%>
</body>

</html>
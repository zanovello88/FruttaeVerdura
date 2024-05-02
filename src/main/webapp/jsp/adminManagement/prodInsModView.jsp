<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 30/04/24
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Inserimento prodotto nel catalogo";

    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    String action=(prodotto != null) ? "modify" : "insert";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>

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

            if(isNaN(prezzoValue)){
                alert("Il campo PREZZO richiede un numero");
                return false;
            }

            if(isNaN(avalaibilityValue)){
                alert("Il campo QUANTITY richiede un numero");
                return false;
            }

            return true;
        }

        function submitProduct() {
            if (StaticFormCheck()) {
                // alert("campi ok");
                document.insModForm.controllerAction.value = "ProductManagement."+status;
                document.insModForm.requestSubmit();
            }
        }

        function goback() {
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler() {
            // document.insModForm.addEventListener("submit", submitWine);
            document.insModForm.Invia.addEventListener("click", submitProduct);
            document.insModForm.backButton.addEventListener("click", goback);
            document.insModForm.price.addEventListener("change", DynamicFormCheck);
            document.insModForm.avalaibility.addEventListener("change", DynamicFormCheck);
        }
    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main>
    <h1>Gestione <%=(action.equals("modify")) ? "Modifica prodotto" : "Nuovo Prodotto"%></h1>
    <section>
        <form name="insModForm" action="Dispatcher" method="post">
            <div>
                <label for="name"><span class="font-medium">Nome</span></label>
                <input type="text" id="name" name="name"
                       value="<%=(action.equals("modify")) ? prodotto.getnome_prod() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="product_image"><span class="font-medium">URL/Path dell'immagine del prodotto</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="product_image" name="product_image"
                       value="<%=(action.equals("modify")) ? prodotto.getimg_path() : ""%>"
                       size="20" maxlength="256"/>
            </div>
            <div class="field">
                <label for="price"><span class="font-medium">Prezzo</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="price" name="price"
                       value="<%=(action.equals("modify")) ? prodotto.getprezzo() : ""%>"
                       required size="20" maxlength="8"/>
            </div>
            <div class="field">
                <label for="avalaibility"><span class="font-medium">Quantita</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="avalaibility" name="avalaibility"
                       value="<%=(action.equals("modify")) ? prodotto.getquantita_disponibile() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="provenance"><span class="font-medium">Sede acquisto</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="provenance" name="provenance"
                       value="<%=(action.equals("modify")) ? prodotto.getsede_acquisto() : ""%>"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label for="category"><span class="font-medium">Categoria</span></label>
                <input type="radio" id="category" name="category" value="Frutta" <%=(action.equals("modify") && prodotto.getcategoria().equals("Frutta")) ? "checked" : ""%>/> Frutta
                <input type="radio" id="category1" name="category" value="Vedura" <%=(action.equals("modify") && prodotto.getcategoria().equals("Verdura")) ? "checked" : ""%> /> Vedura
                <input type="radio" id="category3" name="category" value="Altro" <%=(action.equals("modify") && prodotto.getcategoria().equals("Altro")) ? "checked" : ""%> /> Altro
            </div>
            <div class="field">
                <label for="description"><span class="font-medium">Descrizione</span></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="description" name="description"
                       value="<%=(action.equals("modify")) ? prodotto.getdescrizione() : ""%>"
                       required size="20" maxlength="2048"/>
            </div>
            <div class="field my-4">
                <input type="button" name ="Invia" class="bg-gray-700 hover:bg-green-500 hover:text-black text-white font-bold py-2 px-4 rounded-full w-20" value="Invia"/>
                <input type="button" name="backButton" class="bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-24 ml-2" value="Annulla"/>
            </div>
            <%if (action.equals("modify")) {%>
            <input type="hidden" name="id_prod" value="<%=prodotto.getid_prod()%>"/>
            <%}%>
            <input type="hidden" name="controllerAction"/>
        </form>
    </section>

    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</body>

</html>
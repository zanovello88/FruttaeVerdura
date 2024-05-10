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

        function StaticFormCheck() {
            var prezzoValue = document.getElementById("Prezzo").value;
            var avalaibilityValue = document.getElementById("Quantità_disp").value;

            if (isNaN(prezzoValue)) {
                alert("Il campo PREZZO richiede un numero valido");
                return false;
            }

            if (isNaN(avalaibilityValue)) {
                alert("Il campo QUANTITÀ richiede un numero valido");
                return false;
            }

            return true;
        }


        function submitProduct() {
            if (StaticFormCheck()) {
                // alert("campi ok");
                document.insModForm.controllerAction.value = "ProductManagement."+status;
                document.insModForm.submit();
            }
        }

        function goback() {
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler() {
            // document.insModForm.addEventListener("submit", submitWine);
            document.insModForm.Invia.addEventListener("click", submitProduct);
            document.insModForm.backButton.addEventListener("click", goback);
            document.insModForm.Prezzo.addEventListener("change", DynamicFormCheck);
            document.insModForm.Quantità_disp.addEventListener("change", DynamicFormCheck);
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        /* Stile per il contenitore principale */
        main {
            margin: 20px auto;
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Stile per gli elementi del modulo */
        form div {
            margin-bottom: 15px;
        }

        /* Stile per le etichette */
        label {
            display: block;
            font-weight: bold;
        }
        /* Stile per il menu a tendina */
        select {
            width: calc(100% - 10px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #fff; /* Background bianco */
            color: #333; /* Colore del testo */
        }

        /* Stile per le opzioni del menu a tendina */
        select option {
            background-color: #fff; /* Background bianco */
            color: #333; /* Colore del testo */
        }

        /* Stile per gli input */
        input[type="text"] {
            width: calc(100% - 10px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Stile per i pulsanti */
        input[type="button"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #45a049;
        }

        /* Stile per il pulsante Annulla */
        input[name="backButton"] {
            background-color: #f44336;
        }

        input[name="backButton"]:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main>
    <h1>Gestione <%=(action.equals("modify")) ? "Modifica prodotto" : "Nuovo Prodotto"%></h1>
    <section>
        <form name="insModForm" action="Dispatcher" method="post">
            <div>
                <label for="Nome">Nome</label>
                <input type="text" id="Nome" name="Nome"
                       value="<%= (action.equals("modify")) ? prodotto.getnome_prod() : "" %>"
                       required size="20" maxlength="50"/>
            </div>
            <div>
                <label for="img_path">URL/Path dell'immagine del prodotto</label>
                <input type="text" id="img_path" name="img_path"
                       value="<%= (action.equals("modify")) ? prodotto.getimg_path() : "" %>"
                       size="20" maxlength="256"/>
            </div>
            <div>
                <label for="Prezzo">Prezzo</label>
                <input type="text" id="Prezzo" name="Prezzo"
                       value="<%= (action.equals("modify")) ? prodotto.getprezzo() : "" %>"
                       required size="20" maxlength="8"/>
            </div>
            <div>
                <label for="Quantità_disp">Quantità</label>
                <input type="text" id="Quantità_disp" name="Quantità_disp"
                       value="<%= (action.equals("modify")) ? prodotto.getquantita_disponibile() : "" %>"
                       required size="20" maxlength="50"/>
            </div>
            <div>
                <label for="Sede_acquisto">Sede acquisto</label>
                <input type="text" id="Sede_acquisto" name="Sede_acquisto"
                       value="<%= (action.equals("modify")) ? prodotto.getsede_acquisto() : "" %>"
                       required size="20" maxlength="50"/>
            </div>
            <div>
                <label for="Descrizione">Descrizione</label>
                <input type="text" id="Descrizione" name="Descrizione"
                       value="<%= (action.equals("modify")) ? prodotto.getdescrizione() : "" %>"
                       required size="20" maxlength="2048"/>
            </div>
            <div>
                <label for="Categoria">Categoria</label>
                <select id="Categoria" name="Categoria" required>
                    <option value="frutta" <%=(action.equals("modify") && prodotto.getcategoria().equals("frutta")) ? "selected" : ""%>>Frutta</option>
                    <option value="verdura" <%=(action.equals("modify") && prodotto.getcategoria().equals("verdura")) ? "selected" : ""%>>Verdura</option>
                    <option value="altro" <%=(action.equals("modify") && prodotto.getcategoria().equals("altro")) ? "selected" : ""%>>Altro</option>
                </select>
            </div>
            <div>
                <input type="button" name="Invia" value="Invia" onclick="submitProduct()"/>
                <input type="button" name="backButton" value="Annulla" onclick="goback()"/>
            </div>
            <%if (action.equals("modify")) {%>
            <input type="hidden" name="id_prod" value="<%= prodotto.getid_prod() %>"/>
            <%}%>
            <input type="hidden" name="controllerAction"/>
        </form>
    </section>

    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ProductManagement.viewManagement"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</body>

</html>

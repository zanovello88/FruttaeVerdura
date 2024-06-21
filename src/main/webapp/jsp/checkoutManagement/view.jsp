<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 08/05/24
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.math.BigDecimal" %>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Checkout";

    List<Cart> carts = (List<Cart>) request.getAttribute("carts");
    Utente user = (Utente)request.getAttribute("user");

    BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal shipping = (BigDecimal) request.getAttribute("shipping");
    BigDecimal total_discounted = BigDecimal.ZERO;

%>

<!DOCTYPE html><html>
<head>
    <script lang="javascript">
        var now = Date.now();
        var NowDate = new Date(now);

        function StaticFormCheck(){
            var card_number =  document.CompleteOrderForm.card_n.value;
            var cvc = document.CompleteOrderForm.cvc.value;
            var data = Date.parse("01/"+document.CompleteOrderForm.exp_date.value);

            if(isNaN(card_number)){
                alert("Il campo 'NUMERO DI CARTA' richiede un numero");
                return false;
            }

            if(isNaN(cvc)){
                alert("Il campo 'CVC/CCV' richiede un numero");
                return false;
            }

            if(isNaN(data)){
                alert("Il campo 'DATA DI SCADENZA' richiede una data");
                return false;
            }

            return true;
        }
        function DynamicFormCheck_int(e) {
            var EventTriggerName = (e.target.id);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo '" + EventTriggerName + "' richiede un numero");
        }

        function CompleteOrder() {
            if (StaticFormCheck()) {
                document.CompleteOrderForm.requestSubmit();
            }
        }

        function mainOnLoadHandler() {
            document.CompleteOrderForm.card_n.addEventListener("change", DynamicFormCheck_int);
            document.CompleteOrderForm.cvc.addEventListener("change", DynamicFormCheck_int);
        }

    </script>
    <style>
        /* Stili per il corpo della pagina */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
            color: #333;
        }

        /* Stili per il contenitore principale */
        div.container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Stili per la sezione del pagamento */
        section#payment-section {
            padding: 20px;
            border-radius: 10px;
            background-color: #f5f5f5;
            margin-bottom: 20px;
        }

        /* Stili per gli input e le etichette */
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #666;
        }

        input[type="text"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            color: #333;
        }

        /* Stili per i pulsanti */
        button[type="submit"], a.button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #ff0000;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover, a.button:hover {
            background-color: #b3002a;
        }

        /* Stili per la sezione del riepilogo */
        section#summary-section {
            padding: 20px;
            border-radius: 10px;
            background-color: #f5f5f5;
        }

        #summary-section p {
            margin-bottom: 10px;
            color: #666;
        }

        #summary-section div.item {
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }

        /* Stili per il link di acquisto */
        a.purchase-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        a.purchase-link:hover {
            background-color: #218838;
        }
    </style>
    <%@include file="/include/htmlHead.inc"%>
</head>
<body>
<%@include file="/include/header.jsp"%>
<div class="container">
    <main>
        <h1>Pagamento e Riepilogo Ordine</h1>
        <section id="payment-section">
            <section id="checkout-field">
                <div>
                    <div>
                        <div>
                            <div>
                                <h2>Pagamento</h2>
                            </div>
                            <div>
                                <label for="Numero di Carta">Numero di carta</label>
                                <input form="CompleteOrderForm" id="Numero di Carta" name="card_n" type="text" minlength="16" placeholder="1234567891098765"
                                       value="<%=(user.getCard_n() != null) ? user.getCard_n() : ""%>" maxlength="16" required>
                                <div>
                                    <div>
                                        <label for="CVC/CCV">CVC/CCV</label>
                                        <input form="CompleteOrderForm" id="CVC/CCV" name="cvc" type="text" minlength="3" placeholder="123"
                                               value="<%=(user.getCvc() != 0) ? user.getCvc() : ""%>" maxlength="3" required>
                                    </div>
                                    <div>
                                        <label for="Data di scadenza">Data di scadenza</label>
                                        <input form="CompleteOrderForm" id="Data di scadenza" name="exp_date" type="text" minlength="7" placeholder="MM/YYYY"
                                               value="<%=(user.getExp_date() != null) ? user.getExp_date() : ""%>" maxlength="7" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div>
                            <br><h2>Spedizione</h2>
                            <div>
                                <label for="street">Via</label>
                                <input form="CompleteOrderForm" id="street" name="street" type="text" placeholder="Via Rossi 1"
                                       value="<%=(user.getindirizzo() != null) ? user.getindirizzo() : ""%>" maxlength="50" required>
                                <div>
                                    <div>
                                        <label for="cap">CAP</label>
                                        <input form="CompleteOrderForm" id="cap" name="cap" type="text" placeholder="12345"
                                               value="<%=(user.getcap() != 0) ? user.getcap() : ""%>" maxlength="5" required>
                                    </div>
                                    <div>
                                        <label for="city">Citta</label>
                                        <input form="CompleteOrderForm" id="city" name="city" type="text" placeholder="Roma"
                                               value="<%=(user.getcitta() != null) ? user.getcitta() : ""%>" maxlength="30" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <div>
                <div>
                    <div>
                        <br><h2>Riepilogo</h2>
                    </div>
                    <section id="summary-section">
                        <% for (i = 0; i < carts.size(); i++) { %>
                        <div class="item">
                            <p><span><%=carts.get(i).getProdotto().getnome_prod()%></span>
                                x<%=carts.get(i).getQuantity()%>
                            </p>
                            <p><%=carts.get(i).getProdotto().getprezzo()%> &euro;</p>
                        </div>
                        <% } %>
                        <div>
                            <div>
                                <% if(total_discounted==null){ %>
                                <p>Totale(IVA inclusa)</p>
                                <p>Subtotale</p>
                                <p>Spedizione (10% del totale)</p>
                                <% } else { %>
                                <p>Totale(IVA inclusa)</p>
                                <% } %>
                            </div>
                            <div>
                                <% if(total_discounted==null){ %>
                                <p><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                <p><%=subtotal.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                <p><%=shipping.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                <% } else { %>
                                <p><span><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</span>
                                    <%=total_discounted.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                <% } %>
                            </div>
                        </div>
                    </section>
                    <a href="javascript:CompleteOrder()" class="purchase-link">Acquista</a>
                    <button type="submit" form="backForm" class="button">Annulla</button>
                </div>
            </div>
        </section>
    </main>
</div>

<form name="CompleteOrderForm" id="CompleteOrderForm" method="post" action="Dispatcher">
    <input type="hidden" name="controllerAction" value="CheckoutManagement.order"/>
</form>

<form name="backForm" id="backForm" method="post" action="Dispatcher">
    <input type="hidden" name="controllerAction" value="HomeManagement.view"/>
</form>
</body>
<div class="w-full bottom-0">
    <%@include file="/include/footer.inc"%>
</div>
</html>
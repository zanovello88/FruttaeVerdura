<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 07/05/24
  Time: 15:41
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
    String menuActiveLink = "Carrello";

    List<Cart> carts = (List<Cart>) request.getAttribute("carts");

    BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal shipping = (BigDecimal) request.getAttribute("shipping");
%>

<!DOCTYPE html>
<html>
<head>

    <%@include file="/include/htmlHead.inc"%>
    <script language="javascript">

        function AddToCart(id_prod) {
            document.AddToCartForm.id_prod.value = id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function RemoveFromCart(id_prod) {
            document.RemoveFromCartForm.id_prod.value = id_prod;
            document.RemoveFromCartForm.requestSubmit();
        }

        function RemoveBlockFromCart(id_prod) {
            document.RemoveBlockFromCartForm.id_prod.value = id_prod;
            document.RemoveBlockFromCartForm.requestSubmit();
        }

        function DeleteCart() {
            document.DeleteCartForm.requestSubmit();
        }


        function mainOnLoadHandler() {}
    </script>
    <style>
        /* Stile generale per il contenitore principale del carrello */
        .cart-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Stile per l'intestazione del carrello */
        .cart-header {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Stile per ciascun elemento del carrello */
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        /* Stile per l'immagine del prodotto nel carrello */
        .cart-item img {
            width: 100px;
            height: auto;
            margin-right: 20px;
        }

        /* Stile per i dettagli del prodotto nel carrello */
        .cart-item-details {
            flex: 1;
        }

        /* Stile per le azioni (rimuovi, aggiungi, sottrai) del prodotto nel carrello */
        .cart-item-actions {
            display: flex;
            align-items: center;
        }

        /* Stile per il prezzo del prodotto nel carrello */
        .cart-item-price p {
            font-weight: bold;
        }

        /* Stile per il totale del carrello */
        .cart-total {
            margin-top: 20px;
        }

        /* Stile per la sezione dei dettagli totali */
        .total-details {
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }

        /* Stile per ciascuna riga di dettagli totali */
        .total-row {
            flex: 1;
            text-align: right;
        }

        /* Stile per i pulsanti del carrello */
        .cart-buttons {
            margin-top: 20px;
            text-align: center;
        }

        /* Stile per il pulsante "Procedi al pagamento" */
        .cart-buttons button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-right: 10px;
        }

        /* Stile per il link "Svuota il carrello" */
        .cart-buttons a {
            color: #4CAF50;
            border: 2px solid #4CAF50;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        /* Effetto hover per il link "Svuota il carrello" */
        .cart-buttons a:hover {
            background-color: #4CAF50;
            color: white;
        }


    </style>
</head>
<%@ include file="/include/header.jsp" %>
<main class="cart-container">
    <div>
        <div class="cart-header">
            <h2>Carrello</h2>
        </div>
        <% if(total_amount.compareTo(BigDecimal.ZERO) != 0) { %>
        <div style="text-align: center">
            <h5>Le quantità relative a frutta e verdura sono a kg (1=1kg),<br> mentre il resto dei prodotti sono venduti all'uno</h5><br><br>
        </div>
        <% } %>
        <div class="cart-items">
            <% for (i = 0; i < carts.size(); i++) { %>
            <div class="cart-item">
                <section>
                    <a href="#">
                        <img src="<%= carts.get(i).getProdotto().getimg_path() %>" alt="Immagine prodotto">
                    </a>
                    <div class="cart-item-details">
                        <div>
                            <p><%= carts.get(i).getProdotto().getnome_prod() %> <span>(<%= carts.get(i).getProdotto().getprezzo() %> &euro;)</span></p>
                        </div>
                        <div class="cart-item-actions">
                            <a href="javascript:RemoveFromCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M17 11a1 1 0 010 2H7a1 1 0 010-2h10z"/></svg>
                            </a>
                            <p><%=carts.get(i).getQuantity()%></p>
                            <a href="javascript:AddToCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                            </a>
                        </div>
                    </div>
                </section>
                <section>
                    <div class="cart-item-price">
                        <p><%= carts.get(i).getProdotto().getprezzo().multiply(new BigDecimal(carts.get(i).getQuantity())) %> &euro;</p>
                    </div>
                    <div>
                        <a href="javascript:RemoveBlockFromCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                        </a>
                    </div>
                </section>
            </div>
            <% } %>
        </div>
        <% if(total_amount.compareTo(BigDecimal.ZERO) != 0) { %>
        <div class="cart-total">
            <div class="total-details">
                <div class="total-row">
                    <p>Totale (IVA inclusa)</p>
                    <p><%= total_amount.setScale(2, RoundingMode.CEILING) %> &euro;</p>
                </div>
                <div class="total-row">
                    <p>Subtotale</p>
                    <p><%= subtotal %> &euro;</p>
                </div>
                <div class="total-row">
                    <p>Spedizione (10% del totale)</p>
                    <p><%= shipping.setScale(2, RoundingMode.CEILING) %> &euro;</p>
                </div>
            </div>
            <div class="cart-buttons">
                <button type="submit" form="CheckoutForm">
                    Procedi al pagamento
                </button>
                <a href="javascript:DeleteCart()" type="submit" form="">
                    Svuota il carrello
                </a>
            </div>
        </div>
        <% } else { %>
        <div style="text-align: center">
            <p>Il carrello è vuoto, prendi qualcosa</p>
        </div>
        <% } %>
    </div>
</main>
    <form name="productView" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
    </form>

    <form name="AddToCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="CartManagement.AddProduct"/>
        <input type="hidden" name="viewUrl" value="cartManagement/view"/>
    </form>

    <form name="RemoveFromCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="CartManagement.RemoveProduct"/>
        <input type="hidden" name="viewUrl" value="cartManagement/view"/>
    </form>

    <form name="RemoveBlockFromCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="CartManagement.RemoveProductBlock"/>
        <input type="hidden" name="viewUrl" value="cartManagement/view"/>
    </form>

    <form name="DeleteCartForm" method="post" action="Dispatcher">
        <input type="hidden" name="id_prod"/>
        <input type="hidden" name="controllerAction" value="CartManagement.DeleteCart"/>
        <input type="hidden" name="viewUrl" value="cartManagement/view"/>
    </form>

    <form name="CheckoutForm" id="CheckoutForm" method="post" action="Dispatcher">
        <input type="hidden" name="cart_id"/>
        <input type="hidden" name="controllerAction" value="CheckoutManagement.view"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</html>

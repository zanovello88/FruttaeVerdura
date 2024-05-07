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
            alert("Aggiunto al carrello");
            document.AddToCartForm.id_prod.value = id_prod;
            document.AddToCartForm.requestSubmit();
        }

        function RemoveFromCart(id_prod) {
            alert("Rimosso dal carrello");
            document.RemoveFromCartForm.id_prod.value = id_prod;
            document.RemoveFromCartForm.requestSubmit();
        }

        function RemoveBlockFromCart(id_prod) {
            alert("Rimosso dal carrello");
            document.RemoveBlockFromCartForm.id_prod.value = id_prod;
            document.RemoveBlockFromCartForm.requestSubmit();
        }

        function DeleteCart() {
            alert("Carrello svuotato");
            document.DeleteCartForm.requestSubmit();
        }


        function mainOnLoadHandler() {}
    </script>
</head>
<body  class="bg-gray-500">
<%@include file="/include/header.jsp"%>
<main>
    <div>
        <div>
            <p>Carrello</p>
        </div>
        <div>
            <%for (i = 0; i < carts.size(); i++) {%>
            <div>
                <section>
                    <%--                          <div class="order-1 m-4 w-1/6">--%>
                    <%--                              <img src="<%=carts.get(i).getWine().getProductImage()%>" class="rounded" alt="stock wine image">--%>
                    <%--                          </div>--%>
                    <a href="#">
                        <img src="<%=carts.get(i).getProdotto().getimg_path()%>" alt="stock wine image">
                    </a>
                    <div>
                        <div>
                            <div>
                                <p><%=carts.get(i).getProdotto().getnome_prod()%> <span>(<%=carts.get(i).getProdotto().getprezzo()%> &euro;)</span></p>
                            </div>
                            <div>
                                <a href="javascript:RemoveFromCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M17 11a1 1 0 010 2H7a1 1 0 010-2h10z"/></svg>
                                </a>
                                <p><%=carts.get(i).getQuantity()%></p>
                                <a href="javascript:AddToCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </section>
                <section>
                    <div>
                        <p><%=carts.get(i).getProdotto().getprezzo().multiply(new BigDecimal(carts.get(i).getQuantity()))%> &euro;</p>
                    </div>
                    <div>
                        <a href="javascript:RemoveBlockFromCart(<%=carts.get(i).getProdotto().getid_prod()%>)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                        </a>
                    </div>
                </section>
            </div>
            <%}%>
        </div>
        <%if(total_amount.compareTo(BigDecimal.ZERO) != 0) {%>
        <div>
            <div>
                <div>
                    <p>Totale (IVA inclusa)</p>
                    <p>Subtotale</p>
                    <p>Spedizione (10% del totale)</p>
                </div>
                <div>
                    <p><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                    <p><%=subtotal%> &euro;</p>
                    <p><%=shipping.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                </div>
            </div>
            <div>
                <button type="submit" form="CheckoutForm">
                    Procedi al pagamento
                </button>
                <a href="javascript: DeleteCart()" type="submit" form="">
                    Svuota il carrello
                </a>
            </div>
        </div>
        <%} else {%>
        <div>
            <p>Il carrello e' vuoto, prendi qualcosa</p>
        </div>
        <%}%>
    </div>

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

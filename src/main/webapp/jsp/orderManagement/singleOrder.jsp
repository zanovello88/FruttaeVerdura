<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 08/05/24
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Order"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    boolean setDelivered = false;
    try {
        setDelivered = (Boolean) request.getAttribute("setDeliveredSwitch");
    } catch (NullPointerException e) { }

    DateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
    DateFormat timeFormatter = new SimpleDateFormat("HH:mm");
    DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
    String menuActiveLink = formatter.format(order_tuples.get(0).getTimestamp().getTime());
    int i;
%>

<!DOCTYPE html>
<html>
<head>
    <script language="javascript">

        function mainOnLoadHandler() {}
    </script>
    <style>
    #main-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 40px;
    }

    #order-details,
    #shipment-details,
    #order-actions {
        text-align: center;
    background-color: #f0f0f0;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    width: 70%;
    max-width: 800px;
    }

    .order-item {
    padding: 10px;
    border-bottom: 1px solid #999;
    }

    .product-name {
    color: #333;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 6px;
    }

    .product-info {
    color: #333;
    font-size: 16px;
    margin-bottom: 4px;
    }

    #total-price {
    font-weight: bold;
    padding: 10px;
    }

    .shipment-status {
    margin-left: 10px;
    }

    #deliver-button,
    #process-order-button {
    background-color: #333;
    color: #fff;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    margin-top: 10px;
    cursor: pointer;
    }

    #deliver-button:hover,
    #process-order-button:hover {
    background-color: #4CAF50;
    }
    </style>
    <%@include file="/include/htmlHead.inc"%>
</head>
<body class="bg-gray-500">
<%@include file="/include/header.jsp"%>
<main class="bg-gray-500">
    <div id="main-container">
        <div id="order-details">
            <h1>Ordine del <%=dateFormatter.format(order_tuples.get(0).getTimestamp())%> alle <%=timeFormatter.format(order_tuples.get(0).getTimestamp())%></h1>
            <%for (i = 0; i < order_tuples.size(); i++) {%>
            <section class="order-item">
                <h1 class="product-name"><%=order_tuples.get(i).getProduct().getnome_prod()%></h1>
                <p class="product-info">Quantità: <%=order_tuples.get(i).getQuantity()%></p>
                <p class="product-info">Prezzo: <%=order_tuples.get(i).getProduct().getprezzo()%> &euro;</p>
            </section>
            <%}%>
            <h1 id="total-price">Totale: <%=order_tuples.get(0).getTotalAmount()%> &euro;</h1>
        </div>
        <div id="shipment-details">
            <h1>Tracciamento spedizione</h1>
            <p class="shipment-status"><%=order_tuples.get(0).getStatus()%></p>
            <%if(!order_tuples.get(0).getStatus().equals("Ordine consegnato") || setDelivered){%>
            <button id="deliver-button" type="submit" form="setDeliveredForm">Marca come consegnato</button>
            <%}%>
        </div>
    </div>


    <form id="setDeliveredForm" name="setDeliveredForm" action="Dispatcher" method="post">
        <input type="hidden" name="order_date" value="<%=order_tuples.get(0).getTimestamp().getTime()%>"/>
        <input type="hidden" name="controllerAction" value="OrderManagement.setDelivered"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</body>
</html>
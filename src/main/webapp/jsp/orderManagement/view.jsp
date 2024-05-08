<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 08/05/24
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Cart"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Order"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>


<%
    int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Homepage";
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    TreeMap<Timestamp, List<Order>> ordersBySingleOrder = new TreeMap<Timestamp, List<Order>>(Collections.reverseOrder());
    for (Order order: order_tuples) {
        Timestamp order_date = order.getTimestamp();
        if (!ordersBySingleOrder.containsKey(order_date)) {
            ordersBySingleOrder.put(order_date, new ArrayList<Order>());
        }
        ordersBySingleOrder.get(order_date).add(order);
    }


    DecimalFormat df = new DecimalFormat("#.##");
    df.setRoundingMode(RoundingMode.FLOOR);
    DateFormat outputFormatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<!DOCTYPE html>
<html>
<head>

    <%@include file="/include/htmlHead.inc"%>
    <script language="javascript">

        function orderViewFunc(order_date) {
            f = document.orderViewForm;
            f.order_date.value = order_date;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
    <style>
        /* Stile per il contenitore principale */
        .orders-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        /* Stile per il titolo "Ordini" */
        .orders-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #333; /* Cambio colore del testo */
        }

        /* Stile per le icone del camion */
        .order-icon {
            width: 70px; /* Aumento la larghezza delle icone */
            height: 70px;
            fill: #000000;
            margin-right: 10px;
        }

        /* Stile per ogni singolo ordine */
        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 70%; /* Imposto la larghezza a circa il 70% della pagina */
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Aggiungo una leggera ombra */
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>
<main>
    <div class="orders-container">
        <div>
            <p class="orders-title">📦 Ordini 📦</p> <!-- Aggiungo un emoji per rendere il titolo più carino -->
        </div>
        <% if(!order_tuples.isEmpty()) { %>
        <div class="order-list">
            <% for(Timestamp k : ordersBySingleOrder.keySet()) { %>
            <div class="order-item">
                <div>
                    <a href="javascript:orderViewFunc(<%=k.getTime()%>)">
                        <svg class="order-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024"><path fill="#000000" d="M128.896 736H96a32 32 0 01-32-32V224a32 32 0 0132-32h576a32 32 0 0132 32v96h164.544a32 32 0 0131.616 27.136l54.144 352A32 32 0 01922.688 736h-91.52a144 144 0 11-286.272 0H415.104a144 144 0 11-286.272 0zm23.36-64a143.872 143.872 0 01239.488 0H568.32c17.088-25.6 42.24-45.376 71.744-55.808V256H128v416h24.256zm655.488 0h77.632l-19.648-128H704v64.896A144 144 0 01807.744 672zm48.128-192l-14.72-96H704v96h151.872zM688 832a80 80 0 100-160 80 80 0 000 160zm-416 0a80 80 0 100-160 80 80 0 000 160z"/></svg>
                        <%=outputFormatter.format(k)%>
                    </a>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div>
            <p>Nessun ordine effettuato</p>
        </div>
        <% } %>
    </div>

    <form name="orderViewForm" method="post" action="Dispatcher">
        <input type="hidden" name="order_date"/>
        <input type="hidden" name="controllerAction" value="OrderManagement.orderView"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</html>
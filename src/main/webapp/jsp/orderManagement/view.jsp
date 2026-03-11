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
<%@ page import="java.util.ArrayList" %><%@page import="java.util.LinkedHashMap" %><%@ page import="java.util.*" %>


<%
    int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Homepage";
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    // group orders by their primary key (order_id) preserving reverse insertion order
    LinkedHashMap<Long, List<Order>> ordersBySingleOrder = new LinkedHashMap<>();
    if (order_tuples != null) {
        for (Order order: order_tuples) {
            Long oid = order.getOrderId();
            if (!ordersBySingleOrder.containsKey(oid)) {
                ordersBySingleOrder.put(oid, new ArrayList<Order>());
            }
            ordersBySingleOrder.get(oid).add(order);
        }
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

        function orderViewFunc(order_id) {
            f = document.orderViewForm;
            f.order_id.value = order_id;
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

        /* Stile per la sezione di cleanup */
        .cleanup-container {
            background: linear-gradient(135deg, #73ad21 0%, #99daab 100%);
            border-radius: 12px;
            padding: 25px;
            margin: 30px auto;
            width: 70%;
            max-width: 800px;
            box-shadow: 0 8px 16px rgba(115, 173, 33, 0.3);
        }

        .cleanup-container h3 {
            margin: 0 0 15px 0;
            color: white;
            font-size: 20px;
            font-weight: 600;
        }

        .cleanup-form {
            display: flex;
            justify-content: center;
        }

        .cleanup-form-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
            width: 100%;
        }

        .cleanup-form-group label {
            color: white;
            font-weight: 500;
            font-size: 14px;
        }

        .cleanup-input-group {
            display: flex;
            gap: 10px;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cleanup-input-group input[type="number"] {
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            width: 80px;
            text-align: center;
            background-color: white;
            color: #333;
            font-weight: 600;
        }

        .cleanup-input-group input[type="number"]:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
        }

        .cleanup-unit {
            color: white;
            font-weight: 500;
        }

        .cleanup-btn {
            padding: 10px 25px;
            background-color: white;
            color: #73ad21;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .cleanup-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            background-color: #f0f0f0;
        }

        .cleanup-btn:active {
            transform: translateY(0);
        }

        /* Stile per il titolo "Ordini" */
        .orders-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        /* Stile per le icone del camion */
        .order-icon {
            width: 70px;
            height: 70px;
            fill: #000000;
            margin-right: 10px;
        }

        /* Stile per ogni singolo ordine */
        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 70%;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>

<!-- Cleanup form section: only show to logged in users -->
<% if (loggedOn) { %>
    <% if (applicationMessage != null && !applicationMessage.isEmpty()) { %>
        <div style="text-align: center; margin: 20px auto; padding: 15px; background-color: #e8f5e9; border-radius: 8px; color: #2e7d32; font-weight: 600; width: 70%; max-width: 800px;">
            <%= applicationMessage %>
        </div>
    <% } %>
    <div class="cleanup-container">
        <h3 style="color: white; margin-top: 0; margin-bottom: 20px; text-align: center;">🧹 Pulizia Ordini Archiviati</h3>
        <form method="POST" action="/FruttaeVerdura/Dispatcher" style="display: flex; justify-content: center; gap: 15px; align-items: center;">
            <input type="hidden" name="controllerAction" value="OrderManagement.cleanupOrders"/>
            <div class="cleanup-form-group">
                <label for="months" style="color: white; font-weight: 600; display: block; margin-bottom: 8px;">Elimina ordini più vecchi di:</label>
                <div class="cleanup-input-group">
                    <input type="number" id="months" name="months" min="1" max="60" value="6" required style="padding: 10px; border: none; border-radius: 6px; width: 100px; font-size: 14px;">
                    <span style="color: white; font-weight: 600; margin-left: 8px;">mesi</span>
                </div>
            </div>
            <button type="submit" class="cleanup-btn">Elimina Ordini</button>
        </form>
    </div>

    <!-- Report JOIN Button - Only for Admins -->
    <% if (loggedUser != null && loggedUser.getAdmin().equals("Y")) { %>
    <div style="text-align: center; margin: 20px 0;">
        <a href="/FruttaeVerdura/Dispatcher?controllerAction=OrderManagement.viewOrderDetails" style="
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #73ad21 0%, #99daab 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        " 
        onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 12px rgba(0, 0, 0, 0.3)';"
        onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 8px rgba(0, 0, 0, 0.2)';">
            Visualizza Report Dettagliato 
        </a>
    </div>
    <% } %>
<% } %>

<main>
    <div class="orders-container">
        <div>
            <p class="orders-title">📦 Ordini 📦</p> <!-- Aggiungo un emoji per rendere il titolo più carino -->
        </div>
        <% if(!order_tuples.isEmpty()) { %>
        <div class="order-list">
            <% for(Long k : ordersBySingleOrder.keySet()) { %>
            <div class="order-item">
                <div>
                    <a href="javascript:orderViewFunc(<%=k%>)">
                        <svg class="order-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024"><path fill="#000000" d="M128.896 736H96a32 32 0 01-32-32V224a32 32 0 0132-32h576a32 32 0 0132 32v96h164.544a32 32 0 0131.616 27.136l54.144 352A32 32 0 01922.688 736h-91.52a144 144 0 11-286.272 0H415.104a144 144 0 11-286.272 0zm23.36-64a143.872 143.872 0 01239.488 0H568.32c17.088-25.6 42.24-45.376 71.744-55.808V256H128v416h24.256zm655.488 0h77.632l-19.648-128H704v64.896A144 144 0 01807.744 672zm48.128-192l-14.72-96H704v96h151.872zM688 832a80 80 0 100-160 80 80 0 000 160zm-416 0a80 80 0 100-160 80 80 0 000 160z"/></svg>
                        <%-- display timestamp from first element in list --%>
                        <%=outputFormatter.format(ordersBySingleOrder.get(k).get(0).getTimestamp())%>
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
        <input type="hidden" name="order_id"/>
        <input type="hidden" name="controllerAction" value="OrderManagement.orderView"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</html>
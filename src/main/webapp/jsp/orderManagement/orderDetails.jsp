<%--
  Order Details Report with JOIN Query
  Displays detailed order information combining data from multiple tables
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.OrderDetail" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente" %>

<%
    List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
    String menuActiveLink = "OrderDetails";
    String applicationMessage = null;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    
    DecimalFormat df = new DecimalFormat("#.##");
    df.setRoundingMode(RoundingMode.FLOOR);
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>
    <style>
        /* Main container */
        .details-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            width: 100%;
        }

        /* Title */
        .details-title {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Back button */
        .back-button {
            align-self: flex-start;
            margin-left: 20px;
            padding: 10px 20px;
            background-color: #73ad21;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Table styling */
        .details-table {
            width: 95%;
            max-width: 1200px;
            border-collapse: collapse;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            background: white;
        }

        .details-table thead {
            background: linear-gradient(135deg, #73ad21 0%, #99daab 100%);
            color: white;
            font-weight: 600;
        }

        .details-table th {
            padding: 15px;
            text-align: left;
            border: none;
        }

        .details-table tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.3s ease;
        }

        .details-table tbody tr:hover {
            background-color: #f5f5f5;
        }

        .details-table td {
            padding: 12px 15px;
            text-align: left;
        }

        /* Status badge styling */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-align: center;
            min-width: 80px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }

        .status-processing {
            background-color: #cce5ff;
            color: #004085;
        }

        /* Statistics card */
        .stats-card {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            width: 95%;
            max-width: 1200px;
            margin-bottom: 30px;
        }

        .stat-item {
            background: linear-gradient(135deg, #73ad21 0%, #99daab 100%);
            padding: 20px;
            border-radius: 8px;
            color: white;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .stat-label {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: bold;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .empty-state p {
            font-size: 16px;
        }
    </style>
</head>
<body>
<%@include file="/include/header.jsp"%>

<main>
    <div class="details-container">
        <a href="javascript:window.history.back()" class="back-button">← Indietro</a>
        
        <h1 class="details-title">Report Dettagliato Ordini</h1>

        <% if (orderDetails != null && !orderDetails.isEmpty()) { %>
            <!-- Statistics -->
            <div class="stats-card">
                <div class="stat-item">
                    <div class="stat-label">TOTALE ORDINI</div>
                    <div class="stat-value"><%= orderDetails.size() %></div>
                </div>
                <div class="stat-item">
                    <div class="stat-label">RICAVO TOTALE</div>
                    <div class="stat-value">€ <%= 
                        df.format(orderDetails.stream()
                            .mapToDouble(od -> od.getTotal_amount() != null ? od.getTotal_amount().doubleValue() : 0)
                            .sum())
                    %></div>
                </div>
                <div class="stat-item">
                    <div class="stat-label">PRODOTTI VENDUTI</div>
                    <div class="stat-value"><%= 
                        orderDetails.stream()
                            .mapToLong(od -> od.getQuantity() != null ? od.getQuantity() : 0)
                            .sum()
                    %></div>
                </div>
            </div>

            <!-- Table with JOIN data -->
            <table class="details-table">
                <thead>
                    <tr>
                        <th>ID Ordine</th>
                        <th>Cliente</th>
                        <th>Email</th>
                        <th>Prodotto</th>
                        <th>Quantità</th>
                        <th>Prezzo Unitario</th>
                        <th>Totale</th>
                        <th>Data</th>
                        <th>Stato</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (OrderDetail od : orderDetails) { %>
                        <tr>
                            <td><strong><%= od.getOrder_id() %></strong></td>
                            <td><%= od.getUser_name() %></td>
                            <td><%= od.getUser_email() %></td>
                            <td><%= od.getProduct_name() %></td>
                            <td><%= od.getQuantity() %></td>
                            <td>€ <%= od.getUnit_price() != null ? df.format(od.getUnit_price()) : "0.00" %></td>
                            <td><strong>€ <%= od.getTotal_amount() != null ? df.format(od.getTotal_amount()) : "0.00" %></strong></td>
                            <td><%= od.getTimestamp() != null ? dateFormat.format(od.getTimestamp()) : "-" %></td>
                            <td>
                                <% 
                                    String statusClass = "status-pending";
                                    String statusText = od.getStatus();
                                    if ("delivered".equals(od.getStatus())) {
                                        statusClass = "status-delivered";
                                        statusText = "Consegnato";
                                    } else if ("processing".equals(od.getStatus())) {
                                        statusClass = "status-processing";
                                        statusText = "In Elaborazione";
                                    } else if ("pending".equals(od.getStatus())) {
                                        statusText = "Pendente";
                                    }
                                %>
                                <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

        <% } else { %>
            <div class="empty-state">
                <p>Nessun ordine trovato nel database.</p>
            </div>
        <% } %>
    </div>
</main>

<%@include file="/include/footer.inc"%>
</body>
</html>

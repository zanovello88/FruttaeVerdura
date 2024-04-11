<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 11/04/24
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente" %>
<%@ page session="false" %>
<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }

        h1 {
            color: #444;
            margin-top: 0;
        }

        form {
            margin-top: 30px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #3e8e41;
        }

        .link-container {
            text-align: center;
            margin-top: 20px;
        }

        .link-container a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }

        .link-container a:hover {
            color: #3e8e41;
        }

        .error {
            color: red;
            margin-top: 10px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Registrazione</h1>
    <form action="Dispatcher?controllerAction=HomeManagement.register" method="post">
        <label for="username">Nome utente:</label>
        <input type="text" id="username" name="username" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" required>
        <label for="cognome">Cognome:</label>
        <input type="text" id="cognome" name="cognome" required>
        <input type="submit" value="Registrati">
    </form>
    <div class="link-container">
        <p>Sei già registrato? <a href="homeManagement/view">Effettua il login</a></p>
    </div>
</div>

</body>
</html>

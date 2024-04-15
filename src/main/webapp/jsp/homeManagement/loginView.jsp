<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 15/04/24
  Time: 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Accedi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        #login {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }

        #login form {
            margin-top: 30px;
        }

        #login label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        #login input[type="text"],
        #login input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            margin-bottom: 20px;
        }

        #login input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-bottom: 10px; /* Aggiunto margine inferiore */
        }

        #login input[type="submit"]:hover {
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

        h1 {
            color: #444;
            margin-top: 0;
            font-size: 28px; /* Uguale alla dimensione della scritta registrazione */
        }
    </style>
</head>
<body>
<section id="login" class="clearfix">
    <h1>Accesso</h1>
    <form name="logonForm" action="Dispatcher" method="post">
        <label for="username">Utente</label>
        <input type="text" id="username"  name="username" maxlength="40" required>
        <label for="password">Password</label>
        <input type="password" id="password" name="password" maxlength="40" required>
        <input type="hidden" name="controllerAction" value="HomeManagement.logon"/>
        <input type="submit" value="Ok">
    </form>
    <div class="link-container">
        <p>Se non sei registrato, <a href="Dispatcher?controllerAction=HomeManagement.registerView">registrati qui</a></p>
    </div>
</section>
</body>
</html>

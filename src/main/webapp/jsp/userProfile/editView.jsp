<%--
  Created by IntelliJ IDEA.
  User: francescozanovello
  Date: 11/05/24
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    Utente loggedUser = (Utente) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Modifica profilo";

    Utente user = (Utente) request.getAttribute("user");
    String action=(user != null) ? "modify" : "insert";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.inc"%>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        main {
            margin: 20px auto;
            max-width: 800px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #73ad21;
            margin-bottom: 20px;
        }

        section {
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        button[type="submit"] {
            background-color: #73ad21;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #558f1e;
        }
        button[name="backButton"] {
            background-color: #f44336;
        }

        button[name="backButton"]:hover {
            background-color: #d32f2f;
        }
    </style>

    <script language="javascript">
        var status="<%=action%>"

        function DynamicFormCheck(e) {
            var EventTriggerName = (e.target.name);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo " + EventTriggerName + " richiede un numero");
        }
        function goback() {
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler(){}
    </script>
</head>
<body>
<%@include file="/include/header.jsp"%>
<main>
    <div><h1>Modifica profilo</h1></div>
    <section>
        <section>
            <div>
                <div>
                    <div>
                        <div>
                            <p>Info Utente</p>
                        </div>
                        <div>
                            <label for="Username">Nome Utente</label>
                            <input form="editProfileForm" id="Username" name="Username" type="text" placeholder="mario123"
                                   value="<%=(user.getUsername() != null) ? user.getUsername() : ""%>" maxlength="12" >

                            <label for="Password">Password</label>
                            <input form="editProfileForm" id="Password" name="Password" type="password"
                                   value="<%=(user.getPassword() != null) ? user.getPassword() : ""%>" maxlength="32" >

                            <div>
                                <div>
                                    <label for="Nome">Nome</label>
                                    <input form="editProfileForm" id="Nome" name="Nome" type="text" placeholder="Mario"
                                           value="<%=(user.getNome() != null) ? user.getNome() : ""%>" maxlength="40" >
                                </div>
                                <div>
                                    <label for="Cognome">Cognome</label>
                                    <input form="editProfileForm" id="Cognome" name="Cognome" type="text" placeholder="Rossi"
                                           value="<%=(user.getCognome() != null) ? user.getCognome() : ""%>" maxlength="40" >
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label for="Email">Email</label>
                                    <input form="editProfileForm" id="Email" name="Email" type="email" placeholder="mario.rossi@example.com"
                                           value="<%=(user.getemail() != null) ? user.getemail() : ""%>" maxlength="40" >
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div>
                <div>
                    <div>
                        <div>
                            <p>Info di pagamento</p>
                        </div>
                        <button type="submit" form="deleteCarta">
                            <p style="font-size: 15px">Cancella le informazioni di pagamento
                            <svg width="15" height="15" viewBox="-0.5 0 19 19" version="1.1" xmlns="http://www.w3.org/2000/svg">
                                <title>icon/18/icon-delete</title>
                                <desc>Created with Sketch.</desc>
                                <g id="out" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage">
                                    <path d="M4.91666667,14.8888889 C4.91666667,15.3571429 5.60416667,16 6.0625,16 L12.9375,16 C13.3958333,16 14.0833333,15.3571429 14.0833333,14.8888889 L14.0833333,6 L4.91666667,6 L4.91666667,14.8888889 L4.91666667,14.8888889 L4.91666667,14.8888889 Z M15,3.46500003 L12.5555556,3.46500003 L11.3333333,2 L7.66666667,2 L6.44444444,3.46500003 L4,3.46500003 L4,4.93000007 L15,4.93000007 L15,3.46500003 L15,3.46500003 L15,3.46500003 Z" id="path" fill="#000000" sketch:type="MSShapeGroup"></path>
                                </g>
                            </svg>
                            </p>
                        </button>
                        <div>
                            <label for="card_n">Numero di carta</label>
                            <input form="editProfileForm" id="card_n" name="card_n" type="text" minlength="16" placeholder="1234567891987654"
                                   value="<%=(user.getCard_n() != null) ? user.getCard_n() : ""%>" maxlength="16" >
                            <div>
                                <div>
                                    <label for="cvc">CVC/CCV</label>
                                    <input form="editProfileForm" id="cvc" name="cvc" type="text" minlength="3" placeholder="567"
                                           value="<%=(user.getCvc() != 0) ? user.getCvc() : ""%>" maxlength="3" >
                                </div>
                                <div>
                                    <label for="exp_date">Data di scadenza</label>
                                    <input form="editProfileForm" id="exp_date" name="exp_date" type="text" minlength="7" placeholder="MM/YYYY"
                                           value="<%=(user.getExp_date() != null) ? user.getExp_date() : ""%>" maxlength="7" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <br><br>
                    <div>
                        <div>
                            <p>Info di Spedizione</p>
                        </div>
                        <button type="submit" form="deleteSpedizione">
                            <p style="font-size: 15px">Cancella le informazioni di spedizione
                            <svg width="15" height="15" viewBox="-0.5 0 19 19" version="1.1" xmlns="http://www.w3.org/2000/svg" >
                                <title>icon/18/icon-delete</title>
                                <desc>Created with Sketch.</desc>
                                <g id="out" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage">
                                    <path d="M4.91666667,14.8888889 C4.91666667,15.3571429 5.60416667,16 6.0625,16 L12.9375,16 C13.3958333,16 14.0833333,15.3571429 14.0833333,14.8888889 L14.0833333,6 L4.91666667,6 L4.91666667,14.8888889 L4.91666667,14.8888889 L4.91666667,14.8888889 Z M15,3.46500003 L12.5555556,3.46500003 L11.3333333,2 L7.66666667,2 L6.44444444,3.46500003 L4,3.46500003 L4,4.93000007 L15,4.93000007 L15,3.46500003 L15,3.46500003 L15,3.46500003 Z" id="path" fill="#000000" sketch:type="MSShapeGroup"></path>
                                </g>
                            </svg>
                            </p>
                        </button>
                        <div>
                            <label for="Indirizzo">Indirizzo</label>
                            <input form="editProfileForm" id="Indirizzo" name="Indirizzo" type="text" placeholder="Via Rossi 1"
                                   value="<%=(user.getindirizzo() != null) ? user.getindirizzo() : ""%>" maxlength="50" >
                            <div>
                                <div>
                                    <label for="CAP">CAP</label>
                                    <input form="editProfileForm" id="CAP" name="CAP" type="text" minlength="5" placeholder="12345"
                                           value="<%=(user.getcap() != 0) ? user.getcap() : ""%>" maxlength="5" >
                                </div>
                                <div>
                                    <label for="Città">Città</label>
                                    <input form="editProfileForm" id="Città" name="Città" type="text" placeholder="Roma"
                                           value="<%=(user.getcitta() != null) ? user.getcitta() : ""%>" maxlength="30" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
    <div>
        <button type="submit" form="editProfileForm">Conferma Modifiche</button>
        <button type="submit" name="backButton" onclick="goback()">Annulla Modifiche</button>
    </div>

    <form name="editProfileForm" id="editProfileForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.modify"/>
    </form>

    <form name="deleteCarta" id="deleteCarta" method="post" action="Dispatcher" >
        <input type="hidden" name="controllerAction" value="UserProfile.deleteCarta"/>
    </form>

    <form name="deleteSpedizione" id="deleteSpedizione" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteSpedizione"/>
    </form>
    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.view"/>
    </form>

</main>
<%@include file="/include/footer.inc"%>
</body>

</html>

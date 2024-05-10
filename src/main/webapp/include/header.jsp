<script>
  function headerOnLoadHandler() {
    var usernameTextField = document.querySelector("#username");
    var usernameTextFieldMsg = "Lo username \xE8 obbligatorio.";
    var passwordTextField = document.querySelector("#password");
    var passwordTextFieldMsg = "La password \xE8 obbligatoria.";

    if (usernameTextField != undefined && passwordTextField != undefined ) {
      usernameTextField.setCustomValidity(usernameTextFieldMsg);
      usernameTextField.addEventListener("change", function () {
        this.setCustomValidity(this.validity.valueMissing ? usernameTextFieldMsg : "");
      });
      passwordTextField.setCustomValidity(passwordTextFieldMsg);
      passwordTextField.addEventListener("change", function () {
       this.setCustomValidity(this.validity.valueMissing ? passwordTextFieldMsg : "");
      });
    }
  }

</script>
<style>
    /* Posiziona il menu a tendina sulla destra */
    .tendina {
        float: right;
    }

    /* Stile per il menu a tendina */
    .dropdown {
        position: relative;
        display: inline-block;
        padding: 0 10px; /* Aggiunge spazio attorno al simbolo delle tre linee orizzontali */
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #186400;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        right: 0; /* Allinea il menu a tendina a destra */
    }

    .dropdown-content a {
        color: #000000;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown-content a:hover {
        background-color: #ffffff;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }
    .dropbtn {
        padding: 10px 20px;  /* Aggiunge padding in alto e in basso, e aumenta il padding a destra */
        background-color: transparent;
        color: #ffffff;
        border: none;
        cursor: pointer;
        font-size: 28px; /* Aumenta la dimensione del font */
    }
    .dropbtn span {
        font-size: 20px; /* Dimensione del font per il nome e cognome */
    }

</style>

<header class="clearfix">
    <!-- Definizione del logo -->
    <h1 class="logo">Frutta e Verdura</h1>

    <!-- Form per il logout -->
    <form name="logoutForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
    </form>

    <!-- Menù di navigazione -->
    <nav>
        <ul>
            <li <%=menuActiveLink.equals("Home")?"class=\"active\"":""%>>
                <a href="Dispatcher?controllerAction=HomeManagement.view">Home</a>
            </li>
            <li <%=menuActiveLink.equals("Prodotti")?"class=\"active\"":""%>>
                <a href="Dispatcher?controllerAction=ProductManagement.view">Prodotti</a>
            </li>
            <% if (loggedOn) { %>
            <li <%=menuActiveLink.equals("Carrello")?"class=\"active\"":""%>>
                <a href="Dispatcher?controllerAction=CartManagement.view">Carrello</a>
            </li>
            <% } %>
        </ul>
    </nav>

    <% if (loggedOn) { %>
    <!-- Se l'utente è loggato, mostra il menu a tendina -->
    <li class="dropdown tendina">
        <a href="#" class="dropbtn">
            <span class="name"><%=loggedUser.getNome()%> <%=loggedUser.getCognome()%></span> &#9776;
        </a>
        <div class="dropdown-content">
            <% if (loggedOn && loggedUser.getAdmin().equals("Y")) { %>
            <a href="Dispatcher?controllerAction=AdminManagement.view">Amministrazione
                <svg style="fill: rgb(0,0,0)" width="15px" height="15px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                    <path d="M983.727 5.421 1723.04 353.62c19.765 9.374 32.414 29.252 32.414 51.162v601.525c0 489.6-424.207 719.774-733.779 887.943l-34.899 18.975c-8.47 4.517-17.731 6.889-27.105 6.889-9.262 0-18.523-2.372-26.993-6.89l-34.9-18.974C588.095 1726.08 164 1495.906 164 1006.306V404.78c0-21.91 12.65-41.788 32.414-51.162L935.727 5.42c15.134-7.228 32.866-7.228 48 0ZM757.088 383.322c-176.075 0-319.285 143.323-319.285 319.398 0 176.075 143.21 319.285 319.285 319.285 1.92 0 3.84 0 5.76-.113l58.504 58.503h83.689v116.781h116.781v83.803l91.595 91.482h313.412V1059.05l-350.57-350.682c.114-1.807.114-3.727.114-5.647 0-176.075-143.21-319.398-319.285-319.398Zm0 112.942c113.732 0 206.344 92.724 205.327 216.62l-3.953 37.271 355.426 355.652v153.713h-153.713l-25.412-25.299v-149.986h-116.78v-116.78H868.108l-63.812-63.7-47.209 5.309c-113.732 0-206.344-92.5-206.344-206.344 0-113.732 92.612-206.456 206.344-206.456Zm4.98 124.98c-46.757 0-84.705 37.948-84.705 84.706s37.948 84.706 84.706 84.706c46.757 0 84.706-37.948 84.706-84.706s-37.949-84.706-84.706-84.706Z" fill-rule="evenodd"/>
                </svg>
            </a>
            <% } %>
            <a href="Dispatcher?controllerAction=OrderManagement.view">Ordini
                <svg style="fill: rgb(0,0,0)" width="18px" height="18px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024"><path fill="#000000" d="M128.896 736H96a32 32 0 01-32-32V224a32 32 0 0132-32h576a32 32 0 0132 32v96h164.544a32 32 0 0131.616 27.136l54.144 352A32 32 0 01922.688 736h-91.52a144 144 0 11-286.272 0H415.104a144 144 0 11-286.272 0zm23.36-64a143.872 143.872 0 01239.488 0H568.32c17.088-25.6 42.24-45.376 71.744-55.808V256H128v416h24.256zm655.488 0h77.632l-19.648-128H704v64.896A144 144 0 01807.744 672zm48.128-192l-14.72-96H704v96h151.872zM688 832a80 80 0 100-160 80 80 0 000 160zm-416 0a80 80 0 100-160 80 80 0 000 160z"/></svg>
            </a>
            <a href="Dispatcher?controllerAction=UserProfile.view">Profilo
                <svg style="fill: rgb(0,0,0)" width="16px" height="16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/></svg>
            </a>
            <a href="javascript:logoutForm.submit()">Logout
                <svg style="fill: rgb(0,0,0)" width="16px" height="16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M288 32c0-17.7-14.3-32-32-32s-32 14.3-32 32V256c0 17.7 14.3 32 32 32s32-14.3 32-32V32zM143.5 120.6c13.6-11.3 15.4-31.5 4.1-45.1s-31.5-15.4-45.1-4.1C49.7 115.4 16 181.8 16 256c0 132.5 107.5 240 240 240s240-107.5 240-240c0-74.2-33.8-140.6-86.6-184.6c-13.6-11.3-33.8-9.4-45.1 4.1s-9.4 33.8 4.1 45.1c38.9 32.3 63.5 81 63.5 135.4c0 97.2-78.8 176-176 176s-176-78.8-176-176c0-54.4 24.7-103.1 63.5-135.4z"/></svg>
            </a>
        </div>
    </li>
    <% } %>

    <!-- Se l'utente è loggato come amministratore, mostra il pulsante per l'amministrazione
    <% if (loggedOn && loggedUser.getAdmin().equals("Y")) { %>
    <div style="text-align: right; padding: 20px;">
        <button style="background-color: #ffffff;
                    font-size: 15px;
                    color: #000000;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                    margin-right: 20px;"
                onclick="location.href='Dispatcher?controllerAction=AdminManagement.view'">AMMINISTRAZIONE
            <svg style="fill: rgb(0,0,0)" width="15px" height="15px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                <path d="M983.727 5.421 1723.04 353.62c19.765 9.374 32.414 29.252 32.414 51.162v601.525c0 489.6-424.207 719.774-733.779 887.943l-34.899 18.975c-8.47 4.517-17.731 6.889-27.105 6.889-9.262 0-18.523-2.372-26.993-6.89l-34.9-18.974C588.095 1726.08 164 1495.906 164 1006.306V404.78c0-21.91 12.65-41.788 32.414-51.162L935.727 5.42c15.134-7.228 32.866-7.228 48 0ZM757.088 383.322c-176.075 0-319.285 143.323-319.285 319.398 0 176.075 143.21 319.285 319.285 319.285 1.92 0 3.84 0 5.76-.113l58.504 58.503h83.689v116.781h116.781v83.803l91.595 91.482h313.412V1059.05l-350.57-350.682c.114-1.807.114-3.727.114-5.647 0-176.075-143.21-319.398-319.285-319.398Zm0 112.942c113.732 0 206.344 92.724 205.327 216.62l-3.953 37.271 355.426 355.652v153.713h-153.713l-25.412-25.299v-149.986h-116.78v-116.78H868.108l-63.812-63.7-47.209 5.309c-113.732 0-206.344-92.5-206.344-206.344 0-113.732 92.612-206.456 206.344-206.456Zm4.98 124.98c-46.757 0-84.705 37.948-84.705 84.706s37.948 84.706 84.706 84.706c46.757 0 84.706-37.948 84.706-84.706s-37.949-84.706-84.706-84.706Z" fill-rule="evenodd"/>
            </svg>
        </button>
    </div>
    <% } %>
    -->

    <!-- Se l'utente non è loggato, mostra i pulsanti per l'accesso e la registrazione -->
    <% if (!loggedOn) { %>
    <div style="text-align: right; padding: 20px;">
        <button style="background-color: #ffffff;
                    color: #000000;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;
                    margin-right: 20px;"
                onclick="location.href='Dispatcher?controllerAction=HomeManagement.loginView'">Accedi
        </button>
        <button style="background-color: #ffffff;
                    color: #000000;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s;"
                onclick="location.href='Dispatcher?controllerAction=HomeManagement.registerView'">Registrati
        </button>
    </div>
    <% } %>

    <!-- Form per l'accesso alla zona amministrativa -->
    <form name="AdminZone" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
    </form>
</header>



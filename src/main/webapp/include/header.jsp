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

<header class="clearfix"><!-- Defining the header section of the page -->

  <h1 class="logo"><!-- Defining the logo element -->
    Frutta e Verdura
  </h1>

  <form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
  </form>

  <nav><!-- Defining the navigation menu -->
    <ul>
      <li <%=menuActiveLink.equals("Home")?"class=\"active\"":""%>>
        <a href="Dispatcher?controllerAction=HomeManagement.view">Home</a>
      </li>
        <li <%=menuActiveLink.equals("Prodotti")?"class=\"active\"":""%>>
          <a href="Dispatcher?controllerAction=ProductManagement.view">Prodotti</a>
        </li>
        <%if (loggedOn) {%>
        <li><a href="javascript:logoutForm.submit()">Logout</a></li>
        <li <%=menuActiveLink.equals("Carrello")?"class=\"active\"":""%>>
            <a href="Dispatcher?controllerAction=CartManagement.view">Carrello</a>
        </li>
        <%}%>
    </ul>
  </nav>
    <%if (loggedOn) {%>
    <%if (loggedUser.getAdmin().equals("Y")){%>
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
    <%}%>
    <%}%>
  <%if (!loggedOn) {%>
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
  <%}%>
    <form name="AdminZone" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
    </form>
</header>

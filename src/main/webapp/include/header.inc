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
      <%}%>
    </ul>
  </nav>

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

</header>
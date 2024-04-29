<header style="width: 100%; z-index: 30; top: 0; padding-top: 1rem; background-color: #000;">
    <div style="width: 100%; max-width: 1140px; margin: auto; display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; margin-top: 0; padding: 0 1.5rem;">
        <section style="order: 1; flex: 1;">
            <a id="logo" style="text-decoration: none; font-weight: bold; font-size: 2rem; color: #fff; cursor: pointer;" href="Dispatcher?controllerAction=AdminManagement.view">Frutta e Verdura</a>
            <p style="font-weight: medium; color: #6b9d37; font-size: 0.875rem; text-transform: uppercase; padding-left: 1rem; padding-top: 0.5rem;">Accesso eseguito come amministratore</p>
        </section>
        <div style="order: 2; flex: 1; display: flex; align-items: center; padding: 1rem;">
            <div style="position: relative; display: inline-block;">
                <div style="position: absolute; background-color: #4a5568; color: #fff; border-radius: 0.25rem; padding: 0.5rem; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); top: 100%; left: 0; z-index: 50; display: none;">
                    <a style="display: block; padding: 0.5rem 1rem; width: 100%; text-decoration: none; transition: background-color 0.3s ease-in-out;" href="javascript:logoutForm.requestSubmit()">Esci</a>
                </div>
            </div>
            <div style="position: relative; display: inline-block;">
                <section>
                    <a id="homeadmin" style="padding-left: 0.75rem; display: inline-block;" href="Dispatcher?controllerAction=AdminManagement.view">
                        <svg fill="#ffffff" width="24" height="24" viewBox="0 0 24 24" id="key" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9,12H21m-1,0V10m-4,2V10M6,9a3,3,0,1,0,3,3A3,3,0,0,0,6,9Z" style="fill: none; stroke: #fff; stroke-linecap: round; stroke-linejoin: round; stroke-width: 2;"></path>
                        </svg>
                    </a>
                    <a id="home" href="javascript:HomeForm.requestSubmit()" style="padding-left: 0.75rem; display: inline-block;">
                        <svg fill="#ffffff" width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 3s-6.186 5.34-9.643 8.232c-.203.184-.357.452-.357.768 0 .553.447 1 1 1h2v7c0 .553.447 1 1 1h3c.553 0 1-.448 1-1v-4h4v4c0 .552.447 1 1 1h3c.553 0 1-.447 1-1v-7h2c.553 0 1-.447 1-1 0-.316-.154-.584-.383-.768-3.433-2.892-9.617-8.232-9.617-8.232z"/>
                        </svg>
                    </a>
                </section>
            </div>
        </div>
    </div>
</header>
<form name="HomeForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.view"/>
</form>

<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>

<%-- Created by IntelliJ IDEA.
User: francescozanovello
Date: 03/04/24
Time: 11:54
To change this template use File | Settings | File Templates. da creare, pagina principale --%>
<%@page session="false"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Utente"%>
<%@page import="org.fruttaeverdura.fruttaeverdura.model.mo.Prodotto"%>

<% boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
Utente loggedUser = (Utente) request.getAttribute("loggedUser");
String applicationMessage = (String) request.getAttribute("applicationMessage");
String menuActiveLink = "Home"; %>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="/include/htmlHead.inc"%>
        <style>
            .product-showcase { display: flex; justify-content: center; }
            .product-card { background-color: #f5f5f5; border-radius: 5px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); width: 300px; height: 400px; margin: 20px; text-align: center; }
            .product-image { height: 200px; margin-bottom: 20px; object-fit: cover; width: 100%; }
            .product-name { font-size: 1.2rem; margin-bottom: 10px; }
            .product-price { font-size: 1.1rem; font-weight: bold; }
            .product-button { background-color: #73ad21; border: none; border-radius: 5px; color: white; cursor: pointer; font-size: 1rem; margin-top: 20px; padding: 10px 20px; }
            .product-button:hover { background-color: #73ad21; }
            .slider { display: flex; overflow: hidden; }
            .slide { flex-basis: 100%; }
            .slide.active { display: block; animation: slideIn 0.5s ease-in-out; }
            .slide.inactive { display: none; }
            .pagination { display: flex; justify-content: center; margin-top: 20px; }
            .pagination-button { background-color: #ddd; border: none; border-radius: 50%; cursor: pointer; font-size: 1.5rem; margin: 0 5px; padding: 10px; width: 15px; height: 15px; }
            .pagination-button.active { background-color: #73ad21; }
            @keyframes slideIn { from { transform: translateX(100%); } to { transform: translateX(0%); } }
        </style>
    </head>
    <body>
        <%@include file="/include/header.inc"%>
        <main>
            <%if (loggedOn) {%>
            Benvenuto <%=loggedUser.getNome()%> <%=loggedUser.getCognome()%>!<br/>
            Clicca sulla voce "Prodotti" per vedere i nostri prodotti.
            <%} else {%> Benvenuto. Fai il login per vedere i tuoi ordini.<br/> <%}%>

    <div class="product-showcase">
        <div class="slider">
            <div class="slide active" style="background-image: url(product1.jpg);">
                <div class="product-card"> <h2 class="product-name">Product 1</h2>
                    <p class="product-price">$99.99</p>
                    <%if (loggedOn) {%><button class="product-button" onclick="addToCart()">Add to Cart</button><%}%>
                </div>
            </div>
            <div class="slide inactive" style="background-image: url(product2.jpg);">
                <div class="product-card">
                    <h2 class="product-name">Product 2</h2>
                    <p class="product-price">$79.99</p>
                    <%if (loggedOn) {%><button class="product-button" onclick="addToCart()">Add to Cart</button><%}%>
                </div>
            </div>
            <div class="slide inactive" style="background-image: url(product3.jpg);">
                <div class="product-card">
                    <h2 class="product-name">Product 3</h2>
                    <p class="product-price">$59.99</p>
                    <%if (loggedOn) {%><button class="product-button" onclick="addToCart()">Add to Cart</button><%}%>
                </div>
            </div>
            <div class="slide inactive" style="background-image: url(product4.jpg);">
                <div class="product-card">
                    <h2 class="product-name">Product 4</h2>
                    <p class="product-price">$49.99</p>
                    <%if (loggedOn) {%><button class="product-button" onclick="addToCart()">Add to Cart</button><%}%>
                </div>
            </div>
        </div>
    </div>
            <div class="pagination">
                <button class="pagination-button pagination-button-1 active"></button>
                <button class="pagination-button pagination-button-2"></button>
                <button class="pagination-button pagination-button-3"></button>
                <button class="pagination-button pagination-button-4"></button>
            </div>
            <script>
                let currentSlide = 0;
                const slides = document.querySelectorAll('.slide');
                const paginationButtons = document.querySelectorAll('.pagination-button');

                function showSlide(index) {
                    slides.forEach((slide, i) => {
                        slide.classList.remove('active');
                        slide.classList.add('inactive');
                    });

                    paginationButtons.forEach((button, i) => {
                        button.classList.remove('active');
                    });

                    slides[index].classList.add('active');
                    slides[index].classList.remove('inactive');

                    paginationButtons[index].classList.add('active');

                    currentSlide = index;
                }

                showSlide(0);

                paginationButtons.forEach((button, i) => {
                    button.addEventListener('click', () => {
                        showSlide(i);
                    });
                });
            </script>
        </main>
        <%@include file="/include/footer.inc"%>
    </body>
</html>

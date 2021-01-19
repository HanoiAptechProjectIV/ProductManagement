<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<section id="footer-bar">
    <div class="row">
        <div class="span3">
            <h4>Menu</h4>
            <ul class="nav">
                <li><a href="./index.html">Homepage</a></li>  
                <li><a href="./about.html">About Us</a></li>
                <li><a href="./contact.html">Contact Us</a></li>
                <li><a href="./cart.html">Your Cart</a></li>
                <li><a href="./register.html">Login</a></li>							
            </ul>					
        </div>
        <div class="span4">
            <h4>My Account</h4>
            <ul class="nav">
                <li><a href="#">My Account</a></li>
                <li><a href="#">Order History</a></li>
                <li><a href="#">Wish List</a></li>
                <li><a href="#">Newsletter</a></li>
            </ul>
        </div>
        <div class="span5">
            <!-- <p class="logo"> -->
            <img src="resources/themes/img/logo/fnatic.png" class="img-circle site_logo" alt="titan">
            <strong>Titan Game Shop</strong>
            <!-- </p> -->
            <p>
                © 2021, Titan Games Shop, Inc. All rights reserved. Titan, Titan Games,
                the Titan Games logo, are trademarks or registered trademarks of Titan
                Games, Inc. in the United States of America and elsewhere. Other
                brands or product names are the trademarks of their respective
                owners. Non-US transactions through Titan Games International, S.à
                r.l..
            </p>
            <br>
            <span class="social_icons">
                <a class="facebook" href="#">Facebook</a>
                <a class="twitter" href="#">Twitter</a>
                <a class="skype" href="#">Skype</a>
                <a class="vimeo" href="#">Vimeo</a>
            </span>
        </div>					
    </div>	
</section>

<section id="copyright">
    <span>We sell everything in the world!</span>
</section>

<!-- scripts -->
<script src="${pageContext.request.contextPath}/resources/themes/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.flexslider-min.js"></script>
<script src="${pageContext.request.contextPath}/resources/themes/js/jquery.fancybox.js"></script>
<script type="text/javascript">
    $(function () {
        $(document).ready(function () {
            $('.flexslider').flexslider({
                animation: "fade",
                slideshowSpeed: 4000,
                animationSpeed: 600,
                controlNav: false,
                directionNav: true,
                controlsContainer: ".flex-container" // the container that holds the flexslider
            });
        });
    });
</script>
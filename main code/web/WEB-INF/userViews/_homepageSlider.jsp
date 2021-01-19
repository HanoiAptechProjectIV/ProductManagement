<%-- 
    Document   : _homepageSlider
    Created on : Jan 15, 2021, 1:41:14 AM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section  class="homepage-slider" id="home-slider">
    <div class="flexslider">
        <ul class="slides">
            <li>
                <img src="${pageContext.request.contextPath}/resources/themes/img/slider/slider1.jpg" alt=""  class="slider-image"/>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/resources/themes/img/slider/slider2.jpg" alt=""   class="slider-image"/>
                <div class="intro">
                    <h1>Winter season sale</h1>
                    <p><span>Up to 90% Off</span></p>
                    <p><span>On all games</span></p>
                </div>
            </li>
        </ul>
    </div>			
</section>

<%-- 
    Document   : contactView
    Created on : Jan 15, 2021, 3:19:48 PM
    Author     : Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

            <section class="google_map">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.76409817837!2d105.81853931502917!3d21.002091294063835!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac84510913a3%3A0xf319dedc303775e1!2zMTkgTmd1eeG7hW4gVHLDo2ksIE5nw6MgVMawIFPhu58sIFRoYW5oIFh1w6JuLCBIw6AgTuG7mWkgMTAwMDAsIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1610528132412!5m2!1svi!2s" width="1200" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>			</section>
            <section class="header_text sub">
                <h4><span>Contact Us</span></h4>
            </section>
            <section class="main-content">				
                <div class="row">				
                    <div class="span5">
                        <div>
                            <h5>ADDITIONAL INFORMATION</h5>
                            <p><strong>Phone:</strong>&nbsp;(123) 456-7890<br>
                                <strong>Fax:</strong>&nbsp;+04 (123) 456-7890<br>
                                <strong>Email:</strong>&nbsp;<a href="#">titanshop@email.com</a><br>
                                <strong>Address:</strong>&nbsp;19 Nguyen Trai, Thanh Xuan, Hanoi<br>						
                            </p>
                            <br/>
                            <h5>SECONDARY OFFICE IN VIETNAM</h5>
                            <p><strong>Phone:</strong>&nbsp;(113) 023-1125<br>
                                <strong>Fax:</strong>&nbsp;+04 (113) 023-1145<br>
                                <strong>Email:</strong>&nbsp;<a href="#">titangameshop@gmail.com</a><br>	
                                <strong>Address:</strong>&nbsp;19 Nam Ky Khoi Nghia, District 1, Hochiminh City<br>				
                            </p>
                        </div>
                    </div>
                    <div class="span7">
                        <p>Subscribe or contact to get newest information</p>
                        <form method="post" action="#">
                            <fieldset>
                                <div class="clearfix">
                                    <label for="name"><span>Name:</span></label>
                                    <div class="input">
                                        <input tabindex="1" size="18" id="name" name="name" type="text" value="" class="input-xxlarge" placeholder="Name">
                                    </div>
                                </div>

                                <div class="clearfix">
                                    <label for="email"><span>Email:</span></label>
                                    <div class="input">
                                        <input tabindex="2" size="25" id="email" name="email" type="text" value="" class="input-xxlarge" placeholder="Email Address">
                                    </div>
                                </div>

                                <div class="clearfix">
                                    <label for="message"><span>Message:</span></label>
                                    <div class="input">
                                        <textarea tabindex="3" class="input-xxlarge" id="message" name="body" rows="7" placeholder="Message"></textarea>
                                    </div>
                                </div>

                                <div class="actions">
                                    <button tabindex="3" type="submit" class="btn btn-inverse">Send message</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>				
                </div>
            </section>	            

            <jsp:include page="../_footer.jsp"/>
        </div>            
    </body>
</html>

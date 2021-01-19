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
        <title>FAQ</title>
    </head>
    <body>
        <jsp:include page="../_header.jsp"/>
        <div id="wrapper" class="container">
            <jsp:include page="../_menu.jsp"/>

      <section class="header_text sub">
        <h2><span>FAQ</span></h2>
      </section>
      <section class="main-content">
        <div class="row">
          <div class="span12">
            <div class="accordion" id="accordion2">
              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion1"
                    href="#collapseOne"
                    >What are the future plans for the Titan Games Store?</a
                  >
                </div>
                <div id="collapseOne" class="accordion-body collapse">
                  <div class="accordion-inner">
                    <p>
                      You can find upcoming features, developer updates, and
                      major known issues on our Titan Games Store Roadmap on
                      Trello. We’ll also share significant updates with you on
                      our news feed and social media pages such as Facebook,
                      Twitter, Instagram, and YouTube.
                    </p>
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion2"
                    href="#collapseTwo"
                    >What is the Titan Games Store?</a
                  >
                </div>
                <div id="collapseTwo" class="accordion-body collapse">
                  <div class="accordion-inner">
                    <p>
                      The Titan Games Store is a curated digital storefront for
                      PC and Mac, designed with both players and creators in
                      mind. It’s focused on providing great games for gamers,
                      and a fair deal for game developers. When you buy a game
                      on the Titan Games Store, 88% of the price goes directly
                      to developers, versus only 70% on many other stores. This
                      helps developers invest into building bigger and better
                      games.
                    </p>
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion2"
                    href="#collapseThree"
                  >
                    Which platforms does the Titan Games Store support?
                  </a>
                </div>
                <div id="collapseThree" class="accordion-body collapse">
                  <div class="accordion-inner">
                    The Titan Games Store currently offers PC and Mac support.
                    You can check platform compatibility for individual titles
                    by referring to the “About Game” section of any product
                    page.
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion4"
                    href="#collapseFour"
                  >
                    Why does the Titan Games Store make exclusivity deals?
                  </a>
                </div>
                <div id="collapseFour" class="accordion-body collapse">
                  <div class="accordion-inner">
                    Exclusives are a part of the growth of many successful
                    platforms for games and for other forms of digital
                    entertainment, such as streaming video and music.
                    <br />
                    <br />
                    Titan works in partnership with developers and publishers to
                    offer games exclusively on the store. In exchange for
                    exclusivity, Titan provides them with financial support for
                    development and marketing, which enables them to build more
                    polished games with significantly less uncertainty for the
                    creators.
                    <br />
                    <br />
                    In addition, creators will earn 88% of all the revenue from
                    their game, while most stores only offer 70%.
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion5"
                    href="#collapseFive"
                  >
                    What’s this about free games?
                  </a>
                </div>
                <div id="collapseFive" class="accordion-body collapse">
                  <div class="accordion-inner">
                    Titan will be offering a new free game available each week
                    throughout 2020. When you claim a free game, it’s yours to
                    keep - even after the game is no longer available to new
                    customers for free.
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion6"
                    href="#collapseSix"
                  >
                    I claimed a free game but don’t see it on my account now,
                    why?
                  </a>
                </div>
                <div id="collapseSix" class="accordion-body collapse">
                  <div class="accordion-inner">
                    Once you claim a free game, it’s yours to keep. If you come
                    back later and don’t see it your account, please check to
                    see if you have multiple accounts. If you created an Titan
                    account using an @gmail.com email address, log in to it
                    directly using your Gmail password; using the Google login
                    button will create a distinct account even if it’s tied to
                    the same @gmail.com email address. And check to see if you
                    have both a console-linked account (logging in via
                    PlayStation, Xbox, or Nintendo account) and a separate Titan
                    account. If you still encounter issues, please contact
                    player support <a href="./contact.html">here</a>.
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion7"
                    href="#collapseSeven"
                  >
                    Can I try a game before I buy it?
                  </a>
                </div>
                <div id="collapseSeven" class="accordion-body collapse">
                  <div class="accordion-inner">Sorry no.</div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion8"
                    href="#collapseEight"
                  >
                    How do I contact support?
                  </a>
                </div>
                <div id="collapseEight" class="accordion-body collapse">
                  <div class="accordion-inner">
                    You can contact our support team
                    <a href="./contact.html">here</a>. We also recommend
                    browsing our support center articles, which may help answer
                    questions or resolve issues.
                  </div>
                </div>
              </div>

              <div class="accordion-group">
                <div class="accordion-heading">
                  <a
                    class="accordion-toggle"
                    data-toggle="collapse"
                    data-parent="#accordion9"
                    href="#collapseNine"
                  >
                    Is my Epic Games account secure?
                  </a>
                </div>
                <div id="collapseNine" class="accordion-body collapse">
                  <div class="accordion-inner">
                    The Epic account system powers Fortnite, the Epic Games
                    store, and Unreal Engine. This account system has never been
                    compromised. However, specific individual Epic accounts have
                    been compromised by hackers using lists of email addresses
                    and passwords leaked from other sites which have been
                    compromised. <br />
                    <br />
                    If you use the same email address and password on Epic as
                    you used on another site which has been compromised, then
                    your account is vulnerable to attack. To secure your Epic
                    account, use a unique password, and enable multi-factor
                    authentication. You can learn more about the measures we
                    take to protect your account and what you can do to stay
                    safe here.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

            <jsp:include page="../_footer.jsp"/>
        </div>            
    </body>
</html>

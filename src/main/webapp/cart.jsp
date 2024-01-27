<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Cart</title>

        <!-- favicon -->
        <link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
        <!-- google font -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
        <!-- fontawesome -->
        <link rel="stylesheet" href="assets/css/all.min.css">
        <!-- bootstrap -->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <!-- owl carousel -->
        <link rel="stylesheet" href="assets/css/owl.carousel.css">
        <!-- magnific popup -->
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <!-- animate css -->
        <link rel="stylesheet" href="assets/css/animate.css">
        <!-- mean menu css -->
        <link rel="stylesheet" href="assets/css/meanmenu.min.css">
        <!-- main style -->
        <link rel="stylesheet" href="assets/css/main.css">
        <!-- responsive -->
        <link rel="stylesheet" href="assets/css/responsive.css">
        <script src="js/script.js"></script>
        <link rel="stylesheet" href="./css/style-welcome.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <style>
            input[type="number"] {
                width: 50% !important;
            }
        </style>
    </head>
    <body>

        <!--PreLoader-->
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <!--PreLoader Ends-->

        <!-- header -->
        <jsp:include page="menu.jsp"></jsp:include>

            <!-- end header -->

            <!-- search area -->
            
            <!-- end search arewa -->

            <!-- breadcrumb-section -->
            <div class="breadcrumb-section breadcrumb-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2 text-center">
                            <div class="breadcrumb-text">
                                <p>Fresh and Organic</p>
                                <h1>Cart</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end breadcrumb section -->

            <!-- cart -->
            <div class="cart-section mt-150 mb-150">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10 col-md-12">
                            <div class="cart-table-wrap">
                                <form action="shop" method="post">
                                    <button type="submit" id="acceptButton" class="d-flex border-0 bg-white  mb-2 p-2"><span class="material-symbols-outlined">
                                            arrow_back
                                        </span> Back to shop</button>
                                </form>

                                <table class="cart-table">
                                    <thead class="cart-table-head">
                                        <tr class="table-head-row">

                                            <th class="product-remove"></th>
                                            <th class="product-image">Fruit Image</th>
                                            <th class="product-name">Name</th>
                                            <th class="product-price">Price</th>
                                            <th class="product-quantity">Quantity</th>
                                            <th class="product-amount">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody id="table-cart-item"> 
                                        <tr>
                                            <td class="font-weight-bold" colspan="4">Total:</td>
                                            <td class="font-weight-bold" colspan="2">${amount}VND</td>
                                    </tr>
                                    <c:forEach var="o" items="${pro}">
                                        <tr class="table-body-row">
                                            <td class="product-remove">
                                                <button data-proId="${o.pId}" data-user="${sessionScope.username}" onclick="deleteCart(this)"
                                                        class="btn-link btn text-dark" type="submit"><i class="far fa-window-close"></i></button>                                           
                                            <td class="product-image"><img src="${o.img}" alt=""></td>
                                            <td class="product-name">${o.pname}</td>
                                            <td class="product-price">${o.price}VND</td>
                                            <td class="product-quantity">
                                                <input data-pro-id="${o.pId}" oninput="updateQuan(this)" class="w-25" type="number" min="1" value="${o.quantity}">
                                            </td>
                                            <td class="product-amount">${o.amount}VND</td>
                                        </tr>
                                    </c:forEach>


                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-12">
                        <div class="total-section">

                            <div class="cart-buttons">
                                <c:choose>
                                    <c:when test="${pro.isEmpty()}">
                                        <button id="showMess" class="showMess bg-white border-0 d-inline-block">
                                            <a style="margin: 0;" class="showMess boxed-btn black">Check Out</a>
                                        </button>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="checkout" class="boxed-btn black">Check Out</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- end cart -->
        <div class="main-popup w-100 h-100" id="myPopupCart">
            <div class="popupSignup w-25">
                <div  class="d-flex justify-content-center" style="width: 100%" class="icon">
                    <img id="myIcon" class="d-inline-block" style="width: 30%" src="assets/img/giphy.gif" alt="alt"/>
                </div>
                <div class="d-flex flex-column align-content-center justify-content-center">
                    <h3 class="text-dark text-center">Giỏ hàng trống!<br> Mời bạn mua hàng!</h3>

                    <div class="text-center">
                        <form action="shop" method="post">
                            <button type="submit" id="acceptButton" class="target-button btn btn-dark mr-2 p-2">OK !</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
        <!-- logo carousel -->
        <div class="logo-carousel-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="logo-carousel-inner">
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/1.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/2.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/3.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/4.png" alt="">
                            </div>
                            <div class="single-logo-item">
                                <img src="assets/img/company-logos/5.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end logo carousel -->

        <!-- footer -->
        <div class="footer-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box about-widget">
                            <h2 class="widget-title">About us</h2>
                            <p>Ut enim ad minim veniam perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box get-in-touch">
                            <h2 class="widget-title">Get in Touch</h2>
                            <ul>
                                <li>34/8, East Hukupara, Gifirtok, Sadan.</li>
                                <li>support@fruitkha.com</li>
                                <li>+00 111 222 3333</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box pages">
                            <h2 class="widget-title">Pages</h2>
                            <ul>
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="about.jsp">About</a></li>
                                <li><a href="services.jsp">Shop</a></li>
                                <li><a href="news.jsp">News</a></li>
                                <li><a href="contact.jsp">Contact</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box subscribe">
                            <h2 class="widget-title">Subscribe</h2>
                            <p>Subscribe to our mailing list to get the latest updates.</p>
                            <form action="index.jsp">
                                <input type="email" placeholder="Email">
                                <button type="submit"><i class="fas fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end footer -->

        <!-- copyright -->
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <p>Copyrights &copy; 2019 - <a href="https://imransdesign.com/">Imran Hossain</a>,  All Rights Reserved.</p>
                    </div>
                    <div class="col-lg-6 text-right col-md-12">
                        <div class="social-icons">
                            <ul>
                                <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                                <li><a href="#" target="_blank"><i class="fab fa-dribbble"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end copyright -->
        <script type="text/javascript">
            showHide("showMess", "acceptButton", "myPopupCart", "flex");
            function updateQuan(param) {
                var proId = param.getAttribute('data-pro-id');
                var quantity = param.value;
                $.ajax({
                    type: "get",
                    url: "cart", // URL của Servlet
                    data: {
                        proId: proId,
                        quantity: quantity,
                        update: "Update"
                    },

                    success: function (data) {
                        var row = document.getElementById("table-cart-item");
                        row.innerHTML = data;

                    }
                });
            }
            function deleteCart(param) {
                var proId = param.getAttribute('data-proId');
                var user = param.getAttribute('data-user');
                $.ajax({
                    type: "post",
                    url: "cart", // URL của Servlet
                    data: {
                        proId: proId,
                        user: user
                    },

                    success: function (data) {
                        var row = document.getElementById("table-cart-item");
                        row.innerHTML = data;

                    }
                });
            }
        </script>
        <!-- jquery -->
        <script src="assets/js/jquery-1.11.3.min.js"></script>
        <!-- bootstrap -->
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <!-- count down -->
        <script src="assets/js/jquery.countdown.js"></script>
        <!-- isotope -->
        <script src="assets/js/jquery.isotope-3.0.6.min.js"></script>
        <!-- waypoints -->
        <script src="assets/js/waypoints.js"></script>
        <!-- owl carousel -->
        <script src="assets/js/owl.carousel.min.js"></script>
        <!-- magnific popup -->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!-- mean menu -->
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <!-- sticker js -->
        <script src="assets/js/sticker.js"></script>
        <!-- main js -->
        <script src="assets/js/main.js"></script>

    </body>
</html>
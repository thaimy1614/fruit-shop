<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- title -->
        <title>Check Out</title>

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
        <link rel="stylesheet" href="css/style-welcome.css"/>
        <script src="assets/jquery-1.11.3.min.js"></script>
        <script src="js/script.js"></script>
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
                                <h1>Check Out Product</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end breadcrumb section -->

            <!-- check out section -->
            <div class="checkout-section mt-150 mb-150">
                <div class="container">
                    <form id="orderForm" action="checkout" method="POST">
                        <div class="row">

                            <div class="col-lg-8">
                                <div class="checkout-accordion-wrap">
                                    <div class="accordion" id="accordionExample">
                                        <div class="card single-accordion">
                                            <div class="card-header" id="headingOne">
                                                <h5 class="mb-0">
                                                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                        Shipping Address
                                                    </button>
                                                </h5>
                                            </div>

                                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    <div class="billing-address-form">


                                                        <p><input id="input-name" class="form-control" required type="text" placeholder="Name" name="name" required value="${sessionScope.info.fullname}">
                                                    </p>
                                                    <p><input id="input-address" class="form-control" type="text" placeholder="Address" name="address" required value="${sessionScope.info.address}" >
                                                    </p>
                                                    <p><input id="input-phone" class="form-control" type="tel" placeholder="Phone" name="phone" value="${sessionScope.info.phone}" required>
                                                    </p>
                                                    <p><textarea class="form-control" name="note" id="bill" cols="30" rows="5" placeholder="Say Something"></textarea></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card single-accordion">
                                        <div class="card-header" id="headingThree">
                                            <h5 class="mb-0">
                                                <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                    Card Details
                                                </button>
                                            </h5>
                                        </div>
                                        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <div class="card-details">
                                                    <div class="cart-table-wrap">
                                                        <table class="cart-table">
                                                            <thead class="cart-table-head">
                                                                <tr class="table-head-row">
                                                                    <th class="product-image">Fruit Image</th>
                                                                    <th class="product-name">Name</th>
                                                                    <th class="product-price">Price</th>
                                                                    <th class="product-quantity">Quantity</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody> 
                                                                <c:forEach var="o" items="${name}">
                                                                    <tr class="table-body-quantity">
                                                                        <td class="product-image"><img src="${o.img}" alt=""></td>
                                                                        <td class="product-name">${o.pname}</td>
                                                                        <td class="product-price">${o.price}VND</td>
                                                                        <td class="product-quantity">${o.quantity}</td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="order-details-wrap">
                                <table class="order-details">
                                    <thead>
                                        <tr>
                                            <th>Your order Details</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody class="order-details-body">

                                        <tr>
                                            <td>Product</td>
                                            <td>Total</td>
                                        </tr>

                                        <c:forEach var="h" items="${name}">
                                            <tr class="table-body-row">
                                                <td>${h.pname}</td>
                                                <td class="product-price">${h.amount}VND</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tbody class="checkout-details">
                                        <tr>
                                            <td>Total</td>
                                            <td>
                                                VND<input class="input-group d-inline p-0 border-0" type="number" name="total"  value="${amount}" readonly>
                                                <input class="input-group d-inline p-0 border-0" type="hidden" name="quantity" id="total-input-quantity" value="${quan}" readonly>
                                                <input class="input-group d-inline p-0 border-0" type="hidden" name="pay"  value="${pay}" readonly>
                                                <input type="hidden" name="payonl"  value="${payonl}">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button type="submit" class="border-0 bg-white mt-5 ">
                                    <a class="boxed-btn mt-lg-4" id="btn-submit" >Ship COD</a>
                                </button>

                            </div>
                        </div>

                    </div>
                </form>
                <form class="d-flex justify-content-lg-center w-100 pr-100" id="frmCreateOrder" action="vnpayajax" method="post">
                    <div class="w-50"></div>
                    <button tpostype="submit" class="border-0 bg-white mt-2  mr-100">
                        <input type="hidden" id="language" Checked="True" name="language" value="vn">
                        <input type="hidden" name="amount" value="${amount}">
                        <a  class="boxed-btn d-block " id="btn-submit" >Online Payment</a>
                    </button>
                </form>
            </div>
        </div>
        <!-- end check out section -->
        <div class="main-popup w-100 h-100 ${mess}" id="myPopupCart">
            <div class="popupSignup w-25">
                <div  class="d-flex justify-content-center" style="width: 100%" class="icon">
                    <img id="myIcon" class="d-inline-block" style="width: 30%" src="assets/img/giphy.gif" alt="alt"/>
                </div>
                <div class="d-flex flex-column align-content-center justify-content-center">
                    <h3 class="text-dark text-center">Thank your order,<br><span class="font-weight-bolder">${sessionScope.info.fullname}!</span> </h3>
                    <p class="text-dark text-center"> The order will ship to you soon!</p>
                    <div class="text-center">
                        <form action="shop" method="post">
                            <button type="submit" id="acceptButton" class="target-button btn btn-dark mr-2 p-2">OK !</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
        <div class="main-popup w-100 h-100 ${messoneline}" id="myPopupCart">
            <div class="popupSignup w-25">
                <div  class="d-flex justify-content-center" style="width: 100%" class="icon">
                    <img id="myIcon" class="d-inline-block" style="width: 30%" src="assets/img/giphy.gif" alt="alt"/>
                </div>
                <div class="d-flex flex-column align-content-center justify-content-center">
                    <h3 class="text-dark text-center">Thank your order,<br><span class="font-weight-bolder">${sessionScope.info.fullname}!</span> </h3>
                    <p class="text-dark text-center"> The order will ship to you soon!</p>
                    <div class="text-center">

                        <button onclick="submitFormO()" type="submit" id="acceptButtonOnl" class="target-button btn btn-dark mr-2 p-2">OK !</button>


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
                            <p>FRUIT SHOP - 100% FRESH</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-box get-in-touch">
                            <h2 class="widget-title">Get in Touch</h2>
                            <ul>
                                <li>11, NVC, An Khanh, Ninh Kieu, Can Tho.</li>
                                <li>group01se1709@gmail.com</li>
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
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script >

                            $("#frmCreateOrder").submit(function () {
                                var postData = $("#frmCreateOrder").serialize();
                                var submitUrl = $("#frmCreateOrder").attr("action");
                                $.ajax({
                                    type: "POST",
                                    url: submitUrl,
                                    data: postData,
                                    dataType: 'JSON',
                                    success: function (x) {
                                        if (x.code === '00') {
                                            if (window.vnpay) {
                                                vnpay.open({width: 768, height: 600, url: x.data});
                                            } else {
                                                location.href = x.data;
                                            }
                                            return false;
                                        } else {
                                            alert(x.Message);
                                        }
                                    }
                                });
                                return false;
                            });
                            function myFunction(id, mess) {
                                var inputElement = document.getElementById(id);
                                var inputValue = inputElement.value;
                                var messageSpan = document.getElementById(mess);

                                if (inputValue === '') {
                                    // The input field is empty
                                    messageSpan.textContent = 'Please fill this field!';
                                    // You can perform further actions or validation here
                                } else {
                                    // The input field is not empty
                                    messageSpan.textContent = ' ';
                                    // You can perform further actions with the input value
                                }
                            }
                            checkfillnew();
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
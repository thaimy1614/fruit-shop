<%@page import="model.CartDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Shop</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.js"></script>

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
                                <h1>Shop</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end breadcrumb section -->

            <!-- products -->
            <div class="product-section mt-150 mb-150">
                <div class="container">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="product-filters">
                                <ul>
                                    <li class="active" data-filter="*">All</li>
                                    <li data-filter=".strawberry">Strawberry</li>
                                    <li data-filter=".berry">Berry</li>
                                    <li data-filter=".lemon">Lemon</li>
                                    <li data-filter=".orther">Orther</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="row product-lists">
                    <c:forEach var="p" items="${products}">

                        <div class="col-lg-4 col-md-6 text-center ${fn:toLowerCase(p.cname)}">
                            <div class="single-product-item">
                                <c:url var="detail" value="shop">
                                    <c:param name="name" value="${p.pName}"/>
                                    <c:param name="img" value="${p.pimg}"/>
                                    <c:param name="price" value="${p.pPrice}"/>
                                    <c:param name="des" value="${p.pDes}"/>
                                    <c:param name="cate" value="${p.cname}"/>
                                    <c:param name="proId" value="${p.pId}"/>
                                </c:url>
                                <div class="product-image">                                       
                                    <a onclick="Delete(this)" data-order-link="${detail}"><img src="${p.pimg}" alt=""></a>

                                </div>
                                <h3>${p.pName}</h3>
                                <p class="product-price"><span>Per Kg</span> ${p.pPrice}VND </p>
                                <c:if test="${sessionScope.user == null}">
                                    <a href="loginpage" class="cart-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</a>
                                </c:if>
                                <c:if test="${sessionScope.user != null}">
                                    <button type="submit" class="object d-inline border-0 bg-white" data-cart-id="${p.pId}" data-cart-user="${sessionScope.username}" 
                                            data-cart-quantity="1" onclick="addCart(this)">
                                        <a class="cart-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</a>
                                    </button>
                                </c:if>






                            </div>
                        </div>
                    </c:forEach>			
                </div>

                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="pagination-wrap">
                            <ul>
                                <li><a href="#">Prev</a></li>
                                <li><a href="#">1</a></li>
                                <li><a class="active" href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">Next</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end products -->

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
        <script>
            const buttons = document.querySelectorAll(".object");
            const cart = document.querySelector(".shopping-cart");
            buttons.forEach((button) => {
                button.addEventListener("click", () => {
                    cart.style.animation = "shake 1s ease forwards";
                    setTimeout(() => {
                        cart.style.animation = "none";
                    }, 500);

                });
            });
            
            function addCart(param) {
                var proId = param.getAttribute('data-cart-id');
                var user = param.getAttribute('data-cart-user');
                var quantity = param.getAttribute('data-cart-quantity');
                $.ajax({
                    type: "POST",
                    url: "addcart", // URL của Servlet
                    data: {
                        proId: proId,
                        user: user,
                        quantity: quantity
                    },

                    success: function (data) {
                        if (data && typeof data.count !== 'undefined') {
                            $('#lblCartCount').removeClass('hidden');
                            // Access the updated count from the JSON response
                            var updatedCount = data.count;

                            // Update the cart count on the page
                            var numberOfItem = document.getElementById("lblCartCount");
                            numberOfItem.innerHTML = updatedCount;
                        } else {
                            console.error("Invalid JSON response from server");
                        }
                    },

                    error: function (jqXHR, textStatus, errorThrown) {
                        console.error("AJAX Error:", textStatus, errorThrown);
                        console.log("Response Text:", jqXHR.responseText);
                    }
                });

            }
        </script>
        <!-- jquery -->
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
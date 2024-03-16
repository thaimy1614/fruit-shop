<%@page import="dao.CartDAO"%>
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
        <script>
            // JavaScript để xác định trạng thái đăng nhập của người dùng
            $(document).ready(function () {
                // Kiểm tra xem người dùng đã đăng nhập hay chưa
                var isLoggedIn = ${not empty sessionScope.user};
                console.log('is logged: ' + isLoggedIn);
                // Đặt giá trị của thuộc tính data-logged-in
                $('#login-info').attr('data-logged-in', isLoggedIn.toString());
            });
        </script>
    </head>
    <body>
        <c:if test="${sessionScope.isAdmin eq 1}">
            <c:redirect url="dashboard"></c:redirect>
        </c:if>
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
                                    <c:forEach var="cate" items="${categories}">
                                    <li>${cate.cName}</li>
                                    </c:forEach>
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
                                <li><a id="prevPage">Prev</a></li>
                                    <c:forEach begin="1" end="${allProducts.size()/6 + 1}" step="1" varStatus="number">
                                    <li>
                                        <c:if test="${number.index == 1}">
                                            <a page="${number.index}" class="page-number active">${number.index}</a>
                                        </c:if>
                                        <c:if test="${number.index != 1}">
                                            <a class="page-number"  page="${number.index}">${number.index}</a>
                                        </c:if>    
                                    </li>
                                </c:forEach>


                                <li><a id="nextPage">Next</a></li>
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
        <div id="login-info" data-logged-in="false" data-username="${sessionScope.username}"></div>
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
        <script>
            $(document).ready(function () {
                var currentPage = 1;
                var maxPage = 100;

                // Hàm để tải sản phẩm bằng AJAX
                function loadProducts() {
                    var filter = $('.product-filters li.active').html().toString().toLowerCase();
                    if (filter === 'other') {
                        filter = 'other';
                    }
                    $.ajax({
                        type: "POST",
                        url: "shop",
                        data: {
                            filter: filter,
                            page: currentPage
                        },
                        dataType: "json",
                        success: function (response) {
                            // Xóa danh sách sản phẩm hiện tại
                            $('.product-lists').empty();

                            var totalFilteredProducts = response.totalFilteredProducts;
                            console.log(totalFilteredProducts);
                            var products = response.productsOnPage;
                            // Hiển thị sản phẩm mới tải
                            $.each(products, function (index, p) {
                                var productItem = $('<div>').addClass('col-lg-4 col-md-6 text-center ' + p.cname.toLowerCase());
                                var productInner = $('<div>').addClass('single-product-item');
                                var productImage = $('<div>').addClass('product-image');
                                var imageLink = $('<a>').attr('onclick', 'Delete(this)').attr('data-order-link', 'shop?name=' + encodeURIComponent(p.pName) + '&img=' + encodeURIComponent(p.pimg) + '&price=' + encodeURIComponent(p.pPrice) + '&des=' + encodeURIComponent(p.pDes) + '&cate=' + encodeURIComponent(p.cname) + '&proId=' + encodeURIComponent(p.pId));
                                var image = $('<img>').attr('src', p.pimg).attr('alt', '');
                                var productName = $('<h3>').text(p.pName);
                                var productPrice = $('<p>').addClass('product-price').html('<span>Per Kg</span> ' + p.pPrice + 'VND');

                                // Kiểm tra xem người dùng đã đăng nhập hay chưa
                                var isLoggedIn = ($('#login-info').attr('data-logged-in') === "true");

                                // Tạo nút Add to Cart tương ứng
                                var addToCartButton;
                                if (isLoggedIn) {
                                    var username = $('#login-info').attr('data-username').toString();
                                    addToCartButton = $('<button>').addClass('object d-inline border-0 bg-white').attr('data-cart-id', p.pId).attr('data-cart-user', username).attr('data-cart-quantity', '1').attr('onclick', 'addCart(this)');
                                    var cartBtn = $('<a>').addClass('cart-btn').html('<i class="fas fa-shopping-cart"></i> Add to Cart');
                                    addToCartButton.append(cartBtn);
                                } else {
                                    addToCartButton = $('<a>').addClass('cart-btn').attr('href', 'loginpage').html('<i class="fas fa-shopping-cart"></i> Add to Cart');
                                }

                                // Ghép các phần tử con vào nhau
                                imageLink.append(image);
                                productImage.append(imageLink);
                                productInner.append(productImage);
                                productInner.append(productName);
                                productInner.append(productPrice);
                                productInner.append(addToCartButton);
                                productItem.append(productInner);

                                // Thêm sản phẩm vào danh sách
                                $('.product-lists').append(productItem);
                            });
                            var currentNumberOfPage = $('.pagination-wrap ul').children().length - 2;
                            console.log(currentNumberOfPage);
                            console.log(Math.ceil(totalFilteredProducts / 6));
                            if (currentNumberOfPage !== Math.ceil(totalFilteredProducts / 6)) {
                                $('.pagination-wrap li').remove();
                                var page = "<li><a id='prevPage'>Prev</a></li>";

                                for (var i = 1; i <= Math.ceil(totalFilteredProducts / 6); i++) {
                                    page += "<li><a class='page-number' page='" + i + "'>" + i + "</a></li>";
                                }
                                page += "<li><a id='nextPage'>Next</a></li>";
                                $('.pagination-wrap ul').append(page);
                                $('.pagination-wrap li a.page-number').first().addClass('active');
                                console.log("successful!");
                            }
                            maxPage = Math.ceil(totalFilteredProducts / 6);
                        }
                    });
                }

                // Sử dụng delegated event để gắn sự kiện click cho các thẻ a.page-number trong .pagination-wrap ul
                $('.pagination-wrap ul').on('click', 'li a.page-number', function () {
                    // Loại bỏ lớp 'active' khỏi tất cả các thẻ 'a'
                    $('.pagination-wrap li a').removeClass('active');
                    // Thêm lớp 'active' cho thẻ 'a' hiện tại
                    $(this).addClass('active');
                    // Lấy giá trị của thẻ 'a' được click
                    currentPage = parseInt($(this).text(), 10);
                    // Gọi lại hàm loadProducts() với trang được chọn
                    loadProducts();
                });

                $(".product-filters li").on('click', function () {
                    currentPage = 1;

                    $(".product-filters li").removeClass("active");
                    $(this).addClass("active");
                    loadProducts();

//                    $('.pagination-wrap li a.page-number').removeClass('active');
//                    $('.pagination-wrap li a.page-number').first().addClass('active');
                });
                // Sự kiện khi nhấn Prev hoặc Next
                $('.pagination-wrap ul').on('click', 'li a#prevPage, li a#nextPage', function () {

                    // Loại bỏ lớp 'active' khỏi tất cả các thẻ 'a'
                    $('.pagination-wrap li a').removeClass('active');
                    // Thêm lớp 'active' cho thẻ 'a' hiện tại

                    // Lấy giá trị của thẻ 'a' được click
                    var id = $(this).attr('id');
                    if (id === 'prevPage' && currentPage > 1) {
                        currentPage = currentPage.valueOf() - 1;
                    } else if (id === 'nextPage') {
                        currentPage = currentPage.valueOf() + 1;
                    }
                    if (currentPage == 0 || currentPage == maxPage + 1) {
                        currentPage = 1;
                    }
                    $('.pagination-wrap li a.page-number').eq(currentPage - 1).addClass('active');
                    loadProducts();
                });
                // Tải sản phẩm cho trang đầu tiên khi trang được tải

            });

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
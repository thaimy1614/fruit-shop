<%-- 
    Document   : themthongtin
    Created on : Jun 11, 2023, 2:20:26 PM
    Author     : Dell
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style-welcome.css"/>
        <title>User Information</title>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .top-header-area {
                background-color: #051922;
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.info eq null}">
            <c:redirect url="loginpage"></c:redirect>
        </c:if>
        <c:if test="${sessionScope.isAdmin ne 1}">
            <jsp:include page="menu.jsp"></jsp:include>
        </c:if>
        <c:if test="${sessionScope.isAdmin eq 1}">
            <jsp:include page="nav-admin.jsp"></jsp:include>
                <style>
                    body {
                        background-color: #fbfbfb;
                    }
                    @media (min-width: 991.98px) {
                        main {
                            padding-left: 240px;
                        }
                    }

                    /* Sidebar */
                    .sidebar {
                        position: fixed;
                        top: 0;
                        bottom: 0;
                        left: 0;
                        padding: 58px 0 0; /* Height of navbar */
                        box-shadow: 0 2px 5px 0 rgb(0 0 0 / 5%), 0 2px 10px 0 rgb(0 0 0 / 5%);
                        width: 240px;
                        z-index: 600;
                    }

                    @media (max-width: 991.98px) {
                        .sidebar {
                            width: 100%;
                        }
                    }
                    .sidebar .active {
                        border-radius: 5px;
                        box-shadow: 0 2px 5px 0 rgb(0 0 0 / 16%), 0 2px 10px 0 rgb(0 0 0 / 12%);
                    }

                    .sidebar-sticky {
                        position: relative;
                        top: 0;
                        height: calc(100vh - 48px);
                        padding-top: 0.5rem;
                        overflow-x: hidden;
                        overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
                    }
                </style>
        </c:if>
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <div class="info__background pt-150">
            <div class="info__container">
                <h1 class="info__title">Personal Information</h1>
                <form action="account" method="post" class="info__form" id="update-form" style="display: flex; flex-wrap: wrap;">
                    <div class="info__data">
                        <label for="txtHoten" class="info__data-label">Full name</label>
                        <div class="info__data-area">
                            <input type="text" name="fullname" id="txtHoten" value="${ sessionScope.info.fullname}" placeholder="Enter your name">
                            <p class="info__datap" id="upterror"></p>
                            <input type="hidden"  name="username" value="${ sessionScope.info.user}">
                        </div>
                        <p class="info__datap" id="upnerror"></p>
                    </div>
                    <div class="info__data">
                        <label for="email" class="info__data-label">Email</label>
                        <input type="text" name="mail" readonly id="email" value="${ sessionScope.info.mail}">
                    </div>           
                    <div class="info__data">
                        <label for="txtPhone" class="info__data-label">Phone number</label>
                        <input type="text" id="txtPhone" name="phone" value="${ sessionScope.info.phone}" placeholder="Enter your phone number">
                        <p class="info__datap" id="upterror_1"></p>
                    </div>
                    <div class="info__data">
                        <label for="txtAddress" class="info__data-label">Address</label>
                        <input type="text" id="txtAddress" name="address" value="${ sessionScope.info.address}" placeholder="Enter your address">
                        <p class="info__datap" id="upaerror"></p>
                    </div>
                    <div class="info__footer">

                        <input id="backHome" type="submit" value="Back"></input> 


                        <input type="submit" class="login__submit" value="Update" name="action">
                    </div>
                    <%
                        if (request.getAttribute("thongbao") != null) {
                    %>
                    <p class="text-success" style="text-align: center; font-size: 2rem;"><%=request.getAttribute("thongbao")%></p>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
        <script src="js/script.js"></script>
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
    <script>
        document.getElementById("backHome").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent form submission
            window.location.href = "home"
        });
    </script>
</body>
</html>

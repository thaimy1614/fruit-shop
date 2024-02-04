<%-- 
    Document   : LoginPage
    Created on : Oct 15, 2023, 8:28:31 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <script src="./jQuery/jquery-3.5.1.slim.min.js"></script>
        <script src="./jQuery/popper.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="./jQuery/jquery-3.6.0.min.js"></script>
        <script src="js/script.js"></script>
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
        <<link rel="stylesheet" href="css/style-welcome.css"/>
        <style>
            .top-header-area {
                background-color: #051922;
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.info.user != null}">
            <jsp:forward page="home"></jsp:forward>
        </c:if>
        <jsp:include page="menu.jsp"></jsp:include>
            <div class="container mt-150 mb-150">
                <div class="row justify-content-center mt-5">
                    <div class="col-md-4">
                        <h2 class="text-center">Login Page</h2>
                        <form id="login" action="loginpage" method="POST">
                            <span class="text-danger text-decoration-none">${mess}</span>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" value="${username}" class="form-control" id="username" name="username" placeholder="Enter your username">
                            <span id="error-user" class="text-danger text-decoration-none"></span>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" value="${password}" class="form-control" id="password" name="password" placeholder="Enter your password">
                            <span id="error-pass" class="text-danger text-decoration-none"></span>
                        </div>
                        <div class="mb-3 form-check d-flex justify-content-between">
                            <div>
                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="on">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <div>
                                <a class="text-dark text-decoration-none" href="forgotpass">Forget password</a>
                            </div>

                        </div>
                        <button type="submit" class="btn btn-color btn-block">Login</button>
                    </form> <h6 class="mt-3 mb-3 text-center text-black-50">--Or---</h6>
                    <button type="submit" class=" btn btn-color btn-block"><a class="btn-color " href="signup"> Sign Up </a></button>
                </div>
            </div>
        </div>
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
            checkfill("#login", "#username", "#error-user", "Please enter username!");
            checkfill("#login", "#password", "#error-pass", "Please enter password!");

        </script>
    </body>
</html>
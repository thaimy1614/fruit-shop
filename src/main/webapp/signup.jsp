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
        <title>Sign Up</title>
        <link rel="stylesheet" href="./bootstrap/bootstrap.min.css">
        <script src="./jQuery/jquery-3.5.1.slim.min.js"></script>
        <script src="./jQuery/popper.min.js"></script>
        <script src="./bootstrap/bootstrap.min.js"></script>
        <script src="./jQuery/jquery-3.6.0.min.js"></script>
        <script src="./js/script.js"></script>
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
        <script src="js/script.js"></script>
        <style>
            .top-header-area {
                background-color: #051922;
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.isAdmin eq 1}">
            <c:redirect url="dashboard"></c:redirect>
        </c:if>
        <c:if test="${sessionScope.info.user != null}">
            <jsp:forward page="home"></jsp:forward>
        </c:if>
        <jsp:include page="menu.jsp"></jsp:include>
            <section class="vh-100 mt-80 bg-image"
                     style="background-image: url('https://media.istockphoto.com/id/1194235751/vector/fruit-and-berry-background-abstract-food-seamless-pattern-fresh-fruits-wallpaper-with-apple.jpg?s=612x612&w=0&k=20&c=6F3JSemEMGit8LE3DqXFKlIWMIxAba0PT8Quoa_XbtA=');">
                <div class="mask d-flex align-items-center h-100 gradient-custom-3">
                    <div class="container h-100">
                        <div class="row d-flex justify-content-center align-items-center h-100">
                            <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                                <div class="card" style="border-radius: 15px;">
                                    <div class="card-body p-5">
                                        <h2 class="text-uppercase text-center mb-5">Sign Up</h2>
                                        <span id="error-user" class="align-content-center text-danger text-center mb-2">${mess}</span>

                                    <form id="signupform" action="signup" method="post">
                                        <div class="row justify-content-around">
                                            <div class="form-outline mb-4">
                                                <label class="form-label" for="username">Username <span class="text-danger">*</span></label>
                                                <input type="text" id="username" class="form-control form-control" name="usersignup"/>

                                            </div>
                                            <div class="form-outline mb-4">
                                                <label class="form-label" for="fullname">Your Name <span class="text-danger">*</span></label>
                                                <input type="text" id="fullname" class="form-control form-control" name="fullnamesignup"/>
                                                <span id="error-name" class="text-danger"></span>
                                            </div>
                                        </div>
                                        <div class="row justify-content-around">
                                            <div class="form-outline mb-4">
                                                <label class="form-label" for="password">Password <span class="text-danger">*</span></label>
                                                <input type="password" id="password" class="form-control form-control" name="passwordsignup"/>
                                                <span id="error-pass" class="text-danger"></span>
                                            </div>

                                            <div class="form-outline mb-4">
                                                <label class="form-label" for="repeatPassword">Repeat your password <span class="text-danger">*</span></label>
                                                <input type="password" id="repeatPassword" class="form-control form-control"/>
                                                <span id="error-repass" class=" text-danger"></span>

                                            </div>
                                        </div>
                                        <span id="message" class="align-middle text-danger mb-2"></span>
                                        <div class="row justify-content-around"><div class="form-outline mb-4">
                                                <label class="form-label" for="email">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" id="email" class="form-control form-control" name="emailsignup" />
                                                <span id="error-email" class="text-danger"></span>
                                            </div>
                                            <div class="form-outline mb-4">
                                                <label class="form-label" for="phone">Your Phone</label>
                                                <input type="tel" id="phone" class="form-control form-control" name="phonesignup"/>
                                            </div>
                                        </div>
                                        <div class="form-outline mb-4">
                                            <label class="form-label" for="address">Address</label>
                                            <input type="text" id="address" class="form-control form-control" name="addresssignup"/>
                                        </div>


                                        <div class="d-flex justify-content-center">
                                            <button type="submit"
                                                    class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Register</button>
                                        </div>

                                        <p class="text-center text-muted mt-5 mb-0">Have already an account? <a href="loginpage"
                                                                                                                class="fw-bold text-body"><u>Login here</u></a></p>

                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="main-popup w-100 h-100 ${mess}" id="myPopupSignup">

            <div class="popupSignup w-25">
                <div  class="d-flex justify-content-center" style="width: 100%" class="icon">
                    <img id="myIcon" class="d-inline-block" style="width: 30%" src="assets/img/giphy.gif" alt="alt"/>
                </div>
                <div class="d-flex flex-column align-content-center justify-content-center">
                    <h2 class="text-success text-center">Sign Up <br> Success!</h2>
                    <p class="text-center">Go to Login?</p>
                    <div class="text-center">
                        <button id="acceptButton" class="target-button btn btn-primary mr-2" data-order-link="loginpage" onclick="Delete(this)">Yes</button>
                        <button id="cancelButton" class="cancel btn btn-danger">No</button>
                    </div>
                </div>
            </div>
        </div>


        <script>

            showHide("cancelButton", "cancelButton", "myPopupSignup", "none");
            checkfill("#signupform", "#username", "#error-user", "Please fill this field!");
            checkfill("#signupform", "#fullname", "#error-name", "Please fill this field!");
            checkfill("#signupform", "#password", "#error-pass", "Please fill this field!");
            checkfill("#signupform", "#repeatPassword", "#error-repass", "Please fill this field!");
            checkfill("#signupform", "#email", "#error-email", "Please fill this field!");

            const passwordForm = document.getElementById("signupform");
            const password = document.getElementById("password");
            const repeatPassword = document.getElementById("repeatPassword");
            const message = document.getElementById("message");

            passwordForm.addEventListener("submit", function (e) {
                if (password.value !== repeatPassword.value) {
                    message.textContent = "**Password and authentication password do not match";
                    e.preventDefault();
                }
            });

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
            checkfill("#login", "#username", "#error-user", "Please enter username!");
            checkfill("#login", "#password", "#error-pass", "Please enter password!");

        </script>
    </body>
</html>
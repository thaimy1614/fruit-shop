<%-- 
    Document   : feedback
    Created on : Feb 22, 2024, 1:21:17 PM
    Author     : Duong Quoc Thai CE171563
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

        <!-- title -->
        <title>Feedback</title>

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
        <style>
            .top-header-area {
                background-color: #051922;
            }
            ul li{
                list-style-type: none;
            }
            .message {
                background-color: #f0f0f0;
                padding: 10px;
                border-radius: 5px;
            }

            .response {
                margin-top: 10px;
                margin-left: 30px;
            }

            .response form {
                margin-top: 10px;
            }

            /* Additional CSS classes can be added as needed */

        </style>
    </head>
    <body>

        <!--PreLoader-->
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <jsp:include page="menu.jsp"></jsp:include>

            <div class="container mt-5 mb-5">

                <h2>Feedback Page</h2>

                <!-- Feedback form -->
            <c:if test="${sessionScope.info.isCus eq 1}">
                <form action="feedback" method="post">
                    <div class="form-group">
                        <label for="fb">Your comment:</label>
                        <input type="text" class="form-control" id="fb" name="fb">
                    </div>
                    <div class="form-group">
                        <input type="file" class="form-control-file" id="img" accept="image/png,image/jpeg" name="img">
                    </div>
                    <button type="submit" class="btn btn-primary">POST</button>
                </form>
            </c:if>

            <!-- List of feedback messages -->
            <div>
                <ul class="list-unstyled">
                    <c:forEach var="fb" items="${listOfMessage}">
                        <li class="mb-4">
                            <div class="message">
                                <span>@${fb.username}</span>&nbsp;&nbsp;<span>${fb.dateMessage}</span>
                                <br>
                                <span>${fb.message}</span>
                            </div>

                            <!-- Admin response section -->
                            <div class="response mt-3">
                                <c:if test="${fb.response ne null}">
                                    <span>Admin</span>&nbsp;&nbsp;<span>${fb.dateResponse}</span>
                                    <br>
                                    <span>${fb.response}</span>
                                </c:if>

                                <!-- Admin response form -->
                                <c:if test="${(fb.response eq null) and (sessionScope.isAdmin eq 1)}">
                                    <form action="feedback" method="post">
                                        <input type="hidden" id="u" name="response_to" value="${fb.id}">
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="res" name="response" placeholder="Admin response">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Response</button>
                                    </form>
                                </c:if>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!--PreLoader Ends-->

        <!-- header -->

        <!-- end copyright -->

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
        <!-- form validation js -->
        <script src="assets/js/form-validate.js"></script>
        <!-- main js -->
        <script src="assets/js/main.js"></script>

    </body>
</html>

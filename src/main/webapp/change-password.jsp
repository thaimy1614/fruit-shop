<%-- 
    Document   : change-password
    Created on : Mar 15, 2024, 12:21:21 AM
    Author     : Duong Quoc Thai CE171563
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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
    <c:if test="${sessionScope.info == null}">
        <jsp:forward page="home"></jsp:forward>
    </c:if>
    <jsp:include page="menu.jsp"></jsp:include>
        <div class="container mt-150 mb-150">
            <div class="row justify-content-center mt-5">
                <div class="col-md-4">
                    <h3 class="text-center">Change Password</h3>
                    <form id="changepass" action="change-password" method="POST">
                        <span class="text-success text-center text-decoration-none">${messSuc}</span>
                        <span class="text-danger text-center text-decoration-none">${messFail}</span>
                    <div class="mb-3">
                        <label for="password" class="form-label">Current Password</label>
                        <input type="text" value="" class="form-control" id="password" name="pass" placeholder="Enter your current password">
                        <span id="error-pass" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <label for="newpass" class="form-label">New Password</label>
                        <input type="password" value="${password}" class="form-control" id="newpass" name="newPass" placeholder="Enter your new password">
                        <span id="error-newpass" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <label for="confirm" class="form-label">Confirm Password</label>
                        <input type="password" value="${password}" class="form-control" id="confirm" name="confirm" placeholder="Confirm your new password">
                        <span id="error-confirm" class="text-danger text-decoration-none"></span>
                    </div>

                    <button type="submit" class="btn btn-color btn-block">Change Password</button>
                </form> 
                <h6 class="mt-3 mb-3 text-center text-black-50">--Or---</h6>
                <button type="submit" class=" btn btn-color btn-block"><a class="btn-color " href="home">Back to home</a></button>
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
        checkfill("#changepass", "#password", "#error-pass", "Please enter your password!");
        checkfill("#changepass", "#newpass", "#error-newpass", "Please enter your new password!");
        checkfill("#changepass", "#confirm", "#error-confirm", "Please confirm your new password!");
        $(document).ready(function () {
            $("#changepass").submit(function (event) {
                var newpass = $("#newpass").val();
                var confirm = $("#confirm").val();
                if (newpass !== confirm) {
                    $("#error-confirm").text("New password does not match. Please re-enter!");
                    event.preventDefault();
                } else if(newpass === confirm && confirm !== ""){
                    $("#error-confirm").text("");
                }
            });
            $("#confirm").on("input", function () {
                $("#error-confirm").text("");
            });
        });


    </script>
</html>

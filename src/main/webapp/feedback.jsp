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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: lightsteelblue;
            }

            /*            .container {
                            background-color: #fff;
                            border-radius: 10px;
                            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                            padding: 30px;
                        }*/

            .card {
                margin-bottom: 20px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                transition: 0.3s;
                border-radius: 5px;
                background-color: #fff;
            }

            .card:hover {
                box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.6);
            }

            .card-text {
                margin-bottom: 5px;
                line-height: 1.4;
            }

            .card-text:last-child {
                margin-bottom: 0;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .admin-response {
                background-color: #f9f9f9;
                padding: 5px;
                margin-top: 20px;
                border-radius: 5px;
                margin-left: 20px;
                border: 1px solid #ccc;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                max-width: 70%;
                font-size: 14px;
                color: #333;
            }

            .admin-response p {
                margin-bottom: 5px;
                line-height: 1.4;
            }

            .admin-response p:last-child {
                margin-bottom: 0;
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
        <jsp:include page="menu.jsp"></jsp:include>
            <div class="breadcrumb-section breadcrumb-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2 text-center">
                            <div class="breadcrumb-text">
                                <p>Fruit Shop</p>
                                <h1>Feedback</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="container mt-5 mb-5">
                <!-- Feedback sorting buttons -->
                <div class="text-right mb-3">
                    <button id="newest-btn" class="btn btn-primary">Newest</button>
                    <button id="oldest-btn" class="btn btn-primary">Oldest</button>
                </div>
                <!-- Feedback form -->
            <c:if test="${sessionScope.info.isCus eq 1}">
                <form action="feedback" method="post">
                    <div class="form-group">
                        <label for="fb">Your comment:</label>
                        <input type="text" class="form-control" id="fb" name="fb">
                    </div>
                    <div class="form-group">
                        <label for="img">Upload Image (Optional):</label>
                        <input type="file" class="form-control-file" id="img" accept="image/png,image/jpeg" name="img">
                    </div>
                    <button type="submit" class="btn btn-primary">POST</button>
                </form>
            </c:if>

            <!-- List of feedback messages -->
            <div class="feedback-list">
                <c:forEach var="fb" items="${listOfMessage}">
                    <div class="card">
                        <div class="card-body">
                            <span><h5 class="card-title"><i class="fas fa-user"></i> @${fb.username}</h5></span>
                            <p class="card-text">${fb.message}</p>
                            <p  class="card-text"><small id="date-message" class="text-muted">${fb.dateMessage}</small></p>
                            <!-- Admin response section -->
                            <c:if test="${fb.response ne null}">
                                <div class="admin-response">
                                    <p><i class="fas fa-user-tie"></i> <strong>Admin:</strong> ${fb.response}</p>
                                    <p  class="text-muted"><small id="date-response">${fb.dateResponse}</small></p>
                                </div>
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
                    </div>
                </c:forEach>
            </div>
        </div>
        <div id="login-info" data-logged-in="false" data-username="${sessionScope.username}"></div>
        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {


                // Event listener for sorting buttons
                $("#newest-btn").click(function () {
                    loadFeedback("newest");
                });

                $("#oldest-btn").click(function () {
                    window.console.log("oldest");
                    loadFeedback("oldest");
                });

                var dateMessage = $('#date-message').text();
                var replacedDateMessage = dateMessage.replace('T', ' ');
                var dateResponse = $('#date-response').text();
                var replacedDateResponse = dateResponse.replace('T', ' ');

            $('#date-message').empty();
            $('#date-response').empty();
            $('#date-message').append(replacedDateMessage);
            $('#date-response').append(replacedDateResponse);
            });

            function loadFeedback(sortType) {
                $.ajax({
                    type: "GET",
                    url: "feedback",
                    data: {sort: sortType},
                    success: function (response) {
                        console.log(response);
                        $(".feedback-list").empty(); // Clear previous feedback items

                        // Iterate over each feedback item in the response
                        $.each(response.feedbackList, function (index, feedback) {
                            // Construct HTML for each feedback item
                            var feedbackItem = '<div class="card">' +
                                    '<div class="card-body">' +
                                    '<span><h5 class="card-title"><i class="fas fa-user"></i> @' + feedback.username + '</h5></span>' +
                                    '<p class="card-text">' + feedback.message + '</p>' +
                                    '<p class="card-text"><small class="text-muted">' + feedback.dateMessage + '</small></p>';

                            // Check if there is an admin response
                            if (feedback.response) {
                                feedbackItem += '<div class="admin-response">' +
                                        '<p><i class="fas fa-user-tie"></i> <strong>Admin:</strong> ' + feedback.response + '</p>' +
                                        '<p class="text-muted"><small>' + feedback.dateResponse + '</small></p>' +
                                        '</div>';
                            }

                            // Add admin response form if user is an admin based on the isAdmin flag
                            if (response.isAdmin && !feedback.response) {
                                feedbackItem += '<form action="feedback" method="post">' +
                                        '<input type="hidden" name="response_to" value="' + feedback.id + '">' +
                                        '<div class="form-group">' +
                                        '<input type="text" class="form-control" name="response" placeholder="Admin response">' +
                                        '</div>' +
                                        '<button type="submit" class="btn btn-primary">Response</button>' +
                                        '</form>';
                            }

                            feedbackItem += '</div></div>'; // Close card-body and card div

                            // Append constructed feedback item HTML to the feedback list
                            $('.feedback-list').append(feedbackItem);
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error(xhr.responseText);
                    }
                });
            }
        </script>
    </body>
</html>

<%-- 
    Document   : top-fruit
    Created on : Mar 15, 2024, 3:03:22 PM
    Author     : Duong Quoc Thai CE171563
--%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manager</title>
        <link rel="stylesheet" href="./css/style-welcome.css" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <script src="./jQuery/jquery-3.5.1.slim.min.js"></script>
        <script src="./jQuery/popper.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
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
        <style>
            .top-header-area {
                background-color: #051922;
            }
        </style>
        <style>body {
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
            }</style>
    </head>
    <body>
        <!--PreLoader-->
        <div class="loader">
            <div class="loader-inner">
                <div class="circle"></div>
            </div>
        </div>
        <c:if test="${sessionScope.info.isAdmin == 0 || sessionScope.info.isAdmin == null}">
            <jsp:forward page="home" />
        </c:if>
        <jsp:include page="nav-admin.jsp"></jsp:include>

            <div class="container mt-150 mb-150">
                <div class="row justify-content-center mt-5">
                    <div class="col-md-8">
                        <h1 class="text-center">TOP 10 Best-selling Fruits</h1>
                    </div>
                </div>


                <div class="row justify-content-between" style="margin: 20px 0;">
                    <form action="manage" method="POST">
                        <input type="hidden" name="export" value="topproducts">
                        <button class="btn btn-dark">Export to Excel</button>
                    </form>
                </div>

                <table class="table table-striped">
                    <thead>
                        <tr class="bg-dark text-white">
                            <th class="text-center">ID</th>
                            <th class="text-center">Image</th>
                            <th class="text-center">Name</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Quantity</th>
                            <th class="text-center">Description</th>
                            <th class="text-center">Sold</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${products}">
                        <tr>
                            <td class="align-middle text-center">${order.pId}</td>
                            <td class="align-middle text-center"><img class="w-50" src="${order.pimg}" alt="alt"/></td>
                            <td class="align-middle text-center">${order.pName}</td>
                            <td class="align-middle text-center">${order.pPrice}VND</td>
                            <td class="align-middle text-center">${order.quantity}</td>
                            <td class="align-middle text-justify">
                                <div class="description-scroll">
                                    ${order.pDes}
                                </div></td>

                            <td class="align-middle text-center">${order.soldout}</td>       

                        </tr>
                    </c:forEach>

                </tbody>


            </table>
        </div>

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

<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

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
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
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
                        <h1 class="text-center">Order Management</h1>
                    </div>
                </div>
                <div class="row justify-content-between" style="margin: 20px 0;">
                    <form action="manage" method="POST">
                        <input type="hidden" name="export" value="orders" />
                        <button class="btn btn-dark">Export to Excel</button>
                    </form>

                </div>


                <table class="table table-head-row table-striped">
                    <thead>
                        <tr class="bg-dark text-white">
                            <th class="text-center">Code</th>
                            <th class="text-center">Username</th>
                            <th class="text-center">Quantity</th>
                            <th class="text-center">Amount</th>
                            <th class="text-center">Payment</th>
                            <th class="text-center">Option</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${ord}">
                        <tr>
                            <td class="align-middle text-center">${order.orderId}</td>
                            <td class="align-middle text-center">
                                ${order.username}
                            </td>
                            <td class="align-middle text-center">${order.quantity}</td>
                            <td class="align-middle text-center">${order.amount}$</td>
                            <c:if test="${order.pay == 0}">
                                <td class="align-middle text-center">Ship COD</td>
                            </c:if>
                            <c:if test="${order.pay == 1}">
                                <td class="align-middle text-success text-center">Đã thanh toán</td>
                            </c:if>
                            <td class="align-content-between text-right">
                                <c:url var="huy" value="listorder">
                                    <c:param name="huyId" value="${order.orderId}" />
                                    <c:param name="action" value="huy" />
                                </c:url>
                                <c:url var="xacthuc" value="listorder">
                                    <c:param name="huyId" value="${order.orderId}" />
                                    <c:param name="action" value="xacthuc" />
                                </c:url>
                                <c:if test="${order.status == 1}">
                                    <button id="showPopupButton" class="btn btn-danger showPopupButton mr-3" data-order-link='${huy}' onclick="transferData(this)">
                                        Cancel </button>
                                    <button id="xacthuc" class="btn btn-success showXacthucButton mr-3" data-order-link='${xacthuc}' onclick="Delete(this)">
                                        Confirm </button>
                                    <button class="update-button showButton btn btn-primary mr-3" data-target="elementToToggle"
                                            data-order-id="${order.orderId}" data-username="${order.name}"
                                            data-order-phone="${order.phone}"
                                            data-order-address="${order.address}" data-order-note="${order.note}">
                                        Information
                                    </button>
                                </c:if>
                                <c:if test="${order.status == 0}">
                                    <span class="text-white bg-danger w-50 pr-4 pl-4 pt-1 pb-1 mr-3 rounded">Canceled</span>
                                </c:if>
                                <c:if test="${order.status == 2}">
                                    <span class="text-white bg-success w-50 pr-4 pl-4 pt-1 pb-1 mr-3 rounded">Confirmed</span>
                                </c:if>
                                <button onclick="showDetail(this)" id="showDetailButton" class="btn btn-dark showDetailButton mr-3" data-target="elementToToggle"
                                        data-order-id="${order.orderId}" data-username="${order.name}"
                                        data-order-phone="${order.phone}"
                                        data-order-address="${order.address}"
                                        data-order-date="${order.date}"
                                        data-order-total="${order.amount}" data-order-note="${order.note}">
                                    Detail </button>
                            </td>
                        </tr>                
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- chi tiết đơn hàng -->
        <section id="detail" class="h-100 gradient-custom">
            <div class="container py-5 h-100 ">

                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-lg-10 col-xl-8 detail-main">
                        <button id="hidebutton" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                                aria-label="Close"
                                style="position: absolute; top: 30px; right: 50px; z-index: 4;">&#215</button>
                        <div class="card" style="border-radius: 10px;">
                            <div class="card-header px-4 py-5">
                                <h5 class="text-muted mb-0">Thanks for your Order, <span style="color: #a8729a;">${sessionScope.info.fullname}</span>!</h5>
                            </div>
                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <p class="lead fw-normal mb-0" style="color: #a8729a;">Receipt</p>
                                    <p class="text-muted mb-0 orderId" style="color: #a8729a;">Invoice Number : <span class="fw-bold me-4 text-dark text-right"></span> </p>

                                </div>
                                <div id="save-card" class="save-card">

                                </div>
                                <div class="d-flex justify-content-between pt-2">
                                    <p class="fw-bold mb-0">Order Details</p>
                                    <p class="text-muted mb-0 text-right"><span class="fw-bold me-4 text-right"></span> </p>
                                </div>

                                <div class="d-flex justify-content-between ">
                                    <div class="col-md-8">
                                        <p class="text-muted mb-0 username">Full Naem : <span class="fw-bold me-4 text-dark text-right"></span></p>
                                        <p class="text-muted mb-0 orderPhone">Phone : <span class="fw-bold me-4 text-dark text-right"></span></p>
                                        <p class="text-muted mb-0 orderAddress">Address : <span class="fw-bold me-4 text-dark text-right"></span></p>
                                        <p class="text-muted mb-0 orderDate">Invoice Date : <span class="fw-bold me-4 text-dark text-right"></span></p>
                                    </div>
                                    <div class="col-md-4">
                                        <p class="text-muted mb-0"><span class="fw-bold me-4">Delivery Charges </span>Free</p>
                                        <p class="orderNote description-scroll-detail text-muted mb-0">Note: <span class="fw-bold me-4 text-dark text-right"></span></p>
                                    </div>


                                </div>



                            </div>
                            <div class="card-footer border-0 px-4 py-5"
                                 style="background-color: #051922; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;">
                                <h5 class="orderTotal d-flex align-items-center justify-content-end text-white text-uppercase mb-0">Total
                                    paid: <span class=" h2 text-white mb-0 ms-2"></span></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="main-popup w-100 h-100" id="myPopup">
            <div class="popup w-25">
                <h2 class="text-warning">Warning!</h2>
                <p>Do you want cancel sure ?</p>
                <button id="acceptButton" class="target-button btn btn-danger mr-2" onclick="Delete(this)">Yes</button>
                <button id="cancelButton" class="cancel btn btn-dark">No</button>
            </div>
        </div>
        <div class="main-popup w-100 h-100 ${mess}" id="myPopupCart">
            <div class="popupSignup w-25">
                <div  class="d-flex justify-content-center" style="width: 100%" class="icon">
                    <img id="myIcon" class="d-inline-block" style="width: 30%" src="assets/img/giphy.gif" alt="alt"/>
                </div>
                <div class="d-flex flex-column align-content-center justify-content-center">
                    <h3 class="text-dark text-center">Update success!</h3>
                    <div class="text-center">
                        <button type="submit" id="acceptButton" class="target-button btn btn-dark mr-2 p-2"> <a class="text-white" href="manage?check=ordermanage">OK !</a></button>

                    </div>
                </div>
            </div>
        </div>
        <div id="elementToToggle" class="update pt-150 pb-150">
            <div class="update-content container vh-100">
                <h1 class="text-center">Update Information</h1>
                <button id="hideButton" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                        aria-label="Close"
                        style="position: absolute; top: 150px; right: 100px;">&#215</button>
                <form action="manage" method="get" id="formUpdate">
                    <div class="row">
                        <div class="mb-3 col-6" style="display: none">
                            <label for="orderId" class="form-label"></label>
                            <input type="text" class="form-control" id="orderId" name="orderId" readonly>
                        </div>
                        <div class="mb-3 col-6">
                            <label for="username" class="form-label">Full Name:</label>
                            <input type="text" class="form-control" id="username" name="ordername" required>
                            <span id="error-user" class="text-danger text-decoration-none"></span>
                        </div>
                        <div class="mb-3 col-6">
                            <label for="orderPhone" class="form-labelU">Phone:</label>
                            <input type="text" class="form-control" id="orderPhone" name="orderphone" required min="1">
                            <span id="error-total-quantity" class="text-danger text-decoration-none"></span>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="orderAddress" class="form-labelU">Address: </label>
                        <input type="text" class="form-control" id="orderAddress" name="orderaddress" required min="1">
                        <span id="error-total-quantity" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <label for="orderNote" class="form-label">Note:</label>
                        <textarea class="form-control" id="orderNote" name="note" required></textarea>
                        <span id="error-des" class="text-danger text-decoration-none"></span>
                    </div>
                    <button type="submit" class="btn btn-success" name="action"
                            value="UPDATE">Save</button>
                </form>
            </div>
        </div>

        <script type="text/javascript">
            showHide("showPopupButton", "cancelButton", "myPopup", "flex");
            showHide("showDetailButton", "hidebutton", "detail", "block");
            showHide("showButton", "hideButton", "elementToToggle", "block");
            transmisson2();
            transmisson3();
            function showDetail(param) {
                var orderId = param.getAttribute('data-order-id');
                $.ajax({
                    type: "POST",
                    url: "listorder", // URL của Servlet
                    data: {
                        orderId: orderId
                    },

                    success: function (data) {
                        var row = document.getElementById("save-card");
                        row.innerHTML = data;
                    }
                });
            }
        </script>
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
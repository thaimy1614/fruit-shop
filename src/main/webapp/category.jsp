<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category</title>
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
                        <h1 class="text-center">Category Management</h1>
                    </div>
                </div>
                <div class="d-flex justify-content-center bg-light" style="padding: 16px 0; margin: 20px 0;">
                    <div class="col-5 text-center">
                        Notification:
                    </div>
                    <div class="text-danger text-decoration-none col-7 message" id="message">${mess}</div>
            </div>


            <div class="row justify-content-between" style="margin: 20px 0;">
                <button class="showCreate btn btn-dark">Add new</button>

                <!--                <form action="manage" method="get">
                                    <input type="hidden" name="check" value="ordermanage">
                                    <button class="btn btn-dark">Order management</button>
                                </form>-->
                <form action="category">
                    <button class="btn btn-dark">Show All</button>
                </form>
                <form action="manage" method="POST">
                    <input type="hidden" name="export" value="categories">
                    <button class="btn btn-dark">Export to Excel</button>
                </form>
                <form action="category" method="GET" class="row justify-content-center col-6">
                    <input type="text" class="form-control col-5" id="search" name="searchCate" value="${lastS}"required>
                    <button type="submit" class="btn btn-dark" style="margin: 0 16px;">
                        Search
                    </button>
                </form>

            </div>

            <table class="table table-striped">
                <thead>
                    <tr class="bg-dark text-white">
                        <th class="text-center">ID</th>
                        <th class="text-center">Name</th>
                        <th class="text-center">Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cate" items="${categories}">
                        <tr>
                            <td class="align-middle text-center">${cate.cId}</td>
                            <td class="align-middle text-center">${cate.cName}</td>
                            <td class="align-content-between text-center">
                                <c:url var="delete" value="category">
                                    <c:param name="deleteId" value="${cate.cId}" />
                                    <c:param name="action" value="Delete"/>
                                </c:url>
                                <button id="showPopupButton" class="btn btn-danger showPopupButton m-5" data-order-link='${delete}' onclick="transferData(this)">
                                    Delete 
                                </button>
                                <button class="update-button showButton btn btn-dark" data-target="elementToToggle"
                                        data-order-id="${cate.cId}" data-username="${cate.cName}">
                                    Update
                                </button>
                            </td>


                        </tr>
                    </c:forEach>

                </tbody>


            </table>
        </div>
        <div class="main-popup w-100 h-100" id="myPopup">
            <div class="popup w-25">
                <h2 class="text-warning">Warning!</h2>
                <p>Are you sure you want to delete?</p>
                <button id="acceptButton" class="target-button btn btn-primary" onclick="Delete(this)">Accept</button>
                <button id="cancelButton" class="cancel btn btn-danger">Cancel</button>
            </div>
        </div>

        <div id="elementToToggle" class="update pt-150 pb-150">
            <div class="update-content container vh-100">
                <h1 class="text-center">Update Category</h1>
                <button id="hideButton" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                        aria-label="Close"
                        style="position: absolute; top: 150px; right: 100px;">&#215</button>
                <form action="category" method="post" id="formUpdate" enctype="multipart/form-data">
                    <div class="row">
                        <div class="mb-3 col-6" style="display: none">
                            <label for="cId" class="form-label">Category ID:</label>
                            <input type="text" class="form-control" id="cId" name="cId" readonly>
                        </div>
                        <div class="mb-3 col-6">
                            <label for="username" class="form-label">Category Name:</label>
                            <input type="text" class="form-control" id="username" name="cName" required>
                            <span id="error-user" class="text-danger text-decoration-none"></span>

                        </div>


                        <button type="submit" class="btn btn-success" name="btnEdit"
                                value="UPDATE">Update</button>
                </form>
            </div>
        </div>

    </div>
    <div id="elementCreate" class="update pt-150 pb-150">
        <div class="create-content container">
            <h1>Add Category</h1>
            <button id="hideCreate" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                    aria-label="Close"
                    style="position: absolute; top: 150px; right: 100px;">&#215</button>
            <form action="category" method="POST" id="formCreate" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="username" class="form-label">Category Name:</label>
                    <input type="text" class="form-control" id="usernameC" name="cName" required>
                    <span id="error-user-create" class="text-danger text-decoration-none"></span>
                </div>

                <button type="submit" class="btn btn-success" name="btnInsert"
                        value="CREATE">Save</button>
            </form>
        </div>
    </div>
    <script type="text/javascript">
        showHide("showButton", "hideButton", "elementToToggle", "block");
        showHide("showCreate", "hideCreate", "elementCreate", "block");
        showHide("showPopupButton", "cancelButton", "myPopup", "flex");
        $(document).ready(function () {
            $(".update-button").click(function () {

                var cId = $(this).data("order-id");
                var username = $(this).data("username");
                $("#cId").val(cId);
                $("#username").val(username);
                console.log(cId + username);
            });
        });

        checkfill("#formUpdate", "#username", "#error-user", "Please fill in this field!");
        checkfill("#formUpdate", "#orderTotal", "#error-total", "Please fill in this field!");
        checkfill("#formUpdate", "#orderDescription", "#error-des", "Please fill in this field!");

        checkfill("#formCreate", "#usernameC", "#error-user-create", "Please fill in this field!");
        checkfill("#formCreate", "#orderTotalC", "#error-total-create", "Please fill in this field!");
        checkfill("#formCreate", "#orderDescriptionC", "#error-des-create", "Please fill in this field!");
        checkfill("#formCreate", "#quantity", "#error-total-quantity", "Please fill in this field!");

        checkNum("#formUpdate", "#orderTotal", "#error-total");
        checkNum("#formCreate", "#orderTotalC", "#error-total-create");
        checkNum("#formCreate", "#quantity", "#error-total-quantity");
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
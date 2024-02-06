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
    </head>

    <body>
        <c:if test="${sessionScope.info.isAdmin == 0 || sessionScope.info.isAdmin == null}">
            <jsp:forward page="home" />
        </c:if>
        <jsp:include page="menu.jsp"></jsp:include>
            <div class="container mt-150 mb-150">
                <div class="row justify-content-center mt-5">
                    <div class="col-md-6">
                        <h1 class="text-center">Fruit Management</h1>
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
                
                <form action="manage" method="get">
                    <input type="hidden" name="check" value="ordermanage">
                    <button class="btn btn-dark">Order management</button>
                </form>
                <form action="manage">
                    <button class="btn btn-dark">Show All</button>
                </form>
                <form action="search" method="POST" class="row justify-content-center col-6">
                    <input type="text" class="form-control col-5" id="search" name="search" value="${lastS}"required>
                    <button type="submit" class="btn btn-dark" style="margin: 0 16px;" name="action" value="SEARCH">
                        Search
                    </button>
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
                        <th class="text-center">Edit</th>
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
                            <td class="align-content-between text-center">
                                <c:url var="delete" value="manage">
                                    <c:param name="deleteId" value="${order.pId}" />
                                    <c:param name="action" value="Delete"/>
                                </c:url>
                                <button id="showPopupButton" class="btn btn-danger showPopupButton m-5" data-order-link='${delete}' onclick="transferData(this)">
                                    Delete </button>
                                <button class="update-button showButton btn btn-dark" data-target="elementToToggle"
                                        data-order-id="${order.pId}" data-username="${order.pName}"
                                        data-order-total="${order.pPrice}" data-order-quantity="${order.quantity}"
                                        data-order-date="${order.pimg}" data-order-des="${order.pDes}"
                                        data-category = "${order.cId}">
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
                <h1 class="text-center">Update Fruit</h1>
                <button id="hideButton" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                        aria-label="Close"
                        style="position: absolute; top: 150px; right: 100px;">&#215</button>
                <form action="manage" method="post" id="formUpdate" enctype="multipart/form-data">
                    <div class="row">
                        <div class="mb-3 col-6" style="display: none">
                            <label for="orderID" class="form-label">Fruit ID:</label>
                            <input type="text" class="form-control" id="orderID" name="productId" readonly>
                        </div>
                        <div class="mb-3 col-6">
                            <label for="username" class="form-label">Fruit Name:</label>
                            <input type="text" class="form-control" id="username" name="prodname" required>
                            <span id="error-user" class="text-danger text-decoration-none"></span>

                        </div>
                        <div class="mb-3 col-6">
                            <label for="quantityU" class="form-labelU">Quantity:</label>
                            <input type="number" class="form-control" id="quantityU" name="quantity" required min="1">
                            <span id="error-total-quantity" class="text-danger text-decoration-none"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="mb-3 col-6">
                            <label for="orderTotal" class="form-label">Price:</label>
                            <input type="number" class="form-control" id="orderTotal" name="proprice" required>
                            <span id="error-total" class="text-danger text-decoration-none"></span>

                        </div>
                        <div class="mb-3 col-6">
                            <label for="selectCate" class="form-label">Category:</label>
                            <select class="form-select form-control" name="loai" id="selectCate">
                                <option value="1">Strawberry</option>
                                <option value="2">Berry</option>
                                <option value="3">Lemon</option>
                                <option value="4">Orther</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3 row">
                        <div class="info__data addproduct_data addproduct_data-img col">
                            <label for="pro-pic" class="info__data-label">Upload hình ảnh</label>
                            <input type="hidden" name="imgTmp" id="orderDate" >
                            <input   name="hinhanh2" id="pro-pic" type="file" accept="image/*" style="padding-left: 80px;">
                            <p class="info__datap" id=""></p>
                        </div>
                        <div class="col-6">
                            <img class="w-50" id="imageElement" src="" alt="alt"/>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="orderDescription" class="form-label">Description:</label>
                        <textarea class="form-control" id="orderDescription" name="Description" required></textarea>
                        <span id="error-des" class="text-danger text-decoration-none"></span>

                    </div>

                    <button type="submit" class="btn btn-success" name="btnEdit"
                            value="UPDATE">Update</button>
                </form>
            </div>
        </div>
        <div id="elementCreate" class="update pt-150 pb-150">
            <div class="create-content container">
                <h1>Add Fruit</h1>
                <button id="hideCreate" type="button" class="btn btn-dark" data-bs-dismiss="modal"
                        aria-label="Close"
                        style="position: absolute; top: 150px; right: 100px;">&#215</button>
                <form action="manage" method="POST" id="formCreate" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="username" class="form-label">Fruit Name:</label>
                        <input type="text" class="form-control" id="usernameC" name="prodnameC" required>
                        <span id="error-user-create" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <label for="orderTotal" class="form-label">Price:</label>
                        <input type="number" class="form-control" id="orderTotalC" name="propriceC" required min="1">
                        <span id="error-total-create" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Quantity:</label>
                        <input type="number" class="form-control" id="quantity" name="quantityC" required min="1">
                        <span id="error-total-quantity" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-3">
                        <div class="info__data addproduct_data addproduct_data-img">
                            <label class="info__data-label" for="pro-pic-2">Upload hình ảnh</label>
                            <input class="form-control-file" name="hinhanh" id="pro-pic-2" type="file" accept="image/*" style="padding-left: 100px;">
                            <input type="hidden" name="imgTmp" value="https://mdbootstrap.com/img/Photos/Others/placeholder.jpg">
                            <p class="info__datap" id="error-date"></p>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="orderDescription" class="form-label">Description:</label>
                        <textarea class="form-control" id="orderDescriptionC" name="Description" required></textarea>
                        <span id="error-des-create" class="text-danger text-decoration-none"></span>
                    </div>
                    <div class="mb-5">
                        <select class="form-select form-control" name="loai">
                            <option value="4" disabled selected>Category</option>
                            <option value="1">Strawberry</option>
                            <option value="2">Berry</option>
                            <option value="3">Lemon</option>
                            <option value="4">Orther</option>
                        </select>
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
            transmisson();
            
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
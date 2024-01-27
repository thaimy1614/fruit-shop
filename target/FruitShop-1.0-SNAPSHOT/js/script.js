function showHide(show, hide, element, display) {
    var showButtons = document.querySelectorAll("." + show);
    var hideButton = document.getElementById(hide);
    var elementToToggle = document.getElementById(element);

    showButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            elementToToggle.style.display = display;
        });
    });

    hideButton.addEventListener("click", function () {
        elementToToggle.style.display = "none";
    });
}
function totalclick() {
    $(document).ready(function () {
        $("#btn-delete").click(function () {
            var productRows = document.querySelectorAll('.table-body-row');
            var totalPrice = 0;
            for (var i = 0; i < productRows.length; i++) {
                var priceText = productRows[i].querySelector('.product-price').textContent;
                var quantityText = productRows[i].querySelector('.product-quantity').textContent;
                var price = parseFloat(priceText.replace('VND', ''));
                var quantity = parseInt(quantityText);
                totalPrice += price * quantity;
            }

            var totalData = document.querySelector('.total-data-sub td:last-child');
            totalData.textContent = 'VND' + totalPrice;
        });
    });
}
function total() {

    var productRows = document.querySelectorAll('.table-body-row');
    var totalPrice = 0;
    for (var i = 0; i < productRows.length; i++) {
        var priceText = productRows[i].querySelector('.product-price').textContent;
        var quantityText = productRows[i].querySelector('.product-quantity').textContent;
        var price = parseFloat(priceText.replace('VND', ''));
        var quantity = parseInt(quantityText);
        totalPrice += price * quantity;
    }

    var totalData = document.querySelector('.total-data-sub td:last-child');
    totalData.textContent = 'VND' + totalPrice;

}
function cong() {
    //quantity
    var productquantity = document.querySelectorAll('.table-body-quantity');
    var totalPrice = 0;
    for (var i = 0; i < productquantity.length; i++) {
        var priceText = productquantity[i].querySelector('.product-quantity').textContent;
        var quantity = parseFloat(priceText.replace('VND', ''));
        totalPrice += quantity;
    }

    var totalData = document.querySelector('#total-input-quantity');
    totalData.value = totalPrice;
}
function checkfillnew() {
    $(document).ready(function () {
        $("#btn-submit").click(function () {
            var input1Value = $("#input-name").val();
            var input2Value = $("#input-address").val();

            if (input1Value === "" || input2Value === "") {
                alert("Vui lòng nhập đầy đủ thông tin vào nhận hàng.");
            }
        });
    });

}


function transmisson2() {
    $(document).ready(function () {
        $(".showDetailButton").click(function () {
            var orderId = $(this).data("order-id");
            var username = $(this).data("username");
            var orderPhone = $(this).data("order-phone");
            var orderDate = $(this).data("order-date");
            var orderAddress = $(this).data("order-address");
            var orderTotal = $(this).data("order-total");
            var orderNote = $(this).data("order-note");

            var orderIds = document.querySelector('.orderId span');
            var usernames = document.querySelector('.username span');
            var orderPhones = document.querySelector('.orderPhone span');
            var orderDates = document.querySelector('.orderDate span');
            var orderAddresss = document.querySelector('.orderAddress span');
            var totalData = document.querySelector('.orderTotal span');
            var orderNotes = document.querySelector('.orderNote span');
            totalData.textContent = orderTotal + 'VND';
            orderIds.textContent = orderId;
            usernames.textContent = username;
            orderPhones.textContent = orderPhone;
            orderDates.textContent = orderDate;
            orderAddresss.textContent = orderAddress;
            orderNotes.textContent = orderNote;

        });
    });
}

function transmisson3() {
    $(document).ready(function () {
        $(".update-button").click(function () {
            var orderId = $(this).data("order-id");
            var username = $(this).data("username");
            var orderPhone = $(this).data("order-phone");
            var orderAddress = $(this).data("order-address");
            var orderNote = $(this).data("order-note");

            $("#orderId").val(orderId);
            $("#username").val(username);
            $("#orderPhone").val(orderPhone);
            $("#orderAddress").val(orderAddress);
            $("#orderNote").val(orderNote);

        });
    });
}


function transmisson() {
    $(document).ready(function () {
        $(".update-button").click(function () {
            var orderDater = this.getAttribute('data-order-date');
            var categoryValue = this.getAttribute('data-category');
            var orderQuan = this.getAttribute('data-order-quantity');
            var orderId = $(this).data("order-id");
            var username = $(this).data("username");
            var orderTotal = $(this).data("order-total");
            var orderDes = $(this).data("order-des");

            $("#orderID").val(orderId);
            $("#username").val(username);
            $("#orderTotal").val(orderTotal);
            document.getElementById('selectCate').value = categoryValue;
            document.getElementById('imageElement').src = orderDater;
            document.getElementById('orderDate').value = orderDater;
            document.getElementById('quantityU').value = orderQuan;
            $("#quantityU").val(orderQuan);
            $("#orderDescription").val(orderDes);

        });
    });
}
function checkfill(formId, id, errId, mess) {
    $(document).ready(function () {
        $(formId).submit(function (event) {
            var usernameValue = $(id).val();
            if (usernameValue === "") {
                $(errId).text(mess);
                event.preventDefault();
            } else {
                $(errId).text("");
            }
        });
        $(id).on("input", function () {
            $(errId).text("");
        });
    });
}


function checkNum(formId, id, errorid) {
    $(document).ready(function () {
        $(formId).submit(function (event) {
            var inputValue = parseFloat($(id).val());
            if (!isNaN(inputValue) && inputValue > 0) {
                $(errorid).text("");
            } else if (!isNaN(inputValue) && inputValue <= 0) {
                $(errorid).text("Please enter a positive number!");
                event.preventDefault();
            }
        });
        $(id).on("input", function () {
            $(errorid).text("");
        });
    });
}

function transferData(sourceButton) {
    var deleteS = sourceButton.getAttribute("data-order-link");
    var targetButton = document.querySelector(".target-button");
    targetButton.setAttribute("data-order-link", deleteS);
}

function Delete(sourceButton) {
    var deleteS = sourceButton.getAttribute("data-order-link");
    window.location.href = deleteS;
}
function sendLink() {
    document.getElementById("postLink").addEventListener("click", function () {
        var form = document.getElementById("postForm");
        form.submit();
    });
}


function submitFormD() {
    document.getElementById("formDetail").submit();
}
function submitFormA() {
    document.getElementById("formAddcart").submit();
}
function submitFormO() {
    document.getElementById("orderForm").submit();
}



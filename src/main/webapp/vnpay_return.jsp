<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
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
    </head>
    <body>
        <%
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }
            
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

        %>


        <!--Begin display -->
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label >Mã giao dịch thanh toán:</label>
                    <label><%=request.getParameter("vnp_TxnRef")%></label>
                </div>    
                <div class="form-group">
                    <label >Số tiền:</label>
                    <label><%=(Integer.parseInt(request.getParameter("vnp_Amount")) / 100)%></label>
                </div>  
                <div class="form-group">
                    <label >Mô tả giao dịch:</label>
                    <label><%=request.getParameter("vnp_OrderInfo")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã lỗi thanh toán:</label>
                    <label><%=request.getParameter("vnp_ResponseCode")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã giao dịch tại CTT VNPAY-QR:</label>
                    <label><%=request.getParameter("vnp_TransactionNo")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã ngân hàng thanh toán:</label>
                    <label><%=request.getParameter("vnp_BankCode")%></label>
                </div> 
                <div class="form-group">
                    <label >Thời gian thanh toán:</label>
                    <label><%=request.getParameter("vnp_PayDate")%></label>
                </div> 
                <div class="form-group">
                    <label >Tình trạng giao dịch:</label>
                    <label>
                        <%
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    out.print("Thành công");
                                    request.setAttribute("pay", "1");
                                    Connection conn = null;
                                    PreparedStatement stmt = null;
                                    try {
                                        // Chuỗi kết nối đến cơ sở dữ liệu
                                        String connectionString = "jdbc:sqlserver://localhost:1433;databaseName=ShopTraiCay;user=sa;password=170903;encrypt=false";
                                        conn = DriverManager.getConnection(connectionString);

                                        // Chuẩn bị câu lệnh SQL INSERT
                                        String sql = "INSERT INTO TransactionVnpay (code, username, order_id, bank_name, account_number, transaction_date, total_amount, order_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                                        stmt = conn.prepareStatement(sql);

                                        // Đặt các tham số cho câu lệnh INSERT
                                        stmt.setString(1, request.getParameter("vnp_TxnRef"));
                                        stmt.setString(2, (String) session.getAttribute("username")); // Thay thế bằng tên người dùng thực sự
                                        stmt.setInt(3, 100);
                                        stmt.setString(4, request.getParameter("vnp_BankCode"));
                                        stmt.setString(5, request.getParameter("123456789")); // Cần thay đổi tên tham số này thành tên thích hợp
                                        stmt.setString(6, request.getParameter("vnp_PayDate"));
                                        stmt.setFloat(7, (float)Integer.parseInt(request.getParameter("vnp_Amount")) / 100);
                                        stmt.setString(8, request.getParameter("vnp_OrderInfo"));

                                        // Thực thi câu lệnh INSERT
                                        stmt.executeUpdate();

                                        // Đóng kết nối
                                        conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (stmt != null) {
                                                stmt.close();
                                            }
                                            if (conn != null) {
                                                conn.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    
                                } else {
                                    out.print("Không thành công");
                                    request.setAttribute("pay", "0");
                                }
                                
                            } else {
                                out.print("invalid signature");
                            }
                        %>
                    </label>
                </div> 
                <a href="checkout?pay=${pay}&action=onlinepay" class="boxed-btn" id="btn-submit" >Back to Shop</a>
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>  
    </body>
</html>

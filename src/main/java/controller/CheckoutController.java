/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Cart;
import dao.CartDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import model.Email;
import model.Users;

/**
 *
 * @author ADMIN
 */
public class CheckoutController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ac = request.getParameter("action");
        String pay = "";
        if (ac != null) {
            pay = request.getParameter("pay");

            request.setAttribute("pay", pay);
            request.setAttribute("messoneline", "login");
            request.setAttribute("payonl", "true");
        } else {
            request.setAttribute("pay", "0");
        }
        if (pay.equals("0")) {
            response.sendRedirect("home");
        } else {
            String user = (String) session.getAttribute("username");
            CartDAO dao = new CartDAO();

            List<Cart> pro = dao.getAllCart(user);
            float amount = 0;
            int quan = 0;
            for (Cart c : pro) {
                amount += c.getAmount();
                quan += c.getQuantity();
            }
            String tong = String.format("%.0f", amount);

            request.setAttribute("amount", tong);
            request.setAttribute("quan", quan);
            request.setAttribute("name", pro);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ZoneId gmt7Zone = ZoneId.of("Asia/Ho_Chi_Minh");
        ZonedDateTime gmt7DateTime = ZonedDateTime.now(gmt7Zone);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String date = gmt7DateTime.format(formatter);
        String user = (String) session.getAttribute("username");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String note = request.getParameter("note");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float amount = Float.parseFloat(request.getParameter("total"));
        Users u = (Users) session.getAttribute("info");
        CartDAO daos = new CartDAO();
        List<Cart> pro = daos.getAllCart(user);
        String mail = "";
        float amounts = 0;
        mail += "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN\" crossorigin=\"anonymous\">\n"
                + "<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL\" crossorigin=\"anonymous\"></script>\n"
                + "<style>\n"
                + ".gradient-custom-3 {\n"
                + "    /* fallback for old browsers */\n"
                + "    background: #84fab0;\n"
                + "\n"
                + "    /* Chrome 10-25, Safari 5.1-6 */\n"
                + "    background: -webkit-linear-gradient(to right, rgba(132, 250, 176, 0.5), rgba(143, 211, 244, 0.5));\n"
                + "\n"
                + "    /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */\n"
                + "    background: linear-gradient(to right, rgba(132, 250, 176, 0.5), rgba(143, 211, 244, 0.5))\n"
                + "}\n"
                + ".gradient-custom-4 {\n"
                + "    /* fallback for old browsers */\n"
                + "    background: #84fab0;\n"
                + "\n"
                + "    /* Chrome 10-25, Safari 5.1-6 */\n"
                + "    background: -webkit-linear-gradient(to right, rgba(132, 250, 176, 1), rgba(143, 211, 244, 1));\n"
                + "\n"
                + "    /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */\n"
                + "    background: linear-gradient(to right, rgba(132, 250, 176, 1), rgba(143, 211, 244, 1))\n"
                + "}\n"
                + ".save-card {\n"
                + "    height: 300px;\n"
                + "    overflow: auto;\n"
                + "}\n"
                + "\n"
                + ".description-scroll {\n"
                + "    height: 100px;\n"
                + "    overflow: auto;\n"
                + "}\n"
                + ".description-scroll-detail {\n"
                + "    height: 100px;\n"
                + "    overflow: auto;\n"
                + "    width: 300px;\n"
                + "}\n"
                + "\n"
                + ".detail-main {\n"
                + "    position: relative;\n"
                + "}"
                + "</style>\n"
                + "</head>\n"
                + "<body>"
                + " <div class=\"container py-5 h-100 \">\n"
                + "\n"
                + "                <div class=\"row d-flex justify-content-center align-items-center h-100\">\n"
                + "                    <div class=\"col-lg-10 col-xl-8 detail-main\">\n"
                + "                        <div class=\"card\" style=\"border-radius: 10px;\">\n"
                + "                            <div class=\"card-header px-4 py-5\">\n"
                + "                                <h5 class=\"text-muted mb-0\">Thanks for your Order, <span style=\"color: #a8729a;\">" + name + "</span>!</h5>\n"
                + "                            </div>\n"
                + "                            <div class=\"card-body p-4\">\n";
        for (Cart o : pro) {
            amounts += o.getAmount();
            mail += "<div class=\"card shadow-0 border mb-4\">\n"
                    + "                                        <div class=\"card-body\">\n"
                    + "                                            <div class=\"row\">\n"
                    + "                                                <div class=\"col-md-2 text-center d-flex justify-content-center align-items-center\">\n"
                    + "                                                    <p class=\"text-muted mb-0\">" + o.getPname() + "</p>\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"col-md-2 text-center d-flex justify-content-center align-items-center\">\n"
                    + "                                                    <p class=\"text-muted mb-0 small\">Price: " + o.getPrice() + "VND</p>\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"col-md-2 text-center d-flex justify-content-center align-items-center\">\n"
                    + "                                                    <p class=\"text-muted mb-0 small\">Qty: " + o.getQuantity() + "</p>\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"col-md-2 text-center d-flex justify-content-center align-items-center\">\n"
                    + "                                                    <p class=\"text-muted mb-0 small\">" + o.getAmount() + "VND</p>\n"
                    + "                                                </div>\n"
                    + "                                            </div>\n"
                    + "                                            <hr class=\"mb-4\" style=\"background-color: #e0e0e0; opacity: 1;\">\n"
                    + "                                        </div>\n"
                    + "                                    </div>\n";
        }
        mail += " <div class=\"d-flex justify-content-between pt-2\">\n"
                + "                                    <p class=\"fw-bold mb-0\">Order Details</p>\n"
                + "                                    <p class=\"text-muted mb-0 text-right\"><span class=\"fw-bold me-4 text-right\"></span> </p>\n"
                + "                                </div>\n"
                + "\n"
                + "                                <div class=\"d-flex justify-content-between \">\n"
                + "                                    <div class=\"col-md-8\">\n"
                + "                                        <p class=\"text-muted mb-0 username\">Tên Khách Hàng : <span class=\"fw-bold me-4 text-dark text-right\">" + name + "</span></p>\n"
                + "                                        <p class=\"text-muted mb-0 orderPhone\">SDT : <span class=\"fw-bold me-4 text-dark text-right\">" + phone + "</span></p>\n"
                + "                                        <p class=\"text-muted mb-0 orderAddress\">Address : <span class=\"fw-bold me-4 text-dark text-right\">" + address + "</span></p>\n"
                + "                                        <p class=\"text-muted mb-0 orderDate\">Invoice Date : <span class=\"fw-bold me-4 text-dark text-right\">" + date + "</span></p>\n"
                + "                                    </div>\n"
                + "                                    <div class=\"col-md-4\">\n"
                + "                                        <p class=\"text-muted mb-0\"><span class=\"fw-bold me-4\">Delivery Charges </span>Free</p>\n"
                + "                                        <p class=\"orderNote description-scroll-detail text-muted mb-0\">Note: <span class=\"fw-bold me-4 text-dark text-right\">" + note + "</span></p>\n"
                + "                                    </div>\n"
                + "\n"
                + "\n"
                + "                                </div>\n"
                + "\n"
                + "\n"
                + "\n"
                + "                            </div>\n"
                + "                            <div class=\"card-footer border-0 px-4 py-5\"\n"
                + "                                 style=\"background-color: #051922; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;\">\n"
                + "                                <h5 style=\"color: #ffffff;\" class=\"orderTotal d-flex align-items-center justify-content-end text-white text-uppercase mb-0\">Total\n"
                + "                                    paid: <span  style=\"color: #ffffff;\"  class=\" h2 text-white mb-0 ms-2\">" + amounts + "VND</span></h5>\n"
                + "                            </div>\n"
                + "                        </div>\n"
                + "                    </div>\n"
                + "                </div>\n"
                + "            </div>";
        mail += "</body>\n"
                + "</html>";
        mail += "Đơn hàng sẽ sớm được gửi tới bạn! Xin chân thành cảm ơn!";
        OrderDAO dao = new OrderDAO();
        CartDAO cd = new CartDAO();
        boolean rs;
        int pay = Integer.parseInt(request.getParameter("pay"));
        rs = dao.addOrder(user, name, address, phone, quantity, amount, note, date, pay);
        log(String.valueOf(rs));
        if (rs) {
            rs = false;

            List<Cart> cart = cd.getAllCart(user);
            for (Cart c : cart) {
                int pid = c.getpId();
                int quan = c.getQuantity();
                rs = dao.addOrderItem(pid, quan);
            }
            if (rs) {
                rs = dao.deleteAllCart(user);
                if (rs) {
                    Email.sendEmail(u.getMail(), "Thank your order!", mail);
                    String onl = request.getParameter("payonl");
                    if (onl != null) {
                        if (onl.equals("true")) {
                            request.getRequestDispatcher("shop").forward(request, response);
                        } else {
                            request.setAttribute("mess", "login");
                            request.getRequestDispatcher("checkout.jsp").forward(request, response);

                        }

                    } else {
                        request.setAttribute("mess", "login");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    }

                } else {
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                }
            }

        } else {
            request.getRequestDispatcher("404.jsp").forward(request, response);
        }

    }



    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

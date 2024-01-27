/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Order;
import model.OrderDAO;
import model.OrderItem;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class OrderPlaceController extends HttpServlet {

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
        String huy = request.getParameter("action");
        if (huy != null) {
            if (huy.equals("huyOrder")) {
                int idhuy = Integer.parseInt(request.getParameter("huyId"));
                OrderDAO dao = new OrderDAO();
                boolean rs = dao.huyOrder(idhuy);
                if (rs) {
                    response.sendRedirect("listorder");
                } else {
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                }
            }
            if (huy.equals("huy")) {
                int idhuy = Integer.parseInt(request.getParameter("huyId"));
                OrderDAO dao = new OrderDAO();
                boolean rs = dao.huyOrder(idhuy);
                if (rs) {
                    response.sendRedirect("manage?check=ordermanage");
                } else {
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                }
            }
            if (huy.equals("xacthuc")) {
                int idhuy = Integer.parseInt(request.getParameter("huyId"));
                OrderDAO dao = new OrderDAO();
                boolean rs = dao.xacthucOrder(idhuy);
                if (rs) {
                    response.sendRedirect("manage?check=ordermanage");
                } else {
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                }
            }
            if (huy.equals("UPDATE")) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String name = request.getParameter("ordername");
                String phone = request.getParameter("orderphone");
                String address = request.getParameter("orderaddress");
                String note = request.getParameter("note");
                OrderDAO dao = new OrderDAO();
                boolean rs = dao.updateOrder(orderId, name, address, phone, note);
                if (rs) {
                    response.sendRedirect("listorder?update=success");
                } else {
                    response.sendRedirect("404.jsp");
                }
            }
        } else if (huy == null) {
            response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
            String user = (String) session.getAttribute("username");
            String mess = request.getParameter("update");
            if (mess != null) {
                if (mess.equals("success")) {
                    request.setAttribute("mess", "login");
                }
            }

            OrderDAO dao = new OrderDAO();
            List<Order> orders = dao.getAllOrderByUser(user);
            request.setAttribute("u", user);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("list-order.jsp").forward(request, response);
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDAO dao = new OrderDAO();
        List<OrderItem> orders = dao.getAllOrderItemById(orderId);
        PrintWriter out = response.getWriter();
        for (OrderItem o : orders) {
            out.println("<div class=\"card shadow-0 border mb-4\">\n"
                    + "                                        <div class=\"card-body\">\n"
                    + "                                            <div class=\"row\">\n"
                    + "                                                <div class=\"col-md-2\">\n"
                    + "                                                    <img src=\"" + o.getImg() + "\"\n"
                    + "                                                         class=\"img-fluid\" alt=\"\">\n"
                    + "                                                </div>\n"
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
                    + "                                    </div>");
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

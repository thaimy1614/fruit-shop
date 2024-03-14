/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Cart;
import dao.CartDAO;
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
public class CartController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("username");
        String update = request.getParameter("update");
        PrintWriter out = response.getWriter();
        CartDAO dao = new CartDAO();
        if (update != null) {
            int quan = Integer.parseInt(request.getParameter("quantity"));
            int proId = Integer.parseInt(request.getParameter("proId"));
            boolean rs = dao.updateCart(proId, user, quan);
            if (rs) {
                List<Cart> pro = dao.getAllCart(user);
                float amount = 0;
                for (Cart cart : pro) {
                    amount += cart.getAmount();
                }

                out.println("<tr>\n"
                        + "                                             <td class=\"font-weight-bold\" colspan=\"4\">Total:</td>\n"
                        + "                                             <td class=\"font-weight-bold\" colspan=\"2\">" + amount + "VND</td>\n"
                        + "                                        </tr>");
                for (Cart c : pro) {
                    out.println(" <tr class=\"table-body-row\">\n"
                            + "  <td class=\"product-remove\">\n"
                            + "     <button data-proId=\"" + c.getpId() + "\" data-user=\"" + user + "\" onclick=\"deleteCart(this)\"\n"
                            + "             class=\"btn-link btn text-dark\" type=\"submit\"><i class=\"far fa-window-close\"></i></button>  \n"
                            + "  <td class=\"product-image\"><img src=\"" + c.getImg() + "\" alt=\"\"></td>\n"
                            + "  <td class=\"product-name\">" + c.getPname() + "</td>\n"
                            + " <td class=\"product-price\">" + c.getPrice() + "VND</td>\n"
                            + " <td class=\"product-quantity\">\n"
                            + "  <input data-pro-id=\"" + c.getpId() + "\" oninput=\"updateQuan(this)\" class=\"w-25\" type=\"number\" min=\"1\" value=\"" + c.getQuantity() + "\">\n"
                            + "   </td>\n"
                            + "    <td class=\"product-amount\">" + c.getAmount() + "VND</td>\n"
                            + "   </tr>");

                }

            }
        } else {
            List<Cart> pro = dao.getAllCart(user);
            float amount = 0;
            for (Cart c : pro) {
                amount += c.getAmount();
            }
            request.setAttribute("amount", amount);
            request.setAttribute("pro", pro);

            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }

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

        processRequest(request, response);
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
        String user = request.getParameter("user");
        int pId = Integer.valueOf((String) request.getParameter("proId"));
        CartDAO dao = new CartDAO();
        PrintWriter out = response.getWriter();
        boolean rs = dao.deleteCart(pId, user);
        if (rs) {
            List<Cart> pro = dao.getAllCart(user);
            float amount = 0;
            for (Cart cart : pro) {
                amount += cart.getAmount();
            }

            out.println("<tr>\n"
                    + "                                             <td class=\"font-weight-bold\" colspan=\"4\">Total:</td>\n"
                    + "                                             <td class=\"font-weight-bold\" colspan=\"2\">" + amount + "VND</td>\n"
                    + "                                        </tr>");
            for (Cart c : pro) {
                out.println(" <tr class=\"table-body-row\">\n"
                        + "  <td class=\"product-remove\">\n"
                        + "     <button data-proId=\"" + c.getpId() + "\" data-user=\"" + user + "\" onclick=\"deleteCart(this)\"\n"
                        + "             class=\"btn-link btn text-dark\" type=\"submit\"><i class=\"far fa-window-close\"></i></button>   \n"
                        + "  <td class=\"product-image\"><img src=\"" + c.getImg() + "\" alt=\"\"></td>\n"
                        + "  <td class=\"product-name\">" + c.getPname() + "</td>\n"
                        + " <td class=\"product-price\">" + c.getPrice() + "VND</td>\n"
                        + " <td class=\"product-quantity\">\n"
                        + "  <input data-pro-id=\"" + c.getpId() + "\" oninput=\"updateQuan(this)\" class=\"w-25\" type=\"number\" min=\"1\" value=\"" + c.getQuantity() + "\">\n"
                        + "   </td>\n"
                        + "    <td class=\"product-amount\">" + c.getAmount() + "VND</td>\n"
                        + "   </tr>");

            }

        } else {
            response.sendRedirect("404.jsp");
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

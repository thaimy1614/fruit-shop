/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import model.Product;
import org.json.JSONObject;

/**
 *
 * @author ADMIN
 */
public class AddCart extends HttpServlet {

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
        CartDAO dao = new CartDAO();
        String u = request.getParameter("user");
        int p = Integer.valueOf((String) request.getParameter("prId"));
        int q = Integer.valueOf((String) request.getParameter("quan"));
//        String name = request.getParameter("name");
//        String img = request.getParameter("img");
//        float price = Float.parseFloat(request.getParameter("price"));
//        String des = request.getParameter("des");
//        String cate = request.getParameter("cate");
//        Product pr = new Product(p, name, price, img, des, q, cate, q);
//        String url = "/shop?name=" + name + "&img=" + img + "&price=" + price + "&des=" + des + "&cate=" + cate;

        boolean kq = dao.createCart(u, p, q);
        if (!kq) {
            response.sendRedirect("404.jsp");
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/shop");
            dispatcher.forward(request, response);
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
        CartDAO dao = new CartDAO();
        String user = request.getParameter("user");
        String home = request.getParameter("home");
        int pId = Integer.valueOf((String) request.getParameter("proId"));
        int quantity = Integer.valueOf((String) request.getParameter("quantity"));

        boolean kq = dao.createCart(user, pId, quantity);

        if (kq) {
            try ( PrintWriter out = response.getWriter()) {
                HttpSession session = request.getSession();
                String username = (String) session.getAttribute("username");
                int updatedCount = dao.countItemsInCart(username);

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("count", updatedCount);

                // Set response type to JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Write JSON data to the response
                out.write(jsonResponse.toString());
            } catch (Exception e) {
                e.printStackTrace();

                // Set a proper HTTP status code (500 Internal Server Error)
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

            if (home.equals("home")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/home");
                dispatcher.forward(request, response);
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/shop");
                dispatcher.forward(request, response);
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

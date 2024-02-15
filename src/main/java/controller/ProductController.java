/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import model.Product;
import model.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class ProductController extends HttpServlet {

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
        request.getRequestDispatcher("single-product.jsp").forward(request, response);
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
        ProductDAO dao = new ProductDAO();
        List<Product> allProducts = dao.getAllProducts();
        String filter = request.getParameter("filter");

        int pageNumber = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            pageNumber = Integer.parseInt(pageParam);
        }
        int pageSize = 6;
        List<Product> productsOnPage;
        if (filter == null) {
            productsOnPage = paginate(allProducts, pageNumber, pageSize);
            request.setAttribute("products", productsOnPage);
            request.setAttribute("allProducts", allProducts);

            request.getRequestDispatcher("shop.jsp").forward(request, response);// Gán filter thành chuỗi rỗng nếu không có tham số filter được gửi
        } else {
            List<Product> filteredProducts = null;
            if (filter.equalsIgnoreCase("all")) {
                productsOnPage = paginate(allProducts, pageNumber, pageSize);
            } else {
                filteredProducts = filterProductsByCategory(allProducts, filter);
                productsOnPage = paginate(filteredProducts, pageNumber, pageSize);
            }
            // Tính tổng số sản phẩm thỏa mãn filter theo loại trái cây
            int totalFilteredProducts = filter.equalsIgnoreCase("all") ? allProducts.size() : filteredProducts.size();
            ObjectMapper mapper = new ObjectMapper();
            // Tạo một đối tượng JSON để chứa thông tin về sản phẩm và tổng số sản phẩm thỏa mãn filter
            ObjectNode jsonResponse = mapper.createObjectNode();
            jsonResponse.put("productsOnPage", mapper.valueToTree(productsOnPage));
            jsonResponse.put("totalFilteredProducts", totalFilteredProducts);

            // Gửi đối tượng JSON về dưới dạng chuỗi
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());
        }

    }

    // Hàm lọc sản phẩm dựa trên bộ lọc (loại sản phẩm)
    private List<Product> filterProductsByCategory(List<Product> allProducts, String category) {
        if (category.equals("all") || category.isEmpty()) {
            return allProducts; // Nếu không có bộ lọc, trả về toàn bộ danh sách sản phẩm
        }
        List<Product> filteredProducts = new ArrayList<>();
        for (Product product : allProducts) {
            if (product.getCname().equalsIgnoreCase(category)) {
                filteredProducts.add(product);
            }
        }
        return filteredProducts;
    }

    // Hàm phân trang danh sách sản phẩm
    private List<Product> paginate(List<Product> products, int pageNumber, int pageSize) {
        int startIndex = (pageNumber - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, products.size());
        if (startIndex >= endIndex) {
            return Collections.emptyList();
        }
        return products.subList(startIndex, endIndex);
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

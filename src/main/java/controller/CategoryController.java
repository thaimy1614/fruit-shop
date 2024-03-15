/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.aspose.cells.Cell;
import com.aspose.cells.Workbook;
import com.aspose.cells.Worksheet;
import dao.CategoryDAO;
import model.Order;
import dao.OrderDAO;
import model.Product;
import dao.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
public class CategoryController extends HttpServlet {

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
        String check = request.getParameter("check");
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("Delete")) {
                int id = Integer.parseInt(request.getParameter("deleteId"));
                CategoryDAO dao = new CategoryDAO();
                if (dao.deleteCategory(id)) {
                    response.sendRedirect("category");
                } else {
                    response.sendRedirect("404.jsp");
                }
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            List<Category> categories;
            CategoryDAO dao = new CategoryDAO();
            String search = "";
            if (request.getParameter("searchCate") != null) {
                search = request.getParameter("searchCate");
                categories = dao.searchCategory(search);
            } else {
                categories = dao.getAllCategories();
            }
            
            request.setAttribute("categories", categories);
            request.setAttribute("lastS", search);
            request.getRequestDispatcher("category.jsp").forward(request, response);
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
    private static final String UPLOAD_DIR = "assets/img/products";

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
        

        if (request.getParameter("btnInsert") != null) { //them moi
            String cName = request.getParameter("cName");

            CategoryDAO dao = new CategoryDAO();
            int cId = dao.selectMaxId() + 1;
            boolean kq = dao.createCategory(cId, cName);
            if (kq) {
                response.sendRedirect("category");
            } else {
                response.sendRedirect("404.jsp");
            }
        }

        if (request.getParameter("btnEdit") != null) {
            //chinh sua
            int cId = Integer.parseInt(request.getParameter("cId"));
            String cName = request.getParameter("cName");

            CategoryDAO dao = new CategoryDAO();
            boolean result = dao.updateCategory(cId, cName);
            if (result) {
                response.sendRedirect("category");
            } else {
                response.sendRedirect("404.jsp");
            }
        }

    }

    private String generateUniqueFileName(String baseFileName, String folderPath) {
        String newFileName = baseFileName;
        int fileNumber = 1;
        File existingFile = new File(folderPath, newFileName);

        while (existingFile.exists()) {
            String fileNameWithoutExtension = FilenameUtils.removeExtension(baseFileName);
            String fileExtension = FilenameUtils.getExtension(baseFileName);
            newFileName = fileNameWithoutExtension + "_" + fileNumber + "." + fileExtension;
            existingFile = new File(folderPath, newFileName);
            fileNumber++;
        }

        return newFileName;
    }

    private String getColumnPropertyName(String columnName) {
        // Implement logic to map column names to property names
        // For example:
        switch (columnName) {
            case "ID":
                return "pId";
            case "Name":
                return "pName";
            case "Price":
                return "pPrice";
            case "Image":
                return "pimg";
            case "Description":
                return "pDes";
            case "Quantity":
                return "quantity";
            case "Category Name":
                return "cname";
            case "Category ID":
                return "cId";
            // Add more cases for other column names as needed
            default:
                throw new IllegalArgumentException("Unknown column name: " + columnName);
        }
    }

    private Object getPropertyByName(Product product, String propertyName) {
        // Implement logic to retrieve property value by name
        // You may use reflection or direct getter methods based on your implementation
        // For example (assuming direct getters):
        switch (propertyName) {
            case "pId":
                return product.getpId();
            case "pName":
                return product.getpName();
            case "pPrice":
                return product.getpPrice();
            case "pimg":
                return product.getPimg();
            case "pDes":
                return product.getpDes();
            case "quantity":
                return product.getQuantity();
            case "cname":
                return product.getCname();
            case "cId":
                return product.getcId();
            // Add more cases for other property names as needed
            default:
                throw new IllegalArgumentException("Unknown property name: " + propertyName);
        }
    }

    private String getColumnPropertyNameOfOrder(String columnName) {
        switch (columnName) {
            case "Username":
                return "username";
            case "Order ID":
                return "orderId";
            case "Name":
                return "name";
            case "Address":
                return "address";
            case "Phone":
                return "phone";
            case "Quantity":
                return "quantity";
            case "Amount":
                return "amount";
            case "Date":
                return "date";
            case "Status":
                return "status";
            case "Note":
                return "note";
            case "Payment Method":
                return "pay";
            // Add more cases for other column names as needed
            default:
                throw new IllegalArgumentException("Unknown column name: " + columnName);
        }
    }

    private Object getPropertyByNameOfOrder(Order order, String propertyName) {
        switch (propertyName) {
            case "username":
                return order.getUsername();
            case "orderId":
                return order.getOrderId();
            case "name":
                return order.getName();
            case "address":
                return order.getAddress();
            case "phone":
                return order.getPhone();
            case "quantity":
                return order.getQuantity();
            case "amount":
                return order.getAmount();
            case "date":
                return order.getDate();
            case "status":
                if (order.getStatus() == 0) {
                    return "Canceled";
                } else if (order.getStatus() == 1) {
                    return "Not confirmed yet";
                } else {
                    return "Confirmed";
                }
            case "note":
                return order.getNote();
            case "pay":
                return (order.getPay() == 1) ? "VnPay" : "COD";
            // Add more cases for other property names as needed
            default:
                throw new IllegalArgumentException("Unknown property name: " + propertyName);
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

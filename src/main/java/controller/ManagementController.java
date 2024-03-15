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
public class ManagementController extends HttpServlet {

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
        String messExport = (String) request.getAttribute("messExport");
        if (action != null) {
            if (action.equals("UPDATE")) {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String name = request.getParameter("ordername");
                String phone = request.getParameter("orderphone");
                String address = request.getParameter("orderaddress");
                String note = request.getParameter("note");
                OrderDAO dao = new OrderDAO();
                boolean rs = dao.updateOrder(orderId, name, address, phone, note);
                if (rs) {
                    response.sendRedirect("manage?check=ordermanage&update=success");
                } else {
                    response.sendRedirect("404.jsp");
                }
            } else if (action.equals("Delete")) {
                String id = request.getParameter("deleteId");
                ProductDAO dao = new ProductDAO();
                if (dao.deleteProduct(id)) {
                    response.sendRedirect("manage");
                } else {
                    response.sendRedirect("404.jsp");
                }
            }
        } else if (check != null) {
            if (check.equals("ordermanage")) {
                String mess = request.getParameter("update");
                if (mess != null) {
                    if (mess.equals("success")) {
                        request.setAttribute("mess", "login");
                    }
                }
                OrderDAO dao = new OrderDAO();
                List<Order> order = dao.getAllOrder();
                request.setAttribute("ord", order);
                request.setAttribute("messExport", messExport);
                request.getRequestDispatcher("manage-order.jsp").forward(request, response);
            }

        } else {
            response.setContentType("text/html;charset=UTF-8");
            ProductDAO dao = new ProductDAO();
            List<Product> product = dao.getAllProducts();
            request.setAttribute("products", product);
            request.setAttribute("messExport", messExport);
            request.getRequestDispatcher("Manager.jsp").forward(request, response);
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
        if (request.getParameter("export") != null) {
            Workbook workbook = new Workbook();
            Worksheet sheet = workbook.getWorksheets().get(0);
            ProductDAO dao = new ProductDAO();
            if (request.getParameter("export").equals("products")) {
                List<Product> productList = dao.getAllProducts();

                try {
                    if (!productList.isEmpty()) {
                        String[] columnNames = {"ID", "Name", "Price", "Image", "Description", "Quantity", "Category Name", "Category ID"};

                        // Set column names in the first row
                        for (int i = 0; i < columnNames.length; i++) {
                            Cell cell = sheet.getCells().get(0, i);
                            cell.setValue(columnNames[i]);
                        }

                        // Populate data rows
                        for (int row = 1; row <= productList.size(); row++) {
                            Product product = productList.get(row - 1); // Adjusting for 0-based indexing
                            for (int col = 0; col < columnNames.length; col++) {
                                String propertyName = getColumnPropertyName(columnNames[col]); // Assuming you have a method to get the property name from the column name
                                Object value = getPropertyByName(product, propertyName); // Assuming you have a method to get property value by name
                                Cell cell = sheet.getCells().get(row, col);
                                cell.setValue(value != null ? value.toString() : ""); // Set cell value
                            }
                        }

                        // Save the Excel file
                        workbook.save("D:\\2024\\SWP\\FruitShop\\products.xlsx");
                        response.sendRedirect("manage");
                    } else {
                        System.out.println("No data retrieved from ProductDAO.getAllProducts()");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    Logger.getLogger(ManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if (request.getParameter("export").equals("categories")) {
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Category> categoryList = categoryDAO.getAllCategories();

                try {
                    if (!categoryList.isEmpty()) {
                        String[] columnNames = {"ID", "Name"};

                        // Set column names in the first row
                        for (int i = 0; i < columnNames.length; i++) {
                            Cell cell = sheet.getCells().get(0, i);
                            cell.setValue(columnNames[i]);
                        }

                        // Populate data rows
                        for (int row = 1; row <= categoryList.size(); row++) {
                            Category category = categoryList.get(row - 1); // Adjusting for 0-based indexing
                            for (int col = 0; col < columnNames.length; col++) {
                                String propertyName = getColumnPropertyNameOfCategory(columnNames[col]); // Assuming you have a method to get the property name from the column name
                                Object value = getPropertyByNameOfCategory(category, propertyName); // Assuming you have a method to get property value by name
                                Cell cell = sheet.getCells().get(row, col);
                                cell.setValue(value != null ? value.toString() : ""); // Set cell value
                            }
                        }

                        // Save the Excel file
                        workbook.save("D:\\2024\\SWP\\FruitShop\\categories.xlsx");
                        response.sendRedirect("category");
                    } else {
                        System.out.println("No data retrieved from ProductDAO.getAllProducts()");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    Logger.getLogger(ManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if (request.getParameter("export").equals("orders")) {
                OrderDAO orderDAO = new OrderDAO();
                List<Order> orderList = orderDAO.getAllOrder();

                try {
                    if (!orderList.isEmpty()) {
                        String username;

                        String[] columnNames = {"Username", "Order ID", "Name", "Address", "Phone", "Quantity", "Amount", "Date", "Status", "Note", "Payment Method"};

                        // Set column names in the first row
                        for (int i = 0; i < columnNames.length; i++) {
                            Cell cell = sheet.getCells().get(0, i);
                            cell.setValue(columnNames[i]);
                        }

                        // Populate data rows
                        for (int row = 1; row <= orderList.size(); row++) {
                            Order order = orderList.get(row - 1); // Adjusting for 0-based indexing
                            for (int col = 0; col < columnNames.length; col++) {
                                String propertyName = getColumnPropertyNameOfOrder(columnNames[col]); // Assuming you have a method to get the property name from the column name
                                Object value = getPropertyByNameOfOrder(order, propertyName); // Assuming you have a method to get property value by name
                                Cell cell = sheet.getCells().get(row, col);
                                cell.setValue(value != null ? value.toString() : ""); // Set cell value
                            }
                        }

                        // Save the Excel file
                        workbook.save("D:\\2024\\SWP\\FruitShop\\orders.xlsx");
                        response.sendRedirect("manage?check=ordermanage");
                    } else {
                        System.out.println("No data retrieved from ProductDAO.getAllProducts()");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    Logger.getLogger(ManagementController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        if (request.getParameter("btnInsert") != null) { //them moi
            String tensanpham = request.getParameter("prodnameC");
            int giatien = Integer.parseInt(request.getParameter("propriceC"));
//            int soluong = Integer.valueOf(request.getParameter("soluong"));
            String des = request.getParameter("Description");
            int loai = Integer.parseInt(request.getParameter("loai"));
            int quan = Integer.parseInt(request.getParameter("quantityC"));
            String imgFolderPath = "assets" + File.separator + "img" + File.separator + "products";
            String appPath = "D:" + File.separator + "2024" + File.separator + "SWP" + File.separator + "FruitShop" + File.separator + "web";
            String uploadPath = appPath + File.separator + imgFolderPath;

            // Tạo thư mục upload nếu chưa tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Lấy file từ request
            Part filePart = request.getPart("hinhanh");
            String fileName = filePart.getSubmittedFileName();
            String fileUrl = "";
            if (fileName == "") {
                fileUrl = request.getParameter("imgTmp");
            } else {
                fileName = generateUniqueFileName(fileName, uploadPath);
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // In ra đường dẫn của file đã upload
                fileUrl = UPLOAD_DIR + "/" + fileName;
            }
            String pro_pic = fileUrl;
            if (pro_pic == null) {
                pro_pic = "https://mdbootstrap.com/img/Photos/Others/placeholder.jpg";
            }
            ProductDAO dao = new ProductDAO();

            boolean kq = dao.createOrder(tensanpham, giatien, pro_pic, des, loai, quan);
            if (kq) {
                response.sendRedirect("manage");
            } else {
                response.sendRedirect("404.jsp");
            }
        }

        if (request.getParameter("btnEdit") != null) {
            //chinh sua
            int id = Integer.parseInt(request.getParameter("productId"));
            String tensanpham = request.getParameter("prodname");
            String floatValueStr = request.getParameter("proprice");
            float floatValue = Float.parseFloat(floatValueStr);
            int giatien = (int) floatValue;
            String des = request.getParameter("Description");
            int loai = Integer.parseInt(request.getParameter("loai"));
            int quan = Integer.parseInt(request.getParameter("quantity"));

            String imgFolderPath = "assets" + File.separator + "img" + File.separator + "products";
            String appPath = "D:" + File.separator + "GitHub" + File.separator + "Project_Group01" + File.separator + "Fruitshop" + File.separator + "web";
            String uploadPath = appPath + File.separator + imgFolderPath;

            // Tạo thư mục upload nếu chưa tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Lấy file từ request
            Part filePart = request.getPart("hinhanh2");
            String fileName = filePart.getSubmittedFileName();
            String fileUrl = "";
            if (fileName == "") {
                fileUrl = request.getParameter("imgTmp");
            } else {
                fileName = generateUniqueFileName(fileName, uploadPath);
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // In ra đường dẫn của file đã upload
                fileUrl = UPLOAD_DIR + "/" + fileName;
            }
            String pro_pics = fileUrl;

            ProductDAO dao = new ProductDAO();
            boolean result = dao.updateOrder(id, tensanpham, giatien, pro_pics, des, loai, quan);
            if (result) {
                response.sendRedirect("manage");
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

    private String getColumnPropertyNameOfCategory(String columnName) {
        switch (columnName) {
            case "ID":
                return "cId";
            case "Name":
                return "cName";
            default:
                throw new IllegalArgumentException("Unknown column name: " + columnName);
        }
    }

    private Object getPropertyByNameOfCategory(Category category, String propertyName) {
        switch (propertyName) {
            case "cId":
                return category.getcId();
            case "cName":
                return category.getcName();

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

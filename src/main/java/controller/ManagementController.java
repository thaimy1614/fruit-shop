/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Order;
import model.OrderDAO;
import model.Product;
import model.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
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
                request.getRequestDispatcher("manage-order.jsp").forward(request, response);
            }

        } else {
            response.setContentType("text/html;charset=UTF-8");
            ProductDAO dao = new ProductDAO();
            List<Product> product = dao.getAllProducts();
            request.setAttribute("products", product);
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
        if (request.getParameter("btnInsert") != null) { //them moi
            String tensanpham = request.getParameter("prodnameC");
            int giatien = Integer.parseInt(request.getParameter("propriceC"));
//            int soluong = Integer.valueOf(request.getParameter("soluong"));
            String des = request.getParameter("Description");
            int loai = Integer.parseInt(request.getParameter("loai"));
            int quan = Integer.parseInt(request.getParameter("quantityC"));
            String imgFolderPath = "assets" + File.separator + "img" + File.separator + "products";
            String appPath = "D:" + File.separator + "2024" + File.separator + "SWP" +File.separator + "FruitShop" + File.separator + "web";
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
            String appPath = "D:" + File.separator + "GitHub" +File.separator + "Project_Group01" + File.separator + "Fruitshop" + File.separator + "web";
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

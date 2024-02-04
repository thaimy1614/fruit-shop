/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Email;
import model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class RegisterAccount extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String username = request.getParameter("usersignup");
        String name = request.getParameter("fullnamesignup");
        String pass = request.getParameter("passwordsignup");
        String email = request.getParameter("emailsignup");
        String phone = request.getParameter("phonesignup");
        String address = request.getParameter("addresssignup");
        String verify = request.getParameter("verification");
        String code = "group01";
        Users u = new Users();
        if(verify!=null){
            if(verify.equals(code)){
                boolean kq = false;
                kq = u.createAcc(username, pass, name, email, phone, address);

                if (kq) {
                    request.setAttribute("mess", "login");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
                }
            }
        }
        request.getRequestDispatcher("signup.jsp").forward(request, response);
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
        String username = request.getParameter("usersignup");
        String name = request.getParameter("fullnamesignup");
        String pass = request.getParameter("passwordsignup");
        String email = request.getParameter("emailsignup");
        String phone = request.getParameter("phonesignup");
        String address = request.getParameter("addresssignup");
        Users u = new Users();
        boolean rs = u.checkUser(username);
        if (!rs) {
            boolean checkmail = u.checkMail(email);
            if (!checkmail){
                String code = "group01";
                String subject = "Verification";
                String body = "<html><body>"
                        + "<p>Dear " + name + " ,</p>"
                        + "<p>Chúng tôi đã nhận được yêu cầu đăng ký tài khoản của bạn trên FruitShop. "
                        + "<p>Vui lòng click vào đây để xác nhận tài khoản: "
//                        + "<form action="+"signup"+" method="+"post"+"> "
//                        + "<input type="+"hidden"+" name="+"usersignup"+" value="+username+" />"
//                        + "<input type="+"hidden"+" name="+"fullnamesignup"+" value="+name+" />"
//                        + "<input type="+"hidden"+" name="+"passwordsignup"+" value="+pass+" />"
//                        + "<input type="+"hidden"+" name="+"emailsignup"+" value="+email+" />"
//                        + "<input type="+"hidden"+" name="+"phonesignup"+" value="+phone+" />"
//                        + "<input type="+"hidden"+" name="+"addresssignup"+" value="+address+" />"
//                        + "<input type="+"hidden"+" name="+"verification"+" value="+"group01"+" hidden />"
//                        + "<button type="+"submit"+" class="+"btn btn-primary w-100"+" ></button>"
//                        + "</form>"
                        + "<p>"
                        + "<a href='http://localhost:9999/FruitShop/signup?usersignup="+username+"&fullnamesignup="
                        + name + "&passwordsignup=" + pass + "&emailsignup=" +email+ "&phonesignup=" + phone
                        + "&addresssignup=" + address + "&verification=group01' style='"
                        + "background-color:#3498db; color:#ffffff; text-decoration:none; padding:10px 20px;"
                        + "border-radius:4px; font-size:16px; font-family:Arial, sans-serif; display:inline-block;"
                        + "cursor:pointer; text-align:center;'>Verification Email</a>"
                        + "</p>"
                        + "<p>Trân trọng,<br>"
                        + "Đội ngũ cửa hàng</p>"
                        + "</body></html>";
                Email.sendEmail(email, subject, body);
                    request.setAttribute("mess", "An email was sent to you. Please check your email");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);

            } else {
                request.setAttribute("mess", "Mail đã tồn tại!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("mess", "Username đã tồn tại!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
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

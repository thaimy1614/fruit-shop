/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Random;
import model.Email;
import model.Users;

/**
 *
 * @author ADMIN
 */
public class ForgotPassword extends HttpServlet {

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
            out.println("<title>Servlet ForgotPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassword at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("btnForgot");
        HttpSession session = request.getSession();
        if (action != null) {
            if (action.equals("checkUser")) {
                String user = request.getParameter("userforgot");
                Users u = new Users();
                boolean rs = u.checkUser(user);
                if (rs) {
                    String code = generateRandomString();
                    Users info = u.getInfoAcount(user);
                    String mail = info.getMail();
                    String subject = "Verification";
                    String body = "<html><body>"
                            + "<p>Dear " + info.getFullname() + " ,</p>"
                            + "<p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn trên FuitShop. "
                            + "<p>Mã của bạn: " + code + "</p>"
                            + "<p>Trân trọng,<br>"
                            + "Đội ngũ cửa hàng</p>"
                            + "</body></html>";
                    Email.sendEmail(mail, subject, body);
                    session.setAttribute("code", code);
                    session.setAttribute("userforget", user);
                    request.removeAttribute("forgot");
                    request.setAttribute("ma", "login");
                    request.setAttribute("mail", mail);
                    request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
                } else {
                    request.setAttribute("mess", "Username not exits!");
                    request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
                }
            } else if (action.equals("checkCode")) {
                String checkcode = request.getParameter("codeforget");
                String check = (String) session.getAttribute("code");
                if (checkcode.equals(check)) {
                    session.removeAttribute("code");
                    request.removeAttribute("ma");
                    request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
                }
            }
        } else {
            request.setAttribute("forgot", "login");
            request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
        }

    }

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int LENGTH = 6;

    public static String generateRandomString() {
        SecureRandom random = new SecureRandom();
        StringBuilder stringBuilder = new StringBuilder(LENGTH);

        for (int i = 0; i < LENGTH; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            char randomChar = CHARACTERS.charAt(randomIndex);
            stringBuilder.append(randomChar);
        }

        return stringBuilder.toString();
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
        String passString = request.getParameter("passwordforgot");
        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("userforget");
        Users u = new Users();
        boolean rs = u.changePass(user, passString);
        if (rs) {
            
            request.setAttribute("mess", "login");
            request.getRequestDispatcher("forgotpass.jsp").forward(request, response);
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

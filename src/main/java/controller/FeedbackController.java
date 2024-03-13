package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import config.LocalDateTimeAdapter;
import dao.FeedbackDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Message;
import model.Users;

public class FeedbackController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sortType = request.getParameter("sort"); // Get sorting type from request
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Message> feedbackList = null;
        HttpSession session = request.getSession();
        boolean isAdmin = ((int)session.getAttribute("isAdmin") == 1) ? true : false;
        // Get feedback list based on sorting type
        if (sortType == null) {
            feedbackList = feedbackDAO.getAllMessagesSortedByNewest();
            request.setAttribute("listOfMessage", feedbackList);
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        } else {
            if ("oldest".equals(sortType)) {
                feedbackList = feedbackDAO.getAllMessagesSortedByOldest();
            } else {
                feedbackList = feedbackDAO.getAllMessagesSortedByNewest(); // Default: Newest
            }
            // Convert feedback list and isAdmin flag to JSON
            Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("isAdmin", isAdmin);
            jsonResponse.add("feedbackList", gson.toJsonTree(feedbackList));

            // Send JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") != null) {
            Users u = (Users) session.getAttribute("info");
            LocalDateTime currentDateTime = LocalDateTime.now();

            // Define the format pattern
            String formatPattern = "yyyy-MM-dd HH:mm:ss";

            // Format the current date and time using the specified pattern
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(formatPattern);
            String formattedDateTime = currentDateTime.format(formatter);

            // Parse the formatted date and time string back to a LocalDateTime object
            LocalDateTime parsedDateTime = LocalDateTime.parse(formattedDateTime, formatter);
            FeedbackDAO fd = new FeedbackDAO();
            if (u.getIsCus() == 1) {
                String username = (String) session.getAttribute("username");
                String message = request.getParameter("fb");
                String img = request.getParameter("img");

                if (fd.sendFeedback(username, message, img, parsedDateTime)) {
                    response.sendRedirect("feedback");
                } else {
                    response.sendRedirect("404.jsp");
                }
            } else if (u.getIsAdmin() == 1) {
                String responseMessage = request.getParameter("response");
                int responseTo = Integer.parseInt(request.getParameter("response_to"));
                if (fd.sendResponse(responseTo, responseMessage, parsedDateTime)) {
                    response.sendRedirect("feedback");
                } else {
                    response.sendRedirect("404.jsp");
                }
            }
        } else {
            response.sendRedirect("loginpage"); // Redirect if user is not logged in
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles feedback submission and retrieval";
    }
}

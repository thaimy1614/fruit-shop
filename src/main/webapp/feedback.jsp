<%-- 
    Document   : feedback
    Created on : Feb 22, 2024, 1:21:17 PM
    Author     : Duong Quoc Thai CE171563
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
            <h1>
                Feedback Page
            </h1>
            <form action="feedback" method="post">
                <div>
                    <label for="fb">Your comment: </label>
                    <input type="text" id="fb" name="fb">
                </div> 
                <div>
                    <input type="submit" value="POST">>
                </div>
            </form>

            <div>
                <ul>
                <c:forEach var="fb" items="${feedbackList}">
                    <li>
                        <div class="message">
                            <span>${fb.username}</span>
                            <br>
                            <span>${fb.message}</span><span>${fb.date_message}</span>
                        </div>
                        <div class="response">
                            <span>Admin</span>
                            <br>
                            <span>${fb.response}</span><span>${fb.date_response}</span>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </body>
</html>

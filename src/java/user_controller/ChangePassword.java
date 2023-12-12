package user_controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import DAO.UserDAO;
import entity.user.User;

public class ChangePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the user's session to check the current password
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Get parameters from the form
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Check if the current password matches the user's password in the session
        if (!currentPassword.equals(user.getPassword())) {
            // Current password doesn't match; handle this case appropriately
            session.setAttribute("passwordChangeMessage", "Incorrect current password");
            response.sendRedirect("change_password.jsp");
            return;
        }

        // Update the user's password
        user.setPassword(newPassword);
        UserDAO userDao = new UserDAO();
        userDao.updateUser(user);

        // Set a session attribute to signal password change success
        session.setAttribute("passwordChangeSuccess", true);

        // Redirect back to the change_password.jsp page
        response.sendRedirect("customer/change_password.jsp");
    }
}

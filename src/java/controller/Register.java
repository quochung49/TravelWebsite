package controller;

import DAO.UserDAO;
import DAO.UserRoleDAO;
import entity.model.UserRole;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Register extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO(); // Initialize the UserDAO in the servlet's init method
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve user details from the form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String streetAddress = request.getParameter("streetaddress");
        String zipcode = request.getParameter("zipcode");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");

        // Create a User object with the retrieved details
        User user = new User(email, password, firstName, lastName, streetAddress, zipcode, city, country, phone);
        // default is Customer ( Role = 2)
        user.setRole(new UserRoleDAO().getRoleById(2));
        // Register the user in the database

        boolean registered = userDAO.userRegister(user);

        if (registered) {
            // Registration successful, redirect to a success page
            request.getSession().setAttribute("signupSuccess", "Sign Up Successfully.");
            response.sendRedirect("./validation/register.jsp");
        } else {
            // Registration failed, handle accordingly (e.g., show an error message)
            request.getSession().setAttribute("signupFail", "Registration failed. Please try again.");
            response.sendRedirect("./validation/register.jsp");
        }
    }
}

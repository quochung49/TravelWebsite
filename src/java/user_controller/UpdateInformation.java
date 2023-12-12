/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package user_controller;

import DAO.UserDAO;
import entity.user.User;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author FPT
 */
public class UpdateInformation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID from the request
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Retrieve the user from the database using the user ID
        UserDAO userDAO = new UserDAO();
//        User user = userDAO.getUserById(userId);
        User user = (User) request.getSession().getAttribute("user");

        // Update user fields with the new information
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String streetAddress = request.getParameter("streetAddress");
        String zipcode = request.getParameter("zipcode");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setStreetAddress(streetAddress);
        user.setZipcode(zipcode);
        user.setCity(city);
        user.setCountry(country);
        user.setPhone(phone);

        // Update the user's information in the database
        userDAO.updateUser(user);
        request.getSession().setAttribute("user", user);

        // Redirect the user to a confirmation page
        response.sendRedirect("customer/update_confirmation.jsp");
    }

}

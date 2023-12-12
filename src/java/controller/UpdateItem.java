/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookDAO;
import entity.model.Cart;
import entity.model.Item;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author FPT
 */
public class UpdateItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Retrieve the cart from the session
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        int stockQuantity = new BookDAO().getBookById(bookId).getQuantityInStock();

        if (cart != null) {
            // Update the quantity of the specified product in the cart
            for (Item item : cart.getItems()) {
                if (item.getBook().getId() == bookId) {
                    if (quantity == 0) {
                        cart.removeItem(item);
                    } else if (quantity <= stockQuantity) {
                        item.setQuantity(quantity);
                    } else {
                        // Quantity is greater than the quantity in stock
                        // Set an error message
//                        response.setContentType("application/json");
//                        String errorMessage = "Quantity is out of stock";
//                        response.getWriter().write("{\"error\": \"" + errorMessage + "\"}");
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity is out of stock");
                        return;
                    }
                    break;
                }
            }
        }

        // If everything is successful, redirect
        response.sendRedirect("cart/viewcart.jsp");
    }

}

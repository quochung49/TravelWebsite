/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.model.Cart;
import entity.model.Item;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author FPT
 */
public class RemoveItem extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        // Retrieve the cart from the session
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart != null) {
            // Update the quantity of the specified product in the cart
            for (Item item : cart.getItems()) {
                if (item.getBook().getId() == bookId) {
                    cart.removeItem(item);
                    break; // Stop searching, as the product is found
                }
            }
        }

        response.sendRedirect("cart/viewcart.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.BookDAO;
import entity.model.Book;
import entity.model.Cart;
import entity.model.Item;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author FPT
 */
public class AddCart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("bookId"));

        // Retrieve the product based on the productId from your database
        BookDAO dao = new BookDAO();
        Book book = dao.getBookById(productId);

        // Get the shopping cart from the session
        Cart cart = (Cart) request.getSession().getAttribute("cart");

        if (cart == null) {
            // If the cart doesn't exist, create a new one
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        } else {
            // Check if the product already exists in the cart
            for (Item item : cart.getItems()) {
                if (item.getBook().getId() == productId) {
                    // If the product is found, increase its quantity
                    item.setQuantity(item.getQuantity() + 1);

                    // Redirect back to the product list page
                    response.sendRedirect("index.jsp");
                    return;
                }
            }
        }

        // If the product doesn't exist in the cart, add it as a new item
        Item item = new Item(book, 1);
        cart.addItem(item);
        // cart.getCount() is number of items in cart, how to set this one to the <span class="item-count" id="cart-item-count">0</span> at real time?
        response.sendRedirect("index.jsp"); // Redirect back to the product list page
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

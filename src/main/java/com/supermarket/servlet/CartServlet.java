package com.supermarket.servlet;

import com.supermarket.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CartServlet.class.getName());
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        
        logger.info("Session ID: " + session.getId());
        logger.info("Session is new: " + session.isNew());

        if (path != null && path.equals("/add")) {
            // Get or create cart items list
            @SuppressWarnings("unchecked")
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            if (cartItems == null) {
                cartItems = new ArrayList<>();
                session.setAttribute("cartItems", cartItems);
            }
            logger.info("Current cart items: " + cartItems.size());
            
            // Get product details from request
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imageUrl = request.getParameter("imageUrl");
            int productId = Integer.parseInt(request.getParameter("productId"));

            logger.info("Adding item: " + productName + " with quantity: " + quantity + " and productId: " + productId);

            try {
                // Check if item already exists in cart
                boolean itemExists = false;
                for (CartItem item : cartItems) {
                    if (item.getProductName().equals(productName)) {
                        item.setQuantity(item.getQuantity() + quantity);
                        itemExists = true;
                        logger.info("Updated existing item quantity to: " + item.getQuantity());
                        break;
                    }
                }

                if (!itemExists) {
                    CartItem newItem = new CartItem(productId, productName, price, quantity, imageUrl);
                    cartItems.add(newItem);
                    logger.info("Added new item to cart. Total items now: " + cartItems.size());
                }

                // Update session with modified cart items
                session.setAttribute("cartItems", cartItems);
                logger.info("Updated session with cart items. Session cart items count: " + 
                    ((List<CartItem>) session.getAttribute("cartItems")).size());
                out.print("{\"success\": true}");
            } catch (Exception e) {
                logger.severe("Error adding item to cart: " + e.getMessage());
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"Failed to add item to cart\"}");
            }
        } else if (path != null && path.equals("/count")) {
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            int itemCount = 0;
            if (cartItems != null) {
                for (CartItem item : cartItems) {
                    itemCount += item.getQuantity();
                }
            }
            logger.info("Cart count: " + itemCount + " (Session ID: " + session.getId() + ")");
            out.print("{\"itemCount\": " + itemCount + "}");
        } else if (path != null && path.equals("/update")) {
            updateCartItem(request, response);
        } else if (path != null && path.equals("/remove")) {
            removeCartItem(request, response);
        } else if (path != null && path.equals("/clear")) {
            clearCart(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            
            for (CartItem item : cartItems) {
                if (item.getProductId() == productId) {
                    item.setQuantity(newQuantity);
                    break;
                }
            }
            session.setAttribute("cartItems", cartItems);
        }
        response.getWriter().print("{\"success\": true}");
    }

    private void removeCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cartItems.removeIf(item -> item.getProductId() == productId);
            session.setAttribute("cartItems", cartItems);
        }
        response.getWriter().print("{\"success\": true}");
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("cartItems");
        response.getWriter().print("{\"success\": true}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        logger.info("GET request - Cart items count: " + (cartItems != null ? cartItems.size() : 0));
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("empty_cart.jsp");
        } else {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
} 
package Controllers.User;

import DAL.Products.DAOCart;
import Models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Cart", urlPatterns = {"/addToCart", "/update-cart", "/remove-from-cart","/checkout"})
public class Cart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            DAOCart daoCart = new DAOCart();
            List<Models.Cart> cartList = daoCart.getCartByUser(user.getId());

            request.setAttribute("cartList", cartList);
            request.setAttribute("userName", user.getFullName());
            request.getRequestDispatcher("Views/User/Cart.jsp").forward(request, response);
        } else {
            response.sendRedirect("Views/Login/Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Views/Login/Login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        DAOCart daoCart = new DAOCart();

        switch (path) {
            case "/update-cart":
                handleUpdate(request, response, user, daoCart);
                break;
            case "/remove-from-cart":
                handleRemove(request, response, user, daoCart);
                break;
            case "/checkout":
                session.setAttribute("userID", user.getId());
                response.sendRedirect("shippingAddress");
                break;
            default:
                doGet(request, response);
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response, User user, DAOCart daoCart)
            throws IOException {

        int variantId = Integer.parseInt(request.getParameter("variantId"));
        String action = request.getParameter("action");
        int currentQty = daoCart.getQuantity(user.getId(), variantId);
        if ("decrease".equals(action) && currentQty == 1) {
            daoCart.removeFromCart(user.getId(), variantId);
        } else {
            int newQty = switch (action) {
                case "increase" ->
                    currentQty + 1;
                case "decrease" ->
                    currentQty - 1;
                default ->
                    currentQty;
            };
            daoCart.updateCartItem(user.getId(), variantId, newQty);
        }
        response.sendRedirect("addToCart");
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response, User user, DAOCart daoCart)
            throws IOException {

        int variantId = Integer.parseInt(request.getParameter("variantId"));
        daoCart.removeFromCart(user.getId(), variantId);
        response.sendRedirect("addToCart");
    }
}

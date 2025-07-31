package Controllers.User;

import DAL.ShippingAddress.DAOShippingAddress;
import DAL.Order.DAOOrder;
import DAL.OrderItem.DAOOrderItem;
import DAL.Products.DAOCart;
import DAL.User.UserProcess;
import Models.Order;
import Models.OrderItem;
import Models.User;
import Models.ShippingAddress;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.Console;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ShippingAddress", urlPatterns = {"/shippingAddress", "/save-shipping"})
public class ShippingAddressController extends HttpServlet {

    DAOShippingAddress daoShippingAddress = new DAOShippingAddress();
    UserProcess userProcessr = new UserProcess();
    DAOOrder daoOrder = new DAOOrder();
    DAOOrderItem daoOderItem = new DAOOrderItem();
    DAOCart cart = new DAOCart();

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userID = (int) session.getAttribute("userID");
        User user = new User();
        user = userProcessr.getUserById(userID);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/Views/User/ShippingAddress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userProcessr.getUserById(userId);
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // ShippingAddress
        ShippingAddress sa = new ShippingAddress();
        sa.setUser(user);
        sa.setAddress(address);
        sa.setPhone(phone);
        sa.setReceiverName(name);
        int shippingAddressId = daoShippingAddress.getExistingShippingAddressId(sa);

        if (shippingAddressId == 0) {
            daoShippingAddress.insertShippingAddress(sa);
            shippingAddressId = daoShippingAddress.getExistingShippingAddressId(sa);
        }
        sa.setId(shippingAddressId);

        // User
        // Order
        Order order = new Order();
        order.setUser(user);
        order.setShippingAddress(sa);

        order.setStatus(0);

        if (daoOrder.addOrder(order) > 0) {
            try {
                int newOrderId = daoOrder.getLatestOrderIdByUserId(userId);
                // Set the ID to the order object before forwarding
                order.setId(newOrderId);

                // Insert order items
                daoOderItem.insertOrderItemsFromCart(userId, newOrderId);
                //Remove cart
                cart.removeCart(userId);
            } catch (SQLException ex) {
                Logger.getLogger(ShippingAddressController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        String urlImg = "vn-11134216-7qukw-lk2u2a5dyf429b.jpg";
        request.setAttribute("order", order);
        request.setAttribute("urlImg", urlImg);
        request.getRequestDispatcher("/Views/User/OrderConfirmation.jsp").forward(request, response);
    }
}

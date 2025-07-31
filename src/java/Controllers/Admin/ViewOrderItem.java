package Controllers.Admin;

import DAL.Order.DAOOrder;
import DAL.OrderItem.DAOOrderItem;
import DAL.Products.DAOProduct;
import Models.Order;
import Models.OrderItem;
import Models.Products;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ViewOrderItem", urlPatterns = {"/viewOrderItem"})
public class ViewOrderItem extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            try {
                HttpSession session = request.getSession();
                // Lấy orderId từ session (kiểu Object → ép sang String)
                int orderId = Integer.parseInt(request.getParameter("id"));

                List<OrderItem> orderItemList = new ArrayList<>();
                DAOOrderItem dAOOrderItem = new DAOOrderItem();
                DAOOrder dAOOrder = new DAOOrder();
                orderItemList = dAOOrderItem.getOrderItemsByOrderId(orderId);
                int status = dAOOrder.getStatusById(orderId);
                request.setAttribute("orderId", orderId);
                request.setAttribute("status", status);
                request.setAttribute("orderItemList", orderItemList);
                request.getRequestDispatcher("Views/Admin/AdminListOrderItem.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(ViewOrderItem.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            try {
                int orderId = Integer.parseInt(request.getParameter("id"));
                DAOOrder dAOOrder = new DAOOrder();
                int status = dAOOrder.getStatusById(orderId);
                if (status < 2) {
                    dAOOrder.updateOrderStatus(orderId, status + 1);
                }
                response.sendRedirect("./viewOrder");
            } catch (SQLException ex) {
                Logger.getLogger(ViewOrderItem.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }
}

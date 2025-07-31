package Controllers.Admin;

import DAL.Order.DAOOrder;
import DAL.Products.DAOProduct;
import Models.Order;
import Models.Products;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ViewOrder", urlPatterns = {"/viewOrder"})
public class ViewOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            
            List<Order> order = new ArrayList<>();
            DAOOrder daoOrder = new DAOOrder();
            order = daoOrder.getAllOrders();
            // Gửi dữ liệu sang JSP
            request.setAttribute("order", order);
            request.getRequestDispatcher("Views/Admin/AdminListOrder.jsp").forward(request, response);

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
            String orderId = request.getParameter("id");
            HttpSession session = request.getSession();
            response.sendRedirect("./viewOrderItem?id=" + orderId);

        }
    }

}

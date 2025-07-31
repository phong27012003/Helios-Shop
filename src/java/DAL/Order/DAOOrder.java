package DAL.Order;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import DAL.DAO;
import DAL.ShippingAddress.DAOShippingAddress;
import DAL.User.UserProcess;
import Models.Order;

/**
 *
 * @author ADMIN
 */
public class DAOOrder extends DAO {

    UserProcess userProcess = new UserProcess();
    DAOShippingAddress sa = new DAOShippingAddress();

    public int addOrder(Order order) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[Orders]\n"
                + "           ([UserID]\n"
                + "           ,[AddressID]\n"
                + "           ,[Status]\n"
                + "           ,[CreatedAt])\n"
                + "     VALUES(?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, order.getUser().getId());
            pre.setInt(2, order.getShippingAddress().getId());
            pre.setInt(3, order.getStatus());
            pre.setDate(4, new java.sql.Date(System.currentTimeMillis()));

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT o.*, sa.Phone, sa.Address, sa.ReceiverName\n"
                + "FROM Orders o\n"
                + "JOIN ShippingAddresses sa ON o.AddressID = sa.AddressID";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                // Lấy thông tin từ bảng Order
                order.setId(rs.getInt("OrderID"));
                order.setUser(userProcess.getUserById(rs.getInt("UserID")));
                order.setStatus(rs.getInt("Status"));
                order.setCreatedAt(rs.getTimestamp("CreatedAt"));
                order.setAddress(rs.getString("Address"));
                order.setPhone(rs.getString("Phone"));
                order.setReceiverName(rs.getString("ReceiverName"));
                orderList.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderList;
    }

    public List<Order> getAllOrdersByUserID(int id) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM Orders where UserID = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);

            pre.setInt(1, id);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                // Lấy thông tin từ bảng Order
                order.setId(rs.getInt("OrderID"));
                order.setUser(userProcess.getUserById(rs.getInt("UserID")));
                order.setStatus(rs.getInt("Status"));
                order.setCreatedAt(rs.getTimestamp("CreateAt"));
                orderList.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orderList;
    }

    // Phương thức để đếm tổng số đơn đặt hàng của người dùng theo userID
    public int getTotalOrdersByUserId(int userId) {
        int totalOrders = 0;
        String query = "SELECT COUNT(*) AS total FROM [Orders] WHERE userID = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalOrders = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalOrders;
    }

    public int getTotalOrders() {
        int totalOrders = 0;
        String sql = "SELECT COUNT(*) AS total FROM [dbo].[Order]";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalOrders;
    }

    public boolean updateOrderStatus(int orderId, int newStatus) throws SQLException {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, newStatus);
            stmt.setInt(2, orderId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public int getLatestOrderIdByUserId(int userId) throws SQLException {
        String sql = "SELECT TOP 1 OrderID FROM Orders WHERE UserID = ? ORDER BY OrderID DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("OrderID");
            }
        }
        return -1; // hoặc giá trị báo lỗi nếu không tìm thấy
    }
    public int getStatusById(int orderId) throws SQLException {
        String sql = "SELECT \n" +
"	Status\n" +
"	FROM Orders\n" +
"	where OrderID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("Status");
            }
        }
        return -1; // hoặc giá trị báo lỗi nếu không tìm thấy
    }

}

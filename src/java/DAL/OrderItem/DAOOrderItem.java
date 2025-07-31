package DAL.OrderItem;

import DAL.Order.*;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import DAL.DAO;
import DAL.User.UserProcess;
import Models.Order;
import Models.OrderItem;
import Models.ProductVariants;
import Models.Products;

/**
 *
 * @author ADMIN
 */
public class DAOOrderItem extends DAO {

    public void insertOrderItemsFromCart(int userId, int orderId) throws SQLException {
        String selectCartQuery = """
        SELECT c.VariantID, c.Quantity, p.Price, p.Discount
        FROM Carts c
        JOIN ProductVariants pv ON c.VariantID = pv.VariantID
        JOIN Products p ON pv.ProductID = p.ProductID
        WHERE c.UserID = ?
    """;

        String insertOrderItemQuery = """
        INSERT INTO OrderItems (OrderID, VariantID, Quantity, PriceAtPurchase)
        VALUES (?, ?, ?, ?)
    """;

        try (
                PreparedStatement selectStmt = connection.prepareStatement(selectCartQuery); PreparedStatement insertStmt = connection.prepareStatement(insertOrderItemQuery)) {
            selectStmt.setInt(1, userId);
            ResultSet rs = selectStmt.executeQuery();

            while (rs.next()) {
                int variantId = rs.getInt("VariantID");
                int quantity = rs.getInt("Quantity");
                int price = rs.getInt("Price");
                float discount = rs.getFloat("Discount");

                // Tính giá sau giảm
                int finalPrice = Math.round(price * (1 - discount));

                insertStmt.setInt(1, orderId);
                insertStmt.setInt(2, variantId);
                insertStmt.setInt(3, quantity);
                insertStmt.setInt(4, finalPrice);
                insertStmt.addBatch(); // Thêm vào batch
            }

            insertStmt.executeBatch(); // Thực hiện tất cả INSERT
        }
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        String sql = """
        SELECT 
            oi.OrderItemID,
            oi.Quantity,
            oi.PriceAtPurchase,
            
            pv.VariantID,
            
            p.ProductID,
            p.Name AS ProductName,
            
            o.OrderID
        FROM OrderItems oi
        JOIN ProductVariants pv ON oi.VariantID = pv.VariantID
        JOIN Products p ON pv.ProductID = p.ProductID
        JOIN Orders o ON oi.OrderID = o.OrderID
        WHERE oi.OrderID = ?
    """;

        List<OrderItem> list = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Tạo Order
                Order order = new Order();
                order.setId(rs.getInt("OrderID"));

                // Tạo ProductVariants
                ProductVariants pv = new ProductVariants();
                pv.setVariantId(rs.getInt("VariantID"));

                // Tạo Product (chỉ dùng tên và ID)
                Products product = new Products();
                product.setId(rs.getInt("ProductID"));
                product.setName(rs.getString("ProductName"));

                // Tạo OrderItem
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("OrderItemID"));
                item.setOrder(order);
                item.setProductVariants(pv);
                item.setProducts(product); // gán product vào item
                item.setQuantity(rs.getInt("Quantity"));
                item.setPriceAtPurchase(rs.getInt("PriceAtPurchase"));

                list.add(item);
            }
        }

        return list;
    }
    
}

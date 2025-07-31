package DAL.Products;

import DAL.DAO;
import Models.*;
import java.sql.*;
import java.util.*;

public class DAOCart extends DAO {

    public List<Cart> getCartByUser(int userId) {
        List<Cart> list = new ArrayList<>();
        String sql = """
            SELECT c.CartID, c.UserID, c.VariantID, c.Quantity,
                   pv.Size, pv.Color,
                   p.ProductID, p.Name AS ProductName, p.Price, p.Description, p.Discount,
                   (SELECT TOP 1 ImageURL FROM ProductImages WHERE ProductID = p.ProductID) AS ImageURL
            FROM Carts c
            JOIN ProductVariants pv ON c.VariantID = pv.VariantID
            JOIN Products p ON pv.ProductID = p.ProductID
            WHERE c.UserID = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setId(rs.getInt("ProductID"));
                p.setName(rs.getString("ProductName"));
                p.setPrice(rs.getInt("Price"));
                p.setDescription(rs.getString("Description"));
                p.setDiscount(rs.getDouble("Discount"));
                List<String> images = new ArrayList<>();
                images.add(rs.getString("ImageURL"));
                p.setImageUrls(images);

                ProductVariants variant = new ProductVariants();
                variant.setVariantId(rs.getInt("VariantID"));
                variant.setSize(rs.getString("Size"));
                variant.setColor(rs.getString("Color"));
                variant.setProduct(p);

                Cart cart = new Cart();
                cart.setId(rs.getInt("CartID"));
                User user = new User();
                user.setId(userId);
                cart.setUser(user);
                cart.setVariant(variant);
                cart.setQuantity(rs.getInt("Quantity"));

                list.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getQuantity(int userId, int variantId) {
        String sql = "SELECT Quantity FROM Carts WHERE UserID = ? AND VariantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Quantity");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean addOrUpdateCartItem(int userId, int variantId, int quantity) {
        String checkSql = "SELECT Quantity FROM Carts WHERE UserID = ? AND VariantID = ?";
        String updateSql = "UPDATE Carts SET Quantity = ? WHERE UserID = ? AND VariantID = ?";
        String insertSql = "INSERT INTO Carts (UserID, VariantID, Quantity) VALUES (?, ?, ?)";

        try (PreparedStatement checkPs = connection.prepareStatement(checkSql)) {
            checkPs.setInt(1, userId);
            checkPs.setInt(2, variantId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                int currentQty = rs.getInt("Quantity");
                int newQty = currentQty + quantity;

                try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                    updatePs.setInt(1, newQty);
                    updatePs.setInt(2, userId);
                    updatePs.setInt(3, variantId);
                    return updatePs.executeUpdate() > 0;
                }

            } else {
                try (PreparedStatement insertPs = connection.prepareStatement(insertSql)) {
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, variantId);
                    insertPs.setInt(3, quantity);
                    return insertPs.executeUpdate() > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCartItem(int userId, int variantId, int newQty) {
        String sql = "UPDATE Carts SET Quantity = ? WHERE UserID = ? AND VariantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newQty);
            ps.setInt(2, userId);
            ps.setInt(3, variantId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromCart(int userId, int variantId) {
        String sql = "DELETE FROM Carts WHERE UserID = ? AND VariantID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, variantId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int removeCart(int userId) {

        String sql = "DELETE FROM Carts WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int a = ps.executeUpdate();
            return a;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}

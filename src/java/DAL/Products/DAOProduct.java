package DAL.Products;

import DAL.DAO;
import Models.Category;
import Models.Products;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOProduct extends DAO {

    public void insertProduct(Products product) {
        String insertProductSql = "INSERT INTO Products (Name, Description, Price, Discount, CategoryID) VALUES (?, ?, ?, ?, ?)";
        String insertImageSql = "INSERT INTO ProductImages (ProductID, ImageURL) VALUES (?, ?)";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(insertProductSql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getPrice());
            ps.setDouble(4, product.getDiscount());
            ps.setInt(5, product.getCategory().getId());

            ps.executeUpdate();

            // Lấy ID sản phẩm vừa thêm
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int productId = rs.getInt(1);

                // Lưu danh sách ảnh
                if (product.getImageUrls() != null && !product.getImageUrls().isEmpty()) {
                    PreparedStatement psImg = conn.prepareStatement(insertImageSql);
                    for (String url : product.getImageUrls()) {
                        psImg.setInt(1, productId);
                        psImg.setString(2, url);
                        psImg.addBatch();
                    }
                    psImg.executeBatch();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        String sql = """
            SELECT p.*, c.Name as CategoryName
                        FROM Products p
                        JOIN Categories c ON p.CategoryID = c.CategoryID
                        ORDER BY p.createdAt DESC
        """;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                String name = rs.getString("name");
                String description = rs.getString("description");
                int price = rs.getInt("price");
                double discount = rs.getDouble("discount");
                Date createdAt = rs.getDate("createdAt");

                int categoryId = rs.getInt("CategoryID");
                String categoryName = rs.getString("categoryName");
                Category category = new Category(categoryId, categoryName);

                // Lấy danh sách ảnh
                List<String> imageUrls = getImagesForProduct(productId);

                Products product = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, Name FROM Categories";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("CategoryID");
                String name = rs.getString("Name");
                categories.add(new Category(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public void updateProduct(Products product) {
        String sql = "UPDATE Products SET Name = ?, Description = ?, Price = ?, Discount = ?, CategoryID = ? WHERE ProductID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setInt(3, product.getPrice());
            stmt.setDouble(4, product.getDiscount());
            stmt.setInt(5, product.getCategory().getId());
            stmt.setInt(6, product.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProductImages(int productId, List<String> imageUrls) {
        String deleteSQL = "DELETE FROM ProductImages WHERE ProductID = ?";
        String insertSQL = "INSERT INTO ProductImages (ProductID, ImageUrl) VALUES (?, ?)";
        try {
            connection.setAutoCommit(false);
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSQL)) {
                deleteStmt.setInt(1, productId);
                deleteStmt.executeUpdate();
            }
            try (PreparedStatement insertStmt = connection.prepareStatement(insertSQL)) {
                for (String url : imageUrls) {
                    insertStmt.setInt(1, productId);
                    insertStmt.setString(2, url);
                    insertStmt.addBatch();
                }
                insertStmt.executeBatch();
            }
            connection.commit();
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollEx) {
                rollEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    private List<String> getProductImages(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT ImageUrl FROM ProductImages WHERE ProductID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("ImageUrl"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public boolean deleteProductById(int id) {
        try {
            // 1. Xóa ảnh liên quan trong bảng ProductImages
            String sqlDeleteImages = "DELETE FROM ProductImages WHERE ProductID = ?";
            PreparedStatement stmtImages = connection.prepareStatement(sqlDeleteImages);
            stmtImages.setInt(1, id);
            stmtImages.executeUpdate();

            // 2. Xóa sản phẩm
            String sqlDeleteProduct = "DELETE FROM Products WHERE ProductID = ?";
            PreparedStatement stmtProduct = connection.prepareStatement(sqlDeleteProduct);
            stmtProduct.setInt(1, id);
            int rowsDeleted = stmtProduct.executeUpdate();

            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Products getProductById(int productId) {
        Products product = null;
        String sql = """
        SELECT p.ProductID, p.name, p.description, p.price, p.discount, p.createdAt,
               c.CategoryID AS CategoryID, c.name AS categoryName
        FROM Products p
        JOIN Categories c ON p.CategoryID = c.CategoryID
        WHERE p.ProductID = ?
    """;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("productId");
                String name = rs.getString("name");
                String description = rs.getString("description");
                int price = rs.getInt("price");
                double discount = rs.getDouble("discount");
                Date createdAt = rs.getDate("createdAt");
                int categoryId = rs.getInt("categoryId");
                String categoryName = rs.getString("categoryName");
                // Lấy danh sách ảnh
                List<String> imageUrls = getImagesForProduct(productId);
                Category category = new Category(categoryId, categoryName);
                product = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);

                // Thêm danh sách ảnh
                product.setImageUrls(getImagesForProduct(productId));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return product;
    }

    public List<String> getImagesForProduct(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT ImageURL FROM ProductImages WHERE ProductID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("ImageURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public List<Products> getProductsByPage(int page, int pageSize, String searchKeyword) {
        List<Products> products = new ArrayList<>();
        String sql = """
            SELECT p.ProductID AS productId, p.name, p.description, p.price, p.discount,
                   p.createdAt,
                   c.CategoryID AS CategoryID, c.name AS categoryName
            FROM Products p
            JOIN Categories c ON p.CategoryID = c.CategoryID
            WHERE p.name LIKE ?
            ORDER BY p.createdAt DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
        """;

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + searchKeyword + "%");
            statement.setInt(2, (page - 1) * pageSize);
            statement.setInt(3, pageSize);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("productId");
                String name = rs.getString("name");
                String description = rs.getString("description");
                int price = rs.getInt("price");
                double discount = rs.getDouble("discount");
                Date createdAt = rs.getDate("createdAt");

                int categoryId = rs.getInt("categoryId");
                String categoryName = rs.getString("categoryName");
                Category category = new Category(categoryId, categoryName);

                List<String> imageUrls = getImagesForProduct(productId);

                Products pro = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);
                products.add(pro);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return products;
    }

    public static void main(String[] args) {
        DAOProduct dao = new DAOProduct();

        int testProductId = 15; // ID của sản phẩm bạn muốn thử xóa (đảm bảo tồn tại trong DB)

        boolean result = dao.deleteProductById(testProductId);

        if (result) {
            System.out.println("✅ Product deleted successfully.");
        } else {
            System.out.println("❌ Failed to delete product. Check if ID exists or SQL error.");
        }

//        int testProductId = 1; // Thay đổi ID theo dữ liệu của bạn
//        Products product = dao.getProductById(testProductId);
//
//        if (product != null) {
//            System.out.println("ID: " + product.getId());
//            System.out.println("Name: " + product.getName());
//            System.out.println("Description: " + product.getDescription());
//            System.out.println("Price: " + product.getPrice());
//            System.out.println("Discount: " + product.getDiscount());
//            System.out.println("Category: " + product.getCategory().getName());
//            System.out.println("Created At: " + product.getCreatedAt());
//
//            System.out.println("Image URLs:");
//            for (String img : product.getImageUrls()) {
//                System.out.println(" - " + img);
//            }
//        } else {
//            System.out.println("Product not found with ID = " + testProductId);
//        }
    }
}

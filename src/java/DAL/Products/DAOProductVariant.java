package DAL.Products;

import DAL.DAO;
import Models.Category;
import Models.ProductVariants;
import Models.Products;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOProductVariant extends DAO {

    DAOProduct _DAOProduct = new DAOProduct();

    //get all 
    public List<ProductVariants> getAllProductVariant() {
        List<ProductVariants> variants = new ArrayList<>();
        String sql = "SELECT VariantID, ProductID, Color, Size, Quantity FROM ProductVariants ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("VariantID");
                int productId = rs.getInt("ProductID");
                Products products = _DAOProduct.getProductById(productId);
                String color = rs.getString("Color");
                String size = rs.getString("Size");
                int quantity = rs.getInt("Quantity");
                variants.add(new ProductVariants(id, products, color, size, quantity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    public List<String> getColorFromProducId(int id) {
        List<String> colorList = new ArrayList<>();
        String sql = "SELECT DISTINCT Color FROM ProductVariants WHERE ProductID = ?";

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                colorList.add(rs.getString("Color"));
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Bạn có thể thay bằng ghi log hoặc throw exception tùy theo quy ước dự án
        }

        return colorList;
    }

    public List<String> getSizeFromProducId(int id) {
        List<String> colorList = new ArrayList<>();
        String sql = "SELECT DISTINCT SIZE FROM ProductVariants WHERE ProductID = ?";

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                colorList.add(rs.getString("Size"));
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Bạn có thể thay bằng ghi log hoặc throw exception tùy theo quy ước dự án
        }

        return colorList;
    }

    // get theo page
    public List<ProductVariants> getProductVariantsByPage(int page, int pageSize, String searchKeyword) {
        List<ProductVariants> variants = new ArrayList<>();

        String sql = """
        SELECT v.VariantID AS variantId, v.size, v.color, v.quantity,
               p.ProductID AS productId, p.name, p.description, p.price, p.discount, p.createdAt,
               c.CategoryID AS categoryId, c.name AS categoryName
        FROM ProductVariants v
        JOIN Products p ON v.ProductID = p.ProductID
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
                // Thông tin sản phẩm
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
                Products product = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);

                // Thông tin biến thể
                int variantId = rs.getInt("variantId");
                String size = rs.getString("size");
                String color = rs.getString("color");
                int quantity = rs.getInt("quantity");

                ProductVariants variant = new ProductVariants(variantId, product, size, color, quantity);
                variants.add(variant);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return variants;
    }

    //lấy sản phẩm theo id
    public List<ProductVariants> getVariantsByProductId(int productId) {
        List<ProductVariants> variants = new ArrayList<>();
        String sql = "SELECT VariantID, ProductID, Color, Size, Quantity FROM ProductVariants WHERE ProductID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductVariants variant = new ProductVariants();
                variant.setVariantId(rs.getInt("VariantID"));
                variant.setColor(rs.getString("Color"));
                variant.setSize(rs.getString("Size"));
                variant.setQuantity(rs.getInt("Quantity"));

                // Lấy thông tin sản phẩm chính
                DAOProduct daoProduct = new DAOProduct();
                Products product = daoProduct.getProductById(productId);
                variant.setProduct(product);

                variants.add(variant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    //giảm sản phẩm trong cart
    public void decreaseVariantQuantity(int variantId) throws SQLException {
        String sql = "UPDATE ProductVariants SET Quantity = Quantity - 1 WHERE VariantID = ? AND Quantity > 0";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, variantId);
            stmt.executeUpdate();
        }
    }

    //lấy theo id và size color
    public int getVariantIdsByProductIdAndSC(int productId, String size, String color) {
        int variantIds = 0;
        String sql = "SELECT VariantID FROM ProductVariants WHERE ProductID = ? AND Color = ? AND Size = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setString(2, color);
            stmt.setString(3, size);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("VariantID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return variantIds;
    }

    //tăng sản phẩm trong cart
    public void increaseVariantQuantity(int variantId) throws SQLException {
        String sql = "UPDATE ProductVariants SET Quantity = Quantity + 1 WHERE VariantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, variantId);
            stmt.executeUpdate();
        }
    }

    //thêm sản phẩm 
    public void insertProductVariant(ProductVariants productVanriants) {
        String insertProductSql = "INSERT INTO ProductVariants (ProductID, Color, Size, Quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(insertProductSql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, productVanriants.getProduct().getId());
            ps.setString(2, productVanriants.getColor());
            ps.setString(3, productVanriants.getSize());
            ps.setInt(4, productVanriants.getQuantity());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //cập nhật
    public void updateProductVariant(ProductVariants productVariants) {
        String sql = "UPDATE ProductVariants SET ProductID = ?, Color = ?, Size = ?, Quantity = ? WHERE VariantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productVariants.getProduct().getId());
            stmt.setString(2, productVariants.getColor());
            stmt.setString(3, productVariants.getSize());
            stmt.setInt(4, productVariants.getQuantity());
            stmt.setInt(5, productVariants.getVariantId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //  Xóa sản phẩm
    public boolean deleteProductVariantById(int id) {
        try {
            String sqlDeleteProductVariant = "DELETE FROM ProductVariants WHERE VariantID = ?";
            PreparedStatement stmtProduct = connection.prepareStatement(sqlDeleteProductVariant);
            stmtProduct.setInt(1, id);
            int rowsDeleted = stmtProduct.executeUpdate();

            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //đếm số lượng sản phẩmproducvariantId
    public int getTotalQuantityByProductId(int producvariantId) {
        String sql = "SELECT Quantity FROM ProductVariants WHERE VariantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, producvariantId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("Quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<String> getImagesForProduct(int productId) {
        List<String> urls = new ArrayList<>();
        String sql = "SELECT imageUrl FROM ProductImages WHERE productId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                urls.add(rs.getString("imageUrl"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return urls;
    }

//    public Products getProductById(int productId) {
//        Products product = null;
//        String sql = """
//        SELECT p.ProductID, p.name, p.description, p.price, p.discount, p.createdAt,
//               c.CategoryID AS CategoryID, c.name AS categoryName
//        FROM Products p
//        JOIN Categories c ON p.CategoryID = c.CategoryID
//        WHERE p.ProductID = ?
//    """;
//
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, productId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                int id = rs.getInt("productId");
//                String name = rs.getString("name");
//                String description = rs.getString("description");
//                int price = rs.getInt("price");
//                double discount = rs.getDouble("discount");
//                Date createdAt = rs.getDate("createdAt");
//                int categoryId = rs.getInt("categoryId");
//                String categoryName = rs.getString("categoryName");
//                // Lấy danh sách ảnh
//                List<String> imageUrls = getImagesForProduct(productId);
//                Category category = new Category(categoryId, categoryName);
//                product = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);
//
//                // Thêm danh sách ảnh
//                product.setImageUrls(getImagesForProduct(productId));
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//
//        return product;
//    }
//
//    public List<String> getImagesForProduct(int productId) {
//        List<String> images = new ArrayList<>();
//        String sql = "SELECT ImageURL FROM ProductImages WHERE ProductID = ?";
//
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, productId);
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                images.add(rs.getString("ImageURL"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return images;
//    }
//
//    public List<Products> getProductsByPage(int page, int pageSize, String searchKeyword) {
//        List<Products> products = new ArrayList<>();
//        String sql = """
//            SELECT p.ProductID AS productId, p.name, p.description, p.price, p.discount,
//                   p.createdAt,
//                   c.CategoryID AS CategoryID, c.name AS categoryName
//            FROM Products p
//            JOIN Categories c ON p.CategoryID = c.CategoryID
//            WHERE p.name LIKE ?
//            ORDER BY p.createdAt DESC
//            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
//        """;
//
//        try (PreparedStatement statement = connection.prepareStatement(sql)) {
//            statement.setString(1, "%" + searchKeyword + "%");
//            statement.setInt(2, (page - 1) * pageSize);
//            statement.setInt(3, pageSize);
//            ResultSet rs = statement.executeQuery();
//
//            while (rs.next()) {
//                int productId = rs.getInt("productId");
//                String name = rs.getString("name");
//                String description = rs.getString("description");
//                int price = rs.getInt("price");
//                double discount = rs.getDouble("discount");
//                Date createdAt = rs.getDate("createdAt");
//
//                int categoryId = rs.getInt("categoryId");
//                String categoryName = rs.getString("categoryName");
//                Category category = new Category(categoryId, categoryName);
//
//                List<String> imageUrls = getImagesForProduct(productId);
//
//                Products pro = new Products(productId, name, description, price, discount, category, createdAt, imageUrls);
//                products.add(pro);
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return products;
    public static void main(String[] args) {

        DAOProductVariant testVariant = new DAOProductVariant();
        int testProductId = 1; // ID của sản phẩm test (đảm bảo tồn tại trong DB)

        System.out.println(testVariant.getTotalQuantityByProductId(testProductId));

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

package Controllers.User;

import DAL.Products.DAOCart;
import DAL.Products.DAOProduct;
import DAL.Products.DAOProductVariant;
import Models.Products;
import Models.ProductVariants;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "ProductDetail", urlPatterns = {"/productDetail"})
public class ProductDetail extends HttpServlet {

    DAOProductVariant _DAOProductVariant = new DAOProductVariant();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            DAOProduct dao = new DAOProduct();
            DAOProductVariant daopv = new DAOProductVariant();

            Products productDetail = dao.getProductById(productId);
            List<ProductVariants> productVariants = _DAOProductVariant.getVariantsByProductId(productId);
            List<String> colorList = daopv.getColorFromProducId(productId);
            List<String> sizeList = daopv.getSizeFromProducId(productId);
            
            if (productDetail != null) {
                request.setAttribute("product", productDetail);
                request.setAttribute("colorList", colorList);
                request.setAttribute("sizeList", sizeList);
                request.setAttribute("productVariants", productVariants);
                request.getRequestDispatcher("/Views/User/ProductDetail.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            int userId = ((User) session.getAttribute("user")).getId(); // ép kiểu nếu bạn có class User
            int productId = Integer.parseInt(request.getParameter("id"));
            String size = request.getParameter("braceletSize");
            String color = request.getParameter("braceletColor");

            // Lấy danh sách variant phù hợp với size và màu
            int variantId = _DAOProductVariant.getVariantIdsByProductIdAndSC(productId, size, color);

            if (variantId != 0) {
                int quantity = 1; // hoặc request.getParameter("quantity") nếu có

                // Thêm vào giỏ hàng
                DAOCart cartDAO = new DAOCart(); // khởi tạo DAO
                boolean added = cartDAO.addOrUpdateCartItem(userId, variantId, quantity);

                if (added) {
                    response.sendRedirect("./addToCart"); // hoặc show message thành công
                } else {
                    request.setAttribute("error", "Không thể thêm vào giỏ hàng.");
                    request.getRequestDispatcher("/Views/User/ProductDetail.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Không tìm thấy sản phẩm với size/màu đã chọn.");
                request.getRequestDispatcher("/Views/User/ProductDetail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server.");
        }
    }
}

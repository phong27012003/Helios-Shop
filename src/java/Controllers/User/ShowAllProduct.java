package Controllers.User;

import DAL.Products.DAOProduct;
import DAL.Products.DAOProductVariant;
import Models.ProductVariants;
import Models.Products;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ShowAllProduct", urlPatterns = {"/showAllProduct"})
public class ShowAllProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số từ URL
        String searchKeyword = request.getParameter("search");
        String pageStr = request.getParameter("page");
        String sizeStr = request.getParameter("size");
        DAOProductVariant dAOProductVariant = new DAOProductVariant();
        DAOProduct daoProduct = new DAOProduct();
        

        // Thiết lập giá trị mặc định nếu không có
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int pageSize = (sizeStr != null) ? Integer.parseInt(sizeStr) : 6;
        if (searchKeyword == null) {
            searchKeyword = "";
        }

        // Gọi DAL để lấy danh sách sản phẩm
        List<ProductVariants> productVariantList = dAOProductVariant.getProductVariantsByPage(page, pageSize, searchKeyword);
        List<Products> productList = daoProduct.getProductsByPage(page, pageSize, searchKeyword);


        // Gửi dữ liệu sang JSP
        request.setAttribute("products", productList);
        request.setAttribute("productVariant", productVariantList);
        request.setAttribute("currentPage", page);
        request.setAttribute("search", searchKeyword);
        request.getRequestDispatcher("/Views/User/ShowAllProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}

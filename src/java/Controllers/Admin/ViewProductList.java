package Controllers.Admin;

import DAL.Products.DAOProduct;
import Models.Products;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ViewProductList", urlPatterns = {"/viewProductList"})
public class ViewProductList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            // Lấy tham số từ URL
            String searchKeyword = request.getParameter("search");
            String pageStr = request.getParameter("page");
            String sizeStr = request.getParameter("size");
            DAOProduct daoProduct = new DAOProduct();

            // Thiết lập giá trị mặc định nếu không có
            int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
            int pageSize = (sizeStr != null) ? Integer.parseInt(sizeStr) : 6;
            if (searchKeyword == null) {
                searchKeyword = "";
            }

            // Gọi DAL để lấy danh sách sản phẩm
            List<Products> productList = daoProduct.getProductsByPage(page, pageSize, searchKeyword);

            // Gửi dữ liệu sang JSP
            request.setAttribute("products", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("search", searchKeyword);
            request.getRequestDispatcher("Views/Admin/AdminListProduct.jsp").forward(request, response);

        }
    }

}

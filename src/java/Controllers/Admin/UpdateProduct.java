package Controllers.Admin;

import DAL.Products.DAOProduct;
import Models.Category;
import Models.Products;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
@WebServlet(name = "UpdateProduct", urlPatterns = {"/updateProduct"})
public class UpdateProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        DAOProduct dao = new DAOProduct();
        Products product = dao.getProductById(productId);
        List<Category> categories = dao.getAllCategories(); // bạn cần có phương thức này
        request.setAttribute("categories", categories);

        request.setAttribute("product", product);
        request.getRequestDispatcher("Views/Admin/AdminUpdateProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        List<String> imageUrls = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads");
                File fileDir = new File(uploadPath);
                if (!fileDir.exists()) {
                    fileDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);

                imageUrls.add("uploads/" + fileName);
            }
        }

        Products product = new Products();
        product.setId(id);
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setDiscount(discount);
        product.setCategory(new Category(categoryId, ""));
        product.setImageUrls(imageUrls);

        DAOProduct dao = new DAOProduct();
        dao.updateProduct(product);
        dao.updateProductImages(id, imageUrls);
        response.sendRedirect("viewProductList");

    }
}

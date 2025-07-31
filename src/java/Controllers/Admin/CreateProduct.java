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
@WebServlet(name = "CreateProduct", urlPatterns = {"/createProduct"})
public class CreateProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOProduct dao = new DAOProduct();
        List<Category> categories = dao.getAllCategories(); // bạn cần có phương thức này
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("Views/Admin/AdminCreateProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        String categoryIdStr = request.getParameter("categoryId");
        if (categoryIdStr == null || categoryIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Category is required.");
            DAOProduct dao = new DAOProduct();
            List<Category> categories = dao.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("Views/Admin/AdminCreateProduct.jsp").forward(request, response);
            return;
        }
        int categoryId = Integer.parseInt(categoryIdStr);
        List<String> imageUrls = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);
                imageUrls.add("uploads/" + fileName);
            }
        }

        Products product = new Products();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setDiscount(discount);
        product.setCategory(new Category(categoryId, ""));
        product.setImageUrls(imageUrls);

        DAOProduct dao = new DAOProduct();
        dao.insertProduct(product);
        System.out.println("Name: " + request.getParameter("name"));
        System.out.println("Description: " + request.getParameter("description"));
        System.out.println("Price: " + request.getParameter("price"));
        System.out.println("Discount: " + request.getParameter("discount"));
        System.out.println("Category ID: " + request.getParameter("categoryId"));

        response.sendRedirect("viewProductList");
    }

}

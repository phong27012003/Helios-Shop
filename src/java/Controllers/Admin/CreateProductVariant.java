package Controllers.Admin;

import DAL.Products.DAOProduct;
import DAL.Products.DAOProductVariant;
import Models.Category;
import Models.ProductVariants;
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
@WebServlet(name = "CreateProductVariant", urlPatterns = {"/createProductVariant"})
public class CreateProductVariant extends HttpServlet {
    DAOProduct dAOProduct = new DAOProduct();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Products> products = dAOProduct.getAllProducts(); // bạn cần có phương thức này
        request.setAttribute("products", products);
        request.getRequestDispatcher("Views/Admin/AdminCreateProductVariant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String color = request.getParameter("color");
        int ProductID = Integer.parseInt(request.getParameter("ProductID"));
        Products products = dAOProduct.getProductById(ProductID);
        String size = request.getParameter("size");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        ProductVariants productVariants = new ProductVariants();
        productVariants.setProduct(products);
        productVariants.setColor(color);
        productVariants.setSize(size);
        productVariants.setQuantity(quantity);

        DAOProductVariant dAOProductVariant = new DAOProductVariant();
        dAOProductVariant.insertProductVariant(productVariants);
//        System.out.println("Name: " + request.getParameter("name"));
//        System.out.println("Description: " + request.getParameter("description"));
//        System.out.println("Price: " + request.getParameter("price"));
//        System.out.println("Discount: " + request.getParameter("discount"));
//        System.out.println("Category ID: " + request.getParameter("categoryId"));

        response.sendRedirect("viewProductVariantList");
    }

}

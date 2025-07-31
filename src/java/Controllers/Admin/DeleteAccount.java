package Controllers.Admin;

import DAL.Admin.ManageAccount;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteAccount", urlPatterns = {"/deleteAccount"})
public class DeleteAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Check Session 
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        // Retrieve the account ID from the request parameter
        String idStr = request.getParameter("id");

        // Check if the ID exists in the request
        if (idStr != null) {
            try {
                // Convert the ID to an integer
                int id = Integer.parseInt(idStr);

                // Call the method to delete the account from ManageAccount
                ManageAccount managerAcc = new ManageAccount();
                boolean result = managerAcc.deleteAccountById(id); // Boolean result to check if deletion is successful

                if (result) {
                    // If deletion is successful, redirect back to the account list
                    response.sendRedirect("ViewAccountList");
                } else {
                    // If deletion fails, set an error message and forward to the error page
                    request.setAttribute("error", "Failed to delete account.");
                    request.getRequestDispatcher("Views/Admin/error.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                // If the account ID is invalid (not an integer), forward to the error page
                request.setAttribute("error", "Invalid account ID.");
                request.getRequestDispatcher("Views/Admin/error.jsp").forward(request, response);
            }
        } else {
            // If the ID is missing from the request, set an error message and forward to the error page
            request.setAttribute("error", "Account ID is missing.");
            request.getRequestDispatcher("Views/Admin/error.jsp").forward(request, response);
        }
    }
}

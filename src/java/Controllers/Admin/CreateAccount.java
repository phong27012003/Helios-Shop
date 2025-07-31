/*
 * Copyright(C) 2024, Group2-SE1866-KS.
 * CREATEACCOUNT.JAVA:
 *  FU House Finder
 * Record of change:
 * DATE            Version             AUTHOR           DESCRIPTION
 * 2024-09-26       1.0                PhongNN          Create Account for Staff
 */
package Controllers.Admin;

import DAL.Admin.ManageAccount;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;
import java.util.logging.Logger;


@WebServlet(name = "CreateAccount", urlPatterns = {"/createAccount"})
public class CreateAccount extends HttpServlet {

    // Regular expression to validate basic email format
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    // Regular expression to check specific email format 
    private static final String Phone_Regex = "^[0-9]{10,12}$";
    // Logger to log any issues or important information
    private static final Logger LOGGER = Logger.getLogger(CreateAccount.class.getName());


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Check Session
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        // Forward the request to the account creation JSP
        request.getRequestDispatcher("Views/Admin/AdminCreateAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Check Session
        if (request.getSession(false) == null || request.getSession().getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        // Retrieve form data from the HTML form
        String fullName = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Initialize error and success messages
        String errorFullName = "";
        String errorPassword = "";
        String errorConfirmPassword = "";
        String errorEmail = "";
        String errorPhoneNumber = "";
        String errorAddress = "";
        String successMessage = "";

        // Flag to check if there is any error
        boolean hasError = false;

        // Validate the username
        if (fullName == null || fullName.trim().isEmpty()) {
            errorFullName = "Full Name don't empty!";
            hasError = true;
        } else if (fullName.length() > 50) {
            errorFullName = "Full Name must be at least 50 characters";
            hasError = true;
        }

        if (phone == null || phone.trim().isEmpty()) {
            errorPhoneNumber = "Phone Number don't empty!";
            hasError = true;
        } else if (!Pattern.matches(Phone_Regex, phone)) {
            errorPhoneNumber = "Phone Number format is invalid!";
            hasError = true;
        }
        // Validate the password and confirm password
        if (password == null || password.isEmpty()) {
            errorPassword = "Password can't be empty!";
            hasError = true;
        } else if (!password.equals(confirmPassword)) {
            errorPassword = "Password don't match!";
            hasError = true;
        } else if (password.length() < 8 || !Pattern.compile("[A-Za-z]").matcher(password).find()
                || !Pattern.compile("[0-9]").matcher(password).find()) {
            errorPassword = "Password must be at least 8 characters and include both letters and numbers.";
            hasError = true;
        }

        if (confirmPassword == null || confirmPassword.isEmpty()) {
            errorConfirmPassword = "ConfirmPassword can't be empty";
            hasError = true;
        }

        if (address == null || address.trim().isEmpty()) {
            errorAddress = "Address don't empty!";
            hasError = true;
        } else if (address.length() > 255) {
            errorAddress = "Address must be at least 255 characters.";
            hasError = true;
        }

        // Validate the email format
        if (email == null || email.trim().isEmpty()) {
            errorEmail = "Email can't be empty!";
            hasError = true;
        } else if (!Pattern.matches(EMAIL_REGEX, email)) {
            errorEmail = "Email format is invalid!";
            hasError = true;
        }

        // Optionally, you can add more validation for address, phone, etc.
        // If there is no error, proceed to create a new account
        if (!hasError) {
            // Create a new User object
            User user = new User();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPassword(password); // Assuming ManageAccount handles password encryption
            user.setPhone(phone);
            user.setRoleID(4); // Set role ID based on requirement
            user.setStatus(1); // Set status ID as active (1)
            user.setAddress(address);
            user.setCreatedAt(new java.util.Date()); // Set the account creation date

            // Insert the new account into the database
            ManageAccount manageAccount = new ManageAccount();

            if (manageAccount.checkUserPhoneNumber(phone)) {
                errorPhoneNumber = "Phone number already exists! Please use a different phone number.";
            } else {
                int rowsAffected = manageAccount.insertAccount(user); // Returns the number of affected rows

                if (rowsAffected > 0) {
                    successMessage = "Create account successfully!. Back to "
                            + "<span>"
                            + "<a href = 'viewAccountList' style='font-size: 15px; text-decoration: none'>ListAccount</a>"
                            + "</span>";
                } else {
                    // If insertion fails
                    errorPassword = "Unable to create account, Please try again!";
                }
            }
        }
        // Set the attributes to be used in the JSP
        request.setAttribute("successMessage", successMessage);
        request.setAttribute("errorFullName", errorFullName);
        request.setAttribute("errorPassword", errorPassword);
        request.setAttribute("errorEmail", errorEmail);
        request.setAttribute("errorPhoneNumber", errorPhoneNumber);
        request.setAttribute("errorConfirmPassword", errorConfirmPassword);
        request.setAttribute("errorAddress", errorAddress);

        // Forward the request back to the account creation JSP
        request.getRequestDispatcher("Views/Admin/AdminCreateAccount.jsp").forward(request, response);
    }

}

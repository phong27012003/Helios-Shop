package Controllers.Admin;

import DAL.Admin.ManageAccount;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ViewAccountList", urlPatterns = {"/ViewAccountList"})
public class ViewAccountList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Check Session
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            ManageAccount account = new ManageAccount();
            // Set the current page number and page size (number of accounts per page)
            int page = 1;
            int pageSize = 7;
            String searchKeyword = "";
            // Check if the "page" parameter is sent from the request, if so, convert it to an integer
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            //Check if the search parameter is sent from the request
            if (request.getParameter("search") != null) {
                searchKeyword = request.getParameter("search").trim();
            }
            // Get the total number of accounts from the database
            int totalAccount = account.getAccountCount(searchKeyword);
            // Calculate the total number of pages based on the total accounts and page size
            int totalPages = (int) Math.ceil((double) totalAccount / pageSize);
            // Retrieve the account list for the current page from the database
            List<User> listAcc = account.getAccountsByPage(page, pageSize, searchKeyword);

            // Set attributes to send to the JSP page
            request.setAttribute("listAcc", listAcc);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPage", totalPages);
            // Forward the request to the JSP page to display the account list
            request.getRequestDispatcher("Views/Admin/AdminListAccount.jsp").forward(request, response);
        }
    }
}

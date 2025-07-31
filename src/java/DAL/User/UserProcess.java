package DAL.User;

import DAL.DAO;
import Models.Category;
import Models.Products;
import Models.User;
import Validations.DataEncryptionSHA256;
import java.sql.*;
import java.util.List;
import java.util.Scanner;

public class UserProcess extends DAO {

    public static UserProcess INSTANCE = new UserProcess();

    public UserProcess() {
    }

    public void create(String fname, String lname, String email, String phone, String password) {
        String sql = "insert into [Users] ([FullName], [Email], [Phone], [Password], [Status], [RoleID]) values (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            System.out.println(fname + lname + ", " + email + ", " + phone + ", " + DataEncryptionSHA256.hashPassword(password));
            ps.setString(1, fname + " " + lname);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, DataEncryptionSHA256.hashPassword(password));
            ps.setString(5, "1");
            ps.setString(6, "2");
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("User registered successfully.");
            } else {
                System.out.println("User registration failed.");
            }
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
            status = e.getMessage();
        }
    }
    public User getUserById(int userId) {
        User user = new User();
        String sql = """
        SELECT * 
        FROM Users
        WHERE UserID = ?
    """;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int UserID = rs.getInt("UserID");
                String FullName = rs.getString("FullName");
                String Address = rs.getString("Address");
                String Phone = rs.getString("Phone");
                user.setId(UserID);
                user.setAddress(Address);
                user.setFullName(FullName);
                user.setPhone(Phone);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return user;
    }

    public static void main(String[] args) {
        // Tạo đối tượng Scanner để lấy dữ liệu từ người dùng
        Scanner scanner = new Scanner(System.in);

        // Nhập thông tin người dùng
        System.out.print("First name: ");
        String fname = scanner.nextLine();

        System.out.print("Last name: ");
        String lname = scanner.nextLine();

        System.out.print("Email: ");
        String email = scanner.nextLine();

        System.out.print("Phone: ");
        String phone = scanner.nextLine();

        System.out.print("Password: ");
        String password = scanner.nextLine();

        // Gọi phương thức create
        UserProcess.INSTANCE.create(fname, lname, email, phone, password);

        // Đóng Scanner
        scanner.close();
    }
}

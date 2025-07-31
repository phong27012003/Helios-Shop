package DAL.Login;

import DAL.DBContext;
import Models.User;
import Validations.DataEncryptionSHA256;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOLogin extends DBContext {

    public User loginUser(String userNameORemailOrPhone, String password) {
        String sql = "SELECT * FROM [Users] WHERE (UserName = ? OR Email = ? OR Phone = ?) AND [Password] = ?";
        User customer = null;

        try {
//            String hashedInputPassword = DataEncryptionSHA256.hashPassword(password);
            String hashedInputPassword = DataEncryptionSHA256.hashPassword(password);
            
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, userNameORemailOrPhone);
            statement.setString(2, userNameORemailOrPhone);
            statement.setString(3, userNameORemailOrPhone);
            statement.setString(4, hashedInputPassword);
            ResultSet rs = statement.executeQuery();

            // Kiểm tra nếu người dùng tồn tại với email đó
            if (rs.next()) {
                // Nếu tồn tại, hãy lấy thông tin người dùng
                customer = new User(rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getBoolean(9),
                        rs.getDate(10), rs.getInt(11), rs.getDate(12), rs.getDate(13));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOLogin.class.getName()).log(Level.SEVERE, null, ex);
        }

        return customer; // Trả về null nếu không có người dùng hoặc mật khẩu không hợp lệ
    }

    //test khi chưa có sign up
    public void saveUserPassword(String fullname, String email, String password, int sid, int roleId) {
        String sql = "INSERT INTO [Users] (FullName, Email, Password, StatusID, Roleid) VALUES (? ,?, ?, ?, ?)";
        try {
            // Tạo chuỗi dấu '*' với độ dài bằng mật khẩu
            String maskedPassword = "*".repeat(password.length());

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fullname);
            statement.setString(2, email);
            statement.setString(3, maskedPassword); // Lưu mật khẩu dưới dạng dấu '*'
            statement.setInt(4, sid);
            statement.setInt(5, roleId);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        DAOLogin daoLogin = new DAOLogin();

        // Sample input values for testing
        String userNameORemailOrPhone = "admin@helios.com";
        String password = "1";

        // Call the loginUser method
        User user = daoLogin.loginUser(userNameORemailOrPhone, password);

        // Check if the login was successful
        if (user != null) {
            System.out.println("Login successful! User details:");
            System.out.println("ID: " + user.getId());
            System.out.println("Name: " + user.getFullName());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Phone Number: " + user.getPhone());
            System.out.println(DataEncryptionSHA256.hashPassword("1"));
        } else {
            System.out.println("Login failed: Invalid email/phone or password.");
        }
    }
}

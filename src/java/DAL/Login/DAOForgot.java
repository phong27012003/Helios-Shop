package DAL.Login;

import DAL.DBContext;
import Models.User;
import Validations.DataEncryptionSHA256;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOForgot extends DBContext {

    public void changePassword(int id, String newPass) {
        String sql = "Update [Users] set [Password] = ? Where UserID = ?";

        try {
            // Hash the password before storing
            String hashedPassword = DataEncryptionSHA256.hashPassword(newPass);

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, hashedPassword);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOForgot.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User checkUsersForChangePass(String email) {
        String sql = "Select * from [Users] Where Email = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getString(8), rs.getBoolean(9),
                        rs.getDate(10), rs.getInt(11), rs.getDate(12), rs.getDate(13));
                return user;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOForgot.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {
        DAOForgot dao = new DAOForgot();
//        String email = "xuxumanh1@gmail.com";
//        dao.checkUsersForChangePass(email);
//        System.out.println(email);
        // Sample user ID and new password
        int userId = 2; // replace with the actual user ID you want to update
        String newPassword = "123"; // replace with the new password

        // Call the changePassword method
        dao.changePassword(userId, newPassword);

        System.out.println("Password updated successfully.");
    }
}

package DAL.Admin;

import DAL.DBContext;
import DAL.Login.DAOForgot;
import Models.User;
import Validations.DataEncryptionSHA256;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ManageAccount extends DBContext {

    public boolean checkUserPhoneNumber(String phone) {
        String sql = "Select * from [User] Where PhoneNumber = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, phone);
            ResultSet rs = statement.executeQuery();

            // Nếu có kết quả trả về từ database, tức là số điện thoại đã tồn tại
            return rs.next();

        } catch (SQLException ex) {
            Logger.getLogger(DAOForgot.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Nếu có lỗi hoặc không tìm thấy kết quả, trả về false
        return false;
    }

    public User getAccountById(int id) {
        User user = null;
        String sql = "SELECT * FROM [User] WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                String facebookUserid = rs.getString(2);
                String googleUserid = rs.getString(3);
                String username = rs.getString(4);
                String password = rs.getString(5);
                String email = rs.getString(6);
                String phone = rs.getString(7);
                Date dateOfBirth = rs.getDate(8);
                String address = rs.getString(9);
                int statusID = rs.getInt(10);
                int roleID = rs.getInt(11);
                String avatar = rs.getString(12);
                Date createdDate = rs.getDate(13);
                int roomHistoriesID = rs.getInt(14);

                user = new User(id, roleID, username, username, email, password, phone, address, Boolean.TRUE, dateOfBirth, statusID, createdDate, createdDate);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public int updateAccount(User student) {
        int updateAcc = 0;
        String sql = "UPDATE [dbo].[User]"
                + "   SET [FacebookUserId] = ?,[GoogleUserId] = ?,[FullName] = ?,[Email] = ?,[PhoneNumber] =?,[DateOfBirth] = ?,[Address] =?,"
                + "[StatusID] =?,[Roleid] = ?,[Avatar] = ?,[CreatedDate] = ?,[RoomHistoriesID] = ? WHERE ID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(3, student.getUserName());
            statement.setString(4, student.getEmail());
            statement.setString(5, student.getPhone());
            if (student.getDateOfBirth() != null) {
                statement.setDate(6, new java.sql.Date(student.getDateOfBirth().getTime()));
            } else {
                statement.setNull(6, java.sql.Types.DATE);
            }
            statement.setString(7, student.getAddress());
            statement.setInt(8, student.getStatus());
            statement.setInt(9, student.getRoleID());
            if (student.getCreatedAt() != null) {
                statement.setDate(11, new java.sql.Date(student.getCreatedAt().getTime()));
            } else {
                statement.setNull(11, java.sql.Types.DATE);
            }
            statement.setInt(13, student.getId());
            updateAcc = statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return updateAcc;
    }

    public boolean deleteAccountById(int id) {
        String sql = "DELETE FROM [Users] WHERE UserID = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0; // Trả về true nếu ít nhất một dòng bị xóa
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
            return false; // Trả về false nếu có lỗi
        }
    }

    public int insertAccount(User student) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[User] "
                + "([FacebookUserId], [GoogleUserId], [FullName], [Password], "
                + "[Email], [PhoneNumber], [DateOfBirth], [Address], "
                + "[StatusID], [Roleid], [Avatar], [CreatedDate], [RoomHistoriesID]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement prestate = null;
        try {
            // Kiểm tra kết nối
            if (connection == null || connection.isClosed()) {
                throw new SQLException("Database connection is not available.");
            }

            // Băm mật khẩu 
            String hashedPassword = DataEncryptionSHA256.hashPassword(student.getPassword());

            prestate = connection.prepareStatement(sql);
            prestate.setString(3, student.getUserName());
            prestate.setString(4, hashedPassword);  // Sử dụng mật khẩu đã băm
            prestate.setString(5, student.getEmail());
            prestate.setString(6, student.getPhone());

            // Chuyển đổi java.util.Date sang java.sql.Date
            if (student.getDateOfBirth() != null) {
                prestate.setDate(7, new java.sql.Date(student.getDateOfBirth().getTime()));
            } else {
                prestate.setNull(7, java.sql.Types.DATE);
            }

            prestate.setString(8, student.getAddress());
            prestate.setInt(9, student.getStatus());
            prestate.setInt(10, student.getRoleID());
            prestate.setDate(12, new java.sql.Date(student.getCreatedAt().getTime()));

            // Thực hiện lệnh insert
            n = prestate.executeUpdate();
        } catch (SQLException ex) {
            // Ghi chi tiết lỗi vào log
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, "Error inserting account: " + ex.getMessage(), ex);
        } finally {
            // Đóng PreparedStatement nếu không còn sử dụng
            if (prestate != null) {
                try {
                    prestate.close();
                } catch (SQLException e) {
                    Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, "Error closing PreparedStatement: " + e.getMessage(), e);
                }
            }
        }
        return n;
    }

    public int getAccountCount(String searchKeyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM [Users] Where RoleID = 2 AND FullName LIKE ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchKeyword + "%");
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<User> getAccountsByPage(int page, int pageSize, String searchKeyword) {
        List<User> accounts = new ArrayList<>();
        String sql = """
        SELECT 
            UserID, RoleID, UserName, FullName, Email, Password, 
            Phone, Address, Gender, DOB, Status, CreatedAt, UpdatedAt
        FROM Users
        WHERE RoleID = 2 AND FullName LIKE ?
        ORDER BY UserID
        OFFSET ? ROWS 
        FETCH NEXT ? ROWS ONLY;
    """;

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchKeyword + "%");
            statement.setInt(2, (page - 1) * pageSize);
            statement.setInt(3, pageSize);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                int userId = rs.getInt("UserID");
                int roleId = rs.getInt("RoleID");
                String userName = rs.getString("UserName");
                String fullName = rs.getString("FullName");
                String email = rs.getString("Email");
                String password = rs.getString("Password");
                String phone = rs.getString("Phone");
                String address = rs.getString("Address");
                boolean gender = rs.getBoolean("Gender");
                Date dob = rs.getDate("DOB");
                int status = rs.getInt("Status");
                Date createdAt = rs.getTimestamp("CreatedAt");
                Date updatedAt = rs.getTimestamp("UpdatedAt");

                User user = new User(userId, roleId, userName, fullName, email, password, phone, address, gender, dob, status, createdAt, updatedAt);
                accounts.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }

        return accounts;
    }

    public boolean checkOldPassword(int userId, String oldPassword) {
        String sql = "SELECT Password FROM [Users] WHERE UserID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userId);
            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("Password");

                String hashedOldPassword = DataEncryptionSHA256.hashPassword(oldPassword);

                return storedHashedPassword.equals(hashedOldPassword);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int changePassword(User user) {
        int n = 0;
        String sql = "UPDATE [dbo].[Users] SET [Password] = ? WHERE [UserID] = ?";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            String hashPassword = DataEncryptionSHA256.hashPassword(user.getPassword());
            pre.setString(1, hashPassword);
            pre.setInt(2, user.getId());

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ManageAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public static void main(String[] args) {
        ManageAccount manageAccount = new ManageAccount();
        List<User> user = manageAccount.getAccountsByPage(1, 6, "");
        for (User u : user) {
            System.out.println(u);
        }
//        User test = new User();
//        test.setId(19);
//        test.setFullName("Phong Nam");
//        test.setEmail("phongnnhe176274@fpt.edu.vn");
//        test.setPhone("0398601399");
//        test.setAddress("Hà Nội");
//        test.setStatus(1);
//        test.setRoleID(1);
//        int result = manageAccount.updateAccount(test);
//        if (result > 0) {
//            System.out.println("thành công");
//        } else {
//            System.out.println("thất bại ");
//        }
    }

}

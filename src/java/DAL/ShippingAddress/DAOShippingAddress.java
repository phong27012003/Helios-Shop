package DAL.ShippingAddress;

import DAL.Products.*;
import DAL.DAO;
import Models.Category;
import Models.ShippingAddress;
import Models.Products;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOShippingAddress extends DAO {

    public int getExistingShippingAddressId(ShippingAddress shippingAddress) {
        String sql = "SELECT AddressID FROM ShippingAddresses WHERE UserID = ? AND Address = ? AND Phone = ? AND ReceiverName = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, shippingAddress.getUser().getId());
            ps.setString(2, shippingAddress.getAddress());
            ps.setString(3, shippingAddress.getPhone());
            ps.setString(4, shippingAddress.getReceiverName());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("AddressID"); // Địa chỉ đã tồn tại
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0; // Không tìm thấy địa chỉ
    }

    public int insertShippingAddress(ShippingAddress shippingAddress) {
        String sql = "INSERT INTO ShippingAddresses (UserID, Address, Phone, ReceiverName) VALUES (?, ?, ?, ?)";

        try ( PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, shippingAddress.getUser().getId());
            ps.setString(2, shippingAddress.getAddress());
            ps.setString(3, shippingAddress.getPhone());
            ps.setString(4, shippingAddress.getReceiverName());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về AddressID vừa thêm
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1; // Thêm thất bại
    }

    public static void main(String[] args) {
        DAOShippingAddress dao = new DAOShippingAddress();

        int testProductId = 15; // ID của sản phẩm bạn muốn thử xóa (đảm bảo tồn tại trong DB)

        

    }
}

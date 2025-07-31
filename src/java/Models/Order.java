package Models;

import java.util.Date;

public class Order {

    private int id;
    private User user;
    private ShippingAddress shippingAddress;
    private int status; // 0 = pending, 1 = shipped, 2 = completed...
    private Date createdAt;
    private String address;
    private String phone;
    private String receiverName;
    

    public Order() {
    }

   

    public Order(int id, User user, ShippingAddress shippingAddress, int status, Date createdAt, String address, String phone, String receiverName) {
        this.id = id;
        this.user = user;
        this.shippingAddress = shippingAddress;
        this.status = status;
        this.createdAt = createdAt;
        this.address = address;
        this.phone = phone;
        this.receiverName = receiverName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public ShippingAddress getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(ShippingAddress shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

   

   

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", user=" + user + ", shippingAddress=" + shippingAddress + ", status=" + status + ", createdAt=" + createdAt + '}';
    }
}

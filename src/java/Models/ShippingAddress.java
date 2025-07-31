package Models;

public class ShippingAddress {

    private int id;
    private User user;
    private String address;
    private String phone;
    private String receiverName;

    public ShippingAddress() {
    }

    public ShippingAddress(int id, User user, String address, String phone, String receiverName) {
        this.id = id;
        this.user = user;
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

    @Override
    public String toString() {
        return "ShippingAddress{" + "id=" + id + ", user=" + user + ", address=" + address + ", phone=" + phone + ", receiverName=" + receiverName + '}';
    }
    
}

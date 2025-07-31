package Models;

public class Cart {

    private int id;
    private User user;
    private ProductVariants variant;
    private int quantity;

    public Cart() {
    }

    public Cart(int id, User user, ProductVariants variant, int quantity) {
        this.id = id;
        this.user = user;
        this.variant = variant;
        this.quantity = quantity;
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

    public ProductVariants getVariant() {
        return variant;
    }

    public void setVariant(ProductVariants variant) {
        this.variant = variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", user=" + user + ", variant=" + variant + ", quantity=" + quantity + '}';
    }

}

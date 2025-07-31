package Models;

public class ProductVariants {
    private int variantId; // Fixed typo: varianId -> variantId
    private Products product;
    private String size;
    private String color;
    private int quantity;

    // Default constructor
    public ProductVariants() {
    }

    // Parameterized constructor
    public ProductVariants(int variantId, Products product, String size, String color, int quantity) {
        this.variantId = variantId;
        this.product = product;
        this.size = size;
        this.color = color;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getVariantId() { 
        return variantId;
    }

    public void setVariantId(int variantId) { 
        this.variantId = variantId;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductVariants{" + 
               "variantId=" + variantId + 
               ", product=" + product + 
               ", size='" + size + '\'' + 
               ", color='" + color + '\'' + 
               ", quantity=" + quantity + 
               '}';
    }
}
    
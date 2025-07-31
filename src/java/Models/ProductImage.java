package Models;


public class ProductImage {
    private int id;
    private String imageUrl;
    private Products product;

    public ProductImage() {
    }

    public ProductImage(int id, String imageUrl, Products product) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.product = product;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "ProductImage{" + "id=" + id + ", imageUrl=" + imageUrl + ", product=" + product + '}';
    }
    
}

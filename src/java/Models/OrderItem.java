/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author This PC
 */
public class OrderItem {
    private int id;
    private Order order;
    private ProductVariants productVariants;
    private int quantity;
    private int priceAtPurchase;
    private Products products;

    public OrderItem() {
    }

    public OrderItem(int id, Order order, ProductVariants productVariants, int quantity, int priceAtPurchase,Products products) {
        this.id = id;
        this.order = order;
        this.productVariants = productVariants;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
        this.products = products;
    }

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public ProductVariants getProductVariants() {
        return productVariants;
    }

    public void setProductVariants(ProductVariants productVariants) {
        this.productVariants = productVariants;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPriceAtPurchase() {
        return priceAtPurchase;
    }

    public void setPriceAtPurchase(int priceAtPurchase) {
        this.priceAtPurchase = priceAtPurchase;
    }
     public String getProductName() {
        return (products != null) ? products.getName() : null;
    }
    
}

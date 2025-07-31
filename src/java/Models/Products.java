    package Models;

    import java.util.Date;
    import java.util.List;

    public class Products {
        private int id;
        private String name;
        private String description;
        private int price;
        private double discount;
        private double priceAfterdiscount;
        private Category category;
        private Date createdAt;
        private List<String> imageUrls;
        private List<ProductVariants> variants;

        // Default constructor
        public Products() {
        }

        // Parameterized constructor
        public Products(int id, String name, String description, int price, double discount, 
                       Category category, Date createdAt, List<String> imageUrls) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.price = price;
            this.discount = discount;
            this.category = category;
            this.createdAt = createdAt;
            this.imageUrls = imageUrls;
        }

        // Complete constructor with variants
        public Products(int id, String name, String description, int price, double discount, 
                       Category category, Date createdAt, List<String> imageUrls, 
                       List<ProductVariants> variants) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.price = price;
            this.discount = discount;
            this.category = category;
            this.createdAt = createdAt;
            this.imageUrls = imageUrls;
            this.variants = variants;
        }

        // Getters and Setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public int getPrice() {
            return price;
        }

        public void setPrice(int price) {
            this.price = price;
        }

        public double getDiscount() {
            return discount;
        }

        public void setDiscount(double discount) {
            this.discount = discount;
        }

        public Category getCategory() {
            return category;
        }

        public void setCategory(Category category) {
            this.category = category;
        }

        public Date getCreatedAt() {
            return createdAt;
        }

        public void setCreatedAt(Date createdAt) {
            this.createdAt = createdAt;
        }

        public List<String> getImageUrls() {
            return imageUrls;
        }

        public void setImageUrls(List<String> imageUrls) {
            this.imageUrls = imageUrls;
        }

        public List<ProductVariants> getVariants() {
            return variants;
        }

        public void setVariants(List<ProductVariants> variants) {
            this.variants = variants;
        }


        // Helper method to calculate discounted price
        public double getDiscountedPrice() {
            return price * (1 - discount);
        }

        @Override
        public String toString() {
            return "Products{" + 
                   "id=" + id + 
                   ", name='" + name + '\'' + 
                   ", description='" + description + '\'' + 
                   ", price=" + price + 
                   ", discount=" + discount + 
                   ", category=" + category + 
                   ", createdAt=" + createdAt + 
                   ", imageUrls=" + imageUrls + 
                   ", variants=" + variants + 
                   '}';
        }

    }
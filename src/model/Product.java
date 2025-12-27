package model;// Package for application model classes


// Model class for product data
public class Product {

    // Attributes
    private int productId;
    private int categoryId;
    private String name;
    private String description;
    private double price;
    private int stock;
    private String imageName;
    
    // Default constructor
    public Product() {}
    
    // Alternate constructor
    public Product(int productId, int categoryId, String name, String description, double price, int stock, String imageName) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imageName = imageName;
    }

    // Getter and Setter Methods
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productID) {
        this.productId = productID;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryID) {
        this.categoryId = categoryID;
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

    public void setDescription(String desc) {
        this.description = desc;
    }

    public double getPrice(){
    	
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String img) {
        this.imageName = img;
    }

    // toString method
    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", categoryId=" + categoryId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", imageName='" + imageName + '\'' +
                '}';
    }
}

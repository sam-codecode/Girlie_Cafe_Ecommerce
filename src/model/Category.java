package model;// Package for application model classes

// Model class for category data
public class Category {

    // Attributes
    private int categoryId;
    private String categoryName;
    private String description;
    private String imageName;
    
    // Default constructor
    public Category(){}
    
    public Category(int categoryId, String categoryName, String description, String imageName) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.imageName = imageName;
    }

    // Getter and Setter Methods
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int id) {
        this.categoryId = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String name) {
        this.categoryName = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String desc) {
        this.description = desc;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String img) {
        this.imageName = img;
    }

    // toString() method
    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                ", imageName='" + imageName + '\'' +
                '}';
    }

}

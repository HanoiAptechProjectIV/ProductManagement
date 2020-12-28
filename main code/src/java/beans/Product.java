/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.time.LocalDate;

/**
 *
 * @author Hung
 */
public class Product {
    private int id ,quantity, categoryId, brandId;
    private String name, description, image;
    private LocalDate dateAdded;
    private int price;
    private boolean disable;

    public Product() {
    }

    public Product(int id, int price, int quantity, int categoryId, int brandId
            , String name, String description, String image, LocalDate dateAdded, boolean disable) {
        this.id = id;
        this.quantity = quantity;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.name = name;
        this.description = description;
        this.image = image;
        this.dateAdded = dateAdded;
        this.price = price;
        this.disable = disable;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", quantity=" + quantity + ", categoryId=" + categoryId + ", brandId=" + brandId + ", name=" + name + ", description=" + description + ", image=" + image + ", dateAdded=" + dateAdded + ", price=" + price + '}';
    }

    public boolean isDisable() {
        return disable;
    }

    public void setDisable(boolean disable) {
        this.disable = disable;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public LocalDate getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(LocalDate dateAdded) {
        this.dateAdded = dateAdded;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    
    
}

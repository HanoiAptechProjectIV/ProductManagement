/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Hung
 */
public class OrderDetail {
    private int id, userId, orderId, productId, purchasedQuantity;

    public OrderDetail() {
    }

    public OrderDetail(int id, int userId, int orderId, int productId, int purchasedQuantity) {
        this.id = id;
        this.userId = userId;
        this.orderId = orderId;
        this.productId = productId;
        this.purchasedQuantity = purchasedQuantity;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "id=" + id + ", userId=" + userId + ", orderId=" + orderId + ", productId=" + productId + ", purchasedQuantity=" + purchasedQuantity + '}';
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getPurchasedQuantity() {
        return purchasedQuantity;
    }

    public void setPurchasedQuantity(int purchasedQuantity) {
        this.purchasedQuantity = purchasedQuantity;
    }
    
    
}

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
    private int id, orderId, productId, purchasedQuantity;
    private String status;

    public OrderDetail() {
    }

    public OrderDetail(int id, int orderId, int productId, int purchasedQuantity, String status) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.purchasedQuantity = purchasedQuantity;
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "id=" + id + ", orderId=" + orderId + ", productId=" + productId + ", purchasedQuantity=" + purchasedQuantity + ", status=" + status + '}';
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

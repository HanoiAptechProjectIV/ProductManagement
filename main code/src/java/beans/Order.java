/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.time.LocalDateTime;

/**
 *
 * @author Hung
 */
public class Order {
    private int id;
    private LocalDateTime createdTime, paymentTime;
    private int amount;
    private int userId;

    public Order() {
    }

    public Order(int id, LocalDateTime createdTime, LocalDateTime paymentTime, int amount, int userId) {
        this.id = id;
        this.createdTime = createdTime;
        this.paymentTime = paymentTime;
        this.amount = amount;
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", createdTime=" + createdTime + ", paymentTime=" + paymentTime + ", amount=" + amount + ", userId=" + userId + '}';
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDateTime getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(LocalDateTime createdTime) {
        this.createdTime = createdTime;
    }

    public LocalDateTime getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(LocalDateTime paymentTime) {
        this.paymentTime = paymentTime;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    
}

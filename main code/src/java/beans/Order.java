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
public class Order {
    private int id;
    private LocalDate createdDay;
    private int amount;

    public Order() {
    }

    public Order(int id, LocalDate createdDay, int amount) {
        this.id = id;
        this.createdDay = createdDay;
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", createdDay=" + createdDay + ", amount=" + amount + '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getCreatedDay() {
        return createdDay;
    }

    public void setCreatedDay(LocalDate createdDay) {
        this.createdDay = createdDay;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    
}

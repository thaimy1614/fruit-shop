/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Order {
    String username;
    int orderId;
    String name;
    String address;
    String phone;
    int quantity;
    float amount;
    String date;
    int status;
    String note;
    int pay;

    public Order() {
    }

//    public Order(String username, int orderId, String name, String address, String phone, int quantity, float amount, String date, int status, String note) {
//        this.username = username;
//        this.orderId = orderId;
//        this.name = name;
//        this.address = address;
//        this.phone = phone;
//        this.quantity = quantity;
//        this.amount = amount;
//        this.date = date;
//        this.status = status;
//        this.note = note;
//    }

    public Order(String username, int orderId, String name, String address, String phone, int quantity, float amount, String date, int status, String note, int pay) {
        this.username = username;
        this.orderId = orderId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.quantity = quantity;
        this.amount = amount;
        this.date = date;
        this.status = status;
        this.note = note;
        this.pay = pay;
    }

    public int getPay() {
        return pay;
    }

    public void setPay(int pay) {
        this.pay = pay;
    }
    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    
     
}

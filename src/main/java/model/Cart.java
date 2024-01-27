/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Cart {
//    SELECT TOP (1000) [username]
//      ,[pId]
//      ,[amout]
//      ,[status]
//      ,[cartID]
//  FROM [Fruit_Shop].[dbo].[Cart]

    private int pId;
    private String pname;
    private float price;
    private String img;
    private int quantity;
    private float amount;

    public Cart() {
    }

    public Cart(int pId, String pname, float price, String img, int quantity, float amount) {
        this.pId = pId;
        this.pname = pname;
        this.price = price;
        this.img = img;
        this.quantity = quantity;

        this.amount = amount;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
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

    @Override
    public String toString() {
        return "Cart{" + "pId=" + pId + ", pname=" + pname + ", price=" + price + ", img=" + img + ", quantity=" + quantity + ", amount=" + amount + '}';
    }

    

}

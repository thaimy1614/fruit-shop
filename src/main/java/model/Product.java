/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Product {

    private int pId;
    private String pName;
    private float pPrice;
    private String pimg;
    private String pDes;
    private int quantity;
    private String cname;
    private int cId;

    public Product() {
    }

    public Product(int pId, String pName, float pPrice, String pimg, String pDes,int quantity, String cname, int cId) {
        this.pId = pId;
        this.pName = pName;
        this.pPrice = pPrice;
        this.pimg = pimg;
        this.pDes = pDes;
        this.quantity = quantity;
        this.cname = cname;
        this.cId =  cId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public float getpPrice() {
        return pPrice;
    }

    public void setpPrice(float pPrice) {
        this.pPrice = pPrice;
    }

    public String getPimg() {
        return pimg;
    }

    public void setPimg(String pimg) {
        this.pimg = pimg;
    }

    public String getpDes() {
        return pDes;
    }

    public void setpDes(String pDes) {
        this.pDes = pDes;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public int getcId() {
        return cId;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }
    
    @Override
    public String toString() {
        return "Product{" + "pId=" + pId + ", pName=" + pName + ", pPrice=" + pPrice + ", pimg=" + pimg + ", pDes=" + pDes + ", cname=" + cname + '}';
    }
    
    

    
    
    
}

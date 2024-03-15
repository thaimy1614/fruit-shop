/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Duong Quoc Thai CE171563
 */
public class Category {
    private int cId;
    private String cName;

    public Category() {
    }

    public Category(int cId, String cName) {
        this.cId = cId;
        this.cName = cName;
    }
    
    

    public int getcId() {
        return cId;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }
    
    
}

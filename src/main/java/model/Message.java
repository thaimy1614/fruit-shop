/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author Duong Quoc Thai CE171563
 */
public class Message {
    private int id;
    private String username;
    private String message;
    private String img;
    private String response;
    private LocalDateTime dateMessage;
    private LocalDateTime dateResponse;

    public Message() {
    }
    
    

    public Message(int id, String username, String message, String img, String response, LocalDateTime dateMessage, LocalDateTime dateResponse) {
        this.id = id;
        this.username = username;
        this.message = message;
        this.img = img;
        this.response = response;
        this.dateMessage = dateMessage;
        this.dateResponse = dateResponse;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public LocalDateTime getDateMessage() {
        return dateMessage;
    }

    public void setDateMessage(LocalDateTime dateMessage) {
        this.dateMessage = dateMessage;
    }

    public LocalDateTime getDateResponse() {
        return dateResponse;
    }

    public void setDateResponse(LocalDateTime dateResponse) {
        this.dateResponse = dateResponse;
    }
    
    
}

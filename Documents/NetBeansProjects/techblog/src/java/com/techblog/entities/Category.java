
package com.techblog.entities;

public class Category {
    
    private int cId;
    private String cName;
    private String description;

    public Category(int cId, String cName, String description) {
        this.cId = cId;
        this.cName = cName;
        this.description = description;
    }

    public Category() {
    }

    public Category(String cName, String description) {
        this.cName = cName;
        this.description = description;
    }

    public int getcId() {
        return cId;
    }

    public String getcName() {
        return cName;
    }

    public String getDescription() {
        return description;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
    
    
    
    
    
}

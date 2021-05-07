package com.techblog.entities;

import java.sql.Timestamp;


public class Post {

    private int pId;
    private String pTitle;
    private String pContent;
    private String pCode;
    private String pPic;
    private Timestamp pDate;
    private int catId;
    private int userId;
    public Post() {
    }

    public Post(String pTitle, String pContent,String pCode, String pPic, Timestamp pDate, int catId,int userId) {
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode=pCode;
        this.pPic = pPic;
        this.pDate = pDate;
        this.catId = catId;
        this.userId=userId;
    }

    public Post(int pId, String pTitle, String pContent,String pCode, String pPic, Timestamp pDate, int catId,int userId) {
        this.pId = pId;
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode=pCode;
        this.pPic = pPic;
        this.pDate = pDate;
        this.catId = catId;
        this.userId=userId;
    }

    public int getpId() {
        return pId;
    }

    public String getpTitle() {
        return pTitle;
    }

    public String getpContent() {
        return pContent;
    }

    public String getpPic() {
        return pPic;
    }

    public Timestamp getpDate() {
        return pDate;
    }

    public int getCatId() {
        return catId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public void setpTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    public void setpContent(String pContent) {
        this.pContent = pContent;
    }

    public void setpPic(String pPic) {
        this.pPic = pPic;
    }

    public void setpDate(Timestamp pDate) {
        this.pDate = pDate;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
     
    
    
    
}

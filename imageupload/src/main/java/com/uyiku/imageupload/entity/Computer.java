package com.uyiku.imageupload.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Computer implements Serializable {
    private Integer id;
    private String name;
    private String image;
    private Double price;
    private String remark;
    private Date made_Date;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getMade_Date() {
        return made_Date;
    }

    public void setMade_Date(Date made_Date) {
        this.made_Date = made_Date;
    }

    @Override
    public String toString() {
        return "Computer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", image='" + image + '\'' +
                ", price=" + price +
                ", remark='" + remark + '\'' +
                ", made_Date=" + made_Date +
                '}';
    }
}

package com.bookstore.models;

public class Author extends BaseEntity {
    private String name;
    private String gender;
    private String imageUrl;
    private int age;

    public Author() {
        super();
    }

    public Author(String name, String gender, String imageUrl, int age) {
        super();
        this.name = name;
        this.gender = gender;
        this.imageUrl = imageUrl;
        this.age = age;
    }

    public Author(String id, String name, String gender, String imageUrl, int age) {
        super(id);
        this.name = name;
        this.gender = gender;
        this.imageUrl = imageUrl;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + gender + "," + imageUrl + "," + age;
    }
}
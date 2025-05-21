package com.bookstore.models;

public class User extends BaseEntity {
    private String name;
    private String email;
    private String address;
    private String password;
    private String gender;

    public User() {

        super();
    }
    public User(String name, String email, String address, String password, String gender) {
        super();
        this.name = name;
        this.email = email;
        this.address = address;
        this.password = password;
        this.gender = gender;
    }

    public User(String id, String name, String email, String address, String password, String gender) {
        super(id);
        this.name = name;
        this.email = email;
        this.address = address;
        this.password = password;
        this.gender = gender;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + email + "," + address + "," + password + "," + gender;
    }
}

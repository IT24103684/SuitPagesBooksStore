package com.bookstore.models;


public class Admin extends BaseEntity {
    private String name;
    private String email;
    private String password;
    private String nicNumber;

    public Admin() {

        super();
    }

    public Admin(String name, String email, String password, String nicNumber) {
        super();
        this.name = name;
        this.email = email;
        this.password = password;
        this.nicNumber = nicNumber;
    }

    public Admin(String id, String name, String email, String password, String nicNumber) {
        super(id);
        this.name = name;
        this.email = email;
        this.password = password;
        this.nicNumber = nicNumber;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNicNumber() {
        return nicNumber;
    }

    public void setNicNumber(String nicNumber) {
        this.nicNumber = nicNumber;
    }

    @Override
    public String toString() {
        return id + "," + name + "," + email + "," + password + "," + nicNumber;
    }
}
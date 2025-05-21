package com.bookstore.dtos;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

public class AdminDTO {
    private String id;

    @NotBlank(message = "Name is required")
    private String name;

    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    private String email;

    @NotBlank(message = "Password is required")
    private String password;

    @NotBlank(message = "NIC number is required")
    private String nicNumber;
    public AdminDTO() {
    }

    public AdminDTO(String name, String email, String password, String nicNumber) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.nicNumber = nicNumber;
    }

    public AdminDTO(String id, String name, String email, String password, String nicNumber) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.nicNumber = nicNumber;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
}

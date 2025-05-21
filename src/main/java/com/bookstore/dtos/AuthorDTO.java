package com.bookstore.dtos;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class AuthorDTO {
    private String id;

    @NotBlank(message = "Name is required")
    private String name;

    @NotBlank(message = "Gender is required")
    private String gender;

    private String imageUrl;

    @NotNull(message = "Age is required")
    @Min(value = 1, message = "Age must be greater than 0")
    private Integer age;

    public AuthorDTO() {
    }

    public AuthorDTO(String name, String gender, String imageUrl, Integer age) {
        this.name = name;
        this.gender = gender;
        this.imageUrl = imageUrl;
        this.age = age;
    }

    public AuthorDTO(String id, String name, String gender, String imageUrl, Integer age) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.imageUrl = imageUrl;
        this.age = age;
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

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }
}

package com.bookstore.repositories;

import com.bookstore.models.Admin;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class AdminRepository {
    private static final String ADMINS_FILE = "admins.txt";
    private List<Admin> admins;

    public AdminRepository() {
        loadAdmins();
    }

    private void loadAdmins() {
        admins = FileUtil.loadFromFile(ADMINS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 5) {
                return new Admin(
                        parts[0], // id
                        parts[1], // name
                        parts[2], // email
                        parts[3], // password
                        parts[4]  // nicNumber
                );
            }
            return null;
        });
    }

    private void saveAdmins() {
        FileUtil.saveToFile(admins, ADMINS_FILE);
    }

    public List<Admin> findAll() {
        return new ArrayList<>(admins);
    }

    public Optional<Admin> findById(String id) {
        return admins.stream()
                .filter(admin -> admin.getId().equals(id))
                .findFirst();
    }

    public Optional<Admin> findByEmail(String email) {
        return admins.stream()
                .filter(admin -> admin.getEmail().equals(email))
                .findFirst();
    }

    public Admin save(Admin admin) {
        Optional<Admin> existingAdmin = findById(admin.getId());

        if (existingAdmin.isPresent()) {
            admins.remove(existingAdmin.get());
        }

        admins.add(admin);
        saveAdmins();

        return admin;
    }

    public boolean deleteById(String id) {
        Optional<Admin> adminToDelete = findById(id);

        if (adminToDelete.isPresent()) {
            admins.remove(adminToDelete.get());
            saveAdmins();
            return true;
        }

        return false;
    }

    public boolean existsByEmail(String email) {
        return admins.stream()
                .anyMatch(admin -> admin.getEmail().equals(email));
    }

    public boolean existsByNicNumber(String nicNumber) {
        return admins.stream()
                .anyMatch(admin -> admin.getNicNumber().equals(nicNumber));
    }
}
package com.bookstore.repositories;

import com.bookstore.models.User;
import com.bookstore.utils.FileUtil;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class UserRepository {
    private static final String USERS_FILE = "users.txt";
    private List<User> users;

    public UserRepository() {
        loadUsers();
    }

    private void loadUsers() {
        users = FileUtil.loadFromFile(USERS_FILE, line -> {
            String[] parts = line.split(",");
            if (parts.length >= 6) {
                return new User(
                        parts[0],
                        parts[1],
                        parts[2],
                        parts[3],
                        parts[4],
                        parts[5]
                );
            }
            return null;
        });
    }

    private void saveUsers() {
        FileUtil.saveToFile(users, USERS_FILE);
    }

    public List<User> findAll() {
        return new ArrayList<>(users);
    }

    public Optional<User> findById(String id) {
        return users.stream()
                .filter(user -> user.getId().equals(id))
                .findFirst();
    }

    public Optional<User> findByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equals(email))
                .findFirst();
    }

    public User save(User user) {
        // If user exists, update it
        Optional<User> existingUser = findById(user.getId());

        if (existingUser.isPresent()) {
            users.remove(existingUser.get());
        }

        users.add(user);
        saveUsers();

        return user;
    }

    public boolean deleteById(String id) {
        Optional<User> userToDelete = findById(id);

        if (userToDelete.isPresent()) {
            users.remove(userToDelete.get());
            saveUsers();
            return true;
        }

        return false;
    }

    public boolean existsByEmail(String email) {
        return users.stream()
                .anyMatch(user -> user.getEmail().equals(email));
    }
}

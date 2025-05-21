package com.bookstore.services;

import com.bookstore.dtos.AdminDTO;
import com.bookstore.models.Admin;
import com.bookstore.repositories.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AdminService {

    private final AdminRepository adminRepository;

    @Autowired
    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    public List<AdminDTO> getAllAdmins() {
        return adminRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public AdminDTO getAdminById(String id) {
        Optional<Admin> admin = adminRepository.findById(id);
        return admin.map(this::convertToDTO).orElse(null);
    }

    public AdminDTO createAdmin(AdminDTO adminDTO) {
        if (adminRepository.existsByEmail(adminDTO.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        if (adminRepository.existsByNicNumber(adminDTO.getNicNumber())) {
            throw new IllegalArgumentException("NIC number already exists");
        }

        Admin admin = convertToEntity(adminDTO);
        Admin savedAdmin = adminRepository.save(admin);
        return convertToDTO(savedAdmin);
    }

    public AdminDTO updateAdmin(String id, AdminDTO adminDTO) {
        Optional<Admin> existingAdmin = adminRepository.findById(id);

        if (existingAdmin.isPresent()) {
            if (!existingAdmin.get().getEmail().equals(adminDTO.getEmail()) &&
                    adminRepository.existsByEmail(adminDTO.getEmail())) {
                throw new IllegalArgumentException("Email already exists");
            }

            if (!existingAdmin.get().getNicNumber().equals(adminDTO.getNicNumber()) &&
                    adminRepository.existsByNicNumber(adminDTO.getNicNumber())) {
                throw new IllegalArgumentException("NIC number already exists");
            }

            Admin admin = convertToEntity(adminDTO);
            admin.setId(id);
            Admin updatedAdmin = adminRepository.save(admin);
            return convertToDTO(updatedAdmin);
        }

        return null;
    }

    public boolean deleteAdmin(String id) {
        return adminRepository.deleteById(id);
    }

    public AdminDTO login(LoginDTO loginDTO) {
        Optional<Admin> admin = adminRepository.findByEmail(loginDTO.getEmail());

        if (admin.isPresent() && admin.get().getPassword().equals(loginDTO.getPassword())) {
            return convertToDTO(admin.get());
        }

        return null;
    }

    private AdminDTO convertToDTO(Admin admin) {
        return new AdminDTO(
                admin.getId(),
                admin.getName(),
                admin.getEmail(),
                admin.getPassword(),
                admin.getNicNumber()
        );
    }

    private Admin convertToEntity(AdminDTO adminDTO) {
        return new Admin(
                adminDTO.getName(),
                adminDTO.getEmail(),
                adminDTO.getPassword(),
                adminDTO.getNicNumber()
        );
    }
}
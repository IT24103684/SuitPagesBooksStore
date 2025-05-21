<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Author</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://unpkg.com/@lucide/web@latest"></script>
    <style>
        .focus-ring:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.5);
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
<div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-2xl font-bold text-gray-800">Edit Author</h1>
        <a href="${pageContext.request.contextPath}/authors" class="bg-gray-100 text-gray-700 hover:bg-gray-200 py-2 px-4 rounded-lg border text-sm flex items-center transition-colors">
            <i data-lucide="arrow-left" class="h-4 w-4 mr-1"></i>
            Back
        </a>
    </div>

    <div id="errorMessage" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg mb-6 text-sm flex items-start">
        <i data-lucide="alert-circle" class="h-5 w-5 mr-2 flex-shrink-0"></i>
        <span></span>
    </div>

    <div id="successMessage" class="hidden bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg mb-6 text-sm flex items-start">
        <i data-lucide="check-circle" class="h-5 w-5 mr-2 flex-shrink-0"></i>
        <span></span>
    </div>

    <form id="authorForm" class="space-y-6">
        <input type="hidden" id="authorId" name="authorId" value="${author.id}">

        <div class="relative">
            <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="user" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter author's name"
                        value="${author.name}"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Gender</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="users" class="h-5 w-5 text-gray-400"></i>
                </div>
                <select
                        id="gender"
                        name="gender"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm text-gray-700 appearance-none focus:border-blue-500"
                        required>
                    <option value="">Select Gender</option>
                    <option value="Male" ${author.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${author.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${author.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                    <i data-lucide="chevron-down" class="h-4 w-4 text-gray-400"></i>
                </div>
            </div>
            <p id="genderError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="imageUrl" class="block text-sm font-medium text-gray-700 mb-1">Image URL</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="image" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="text"
                        id="imageUrl"
                        name="imageUrl"
                        placeholder="https://example.com/image.jpg"
                        value="${author.imageUrl}"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500">
            </div>
            <p id="imageUrlError" class="text-red-500 text-xs mt-1 hidden"></p>
            <p class="text-gray-500 text-xs mt-1">Optional: URL to author's profile image</p>
        </div>

        <div class="relative">
            <label for="age" class="block text-sm font-medium text-gray-700 mb-1">Age</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="calendar" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="number"
                        id="age"
                        name="age"
                        min="1"
                        placeholder="Enter age"
                        value="${author.age}"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="ageError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="flex space-x-4">
            <button type="submit" id="submitBtn"
                    class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 flex items-center justify-center transition-colors">
                <i data-lucide="save" class="h-5 w-5 mr-2"></i>
                Update Author
            </button>

            <button type="button" id="deleteBtn"
                    class="flex-1 bg-red-500 hover:bg-red-600 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 flex items-center justify-center transition-colors">
                <i data-lucide="trash-2" class="h-5 w-5 mr-2"></i>
                Delete
            </button>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        lucide.createIcons();

        const authorForm = document.getElementById('authorForm');
        const errorMessage = document.getElementById('errorMessage');
        const successMessage = document.getElementById('successMessage');
        const submitBtn = document.getElementById('submitBtn');
        const deleteBtn = document.getElementById('deleteBtn');
        const authorId = document.getElementById('authorId').value;

        const patterns = {
            name: /^[A-Za-z\s]{2,50}$/,
            imageUrl: /^(https?:\/\/.*\.(?:png|jpg|jpeg|gif|webp))?$/
        };

        function validateField(field, pattern) {
            const errorElement = document.getElementById(field.id + "Error");

            if (field.required && !field.value.trim()) {
                errorElement.textContent = field.name.charAt(0).toUpperCase() + field.name.slice(1) + " is required";
                errorElement.classList.remove("hidden");
                return false;
            }

            if (pattern && field.value.trim() && !pattern.test(field.value.trim())) {
                if (field.id === 'name') {
                    errorElement.textContent = 'Name should contain only letters and spaces (2-50 characters)';
                } else if (field.id === 'imageUrl') {
                    errorElement.textContent = 'Please enter a valid image URL (or leave empty)';
                }
                errorElement.classList.remove('hidden');
                return false;
            }

            if (field.id === 'age' && field.value < 1) {
                errorElement.textContent = 'Age must be greater than 0';
                errorElement.classList.remove('hidden');
                return false;
            }

            errorElement.classList.add('hidden');
            return true;
        }

        authorForm.addEventListener('submit', function(e) {
            e.preventDefault();

            errorMessage.classList.add('hidden');
            successMessage.classList.add('hidden');

            const name = document.getElementById('name');
            const gender = document.getElementById('gender');
            const imageUrl = document.getElementById('imageUrl');
            const age = document.getElementById('age');

            const isNameValid = validateField(name, patterns.name);
            const isGenderValid = validateField(gender);
            const isImageUrlValid = validateField(imageUrl, patterns.imageUrl);
            const isAgeValid = validateField(age);

            if (isNameValid && isGenderValid && isImageUrlValid && isAgeValid) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Processing...';

                const authorData = {
                    id: authorId,
                    name: name.value.trim(),
                    gender: gender.value,
                    imageUrl: imageUrl.value.trim() || null,
                    age: parseInt(age.value)
                };

                const contextPath = "${pageContext.request.contextPath}";
                const apiUrl = contextPath + "/api/authors/" + authorId;

                fetch(apiUrl, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(authorData)
                })
                    .then(response => {
                        if (!response.ok) {
                            return response.json().then(err => {
                                throw new Error(err.message || 'Failed to update author. Server returned ' + response.status);
                            });
                        }
                        return response.json();
                    })
                    .then(data => {
                        successMessage.querySelector('span').textContent = 'Author updated successfully!';
                        successMessage.classList.remove('hidden');

                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    })
                    .catch(error => {
                        errorMessage.querySelector('span').textContent = error.message || 'An unexpected error occurred';
                        errorMessage.classList.remove('hidden');

                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    })
                    .finally(() => {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i data-lucide="save" class="h-5 w-5 mr-2"></i>Update Author';
                        lucide.createIcons();
                    });
            }
        });

        deleteBtn.addEventListener('click', function() {
            if (confirm('Are you sure you want to delete this author? This action cannot be undone.')) {
                deleteBtn.disabled = true;
                deleteBtn.innerHTML = '<svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Deleting...';

                const contextPath = "${pageContext.request.contextPath}";
                const apiUrl = contextPath + "/api/authors/" + authorId;

                fetch(apiUrl, {
                    method: 'DELETE'
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Failed to delete author. Server returned ' + response.status);
                        }
                        window.location.href = contextPath + "/authors";
                    })
                    .catch(error => {
                        errorMessage.querySelector('span').textContent = error.message || 'An unexpected error occurred';
                        errorMessage.classList.remove('hidden');

                        deleteBtn.disabled = false;
                        deleteBtn.innerHTML = '<i data-lucide="trash-2" class="h-5 w-5 mr-2"></i>Delete';
                        lucide.createIcons();

                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    });
            }
        });

        document.getElementById('name').addEventListener('input', function() {
            validateField(this, patterns.name);
        });

        document.getElementById('gender').addEventListener('change', function() {
            validateField(this);
        });

        document.getElementById('imageUrl').addEventListener('input', function() {
            validateField(this, patterns.imageUrl);
        });

        document.getElementById('age').addEventListener('input', function() {
            validateField(this);
        });
    });
</script>
</body>
</html>
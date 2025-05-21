<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Admin</title>
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
        <h1 class="text-2xl font-bold text-gray-800">Create New Admin</h1>
        <a href="${pageContext.request.contextPath}/admins" class="bg-gray-100 text-gray-700 hover:bg-gray-200 py-2 px-4 rounded-lg border text-sm flex items-center transition-colors">
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

    <form id="adminForm" class="space-y-6">
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
                        placeholder="Enter admin's full name"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="mail" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="name@example.com"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="emailError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="lock" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="••••••••"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-10 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
                <button
                        type="button"
                        id="togglePassword"
                        class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600">
                    <i data-lucide="eye" class="h-5 w-5" id="showPasswordIcon"></i>
                    <i data-lucide="eye-off" class="h-5 w-5 hidden" id="hidePasswordIcon"></i>
                </button>
            </div>
            <p id="passwordError" class="text-red-500 text-xs mt-1 hidden"></p>
            <p class="text-gray-500 text-xs mt-1">Must be at least 8 characters</p>
        </div>

        <div class="relative">
            <label for="nicNumber" class="block text-sm font-medium text-gray-700 mb-1">NIC Number</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="id-card" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="text"
                        id="nicNumber"
                        name="nicNumber"
                        placeholder="Enter NIC number"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="nicNumberError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div>
            <button type="submit" id="submitBtn"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 flex items-center justify-center transition-colors">
                <i data-lucide="user-plus" class="h-5 w-5 mr-2"></i>
                Create Admin
            </button>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        lucide.createIcons();

        const adminForm = document.getElementById('adminForm');
        const errorMessage = document.getElementById('errorMessage');
        const successMessage = document.getElementById('successMessage');
        const submitBtn = document.getElementById('submitBtn');
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');
        const showPasswordIcon = document.getElementById('showPasswordIcon');
        const hidePasswordIcon = document.getElementById('hidePasswordIcon');

        const patterns = {
            name: /^[A-Za-z\s]{2,50}$/,
            email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
            password: /^.{8,}$/,
            nicNumber: /^[0-9]{9}[vVxX]$|^[0-9]{12}$/  // Common NIC formats
        };

        togglePassword.addEventListener('click', function() {
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                showPasswordIcon.classList.add('hidden');
                hidePasswordIcon.classList.remove('hidden');
            } else {
                passwordInput.type = 'password';
                showPasswordIcon.classList.remove('hidden');
                hidePasswordIcon.classList.add('hidden');
            }
        });

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
                } else if (field.id === 'email') {
                    errorElement.textContent = 'Please enter a valid email address';
                } else if (field.id === 'password') {
                    errorElement.textContent = 'Password must be at least 8 characters long';
                } else if (field.id === 'nicNumber') {
                    errorElement.textContent = 'Please enter a valid NIC number';
                }
                errorElement.classList.remove('hidden');
                return false;
            }

            errorElement.classList.add('hidden');
            return true;
        }

        adminForm.addEventListener('submit', function(e) {
            e.preventDefault();

            errorMessage.classList.add('hidden');
            successMessage.classList.add('hidden');

            const name = document.getElementById('name');
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const nicNumber = document.getElementById('nicNumber');

            const isNameValid = validateField(name, patterns.name);
            const isEmailValid = validateField(email, patterns.email);
            const isPasswordValid = validateField(password, patterns.password);
            const isNicNumberValid = validateField(nicNumber, patterns.nicNumber);

            if (isNameValid && isEmailValid && isPasswordValid && isNicNumberValid) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Processing...';

                const adminData = {
                    name: name.value.trim(),
                    email: email.value.trim(),
                    password: password.value,
                    nicNumber: nicNumber.value.trim()
                };

                const contextPath = "${pageContext.request.contextPath}";
                const apiUrl = "${pageContext.request.contextPath}/api/admins";

                fetch(apiUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(adminData)
                })
                    .then(response => {
                        if (!response.ok) {
                            return response.json().then(err => {
                                throw new Error(err.message || 'Failed to create admin. Server returned ' + response.status);
                            });
                        }
                        return response.json();
                    })
                    .then(data => {
                        successMessage.querySelector('span').textContent = 'Admin created successfully!';
                        successMessage.classList.remove('hidden');
                        adminForm.reset();

                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    })
                    .catch(error => {
                        errorMessage.querySelector('span').textContent = error.message || 'An unexpected error occurred';
                        errorMessage.classList.remove('hidden');

                        window.scrollTo({ top: 0, behavior: 'smooth' });
                    })
                    .finally(() => {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i data-lucide="user-plus" class="h-5 w-5 mr-2"></i>Create Admin';
                        lucide.createIcons();
                    });
            }
        });

        document.getElementById('name').addEventListener('input', function() {
            validateField(this, patterns.name);
        });

        document.getElementById('email').addEventListener('input', function() {
            validateField(this, patterns.email);
        });

        document.getElementById('password').addEventListener('input', function() {
            validateField(this, patterns.password);
        });

        document.getElementById('nicNumber').addEventListener('input', function() {
            validateField(this, patterns.nicNumber);
        });
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Bookstore</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="w-full max-w-md">
    <div class="bg-white rounded-lg shadow-xl overflow-hidden">
        <div class="bg-indigo-600 p-6 text-center">
            <h1 class="text-white text-3xl font-bold">Bookstore Admin</h1>
            <p class="text-indigo-200 mt-2">Sign in to your dashboard</p>
        </div>

        <div class="p-6">
            <div id="errorMessage"
                 class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4"></div>

            <form id="loginForm" class="space-y-6">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email Address</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" id="email" name="email" required
                               class="pl-10 block w-full py-3 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                               placeholder="admin@example.com">
                    </div>
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="mt-1 relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-lock text-gray-400"></i>
                        </div>
                        <input type="password" id="password" name="password" required
                               class="pl-10 block w-full py-3 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                               placeholder="••••••••">
                    </div>
                </div>

                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <input id="remember-me" name="remember-me" type="checkbox"
                               class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded">
                        <label for="remember-me" class="ml-2 block text-sm text-gray-700">
                            Remember me
                        </label>
                    </div>

                    <div class="text-sm">
                        <a href="#" class="font-medium text-indigo-600 hover:text-indigo-500">
                            Forgot your password?
                        </a>
                    </div>
                </div>

                <div>
                    <button type="submit"
                            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        <span id="loginButtonText">Sign in</span>
                        <span id="loginSpinner" class="hidden ml-2">
                                <i class="fas fa-circle-notch fa-spin"></i>
                            </span>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div class="text-center mt-4 text-gray-500 text-sm">
        &copy; 2023 Bookstore Admin Panel. All rights reserved.
    </div>
</div>

<script>
    document.getElementById("loginForm").addEventListener("submit", function (event) {
        event.preventDefault();
        document.getElementById("loginButtonText").textContent = "Signing in...";
        document.getElementById("loginSpinner").classList.remove("hidden");

        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;
        document.getElementById("errorMessage").classList.add("hidden");
        var data = JSON.stringify({
            "email": email,
            "password": password
        });
        fetch("/api/admins/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: data
        })
            .then(function (response) {
                if (!response.ok) {
                    return response.json().then(function (errorData) {
                        throw new Error(errorData.error || "Invalid credentials");
                    });
                }
                return response.json();
            })
            .then(function (data) {
                window.location.href = "/admin";
            })
            .catch(function (error) {
                var errorMessage = document.getElementById("errorMessage");
                errorMessage.textContent = error.message || "Login failed. Please try again.";
                errorMessage.classList.remove("hidden");
                document.getElementById("loginButtonText").textContent = "Sign in";
                document.getElementById("loginSpinner").classList.add("hidden");
            });
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Bookstore</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 min-h-screen">
<div class="bg-indigo-600 text-white shadow-md">
    <div class="container mx-auto px-4 py-6">
        <div class="flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold">Bookstore Admin</h1>
                <p class="text-indigo-200">Dashboard</p>
            </div>
            <div class="flex items-center space-x-4">
                <span class="text-sm">Welcome, Admin</span>
                <a href="/logout" class="bg-indigo-700 hover:bg-indigo-800 px-4 py-2 rounded-md text-sm font-medium">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <h2 class="text-2xl font-semibold text-gray-800 mb-6">Management Dashboard</h2>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <a href="/books" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-blue-100 flex items-center justify-center mb-4">
                    <i class="fas fa-book text-2xl text-blue-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Book Management</h3>
                <p class="text-gray-600">Manage books inventory, categories, and details</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-blue-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>

        <a href="/admins/customers" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-green-100 flex items-center justify-center mb-4">
                    <i class="fas fa-users text-2xl text-green-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Customer Management</h3>
                <p class="text-gray-600">View and manage customer accounts and profiles</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-green-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>

        <a href="/admins" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-purple-100 flex items-center justify-center mb-4">
                    <i class="fas fa-user-shield text-2xl text-purple-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Admin Management</h3>
                <p class="text-gray-600">Manage admin accounts and permissions</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-purple-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>


        <a href="/admins/feedback" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-yellow-100 flex items-center justify-center mb-4">
                    <i class="fas fa-comments text-2xl text-yellow-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Feedback Management</h3>
                <p class="text-gray-600">View and respond to customer feedback and reviews</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-yellow-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>

        <a href="/authors" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-red-100 flex items-center justify-center mb-4">
                    <i class="fas fa-pen-fancy text-2xl text-red-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Author Management</h3>
                <p class="text-gray-600">Manage author profiles and their publications</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-red-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>


        <a href="/orders" class="block bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300">
            <div class="p-6">
                <div class="w-14 h-14 rounded-full bg-teal-100 flex items-center justify-center mb-4">
                    <i class="fas fa-shopping-cart text-2xl text-teal-600"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Order Management</h3>
                <p class="text-gray-600">Track and manage customer orders and deliveries</p>
            </div>
            <div class="px-6 py-3 bg-gray-50 rounded-b-lg">
                    <span class="text-teal-600 font-medium flex items-center">
                        Access <i class="fas fa-arrow-right ml-2"></i>
                    </span>
            </div>
        </a>
    </div>
</div>

<footer class="bg-white py-4 mt-8 border-t">
    <div class="container mx-auto px-4 text-center text-gray-500 text-sm">
        &copy; 2023 Bookstore Admin Panel. All rights reserved.
    </div>
</footer>
</body>
</html>
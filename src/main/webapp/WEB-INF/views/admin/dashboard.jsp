<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Bookstore Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Inter', sans-serif;
        }

        .dashboard-card {
            position: relative;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid transparent;
        }

        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.1);
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--card-color), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .dashboard-card:hover::before {
            opacity: 1;
        }

        .icon-container {
            transition: transform 0.3s ease;
        }

        .dashboard-card:hover .icon-container {
            transform: scale(1.1);
        }

        .access-link {
            position: relative;
            overflow: hidden;
        }

        .access-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: currentColor;
            transition: width 0.3s ease;
        }

        .dashboard-card:hover .access-link::after {
            width: 100%;
        }

        .gradient-header {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        }

        .logout-btn {
            position: relative;
            overflow: hidden;
        }

        .logout-btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .logout-btn:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(40, 40);
                opacity: 0;
            }
        }

        .footer-border {
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        .stat-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: #ef4444;
            color: white;
            font-size: 10px;
            font-weight: 600;
            padding: 2px 6px;
            border-radius: 10px;
            min-width: 18px;
            text-align: center;
        }

        .loading-shimmer {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
        }

        @keyframes shimmer {
            0% {
                background-position: -200% 0;
            }
            100% {
                background-position: 200% 0;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<!-- Loading overlay (hidden by default) -->
<div id="loadingOverlay" class="fixed inset-0 bg-white bg-opacity-80 z-50 flex items-center justify-center hidden">
    <div class="text-center">
        <div class="w-16 h-16 rounded-full border-4 border-t-indigo-600 border-r-transparent border-b-transparent border-l-transparent animate-spin mx-auto mb-4"></div>
        <p class="text-gray-600 font-medium">Loading Dashboard...</p>
    </div>
</div>

<div class="gradient-header text-white shadow-lg sticky top-0 z-40">
    <div class="container mx-auto px-4 py-5">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center">
            <div class="mb-4 md:mb-0">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-white bg-opacity-20 rounded-lg flex items-center justify-center">
                        <i class="fas fa-book-open text-xl"></i>
                    </div>
                    <div>
                        <h1 class="text-2xl md:text-3xl font-bold tracking-tight">Bookstore Admin</h1>
                        <p class="text-indigo-100 text-sm md:text-base mt-1">Management Dashboard</p>
                    </div>
                </div>
            </div>
            <div class="flex items-center space-x-4">
                <div class="hidden md:flex items-center space-x-2 bg-white bg-opacity-10 px-3 py-2 rounded-lg">
                    <i class="fas fa-user-circle"></i>
                    <span class="text-sm font-medium">Welcome, Admin</span>
                </div>
                <button onclick="adminLogout()" class="logout-btn bg-white text-indigo-600 hover:bg-gray-100 px-4 py-2.5 rounded-lg text-sm font-semibold transition-all duration-300 shadow-sm hover:shadow-md flex items-center space-x-2">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </div>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8 max-w-7xl">
    <!-- Dashboard Stats Banner -->
    <div class="bg-white rounded-2xl shadow-md p-6 mb-8 border border-gray-100">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center">
            <div>
                <h2 class="text-2xl font-bold text-gray-800">Management Dashboard</h2>
                <p class="text-gray-600 mt-2">Manage all aspects of your bookstore from one centralized location</p>
            </div>
            <div class="mt-4 md:mt-0 flex items-center space-x-2 text-sm text-gray-500">
                <i class="fas fa-clock"></i>
                <span id="currentDateTime">Loading...</span>
            </div>
        </div>
    </div>

    <!-- Dashboard Cards Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Book Management Card -->
        <a href="/books"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #3b82f6;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-blue-50 flex items-center justify-center">
                        <i class="fas fa-book text-3xl text-blue-500"></i>
                    </div>
                    <span class="text-xs font-semibold text-blue-600 bg-blue-50 px-3 py-1 rounded-full">CRITICAL</span>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Book Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">Manage books inventory, categories, pricing, and publication details with full control</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-blue-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>

        <!-- Customer Management Card -->
        <a href="/admins/customers"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #10b981;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-green-50 flex items-center justify-center">
                        <i class="fas fa-users text-3xl text-green-500"></i>
                    </div>
                    <span class="text-xs font-semibold text-green-600 bg-green-50 px-3 py-1 rounded-full">ACTIVE</span>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Customer Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">View and manage customer accounts, profiles, preferences, and purchase history</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-green-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>

        <!-- Admin Management Card -->
        <a href="/admins"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #8b5cf6;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-purple-50 flex items-center justify-center">
                        <i class="fas fa-user-shield text-3xl text-purple-500"></i>
                    </div>
                    <span class="text-xs font-semibold text-purple-600 bg-purple-50 px-3 py-1 rounded-full">SECURED</span>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Admin Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">Manage admin accounts, permissions, roles, and system access controls</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-purple-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>

        <!-- Feedback Management Card -->
        <a href="/admins/feedback"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #f59e0b;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-yellow-50 flex items-center justify-center">
                        <i class="fas fa-comments text-3xl text-yellow-500"></i>
                    </div>
                    <div class="stat-badge">3</div>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Feedback Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">View, respond to, and analyze customer feedback, reviews, and ratings</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-yellow-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>

        <!-- Author Management Card -->
        <a href="/authors"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #ef4444;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-red-50 flex items-center justify-center">
                        <i class="fas fa-pen-fancy text-3xl text-red-500"></i>
                    </div>
                    <span class="text-xs font-semibold text-red-600 bg-red-50 px-3 py-1 rounded-full">UPDATED</span>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Author Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">Manage author profiles, biographies, publications, and royalty information</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-red-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>

        <!-- Order Management Card -->
        <a href="/orders"
           class="dashboard-card bg-white rounded-xl shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100"
           style="--card-color: #14b8a6;">
            <div class="p-6">
                <div class="flex items-start justify-between mb-4">
                    <div class="icon-container w-16 h-16 rounded-2xl bg-teal-50 flex items-center justify-center">
                        <i class="fas fa-shopping-cart text-3xl text-teal-500"></i>
                    </div>
                    <div class="stat-badge">12</div>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-3">Order Management</h3>
                <p class="text-gray-600 text-sm leading-relaxed">Track, manage, and fulfill customer orders, deliveries, and returns</p>
            </div>
            <div class="px-6 py-4 bg-gray-50 rounded-b-xl border-t border-gray-100">
                <span class="access-link text-teal-600 font-semibold flex items-center justify-between">
                    <span>Access Management Panel</span>
                    <i class="fas fa-arrow-right text-sm transform group-hover:translate-x-1 transition-transform"></i>
                </span>
            </div>
        </a>
    </div>
</div>


<footer class="bg-white py-6 mt-12 footer-border">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row justify-between items-center">
            <div class="text-center md:text-left mb-4 md:mb-0">
                <div class="flex items-center justify-center md:justify-start space-x-2 mb-2">
                    <i class="fas fa-book text-indigo-600"></i>
                    <span class="text-gray-800 font-semibold">Bookstore Admin</span>
                </div>
                <p class="text-gray-500 text-sm">Management Panel v2.0</p>
            </div>
            <div class="text-center md:text-right">
                <p class="text-gray-500 text-sm">&copy; 2023 Bookstore Management System. All rights reserved.</p>
                <p class="text-gray-400 text-xs mt-1">Last updated: October 2023</p>
            </div>
        </div>
    </div>

</footer>

<script>


    // Update current date and time
    function updateDateTime() {
        const now = new Date();
        const options = {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        document.getElementById('currentDateTime').textContent = now.toLocaleDateString('en-US', options);
    }

    // Initialize date/time and update every minute
    updateDateTime();
    setInterval(updateDateTime, 60000);

    // Add loading state simulation for links
    document.querySelectorAll('.dashboard-card').forEach(card => {
        card.addEventListener('click', function(e) {
            const link = this.getAttribute('href');
            if (link && link !== '#') {
                // Show loading overlay
                document.getElementById('loadingOverlay').classList.remove('hidden');

                // Simulate navigation delay for demo
                setTimeout(() => {

                    // window.location.href = link;
                    document.getElementById('loadingOverlay').classList.add('hidden');
                }, 800);
            }
        });
    });

    // Add keyboard navigation support
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            document.getElementById('loadingOverlay').classList.add('hidden');
        }
    });

    // Initialize tooltips (simulated)
    document.querySelectorAll('.stat-badge').forEach(badge => {
        badge.setAttribute('title', 'Pending items requiring attention');
    });

    // Admin logout function
    function adminLogout() {
        if (confirm('Are you sure you want to logout?')) {

            document.getElementById('loadingOverlay').classList.remove('hidden');

            fetch('/api/admins/logout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => response.json())
                .then(data => {

                    localStorage.removeItem('adminId');
                    localStorage.removeItem('adminEmail');
                    localStorage.removeItem('adminName');

                    window.location.href = '/admin/login';
                })
                .catch(error => {
                    console.error('Logout error:', error);
                    localStorage.clear();
                    window.location.href = "/admin/admin/dashboard";
                });
        }

    }



</script>
</body>
</html>
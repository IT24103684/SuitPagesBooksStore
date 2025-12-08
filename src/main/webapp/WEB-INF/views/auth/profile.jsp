<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - SuitPages</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            DEFAULT: '#e94560',
                            dark: '#c73e54',
                            light: '#f17791'
                        },
                        secondary: {
                            DEFAULT: '#1a1a2e',
                            dark: '#121220',
                            light: '#2d2d44'
                        },
                        accent: {
                            DEFAULT: '#4a90e2',
                            dark: '#357abd'
                        }
                    },
                    boxShadow: {
                        'soft': '0 4px 20px rgba(0, 0, 0, 0.05)',
                        'glow': '0 0 15px rgba(233, 69, 96, 0.1)'
                    },
                    transitionDuration: {
                        '200': '200ms'
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background-image:
                    linear-gradient(135deg, rgba(26, 26, 46, 0.85) 0%, rgba(26, 26, 46, 0.7) 100%),
                    url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
            margin: 0;
            min-height: 100vh;
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, 'Roboto', sans-serif;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                    radial-gradient(circle at 20% 80%, rgba(233, 69, 96, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(74, 144, 226, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(26, 26, 46, 0.2) 0%, transparent 50%);
            backdrop-filter: blur(15px) saturate(180%);
            -webkit-backdrop-filter: blur(15px) saturate(180%);
            z-index: -1;
        }

        .navbar, .navbar * {
            color: white !important;
        }

        .content-card {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 24px;
            box-shadow:
                    0 20px 60px rgba(0, 0, 0, 0.1),
                    0 0 0 1px rgba(255, 255, 255, 0.2),
                    inset 0 1px 0 rgba(255, 255, 255, 0.6);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
        }

        .content-card:hover {
            transform: translateY(-8px) scale(1.005);
            box-shadow:
                    0 30px 80px rgba(233, 69, 96, 0.2),
                    0 0 0 1px rgba(255, 255, 255, 0.3),
                    inset 0 1px 0 rgba(255, 255, 255, 0.8);
        }

        .btn-primary {
            background: linear-gradient(
                    135deg,
                    #e94560 0%,
                    #ff6b8b 25%,
                    #e94560 50%,
                    #ff6b8b 75%,
                    #e94560 100%
            );
            background-size: 400% 400%;
            animation: gradientShift 8s ease infinite;
            border: none;
            border-radius: 12px;
            padding: 14px 32px;
            color: white;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow:
                    0 10px 30px rgba(233, 69, 96, 0.4),
                    0 0 20px rgba(233, 69, 96, 0.3);
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.3),
                    transparent
            );
            transition: left 0.6s;
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow:
                    0 20px 40px rgba(233, 69, 96, 0.6),
                    0 0 30px rgba(233, 69, 96, 0.4);
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:active {
            transform: translateY(-1px) scale(1.02);
        }

        .input-field {
            background: radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.15) 0%, transparent 50%);
            border: 2px solid transparent;
            border-radius: 12px;
            padding: 16px 20px;
            font-size: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow:
                    0 4px 20px rgba(0, 0, 0, 0.05),
                    inset 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .input-field:focus {
            background: rgba(255, 255, 255, 1);
            border-color: #e94560;
            box-shadow:
                    0 8px 30px rgba(233, 69, 96, 0.2),
                    0 0 0 4px rgba(233, 69, 96, 0.1),
                    inset 0 1px 3px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
            outline: none;
        }

        .nav-item {
            background: transparent;
            border: none;
            border-radius: 14px;
            padding: 16px 24px;
            margin: 6px 0;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(233, 69, 96, 0.1),
                    transparent
            );
            transition: left 0.6s;
        }

        .nav-item:hover {
            background: linear-gradient(
                    135deg,
                    rgba(233, 69, 96, 0.08) 0%,
                    rgba(74, 144, 226, 0.08) 100%
            );
            transform: translateX(10px) scale(1.02);
            box-shadow:
                    0 8px 25px rgba(233, 69, 96, 0.15),
                    0 0 0 1px rgba(233, 69, 96, 0.1);
        }

        .nav-item:hover::before {
            left: 100%;
        }

        .nav-item.active {
            background: linear-gradient(
                    135deg,
                    rgba(233, 69, 96, 0.15) 0%,
                    rgba(233, 69, 96, 0.05) 100%
            );
            box-shadow:
                    inset 2px 0 0 #e94560,
                    0 8px 25px rgba(233, 69, 96, 0.1),
                    0 0 0 1px rgba(233, 69, 96, 0.1);
            transform: translateX(8px);
        }

        .nav-item.active i {
            color: #e94560;
            transform: scale(1.1);
        }

        .delete-btn {
            background: linear-gradient(
                    135deg,
                    rgba(239, 68, 68, 0.05) 0%,
                    rgba(239, 68, 68, 0.02) 100%
            );
            border: 2px solid transparent;
            border-radius: 12px;
            padding: 12px 28px;
            color: #ef4444;
            font-weight: 600;
            letter-spacing: 0.5px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .delete-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(239, 68, 68, 0.1),
                    transparent
            );
            transition: left 0.6s;
        }

        .delete-btn:hover {
            background: linear-gradient(
                    135deg,
                    rgba(239, 68, 68, 0.1) 0%,
                    rgba(239, 68, 68, 0.05) 100%
            );
            border-color: rgba(239, 68, 68, 0.3);
            color: #dc2626;
            transform: translateY(-2px) scale(1.05);
            box-shadow:
                    0 10px 25px rgba(239, 68, 68, 0.2),
                    0 0 15px rgba(239, 68, 68, 0.1);
        }

        .delete-btn:hover::before {
            left: 100%;
        }

        .modal-backdrop {
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeIn 0.4s ease-out;
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 24px;
            box-shadow:
                    0 40px 80px rgba(0, 0, 0, 0.25),
                    0 0 0 1px rgba(255, 255, 255, 0.2),
                    inset 0 1px 0 rgba(255, 255, 255, 0.8);
            animation: modalSlideUp 0.5s cubic-bezier(0.4, 0, 0.2, 1) forwards;
            transform: translateY(30px) scale(0.95);
            opacity: 0;
        }

        .profile-image-container {
            width: 160px;
            height: 160px;
            background: linear-gradient(
                    135deg,
                    #e94560 0%,
                    #ff6b8b 25%,
                    #4a90e2 50%,
                    #1a1a2e 75%,
                    #e94560 100%
            );
            background-size: 400% 400%;
            animation: gradientShift 12s ease infinite;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow:
                    0 20px 60px rgba(233, 69, 96, 0.4),
                    0 0 40px rgba(74, 144, 226, 0.4),
                    inset 0 4px 20px rgba(255, 255, 255, 0.5);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .profile-image-container:hover {
            transform: rotate(5deg) scale(1.05);
            box-shadow:
                    0 30px 80px rgba(233, 69, 96, 0.6),
                    0 0 60px rgba(74, 144, 226, 0.6),
                    inset 0 4px 20px rgba(255, 255, 255, 0.8);
        }

        .profile-image-container::before {
            content: '';
            position: absolute;
            top: 4px;
            left: 4px;
            right: 4px;
            bottom: 4px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50%;
            z-index: 1;
        }

        .section-divider {
            height: 2px;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(233, 69, 96, 0.5),
                    rgba(74, 144, 226, 0.5),
                    transparent
            );
            border: none;
            margin: 40px 0;
            position: relative;
            overflow: hidden;
        }

        .section-divider::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.8),
                    transparent
            );
            animation: shimmer 3s infinite;
        }

        .success-message {
            background: linear-gradient(
                    135deg,
                    rgba(16, 185, 129, 0.1) 0%,
                    rgba(16, 185, 129, 0.05) 100%
            );
            border-left: 4px solid #10b981;
            backdrop-filter: blur(20px);
            animation: slideIn 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .error-message {
            background: linear-gradient(
                    135deg,
                    rgba(239, 68, 68, 0.1) 0%,
                    rgba(239, 68, 68, 0.05) 100%
            );
            border-left: 4px solid #ef4444;
            backdrop-filter: blur(20px);
            animation: slideIn 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(233, 69, 96, 0.1);
            border-top: 4px solid #e94560;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            position: relative;
        }

        .loading-spinner::before {
            content: '';
            position: absolute;
            top: -4px;
            left: -4px;
            right: -4px;
            bottom: -4px;
            border: 4px solid transparent;
            border-top: 4px solid #4a90e2;
            border-radius: 50%;
            animation: spin 1.5s linear infinite reverse;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes modalSlideUp {
            to {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .floating-element {
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @media (max-width: 768px) {
            .content-card {
                border-radius: 20px;
                margin: 10px;
            }

            .btn-primary {
                padding: 12px 24px;
                font-size: 14px;
            }

            .profile-image-container {
                width: 120px;
                height: 120px;
            }
        }

        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(
                    135deg,
                    #e94560 0%,
                    #4a90e2 100%
            );
            border-radius: 10px;
            border: 2px solid rgba(255, 255, 255, 0.2);
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(
                    135deg,
                    #ff6b8b 0%,
                    #6aa4f4 100%
            );
        }
    </style>
</head>
<body class=" font-sans antialiased">
<jsp:include page="../common/navbar.jsp"/>

<div class="max-w-6xl mx-auto px-4 py-12">
    <div class="flex flex-col md:flex-row gap-8">

        <div class="w-full md:w-1/4">
            <div class="bg-white rounded-xl shadow-soft p-6">
                <div class="flex flex-col items-center text-center mb-6">
                    <div class="w-32 h-32 bg-gradient-to-br from-primary-light to-primary rounded-full flex items-center justify-center mb-4 overflow-hidden ring-4 ring-primary/10">
                        <div id="profile-initial" class="text-4xl font-bold text-white"></div>
                        <img id="profile-image" class="w-full h-full object-cover hidden" alt="Profile picture">
                    </div>
                    <h2 id="user-name" class="text-2xl font-bold text-secondary tracking-tight">Loading...</h2>
                    <p id="user-email" class="text-gray-500 text-sm mt-1">Loading...</p>
                </div>

                <div class="border-t border-gray-200 pt-4">
                    <nav class="flex flex-col space-y-2">
                        <button id="profile-tab-btn" class="nav-item active flex items-center px-4 py-3 text-secondary rounded-lg">
                            <i class="fas fa-user-circle mr-3 text-primary"></i>
                            <span class="font-medium">Account Settings</span>
                        </button>
                        <a href="/my-orders" id="orders-tab-btn" class="nav-item flex items-center px-4 py-3 text-gray-600 rounded-lg">
                            <i class="fas fa-shopping-bag mr-3 text-gray-400"></i>
                            <span class="font-medium">My Orders</span>
                        </a>
                        <button id="wishlist-tab-btn" class="nav-item flex items-center px-4 py-3 text-gray-600 rounded-lg">
                            <i class="fas fa-heart mr-3 text-gray-400"></i>
                            <span class="font-medium">Wishlist</span>
                        </button>
                        <button id="logout-btn" class="nav-item flex items-center px-4 py-3 text-gray-600 rounded-lg hover:bg-red-50 hover:text-red-500 mt-6">
                            <i class="fas fa-sign-out-alt mr-3 text-gray-400"></i>
                            <span class="font-medium">Logout</span>
                        </button>
                    </nav>
                </div>
            </div>
        </div>
        <div class="w-full md:w-3/4">

            <div id="profile-tab" class="bg-white rounded-xl shadow-soft">
                <div class="p-6 border-b border-gray-200">
                    <h3 class="text-2xl font-bold text-secondary tracking-tight">Account Settings</h3>
                    <p class="text-gray-500 text-sm mt-1">Update your personal information</p>
                </div>

                <div class="p-6">
                    <div id="profile-error" class="hidden bg-red-50 text-red-600 p-4 rounded-lg mb-6">
                        <i class="fas fa-exclamation-circle mr-2"></i>
                        <span id="error-message"></span>
                    </div>

                    <div id="profile-success" class="hidden bg-green-50 text-green-600 p-4 rounded-lg mb-6">
                        <i class="fas fa-check-circle mr-2"></i>
                        <span>Your profile has been updated successfully!</span>
                    </div>

                    <form id="profile-form">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                            <div>
                                <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                                <input type="text" id="fullName" name="fullName" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                            </div>
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                                <input type="email" id="email" name="email" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                            </div>

                            <div>
                                <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                                <input type="text" id="address" name="address" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                            </div>
                        </div>

                        <div class="border-t border-gray-200 pt-6 mb-6">
                            <h4 class="text-lg font-semibold text-secondary mb-4">Change Password</h4>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                                    <input type="password" id="currentPassword" name="currentPassword" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                                </div>
                                <div></div>
                                <div>
                                    <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                                    <input type="password" id="newPassword" name="newPassword" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                                </div>
                                <div>
                                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="input-field w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent bg-gray-50">
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <button type="submit" id="update-profile-btn" class="btn-primary px-6 py-2 bg-primary text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2">
                                <i class="fas fa-save mr-2"></i> Save Changes
                            </button>
                            <button type="button" id="delete-account-btn" class="delete-btn px-6 py-2 text-red-500 focus:outline-none flex items-center">
                                <i class="fas fa-trash-alt mr-2"></i> Delete Account
                            </button>
                        </div>
                    </form>
                </div>
            </div>


            <div id="wishlist-tab" class="bg-white rounded-xl shadow-soft hidden">
                <jsp:include page="../cart/list.jsp"/>
            </div>
        </div>
    </div>
</div>


<div id="delete-modal" class="modal-backdrop fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="modal-content bg-white rounded-xl max-w-md mx-4 w-full transform scale-95">
        <div class="p-6">
            <h3 class="text-xl font-bold text-secondary mb-4">Delete Account</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.</p>
            <div class="flex justify-end space-x-4">
                <button id="cancel-delete-btn" class="px-4 py-2 text-gray-600 hover:text-gray-800 focus:outline-none">
                    Cancel
                </button>
                <button id="confirm-delete-btn" class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2">
                    Delete Account
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let constUser = {}
    document.addEventListener('DOMContentLoaded', function() {
        const userId = localStorage.getItem('userId');
        if (!userId) {
            window.location.href = 'login';
            return;
        }

        const profileTab = document.getElementById('profile-tab');
        const wishlistTab = document.getElementById('wishlist-tab');

        const profileTabBtn = document.getElementById('profile-tab-btn');
        const ordersTabBtn = document.getElementById('orders-tab-btn');
        const wishlistTabBtn = document.getElementById('wishlist-tab-btn');


        profileTab.classList.remove('hidden');

        profileTabBtn.addEventListener('click', function() {
            profileTab.classList.remove('hidden');
            wishlistTab.classList.add('hidden');

            profileTabBtn.classList.add('active', 'text-secondary');
            profileTabBtn.classList.remove('text-gray-600');

            ordersTabBtn.classList.remove('active', 'text-secondary');
            ordersTabBtn.classList.add('text-gray-600');

            wishlistTabBtn.classList.remove('active', 'text-secondary');
            wishlistTabBtn.classList.add('text-gray-600');
        });

        wishlistTabBtn.addEventListener('click', function() {
            wishlistTab.classList.remove('hidden');
            profileTab.classList.add('hidden');

            wishlistTabBtn.classList.add('active', 'text-secondary');
            wishlistTabBtn.classList.remove('text-gray-600');

            profileTabBtn.classList.remove('active', 'text-secondary');
            profileTabBtn.classList.add('text-gray-600');

            ordersTabBtn.classList.remove('active', 'text-secondary');
            ordersTabBtn.classList.add('text-gray-600');

            loadWishlist();
        });

        fetchUserProfile();

        const profileForm = document.getElementById('profile-form');
        profileForm.addEventListener('submit', function(e) {
            e.preventDefault();
            updateUserProfile();
        });

        document.getElementById('logout-btn').addEventListener('click', function() {
            logout();
        });

        const deleteAccountBtn = document.getElementById('delete-account-btn');
        const deleteModal = document.getElementById('delete-modal');
        const cancelDeleteBtn = document.getElementById('cancel-delete-btn');
        const confirmDeleteBtn = document.getElementById('confirm-delete-btn');

        deleteAccountBtn.addEventListener('click', function() {
            deleteModal.classList.remove('hidden');
            setTimeout(() => {
                deleteModal.querySelector('.modal-content').classList.remove('scale-95');
            }, 10);
        });

        cancelDeleteBtn.addEventListener('click', function() {
            deleteModal.classList.add('hidden');
        });

        confirmDeleteBtn.addEventListener('click', function() {
            deleteAccount();
        });

        deleteModal.addEventListener('click', function(e) {
            if (e.target === deleteModal) {
                deleteModal.classList.add('hidden');
            }
        });
    });

    function fetchUserProfile() {
        const userId = localStorage.getItem('userId');

        fetch("/api/users/"+userId, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch user profile');
                }
                return response.json();
            })
            .then(user => {
                constUser = user;
                document.getElementById('user-name').textContent = user.name || 'User';
                document.getElementById('user-email').textContent = user.email || '';

                if (user.imageUrl) {
                    const profileImage = document.getElementById('profile-image');
                    profileImage.src = user.imageUrl;
                    profileImage.classList.remove('hidden');
                    document.getElementById('profile-initial').classList.add('hidden');
                } else {
                    const name = user.name || 'User';
                    const initial = name.charAt(0).toUpperCase();
                    document.getElementById('profile-initial').textContent = initial;
                }

                document.getElementById('fullName').value = user.name || '';
                document.getElementById('email').value = user.email || '';
                document.getElementById('address').value = user.address || '';
            })
            .catch(error => {
                console.error('Error fetching user profile:', error);
                showError('Failed to load user profile. Please try again later.');
            });
    }

    function updateUserProfile() {
        const userId = localStorage.getItem('userId');
        const updateBtn = document.getElementById('update-profile-btn');

        const name = document.getElementById('fullName').value;
        const email = document.getElementById('email').value;
        const address = document.getElementById('address').value;
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (!name || !email) {
            showError('Name and email are required fields.');
            return;
        }

        if (newPassword && newPassword !== confirmPassword) {
            showError('New password and confirmation do not match.');
            return;
        }

        updateBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Saving...';
        updateBtn.disabled = true;

        const payload = {
            name,
            email,
            address,
            gender: constUser.gender,
            password: constUser.password,
        };

        if (currentPassword && newPassword) {
            payload.currentPassword = currentPassword;
            payload.newPassword = newPassword;
            payload.password = newPassword;
        }

        fetch("/api/users/"+userId, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to update profile');
                }
                return response.json();
            })
            .then(updatedUser => {
                if (updatedUser.name) {
                    localStorage.setItem('userName', updatedUser.name);
                }
                if (updatedUser.email) {
                    localStorage.setItem('userEmail', updatedUser.email);
                }

                document.getElementById('currentPassword').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmPassword').value = '';

                document.getElementById('profile-success').classList.remove('hidden');
                document.getElementById('profile-error').classList.add('hidden');

                setTimeout(() => {
                    document.getElementById('profile-success').classList.add('hidden');
                }, 3000);

                fetchUserProfile();
            })
            .catch(error => {
                console.error('Error updating profile:', error);
                showError('Failed to update profile. Please check your information and try again.');
            })
            .finally(() => {
                updateBtn.innerHTML = '<i class="fas fa-save mr-2"></i> Save Changes';
                updateBtn.disabled = false;
            });
    }

    function deleteAccount() {
        const userId = localStorage.getItem('userId');
        const confirmBtn = document.getElementById('confirm-delete-btn');

        confirmBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Deleting...';
        confirmBtn.disabled = true;

        fetch("/api/users/"+userId, {
            method: 'DELETE',
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to delete account');
                }
                logout();
            })
            .catch(error => {
                console.error('Error deleting account:', error);
                document.getElementById('delete-modal').classList.add('hidden');
                showError('Failed to delete account. Please try again later.');
                confirmBtn.innerHTML = 'Delete Account';
                confirmBtn.disabled = false;
            });
    }

    function logout() {
        localStorage.removeItem('userId');
        localStorage.removeItem('token');
        localStorage.removeItem('userName');
        localStorage.removeItem('userEmail');
        localStorage.removeItem('rememberUser');
        window.location.href = 'login';
    }

    function showError(message) {
        const errorElement = document.getElementById('profile-error');
        const errorMessage = document.getElementById('error-message');

        errorMessage.textContent = message;
        errorElement.classList.remove('hidden');
        document.getElementById('profile-success').classList.add('hidden');
        errorElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function loadWishlist() {
        const wishlistContainer = document.getElementById('wishlist-container');
        const userId = localStorage.getItem('userId');

        wishlistContainer.innerHTML = '<p class="text-gray-500 text-center py-8">Loading your wishlist...</p>';

        setTimeout(() => {
            wishlistContainer.innerHTML = "<p class=\"text-gray-500 text-center py-8\"><i class=\"fas fa-heart text-gray-300 text-5xl mb-4 block\"></i>Your wishlist is empty.</p>";
        }, 1000);
    }
</script>
</body>
</html>
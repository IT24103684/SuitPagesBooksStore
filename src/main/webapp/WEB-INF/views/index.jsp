<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LiteraryRealm - Premium Book Collection</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --gold: #D4AF37;
            --deep-blue: #1a365d;
            --velvet: #2d3748;
            --emerald: #10b981;
            --ruby: #dc2626;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg,
            #0f172a 0%,
            #1e293b 50%,
            #0f172a 100%);
            min-height: 100vh;
            color: #e2e8f0;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(16, 185, 129, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(79, 70, 229, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: 1;
        }

        .hero-section {
            background-image:
                    linear-gradient(135deg, rgba(10, 25, 47, 0.95) 0%, rgba(26, 54, 93, 0.95) 100%),
                    url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
            overflow: hidden;
            border-bottom: 3px solid var(--gold);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg,
            transparent 45%,
            rgba(212, 175, 55, 0.1) 50%,
            transparent 55%);
            animation: shine 8s infinite linear;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .book-card {
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            width: 100%;
            max-width: 280px;
            height: 480px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border-radius: 20px;
            overflow: hidden;
            background: linear-gradient(145deg, #1e293b 0%, #334155 100%);
            border: 2px solid rgba(212, 175, 55, 0.2);
            position: relative;
            transform-style: preserve-3d;
            perspective: 1000px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
        }

        .book-card:hover {
            transform: translateY(-15px) rotateX(5deg) rotateY(5deg);
            box-shadow:
                    0 35px 70px rgba(0, 0, 0, 0.7),
                    0 0 100px rgba(212, 175, 55, 0.3);
            border-color: var(--gold);
            border-width: 2px;
        }

        .book-image-container {
            height: 220px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        .book-image-container::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg,
            transparent,
            rgba(212, 175, 55, 0.5),
            transparent);
        }

        .book-image {
            max-height: 180px;
            max-width: 150px;
            object-fit: contain;
            transition: transform 0.6s ease;
            filter: drop-shadow(0 8px 16px rgba(0,0,0,0.5));
            transform-origin: center;
        }

        .book-card:hover .book-image {
            transform: scale(1.15) rotate(1deg);
            filter: drop-shadow(0 12px 24px rgba(0,0,0,0.7));
        }

        .book-content {
            padding: 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .book-title {
            font-size: 17px;
            font-weight: 600;
            color: #f1f5f9;
            margin-bottom: 10px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 48px;
        }

        .book-meta {
            color: #94a3b8;
            font-size: 13px;
            margin-bottom: 5px;
        }

        .book-footer {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 16px;
            border-top: 1px solid rgba(212, 175, 55, 0.1);
        }

        .book-price {
            font-size: 22px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--gold) 0%, #F59E0B 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 15px rgba(212, 175, 55, 0.3);
            position: relative;
            padding-left: 20px;
        }

        .book-price::before {
            content: '$';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            color: var(--gold);
        }

        .stock-indicator {
            font-size: 11px;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 15px;
        }

        .stock-high {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.2) 0%, rgba(16, 185, 129, 0.1) 100%);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .stock-low {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.2) 0%, rgba(245, 158, 11, 0.1) 100%);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .stock-none {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.2) 0%, rgba(239, 68, 68, 0.1) 100%);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .category-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: linear-gradient(135deg, var(--gold) 0%, #B8860B 100%);
            color: #1a202c;
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 0.5px;
            z-index: 2;
            box-shadow: 0 4px 12px rgba(212, 175, 55, 0.3);
        }

        .add-to-cart-btn {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, var(--emerald) 0%, #059669 100%);
            color: white;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
            width: 100%;
            padding: 14px;
            cursor: pointer;
            font-size: 15px;
        }

        .add-to-cart-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.2),
            transparent);
            transition: left 0.6s ease;
        }

        .add-to-cart-btn:hover:not(:disabled) {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            transform: translateY(-2px);
            box-shadow:
                    0 10px 25px rgba(16, 185, 129, 0.4),
                    inset 0 2px 10px rgba(255, 255, 255, 0.2);
            letter-spacing: 1px;
        }

        .add-to-cart-btn:hover:not(:disabled)::before {
            left: 100%;
        }

        .add-to-cart-btn:disabled {
            background: linear-gradient(135deg, #475569 0%, #64748b 100%);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .category-btn {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #334155 0%, #475569 100%);
            color: #cbd5e1;
            border: 1px solid rgba(148, 163, 184, 0.2);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            padding: 10px 20px;
            font-weight: 500;
        }

        .category-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg,
            transparent,
            rgba(212, 175, 55, 0.2),
            transparent);
            transition: left 0.6s ease;
        }

        .category-btn:hover::before {
            left: 100%;
        }

        .category-btn.active {
            background: linear-gradient(135deg, var(--gold) 0%, #B8860B 100%);
            color: #1a202c;
            font-weight: 600;
            border-color: var(--gold);
            box-shadow:
                    0 0 30px rgba(212, 175, 55, 0.6),
                    inset 0 2px 10px rgba(255, 255, 255, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        #searchInput {
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid rgba(212, 175, 55, 0.3);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        #searchInput:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow:
                    0 15px 40px rgba(0, 0, 0, 0.3),
                    0 0 20px rgba(212, 175, 55, 0.2);
            transform: translateY(-2px);
        }

        #searchInput + button {
            transition: all 0.3s ease;
            background: linear-gradient(135deg, var(--gold) 0%, #B8860B 100%);
        }

        #searchInput + button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(212, 175, 55, 0.4);
        }

        #authorsContainer > div {
            transition: all 0.4s ease;
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        #authorsContainer > div:hover {
            transform: translateY(-10px);
            box-shadow:
                    0 20px 40px rgba(0, 0, 0, 0.4),
                    0 0 30px rgba(212, 175, 55, 0.2);
            border-color: var(--gold);
        }

        #authorsContainer img {
            border: 3px solid var(--gold);
            padding: 3px;
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
        }

        #loadingIndicator > div {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(212, 175, 55, 0.3);
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        #noResults {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            border: 2px solid rgba(212, 175, 55, 0.3);
            border-radius: 20px;
            padding: 60px 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        #noResults i {
            color: var(--gold);
            filter: drop-shadow(0 4px 8px rgba(212, 175, 55, 0.3));
        }

        .bg-indigo-700 {
            background: linear-gradient(135deg, var(--deep-blue) 0%, #2d3748 100%);
            position: relative;
            overflow: hidden;
        }

        .bg-indigo-700::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 20% 50%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 50%, rgba(16, 185, 129, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .bg-indigo-700 input[type="email"] {
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid rgba(212, 175, 55, 0.3);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .bg-indigo-700 input[type="email"]:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow:
                    0 15px 40px rgba(0, 0, 0, 0.3),
                    0 0 20px rgba(212, 175, 55, 0.2);
        }

        footer {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-top: 3px solid var(--gold);
            position: relative;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg,
            transparent,
            rgba(212, 175, 55, 0.5),
            transparent);
        }

        footer a:hover {
            color: var(--gold);
            transform: translateX(5px);
            transition: all 0.3s ease;
        }

        footer .text-gray-400:hover {
            color: var(--gold) !important;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(135deg, #334155 0%, #475569 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #cbd5e1;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: linear-gradient(135deg, var(--gold) 0%, #B8860B 100%);
            color: #1a202c;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(212, 175, 55, 0.3);
        }
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="common/navbar.jsp"/>

<!-- Hero Section -->
<div class="hero-section py-16 md:py-24">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h1 class="text-4xl md:text-5xl font-extrabold text-white tracking-tight">
            Discover Worlds Beyond Your Imagination
        </h1>
        <p class="mt-4 text-xl text-gray-300 max-w-3xl mx-auto">
            Explore our curated collection of premium literature from renowned authors around the globe.
        </p>
        <div class="mt-8 max-w-md mx-auto">
            <div class="flex">
                <input
                        id="searchInput"
                        type="text"
                        class="w-full px-5 py-3 focus:ring-indigo-500 focus:border-indigo-500 block rounded-l-md border-gray-300 shadow-sm"
                        placeholder="Search by title, author, or ISBN">
                <button
                        type="button"
                        class="flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-r-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Category Filters  -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-8">
    <div class="flex flex-wrap items-center justify-center gap-3" id="categoryFilters">
        <button class="category-btn px-4 py-2 bg-indigo-600 text-white rounded-full text-sm font-medium hover:bg-indigo-700" data-category="all">All Books</button>
        <button class="category-btn px-4 py-2 bg-gray-200 text-gray-800 rounded-full text-sm font-medium hover:bg-gray-300" data-category="Fiction">Fiction</button>
        <button class="category-btn px-4 py-2 bg-gray-200 text-gray-800 rounded-full text-sm font-medium hover:bg-gray-300" data-category="Science">Science</button>
        <button class="category-btn px-4 py-2 bg-gray-200 text-gray-800 rounded-full text-sm font-medium hover:bg-gray-300" data-category="Fantasy">Fantasy</button>
        <button class="category-btn px-4 py-2 bg-gray-200 text-gray-800 rounded-full text-sm font-medium hover:bg-gray-300" data-category="Biography">Biography</button>
        <button class="category-btn px-4 py-2 bg-gray-200 text-gray-800 rounded-full text-sm font-medium hover:bg-gray-300" data-category="History">History</button>
    </div>
</div>

<!-- Books Section  -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <h2 class="text-3xl font-extrabold mb-8">Featured Books</h2>
    <div id="loadingIndicator" class="flex justify-center items-center py-20">
        <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-indigo-600"></div>
    </div>
    <div id="booksContainer" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
    </div>
    <div id="noResults" class="hidden text-center py-20">
        <i class="fas fa-book-open text-5xl text-gray-300 mb-4"></i>
        <p class="text-xl font-medium text-gray-500">No books found matching your criteria</p>
        <button id="clearFilters" class="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-md text-sm font-medium hover:bg-indigo-700">
            Clear Filters
        </button>
    </div>
</div>

<!-- Authors Section  -->
<div class="bg-gray-100 py-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-extrabold text-gray-900 mb-8">Featured Authors</h2>
        <div id="authorsContainer" class="flex flex-wrap justify-center gap-6">
        </div>
    </div>
</div>

<!-- Newsletter Section -->
<div class="bg-indigo-700 text-white py-16">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h2 class="text-3xl font-extrabold mb-4">Stay Updated with New Releases</h2>
        <p class="max-w-2xl mx-auto mb-8 text-indigo-100">Subscribe to our newsletter and be the first to know about new books, exclusive offers and literary events.</p>
        <div class="max-w-md mx-auto">
            <div class="flex">
                <input type="email" class="w-full px-5 py-3 text-gray-900 focus:ring-indigo-500 focus:border-indigo-500 block rounded-l-md border-gray-300 shadow-sm" placeholder="Enter your email">
                <button type="button" class="flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-r-md text-indigo-700 bg-white hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Subscribe
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Feedback Section -->
<jsp:include page="./feedbacks/all.jsp"/>

<!-- Footer -->
<footer class="bg-gray-800 text-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
                <h3 class="text-xl font-semibold mb-4">LiteraryRealm</h3>
                <p class="text-gray-400">Your premier destination for quality literature from around the world.</p>
                <div class="mt-6 flex space-x-4">
                    <a href="#" class="social-icon">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="social-icon">
                        <i class="fab fa-pinterest"></i>
                    </a>
                </div>
            </div>
            <div>
                <h3 class="text-xl font-semibold mb-4">Quick Links</h3>
                <ul class="space-y-2">
                    <li><a href="#" class="text-gray-400 hover:text-white">About Us</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white">Contact</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white">Privacy Policy</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white">Terms of Service</a></li>
                    <li><a href="#" class="text-gray-400 hover:text-white">Shipping Information</a></li>
                </ul>
            </div>
            <div>
                <h3 class="text-xl font-semibold mb-4">Contact Us</h3>
                <ul class="space-y-2 text-gray-400">
                    <li class="flex items-center">
                        <i class="fas fa-map-marker-alt mr-3"></i>
                        <span>123 Book Street, Galle, Srilanka</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-phone mr-3"></i>
                        <span>+7441 118 890 0</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-envelope mr-3"></i>
                        <span>info@SuitPages.com</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2025 SuitPages. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const userId = localStorage.getItem("userId");
        const isLoggedIn = !!userId;

        let allBooks = [];
        let allAuthors = [];
        let filteredBooks = [];
        let currentCategory = "all";
        let currentSearchTerm = "";

        const booksContainer = document.getElementById("booksContainer");
        const authorsContainer = document.getElementById("authorsContainer");
        const loadingIndicator = document.getElementById("loadingIndicator");
        const noResults = document.getElementById("noResults");
        const searchInput = document.getElementById("searchInput");
        const categoryButtons = document.querySelectorAll(".category-btn");
        const clearFiltersBtn = document.getElementById("clearFilters");

        async function fetchBooks() {
            try {
                const response = await fetch("/api/books");
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }

                allBooks = await response.json();
                filteredBooks = [...allBooks];
                renderBooks(filteredBooks);
            } catch (error) {
                console.error("Error fetching books:", error);
                loadingIndicator.innerHTML = "<p class='text-red-500'>Failed to load books. Please try again later.</p>";
            } finally {
                loadingIndicator.classList.add("hidden");
            }
        }

        async function fetchAuthors() {
            try {
                const response = await fetch("/api/authors");
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                allAuthors = await response.json();
                renderFeaturedAuthors(allAuthors.slice(3, 6));
            } catch (error) {
                console.error("Error fetching authors:", error);
            }
        }

        function getAuthorById(authorId) {
            return allAuthors.find(author => author.id === authorId) || null;
        }

        function renderFeaturedAuthors(authors) {
            authorsContainer.innerHTML = "";

            authors.forEach(author => {
                const authorCard = document.createElement("div");
                authorCard.className = "bg-white p-6 rounded-lg shadow-md max-w-xs";

                authorCard.innerHTML =
                    "<div class='flex justify-center'>" +
                    "<div class='h-32 w-32 rounded-full overflow-hidden'>" +
                    "<img src='" + (author.imageUrl || "https://via.placeholder.com/200") + "' alt='" + author.name + "' class='h-full w-full object-cover'>" +
                    "</div>" +
                    "</div>" +
                    "<div class='mt-4 text-center'>" +
                    "<h3 class='text-lg font-bold'>" + author.name + "</h3>" +
                    "<p class='text-gold-600 mt-1'>" + (author.gender || "Author") + "</p>" +
                    "<p class='mt-3 text-sm text-gray-500'>" + (author.bio || "Renowned author with multiple publications") + "</p>" +
                    "</div>";

                authorsContainer.appendChild(authorCard);
            });
        }

        function renderBooks(books) {
            if (books.length === 0) {
                booksContainer.innerHTML = "";
                noResults.classList.remove("hidden");
                return;
            }

            noResults.classList.add("hidden");
            booksContainer.innerHTML = "";

            books.forEach(book => {
                const author = getAuthorById(book.authorId);
                const bookCard = document.createElement("div");
                bookCard.className = "book-card bg-white rounded-lg shadow-md overflow-hidden";

                const addToCartButton = isLoggedIn ?
                    "<button class='add-to-cart-btn w-full py-2  text-white font-medium hover:bg-indigo-700 transition-colors' data-id='" + book.id + "'>" +
                    "<i class='fas fa-shopping-cart mr-2'></i>Add to Cart" +
                    "</button>" :
                    "<button class='w-full py-2 bg-gray-300 text-gray-600 font-medium cursor-not-allowed'>" +
                    "<i class='fas fa-user mr-2'></i>Login to Purchase" +
                    "</button>";

                bookCard.innerHTML =
                    "<div class='overflow-hidden flex justify-center items-center' style='height: 160px;'>" +
                    "<img src='" + (book.imageUrl || "https://via.placeholder.com/300x400?text=No+Image") + "' alt='" + book.name + "' class='max-h-full max-w-full object-contain'>" +
                    "</div>" +
                    "<div class='p-4'>" +
                    "<div class='flex justify-between items-start'>" +
                    "<h3 class='text-lg font-bold '>" + book.name + "</h3>" +
                    "<span class='px-2 py-1 bg-indigo-100 text-indigo-800 text-xs font-medium rounded-full'>" + book.category + "</span>" +
                    "</div>" +
                    "<p class='text-sm  mt-1'>ISBN: " + book.isbn + "</p>" +
                    (author ? "<p class='text-sm  mt-1'>Author: " + author.name + "</p>" : "") +
                    "<div class='mt-4 flex justify-between items-center'>" +
                    "<p class='text-lg font-bold '>$" + book.price.toFixed(2) + "</p>" +
                    "<p class='text-sm " + (book.inStock > 10 ? "text-green-600" : book.inStock > 0 ? "text-yellow-600" : "text-red-600") + "'>" +
                    (book.inStock > 10 ? "In Stock" : book.inStock > 0 ? "Low Stock" : "Out of Stock") +
                    "</p>" +
                    "</div>" +
                    "</div>" +
                    "<div class='border-t border-gray-200'>" +
                    addToCartButton +
                    "</div>";

                booksContainer.appendChild(bookCard);
            });

            if (isLoggedIn) {
                document.querySelectorAll(".add-to-cart-btn").forEach(button => {
                    button.addEventListener("click",async function() {
                        const bookId = this.getAttribute("data-id");

                        await  fetch("/api/carts/" + userId+"/items", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify({
                                bookId: bookId,
                                quantity: 1
                            })
                        });

                        alert("Item added to cart")

                        const cartCount = document.getElementById("cartCount");
                        cartCount.textContent = parseInt(cartCount.textContent) + 1;
                    });
                });
            }
        }

        function filterBooks() {
            filteredBooks = allBooks.filter(book => {
                const categoryMatch = currentCategory === "all" || book.category === currentCategory;

                const searchLower = currentSearchTerm.toLowerCase();
                const bookAuthor = getAuthorById(book.authorId);
                const authorName = bookAuthor ? bookAuthor.name.toLowerCase() : "";

                const searchMatch =
                    book.name.toLowerCase().includes(searchLower) ||
                    book.isbn.toLowerCase().includes(searchLower) ||
                    book.category.toLowerCase().includes(searchLower) ||
                    authorName.includes(searchLower);

                return categoryMatch && searchMatch;
            });

            renderBooks(filteredBooks);
        }

        categoryButtons.forEach(button => {
            button.addEventListener("click", function() {
                categoryButtons.forEach(btn => {
                    btn.classList.remove("bg-indigo-600", "text-white");
                    btn.classList.add("bg-gray-200", "text-gray-800");
                });

                this.classList.remove("bg-gray-200", "text-gray-800");
                this.classList.add("bg-indigo-600", "text-white");

                currentCategory = this.getAttribute("data-category");
                filterBooks();
            });
        });

        searchInput.addEventListener("input", function() {
            currentSearchTerm = this.value;
            filterBooks();
        });

        clearFiltersBtn.addEventListener("click", function() {
            searchInput.value = "";
            currentSearchTerm = "";

            currentCategory = "all";
            categoryButtons.forEach(btn => {
                if (btn.getAttribute("data-category") === "all") {
                    btn.classList.remove("bg-gray-200", "text-gray-800");
                    btn.classList.add("bg-indigo-600", "text-white");
                } else {
                    btn.classList.remove("bg-indigo-600", "text-white");
                    btn.classList.add("bg-gray-200", "text-gray-800");
                }
            });

            filteredBooks = [...allBooks];
            renderBooks(filteredBooks);
        });

        fetchBooks();
        fetchAuthors();
    });
</script>
</body>
</html>
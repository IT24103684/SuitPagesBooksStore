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
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .book-card {
            transition: all 0.3s ease;
            width: 100%;
            max-width: 250px;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .book-card img {
            width: 100%;
            height: 200px;
            object-fit: contain; /* Changed to contain to show full image */
            background-color: #f9f9f9; /* Optional: Adds a light background if image is smaller */
        }
        .book-card .p-4 {
            padding: 1rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .book-card .border-t {
            padding: 0.5rem;
        }
        .hero-section {
            background-image: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="common/navbar.jsp"/>

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

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <h2 class="text-3xl font-extrabold text-gray-900 mb-8">Featured Books</h2>
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

<div class="bg-gray-100 py-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-extrabold text-gray-900 mb-8">Featured Authors</h2>
        <div id="authorsContainer" class="flex flex-wrap justify-center gap-6">
        </div>
    </div>
</div>

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
<jsp:include page="./feedbacks/all.jsp"/>
<footer class="bg-gray-800 text-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
                <h3 class="text-xl font-semibold mb-4">LiteraryRealm</h3>
                <p class="text-gray-400">Your premier destination for quality literature from around the world.</p>
                <div class="mt-6 flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-white">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-white">
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
                        <span>123 Book Street, Reading, RG1 2LR</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-phone mr-3"></i>
                        <span>+44 (0) 123 456 7890</span>
                    </li>
                    <li class="flex items-center">
                        <i class="fas fa-envelope mr-3"></i>
                        <span>info@literaryrealm.com</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2025 LiteraryRealm. All rights reserved.</p>
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
                renderFeaturedAuthors(allAuthors.slice(3, 6)); // Show first 3 authors as featured
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
                    "<p class='text-gray-600 mt-1'>" + (author.gender || "Author") + "</p>" +
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
                    "<button class='add-to-cart-btn w-full py-2 bg-indigo-600 text-white font-medium hover:bg-indigo-700 transition-colors' data-id='" + book.id + "'>" +
                    "<i class='fas fa-shopping-cart mr-2'></i>Add to Cart" +
                    "</button>" :
                    "<button class='w-full py-2 bg-gray-300 text-gray-600 font-medium cursor-not-allowed'>" +
                    "<i class='fas fa-user mr-2'></i>Login to Purchase" +
                    "</button>";

                bookCard.innerHTML =
                    "<div class='overflow-hidden flex justify-center items-center' style='height: 160px;'>" + // Keep a fixed height for the container
                    "<img src='" + (book.imageUrl || "https://via.placeholder.com/300x400?text=No+Image") + "' alt='" + book.name + "' class='max-h-full max-w-full object-contain'>" + // Use object-contain to show the full image
                    "</div>" +
                    "<div class='p-4'>" +
                    "<div class='flex justify-between items-start'>" +
                    "<h3 class='text-lg font-bold text-gray-900'>" + book.name + "</h3>" +
                    "<span class='px-2 py-1 bg-indigo-100 text-indigo-800 text-xs font-medium rounded-full'>" + book.category + "</span>" +
                    "</div>" +
                    "<p class='text-sm text-gray-500 mt-1'>ISBN: " + book.isbn + "</p>" +
                    (author ? "<p class='text-sm text-gray-600 mt-1'>Author: " + author.name + "</p>" : "") +
                    "<div class='mt-4 flex justify-between items-center'>" +
                    "<p class='text-lg font-bold text-indigo-600'>$" + book.price.toFixed(2) + "</p>" +
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

            // Reset filters and render all books
            filteredBooks = [...allBooks];
            renderBooks(filteredBooks);
        });

        // Initialize: fetch books and authors
        fetchBooks();
        fetchAuthors();
    });
</script>
</body>
</html>
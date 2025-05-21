<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Book</title>
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
        <h1 class="text-2xl font-bold text-gray-800">Create New Book</h1>
        <a href="${pageContext.request.contextPath}/books" class="bg-gray-100 text-gray-700 hover:bg-gray-200 py-2 px-4 rounded-lg border text-sm flex items-center transition-colors">
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

    <form id="bookForm" class="space-y-6">
        <div class="relative">
            <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Book Title</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="book" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter book title"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="nameError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="isbn" class="block text-sm font-medium text-gray-700 mb-1">ISBN</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="barcode" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="text"
                        id="isbn"
                        name="isbn"
                        placeholder="Enter ISBN"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="isbnError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="category" class="block text-sm font-medium text-gray-700 mb-1">Category</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="tag" class="h-5 w-5 text-gray-400"></i>
                </div>
                <select
                        id="category"
                        name="category"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm text-gray-700 appearance-none focus:border-blue-500"
                        required>
                    <option value="">Select Category</option>
                    <option value="Fiction">Fiction</option>
                    <option value="Non-Fiction">Non-Fiction</option>
                    <option value="Science">Science</option>
                    <option value="Technology">Technology</option>
                    <option value="History">History</option>
                    <option value="Biography">Biography</option>
                    <option value="Self-Help">Self-Help</option>
                    <option value="Children">Children</option>
                    <option value="Other">Other</option>
                </select>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                    <i data-lucide="chevron-down" class="h-4 w-4 text-gray-400"></i>
                </div>
            </div>
            <p id="categoryError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Price</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="dollar-sign" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="number"
                        id="price"
                        name="price"
                        min="0"
                        step="0.01"
                        placeholder="Enter price"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="priceError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="inStock" class="block text-sm font-medium text-gray-700 mb-1">Stock Quantity</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="package" class="h-5 w-5 text-gray-400"></i>
                </div>
                <input
                        type="number"
                        id="inStock"
                        name="inStock"
                        min="0"
                        placeholder="Enter stock quantity"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500"
                        required>
            </div>
            <p id="inStockError" class="text-red-500 text-xs mt-1 hidden"></p>
        </div>

        <div class="relative">
            <label for="authorId" class="block text-sm font-medium text-gray-700 mb-1">Author</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i data-lucide="user" class="h-5 w-5 text-gray-400"></i>
                </div>
                <select
                        id="authorId"
                        name="authorId"
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm text-gray-700 appearance-none focus:border-blue-500"
                        required>
                    <option value="">Select Author</option>
                </select>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                    <i data-lucide="chevron-down" class="h-4 w-4 text-gray-400"></i>
                </div>
            </div>
            <p id="authorIdError" class="text-red-500 text-xs mt-1 hidden"></p>
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
                        class="focus-ring w-full rounded-lg border border-gray-300 pl-10 pr-3 py-2 text-sm shadow-sm placeholder:text-gray-400 focus:border-blue-500">
            </div>
            <p id="imageUrlError" class="text-red-500 text-xs mt-1 hidden"></p>
            <p class="text-gray-500 text-xs mt-1">Optional: URL to book cover image</p>
        </div>

        <div>
            <button type="submit" id="submitBtn"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 flex items-center justify-center transition-colors">
                <i data-lucide="save" class="h-5 w-5 mr-2"></i>
                Create Book
            </button>
        </div>
    </form>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        lucide.createIcons();

        const bookForm = document.getElementById('bookForm');
        const errorMessage = document.getElementById('errorMessage');
        const successMessage = document.getElementById('successMessage');
        const submitBtn = document.getElementById('submitBtn');
        const authorSelect = document.getElementById('authorId');

        fetchAuthors();

        const patterns = {
            name: /^.{2,100}$/,
            isbn: /^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$/,
            imageUrl: /^(https?:\/\/.*\.(?:png|jpg|jpeg|gif|webp))?$/
        };

        function fetchAuthors() {
            fetch('/api/authors')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to fetch authors');
                    }
                    return response.json();
                })
                .then(authors => {
                    while (authorSelect.options.length > 1) {
                        authorSelect.remove(1);
                    }

                    authors.forEach(author => {
                        const option = document.createElement('option');
                        option.value = author.id;
                        option.textContent = author.name;
                        authorSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    showError('Failed to load authors: ' + error.message);
                });
        }

        function validateField(field, pattern) {
            const errorElement = document.getElementById(field.id + "Error");

            if (field.required && !field.value.trim()) {
                errorElement.textContent = field.name.charAt(0).toUpperCase() + field.name.slice(1) + " is required";
                errorElement.classList.remove("hidden");
                return false;
            }

            if (pattern && field.value.trim() && !pattern.test(field.value.trim())) {
                if (field.id === 'name') {
                    errorElement.textContent = 'Title should be between 2-100 characters';
                } else if (field.id === 'isbn') {
                    errorElement.textContent = 'Please enter a valid ISBN (10 or 13 digits)';
                } else if (field.id === 'imageUrl') {
                    errorElement.textContent = 'Please enter a valid image URL (or leave empty)';
                }
                errorElement.classList.remove('hidden');
                return false;
            }

            if ((field.id === 'price' || field.id === 'inStock') && field.value < 0) {
                errorElement.textContent = field.id === 'price' ? 'Price must be greater than or equal to 0' : 'Stock quantity must be greater than or equal to 0';
                errorElement.classList.remove('hidden');
                return false;
            }

            errorElement.classList.add('hidden');
            return true;
        }

        function showError(message) {
            errorMessage.querySelector('span').textContent = message;
            errorMessage.classList.remove('hidden');
            successMessage.classList.add('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function showSuccess(message) {
            successMessage.querySelector('span').textContent = message;
            successMessage.classList.remove('hidden');
            errorMessage.classList.add('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        bookForm.addEventListener('submit', function(e) {
            e.preventDefault();

            errorMessage.classList.add('hidden');
            successMessage.classList.add('hidden');

            const name = document.getElementById('name');
            const isbn = document.getElementById('isbn');
            const category = document.getElementById('category');
            const price = document.getElementById('price');
            const inStock = document.getElementById('inStock');
            const authorId = document.getElementById('authorId');
            const imageUrl = document.getElementById('imageUrl');

            const isNameValid = validateField(name, patterns.name);
            const isIsbnValid = validateField(isbn, patterns.isbn);
            const isCategoryValid = validateField(category);
            const isPriceValid = validateField(price);
            const isInStockValid = validateField(inStock);
            const isAuthorIdValid = validateField(authorId);
            const isImageUrlValid = validateField(imageUrl, patterns.imageUrl);

            if (isNameValid && isIsbnValid && isCategoryValid && isPriceValid && isInStockValid && isAuthorIdValid && isImageUrlValid) {

                submitBtn.disabled = true;
                submitBtn.innerHTML = '<svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Processing...';

                const bookData = {
                    name: name.value.trim(),
                    isbn: isbn.value.trim(),
                    category: category.value,
                    price: parseFloat(price.value),
                    inStock: parseInt(inStock.value),
                    authorId: authorId.value,
                    imageUrl: imageUrl.value.trim() || null
                };

                fetch('/api/books', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(bookData)
                })
                    .then(response => {
                        if (!response.ok) {
                            return response.text().then(text => {
                                throw new Error(text || 'Failed to create book');
                            });
                        }
                        return response.json();
                    })
                    .then(data => {
                        bookForm.reset();

                        showSuccess('Book created successfully!');

                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i data-lucide="save" class="h-5 w-5 mr-2"></i>Create Book';
                        lucide.createIcons();
                        y
                        setTimeout(() => {
                            window.location.href = '/books';
                        }, 2000);
                    })
                    .catch(error => {
                        showError(error.message || 'An error occurred while creating the book');

                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i data-lucide="save" class="h-5 w-5 mr-2"></i>Create Book';
                        lucide.createIcons();
                    });
            }
        });
    });
</script>
</body>
</html>
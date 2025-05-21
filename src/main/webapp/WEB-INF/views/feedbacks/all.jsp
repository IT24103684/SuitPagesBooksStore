<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Feedback - BookStore</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .feedback-card {
            transition: all 0.3s ease;
            border-radius: 0.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        .feedback-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .star-rating {
            color: #fbbf24;
            font-size: 1rem;
        }
        .empty-star {
            color: #d1d5db;
            font-size: 1rem;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .book-select-card {
            cursor: pointer;
            transition: all 0.2s ease;
            border: 2px solid transparent;
        }
        .book-select-card:hover {
            background-color: #f3f4f6;
        }
        .book-select-card.selected {
            border: 2px solid #3b82f6;
            background-color: #eff6ff;
        }
    </style>
</head>
<body class="bg-gray-50">
    

    <div class="container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-gray-800">Book Feedback</h1>
            <button id="addFeedbackBtn" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg">
                <i class="fas fa-plus mr-2"></i>Add Feedback
            </button>
        </div>
        
        <div id="createFeedbackSection" class="hidden mb-8 bg-white p-6 rounded-lg shadow-md">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold">Add New Feedback</h2>
                <button id="closeCreateSection" class="text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <form id="createFeedbackForm">
                <div class="mb-4">
                    <label for="createBookSelect" class="block text-sm font-medium text-gray-700 mb-2">Book</label>
                    <select id="createBookSelect" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        <option value="">Select a book</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="createStars" class="block text-sm font-medium text-gray-700 mb-2">Rating</label>
                    <div class="flex space-x-1" id="createStarRating">
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="1"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="2"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="3"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="4"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="5"></i>
                    </div>
                    <input type="hidden" id="createStars" name="stars" required>
                </div>

                <div class="mb-4">
                    <label for="createComment" class="block text-sm font-medium text-gray-700 mb-2">Comment</label>
                    <textarea id="createComment" name="comment" rows="4"
                              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>

                <div class="flex justify-end space-x-3">
                    <button type="button" id="cancelCreateBtn" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">Submit</button>
                </div>
            </form>
        </div>
        
        <div id="bookSelectionSection" class="hidden mb-8">
            <h2 class="text-xl font-semibold mb-4">Select a Book to Review</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4" id="booksContainer">
            </div>
        </div>
        
        <div id="feedbacksContainer" class="space-y-6">
            <div class="text-center py-12">
                <div class="inline-block animate-spin rounded-full h-8 w-8 border-t-2 border-b-2 border-blue-500"></div>
                <p class="mt-2 text-gray-600">Loading feedbacks...</p>
            </div>
        </div>
    </div>
    
    <div id="editFeedbackModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
        <div class="relative top-20 mx-auto p-5 border w-full max-w-md shadow-lg rounded-md bg-white">
            <div class="flex justify-between items-center pb-3">
                <h3 class="text-xl font-medium text-gray-900" id="modalTitle">Edit Feedback</h3>
                <button type="button" class="text-gray-400 hover:text-gray-500" id="closeEditModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="editFeedbackForm">
                <input type="hidden" id="feedbackId">
                <div class="mb-4">
                    <label for="bookSelect" class="block text-sm font-medium text-gray-700 mb-2">Book</label>
                    <select id="bookSelect" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        <option value="">Select a book</option>
                    </select>
                </div>
                <input type="hidden" id="userId">

                <div class="mb-4">
                    <label for="stars" class="block text-sm font-medium text-gray-700 mb-2">Rating</label>
                    <div class="flex space-x-1" id="starRating">
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="1"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="2"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="3"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="4"></i>
                        <i class="fas fa-star text-2xl cursor-pointer" data-rating="5"></i>
                    </div>
                    <input type="hidden" id="stars" name="stars" required>
                </div>

                <div class="mb-4">
                    <label for="comment" class="block text-sm font-medium text-gray-700 mb-2">Comment</label>
                    <textarea id="comment" name="comment" rows="4"
                              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>

                <div class="flex justify-end space-x-3">
                    <button type="button" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300" id="cancelEditBtn">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">Update</button>
                </div>
            </form>
        </div>
    </div>
    
    <div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
        <div class="relative top-20 mx-auto p-5 border w-full max-w-md shadow-lg rounded-md bg-white">
            <div class="flex justify-between items-center pb-3">
                <h3 class="text-xl font-medium text-gray-900">Confirm Delete</h3>
                <button type="button" class="text-gray-400 hover:text-gray-500" id="closeDeleteModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="py-4">
                <p class="text-gray-700">Are you sure you want to delete this feedback? This action cannot be undone.</p>
            </div>
            <div class="flex justify-end space-x-3">
                <button type="button" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300" id="cancelDeleteBtn">Cancel</button>
                <button type="button" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700" id="confirmDeleteBtn">Delete</button>
            </div>
        </div>
    </div>

    <script>
        let currentUserId = localStorage.getItem('userId');
        let books = [];
        let feedbacks = [];
        let selectedBookId = null;
        let feedbackToDelete = null;
        
        const editFeedbackModal = document.getElementById('editFeedbackModal');
        const deleteModal = document.getElementById('deleteModal');
        const createFeedbackSection = document.getElementById('createFeedbackSection');

        document.addEventListener('DOMContentLoaded', function() {
            
            
            loadBooks();
            loadFeedbacks();
            
            setupStarRating();
            setupCreateStarRating();
            setupFormSubmit();
            setupModalControls();
            
            document.getElementById('addFeedbackBtn').addEventListener('click', function() {
                createFeedbackSection.classList.remove('hidden');
            });
            
            document.getElementById('closeCreateSection').addEventListener('click', function() {
                createFeedbackSection.classList.add('hidden');
            });
            
            document.getElementById('cancelCreateBtn').addEventListener('click', function() {
                createFeedbackSection.classList.add('hidden');
            });
        });

        function setupModalControls() {
            document.getElementById('closeEditModal').addEventListener('click', () => {
                editFeedbackModal.classList.add('hidden');
            });
            document.getElementById('cancelEditBtn').addEventListener('click', () => {
                editFeedbackModal.classList.add('hidden');
            });
            
            document.getElementById('closeDeleteModal').addEventListener('click', () => {
                deleteModal.classList.add('hidden');
            });

        }

        async   function   deleteFeedbacks(id){
            try {

                const response = await fetch(`/api/feedbacks/`+id, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (response.ok) {
                    const feedbackElement = document.querySelector(".feedback-card[data-id=\"" + id + "\"]");
                    if (feedbackElement) {
                        feedbackElement.remove();
                    }
                    
                    loadFeedbacks();
                    
                    alert('Feedback deleted successfully');
                } else {
                    alert('Failed to delete feedback');
                }
            } catch (error) {
                console.error('Error deleting feedback:', error);
                showAlert('An error occurred while deleting feedback', 'error');
            } finally {
                deleteModal.classList.add('hidden');
            }
        }

        function loadBooks() {
            fetch('/api/books')
                .then(response => response.json())
                .then(data => {
                    books = data;
                    populateBookSelect();
                    populateCreateBookSelect();
                })
                .catch(error => {
                    console.error('Error loading books:', error);
                });
        }

        function populateBookSelect() {
            const bookSelect = document.getElementById('bookSelect');
            bookSelect.innerHTML = '<option value="">Select a book</option>';

            books.forEach(book => {
                const option = document.createElement('option');
                option.value = book.id;
                option.textContent = book.name;
                bookSelect.appendChild(option);
            });
        }
        
        function populateCreateBookSelect() {
            const bookSelect = document.getElementById('createBookSelect');
            bookSelect.innerHTML = '<option value="">Select a book</option>';

            books.forEach(book => {
                const option = document.createElement('option');
                option.value = book.id;
                option.textContent = book.name;
                bookSelect.appendChild(option);
            });
        }

        function loadFeedbacks() {
            fetch('/api/feedbacks')
                .then(response => response.json())
                .then(data => {
                    feedbacks = data;
                    renderFeedbacks();
                })
                .catch(error => {
                    console.error('Error loading feedbacks:', error);
                    document.getElementById('feedbacksContainer').innerHTML =
                        '<div class="alert alert-danger">Failed to load feedbacks</div>';
                });
        }

        function renderBooks() {
            const container = document.getElementById('booksContainer');
            container.innerHTML = '';

            books.forEach(book => {
                const bookDiv = document.createElement('div');
                bookDiv.className = 'book-select-card p-4 border rounded-lg';
                bookDiv.dataset.bookId = book.id;
                bookDiv.innerHTML =
                    '<div class="flex items-center space-x-4">' +
                    '<img src="' + (book.imageUrl || 'https://via.placeholder.com/60x90') + '" alt="' + book.name + '" class="w-16 h-24 object-cover rounded">' +
                    '<div>' +
                    '<h5 class="font-medium">' + book.name + '</h5>' +
                    '<p class="text-sm text-gray-600">' + book.category + '</p>' +
                    '</div>' +
                    '</div>';

                bookDiv.addEventListener('click', function() {
                    document.querySelectorAll('.book-select-card').forEach(card => {
                        card.classList.remove('selected');
                    });
                    this.classList.add('selected');
                    selectedBookId = this.dataset.bookId;
                    showFeedbackForm();
                });

                container.appendChild(bookDiv);
            });
        }

        function renderFeedbacks() {
            const container = document.getElementById('feedbacksContainer');

            if (feedbacks.length === 0) {
                container.innerHTML =
                    '<div class="text-center py-12">' +
                    '<i class="fas fa-comment-slash text-4xl text-gray-300 mb-4"></i>' +
                    '<p class="text-gray-600">No feedbacks yet. Be the first to review!</p>' +
                    '</div>';
                return;
            }

            container.innerHTML = '';
            
            const feedbacksByBook = {};
            feedbacks.forEach(feedback => {
                if (!feedbacksByBook[feedback.bookId]) {
                    feedbacksByBook[feedback.bookId] = [];
                }
                feedbacksByBook[feedback.bookId].push(feedback);
            });
            
            Object.keys(feedbacksByBook).forEach(bookId => {
                const book = books.find(b => b.id === bookId);
                if (!book) return;

                const bookSection = document.createElement('div');
                bookSection.className = 'mb-8';
                bookSection.innerHTML =
                    '<div class="flex items-center mb-4">' +
                    '<img src="' + (book.imageUrl || 'https://via.placeholder.com/60x90') + '" alt="' + book.name + '" class="w-12 h-16 object-cover rounded mr-3">' +
                    '<h3 class="text-xl font-semibold">' + book.name + '</h3>' +
                    '</div>';

                const feedbacksList = document.createElement('div');
                feedbacksList.className = 'space-y-4';

                feedbacksByBook[bookId].forEach(feedback => {
                    const feedbackDiv = document.createElement('div');
                    feedbackDiv.className = 'feedback-card bg-white p-4 rounded-lg border border-gray-200 hover:border-blue-300';
                    feedbackDiv.dataset.id = feedback.id;

                    let feedbackHtml =
                        '<div class="flex justify-between items-start">' +
                        '<div class="flex items-start space-x-3">' +
                        '<div class="flex-shrink-0">' +
                        '<img src="https://ui-avatars.com/api/?name=User&background=random" alt="User" class="user-avatar">' +
                        '</div>' +
                        '<div>' +
                        '<div class="flex items-center mb-1">' +
                        '<div class="font-medium text-gray-900 mr-2" id="user-name-' + feedback.id + '">Loading...</div>' +
                        '<div class="text-sm text-gray-500">' + new Date(feedback.createdAt).toLocaleDateString() + '</div>' +
                        '</div>' +
                        '<div class="flex mb-2">' + renderStars(feedback.stars) + '</div>' +
                        '<p class="text-gray-700">' + feedback.comment + '</p>' +
                        '</div>' +
                        '</div>';

                    if (currentUserId && feedback.userId === currentUserId) {
                        feedbackHtml +=
                            '<div class="flex space-x-2">' +
                            '<button onclick="editFeedback(\'' + feedback.id + '\')" class="text-blue-500 hover:text-blue-700 transition-colors">' +
                            '<i class="fas fa-edit"></i>' +
                            '</button>' +
                            '<button onclick="deleteFeedback(\'' + feedback.id + '\')" class="text-red-500 hover:text-red-700 transition-colors">' +
                            '<i class="fas fa-trash-alt"></i>' +
                            '</button>' +
                            '</div>';
                    }

                    feedbackHtml += '</div>';
                    feedbackDiv.innerHTML = feedbackHtml;

                    fetch('/api/users/' + feedback.userId)
                        .then(response => response.json())
                        .then(user => {
                            const userNameElement = feedbackDiv.querySelector('#user-name-' + feedback.id);
                            if (userNameElement) {
                                userNameElement.textContent = user.name;
                            }
                        })
                        .catch(error => {
                            console.error('Error loading user:', error);
                        });

                    feedbacksList.appendChild(feedbackDiv);
                });

                bookSection.appendChild(feedbacksList);
                container.appendChild(bookSection);
            });
        }

        function renderStars(rating) {
            let starsHtml = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) {
                    starsHtml += '<i class="fas fa-star star-rating"></i>';
                } else {
                    starsHtml += '<i class="fas fa-star empty-star"></i>';
                }
            }
            return starsHtml;
        }

        function showBookSelection() {
            document.getElementById('bookSelectionSection').classList.remove('hidden');
            document.getElementById('modalTitle').textContent = 'Add Feedback';
        }

        function showFeedbackForm() {
            document.getElementById('bookSelectionSection').classList.add('hidden');
            document.getElementById('feedbackId').value = '';
            document.getElementById('stars').value = '';
            document.getElementById('comment').value = '';
            updateStarRating(0);

            if (selectedBookId) {
                document.getElementById('bookSelect').value = selectedBookId;
            }

            document.getElementById('modalTitle').textContent = 'Add Feedback';
            feedbackModal.classList.remove('hidden');
        }

        function editFeedback(id) {
            const feedback = feedbacks.find(f => f.id === id);
            if (!feedback) return;

            document.getElementById('feedbackId').value = feedback.id;
            document.getElementById('bookSelect').value = feedback.bookId;
            document.getElementById('userId').value = feedback.userId;
            document.getElementById('stars').value = feedback.stars;
            document.getElementById('comment').value = feedback.comment;

            updateStarRating(feedback.stars);

            editFeedbackModal.classList.remove('hidden');
        }

        function deleteFeedback(id) {
            feedbackToDelete = id;
            deleteModal.classList.remove('hidden');
            
            document.getElementById('confirmDeleteBtn').setAttribute('onclick', "deleteFeedbacks('" + id + "')");
        }

        async function deleteFeedbacks(id) {
            try {
                const response = await fetch(`/api/feedbacks/`+id, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (response.ok) {
                    const feedbackElement = document.querySelector(".feedback-card[data-id=\"" + id + "\"]");
                    if (feedbackElement) {
                        feedbackElement.remove();
                    }
                    
                    loadFeedbacks();
                    
                    alert('Feedback deleted successfully');
                } else {
                    alert('Failed to delete feedback');
                }
            } catch (error) {
                console.error('Error deleting feedback:', error);
                alert('An error occurred while deleting feedback');
            } finally {
                deleteModal.classList.add('hidden');
            }
        }

        function updateStarRating(rating) {
            document.querySelectorAll('#starRating i').forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('text-yellow-400');
                    star.classList.remove('empty-star');
                } else {
                    star.classList.remove('text-yellow-400');
                    star.classList.add('empty-star');
                }
            });
        }

        function setupStarRating() {
            document.querySelectorAll('#starRating i').forEach(star => {
                star.addEventListener('click', function() {
                    const rating = parseInt(this.dataset.rating);
                    document.getElementById('stars').value = rating;
                    updateStarRating(rating);
                });
                
                star.classList.add('empty-star');
            });
        }

        function setupCreateStarRating() {
            document.querySelectorAll('#createStarRating i').forEach(star => {
                star.addEventListener('click', function() {
                    const rating = parseInt(this.dataset.rating);
                    document.getElementById('createStars').value = rating;
                    updateCreateStarRating(rating);
                });
                
                star.classList.add('empty-star');
            });
        }
        
        function updateCreateStarRating(rating) {
            document.querySelectorAll('#createStarRating i').forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('text-yellow-400');
                    star.classList.remove('empty-star');
                } else {
                    star.classList.remove('text-yellow-400');
                    star.classList.add('empty-star');
                }
            });
        }

        function setupFormSubmit() {
            document.getElementById('editFeedbackForm').addEventListener('submit', function(e) {
                e.preventDefault();

                const feedbackId = document.getElementById('feedbackId').value;
                const bookId = document.getElementById('bookSelect').value;
                const stars = document.getElementById('stars').value;
                const comment = document.getElementById('comment').value;

                if (!bookId) {
                    alert('Please select a book');
                    return;
                }

                if (!stars) {
                    alert('Please select a rating');
                    return;
                }

                const feedbackData = {
                    bookId: bookId,
                    userId: currentUserId,
                    stars: parseInt(stars),
                    comment: comment
                };

                fetch('/api/feedbacks/' + feedbackId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(feedbackData)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to update feedback');
                    }
                    return response.json();
                })
                .then(() => {
                    editFeedbackModal.classList.add('hidden');
                    loadFeedbacks();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to update feedback. Please try again.');
                });
            });
            
            document.getElementById('createFeedbackForm').addEventListener('submit', function(e) {
                e.preventDefault();

                const bookId = document.getElementById('createBookSelect').value;
                const stars = document.getElementById('createStars').value;
                const comment = document.getElementById('createComment').value;

                if (!bookId) {
                    alert('Please select a book');
                    return;
                }

                if (!stars) {
                    alert('Please select a rating');
                    return;
                }

                const feedbackData = {
                    bookId: bookId,
                    userId: currentUserId,
                    stars: parseInt(stars),
                    comment: comment
                };

                fetch('/api/feedbacks', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(feedbackData)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to create feedback');
                    }
                    return response.json();
                })
                .then(() => {
                    document.getElementById('createBookSelect').value = '';
                    document.getElementById('createStars').value = '';
                    document.getElementById('createComment').value = '';
                    updateCreateStarRating(0);
                    
                    createFeedbackSection.classList.add('hidden');
                    
                    loadFeedbacks();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to create feedback. Please try again.');
                });
            });
            
        }
        
    </script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Feedbacks</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        .star-rating {
            color: #fbbf24;
            font-weight: bold;
        }
        .bg-white {
            background-color: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        nav {
            background:#002147;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }

    </style>
</head>
<body class="bg-gray-50">
<nav class="fixed top-0 left-0 right-0 z-50 text-white shadow-lg">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-4">
                <a href="/" class="text-2xl font-bold">BookApp</a>
                <div class="hidden md:flex space-x-6">
                    <a href="/admin" class="hover:text-indigo-200 transition">Dashboard</a>
                    <a href="/feedbacks" class="hover:text-indigo-200 transition font-medium border-b-2 border-white pb-1">Feedbacks</a>
                    <a href="/authors" class="hover:text-indigo-200 transition">Authors</a>
                </div>
            </div>
            <div class="flex items-center space-x-4">
                <a href="/admin/profile" class="hover:text-indigo-200">
                    <i class="fas fa-user-circle text-xl"></i>
                </a>
                <a href="/logout" class="hover:text-indigo-200">
                    <i class="fas fa-sign-out-alt text-xl"></i>
                </a>
                <button class="md:hidden" id="mobileMenuButton">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="md:hidden hidden bg-indigo-700" id="mobileMenu">
        <div class="container mx-auto px-4 py-2">
            <div class="flex flex-col space-y-2 pb-3">
                <a href="/admin" class="py-2 hover:bg-indigo-600 px-2 rounded">Dashboard</a>
                <a href="/feedbacks" class="py-2 bg-indigo-800 px-2 rounded">Feedbacks</a>
                <a href="/authors" class="py-2 hover:bg-indigo-600 px-2 rounded">Authors</a>
            </div>
        </div>
    </div>
</nav>

<div class="bg-white shadow">
    <div class="container mx-auto px-4 py-3">
        <div class="flex items-center text-sm text-#002147">
            <a href="/admin" class="hover:text-#002147">Dashboard</a>
            <span class="mx-2">/</span>
            <span class="font-medium">Feedbacks</span>
        </div>
    </div>
</div>

    <div class="container mx-auto px-4 py-8">
        <div class="mb-6">
            <h1 class="text-2xl font-bold text-gray-800">Customer Feedbacks</h1>
            <p class="text-gray-600">View all customer feedbacks</p>
        </div>

        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Book</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">User</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Rating</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Comment</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200" id="feedbacksTableBody">
                    <tr>
                        <td colspan="5" class="px-6 py-10 text-center text-sm text-gray-500">
                            <div class="flex flex-col items-center justify-center">
                                <i class="fas fa-spinner fa-spin text-4xl text-gray-300 mb-3"></i>
                                <p>Loading feedbacks...</p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <footer class="bg-gray-800 border-t py-6 fixed bottom-0 w-full">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <p class="text-sm text-white">&copy; 2023 BookApp. All rights reserved.</p>
                </div>
                <div class="flex space-x-4">
                    <a href="#" class="text-white hover:text-indigo-600">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <a href="#" class="text-white hover:text-indigo-600">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="text-white hover:text-indigo-600">
                        <i class="fab fa-instagram"></i>
                    </a>
                </div>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            loadFeedbacks();
        });

        const bookCache = {};
        const userCache = {};

        function loadFeedbacks() {
            fetch('/api/feedbacks')
                .then(response => response.json())
                .then(feedbacks => {
                    renderFeedbacks(feedbacks);
                })
                .catch(error => {
                    console.error('Error loading feedbacks:', error);
                    document.getElementById('feedbacksTableBody').innerHTML = 
                        '<tr><td colspan="5" class="px-6 py-4 text-center text-red-500">Failed to load feedbacks</td></tr>';
                });
        }

        function renderFeedbacks(feedbacks) {
            if (feedbacks.length === 0) {
                document.getElementById('feedbacksTableBody').innerHTML = 
                    '<tr><td colspan="5" class="px-6 py-4 text-center text-gray-500">No feedbacks found</td></tr>';
                return;
            }

            const bookPromises = [];
            const userPromises = [];
            feedbacks.forEach(feedback => {
                if (!bookCache[feedback.bookId]) {
                    bookPromises.push(
                        fetch('/api/books/' + feedback.bookId)
                            .then(response => response.json())
                            .then(book => {
                                bookCache[feedback.bookId] = book;
                            })
                    );
                }

                if (!userCache[feedback.userId]) {
                    userPromises.push(
                        fetch('/api/users/' + feedback.userId)
                            .then(response => response.json())
                            .then(user => {
                                userCache[feedback.userId] = user;
                            })
                    );
                }
            });

            Promise.all([...bookPromises, ...userPromises])
                .then(() => {
                    let html = '';
                    feedbacks.forEach(feedback => {
                        const book = bookCache[feedback.bookId] || { name: 'Unknown Book' };
                        const user = userCache[feedback.userId] || { name: 'Unknown User' };
                        const date = new Date(feedback.createdAt).toLocaleDateString();
                        html +=
                            "<tr>" +
                            "<td class=\"px-6 py-4 whitespace-nowrap\">" + book.name + "</td>" +
                            "<td class=\"px-6 py-4 whitespace-nowrap\">" + user.name + "</td>" +
                            "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                            "<span class=\"star-rating\">" + feedback.stars + "</span>" +
                            "</td>" +
                            "<td class=\"px-6 py-4\">" + (feedback.comment || '-') + "</td>" +
                            "<td class=\"px-6 py-4 whitespace-nowrap\">" + date + "</td>" +
                            "</tr>";

                    });
                    document.getElementById('feedbacksTableBody').innerHTML = html;
                });
        }
    </script>
</body>
</html>
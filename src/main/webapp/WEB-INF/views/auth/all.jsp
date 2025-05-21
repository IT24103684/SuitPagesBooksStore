<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users List</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        body {
            background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
            url('https://images.pexels.com/photos/7695408/pexels-photo-7695408.jpeg?cs=srgb&dl=pexels-yankrukov-7695408.jpg&fm=jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
        }

        .table-row-animate {
            transition: all 0.3s ease;
            background-color: rgba(255, 255, 255, 0.8);
        }

        .table-row-animate:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 255, 0.2);
            background-color: rgba(255, 255, 255, 0.95);
        }

        .btn-icon {
            transition: all 0.2s ease;
        }

        .btn-icon:hover {
            transform: scale(1.2);
            filter: brightness(1.2);
        }

        .nav-gradient {
            background: linear-gradient(90deg, #4f46e5 0%, #7c3aed 100%);
        }

        .card {
            background: rgba(173, 216, 230, 0.85);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .search-input {
            transition: all 0.3s ease;
            background-color: rgba(255, 255, 255, 0.9);
        }

        .search-input:focus {
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.3);
            border-color: #4f46e5;
            background-color: white;
        }

        .table-header {
            background-color: #4f46e5;
            color: white !important;
        }

        .table-cell {
            padding: 1rem;
            vertical-align: middle;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }

        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: #4f46e5;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #7c3aed;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .animate-spin {
            animation: spin 1s linear infinite;
        }
    </style>

</head>
<body class="bg-gray-50 min-h-screen font-sans">

<nav class="bg-indigo-600 text-white shadow-lg">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-4">
                <a href="/" class="text-2xl font-bold">BookApp</a>
                <div class="hidden md:flex space-x-6">
                    <a href="/admin" class="hover:text-indigo-200 transition">Dashboard</a>
                    <a href="/books" class="hover:text-indigo-200 transition">Books</a>
                    <a href="/authors" class="hover:text-indigo-200 transition">Authors</a>
                    <a href="/users" class="hover:text-indigo-200 transition font-medium border-b-2 border-white pb-1">Users</a>
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
                <a href="/books" class="py-2 hover:bg-indigo-600 px-2 rounded">Books</a>
                <a href="/authors" class="py-2 hover:bg-indigo-600 px-2 rounded">Authors</a>
                <a href="/users" class="py-2 bg-indigo-800 px-2 rounded">Users</a>
            </div>
        </div>
    </div>
</nav>

<div class="bg-white shadow">
    <div class="container mx-auto px-4 py-3">
        <div class="flex items-center text-sm text-gray-600">
            <a href="/admin" class="hover:text-indigo-600">Dashboard</a>
            <span class="mx-2">/</span>
            <span class="text-gray-800 font-medium">Users</span>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">

    <div class="mb-6 flex flex-col md:flex-row justify-between items-start md:items-center">
        <div class="mb-4 md:mb-0">
            <h1 class="text-3xl font-bold text-white">Users</h1>
            <p class="text-white opacity-90">Manage user accounts</p>
        </div>
        <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-2">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search users..."
                       class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                <div class="absolute left-3 top-1/2 transform -translate-y-1/2">
                    <i class="fas fa-search text-gray-400"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Name
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Email
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Address
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Gender
                    </th>
                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200" id="usersTableBody">

                <tr>
                    <td colspan="5" class="px-6 py-10 text-center text-sm text-gray-500">
                        <div class="flex flex-col items-center justify-center">
                            <i class="fas fa-spinner fa-spin text-4xl text-gray-300 mb-3"></i>
                            <p>Loading users...</p>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<div id="deleteModal" class="fixed z-10 inset-0 overflow-y-auto hidden">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 transition-opacity" aria-hidden="true">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                <div class="sm:flex sm:items-start">
                    <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
                        <i class="fas fa-exclamation-triangle text-red-600"></i>
                    </div>
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                        <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
                            Delete User
                        </h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-500" id="modal-description">
                                Are you sure you want to delete this user? This action cannot be undone.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <button type="button" id="confirmDeleteBtn" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Delete
                </button>
                <button type="button" onclick="closeModal()" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let allUsers = [];
    let currentUserIdToDelete = null;

    function fetchUsers() {
        fetch('/api/users')
            .then(response => response.json())
            .then(users => {
                allUsers = users;
                renderUsers(allUsers);
            })
            .catch(error => {
                console.error('Error fetching users:', error);
                showEmptyState('Failed to load users');
            });
    }

    function renderUsers(users) {
        const tableBody = document.getElementById('usersTableBody');

        if (users.length === 0) {
            showEmptyState('No users found');
            return;
        }

        tableBody.innerHTML = '';

        users.forEach(user => {
            const row = document.createElement('tr');
            row.className = 'table-row-animate hover:bg-gray-50';
            row.dataset.id = user.id;

            const address = user.address && isNaN(user.address) ? user.address : 'N/A';

            const gender = user.gender
                ? user.gender.toString().toLowerCase().trim() === 'male' || user.gender.toString().toLowerCase().trim() === 'female'
                    ? user.gender.toString().charAt(0).toUpperCase() + user.gender.toString().slice(1).toLowerCase()
                    : 'N/A'
                : 'N/A';

            row.innerHTML =
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"flex items-center\">" +
                "<div class=\"ml-4\">" +
                "<div class=\"text-sm font-medium text-gray-900\">" + (user.name || 'N/A') + "</div>" +
                "</div>" +
                "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                (user.email || 'N/A') +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                address +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                gender +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\">" +
                "<div class=\"flex justify-end space-x-2\">" +
                "<button onclick=\"confirmDelete('" + user.id + "', '" + user.name.replace("'", "\\'") + "')\" " +
                "class=\"text-red-600 hover:text-red-900 btn-icon\">" +
                "<i class=\"fas fa-trash-alt\"></i>" +
                "</button>" +
                "</div>" +
                "</td>";

            tableBody.appendChild(row);
        });
    }

    function showEmptyState(message) {
        const tableBody = document.getElementById('usersTableBody');
        tableBody.innerHTML =
            "<tr>" +
            "<td colspan=\"5\" class=\"px-6 py-10 text-center text-sm text-gray-500\">" +
            "<div class=\"flex flex-col items-center justify-center\">" +
            "<i class=\"fas fa-user-slash text-4xl text-gray-300 mb-3\"></i>" +
            "<p>" + message + "</p>" +
            "</div>" +
            "</td>" +
            "</tr>";
    }


    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const filteredUsers = allUsers.filter(user =>
            (user.name && user.name.toLowerCase().includes(searchTerm)) ||
            (user.email && user.email.toLowerCase().includes(searchTerm)) ||
            (user.address && user.address.toLowerCase().includes(searchTerm))
        );
        renderUsers(filteredUsers);
    });

    function confirmDelete(userId, userName) {
        currentUserIdToDelete = userId;
        document.getElementById('modal-title').textContent = "Delete User " + userName;
        document.getElementById('modal-description').textContent =
            "Are you sure you want to delete user \"" + userName + "\"? This action cannot be undone.";
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeModal() {
        currentUserIdToDelete = null;
        document.getElementById('deleteModal').classList.add('hidden');
    }

    document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
        if (!currentUserIdToDelete) return;

        fetch(`/api/users/`+currentUserIdToDelete, {
            method: 'DELETE'
        })
            .then(response => {
                if (!response.ok) throw new Error('User deletion Access by a admin.');
                return response.json();
            })

            .catch(error => {
                console.error('Error deleting user:', error);
                alert('User deletion done by a admin.');
            })
            .then(() => {

                fetchUsers();
            })
            .finally(() => {
                closeModal();
            });
    });


    document.addEventListener('DOMContentLoaded', function() {
        fetchUsers();


        document.getElementById('mobileMenuButton').addEventListener('click', function() {
            document.getElementById('mobileMenu').classList.toggle('hidden');
        });
    });
</script>
</body>
</html>
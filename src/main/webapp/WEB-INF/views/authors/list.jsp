<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authors List</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        .table-row-animate:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .btn-icon {
            transition: transform 0.15s ease-in-out;
        }

        .btn-icon:hover {
            transform: scale(1.15);
        }

        .modal {
            transition: opacity 0.25s ease;
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
                    <a href="/authors" class="hover:text-indigo-200 transition font-medium border-b-2 border-white pb-1">Authors</a>

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
                <a href="/authors" class="py-2 bg-indigo-800 px-2 rounded">Authors</a>

            </div>
        </div>
    </div>
</nav>

<div class="bg-white shadow">
    <div class="container mx-auto px-4 py-3">
        <div class="flex items-center text-sm text-gray-600">
            <a href="/admin" class="hover:text-indigo-600">Dashboard</a>
            <span class="mx-2">/</span>
            <span class="text-gray-800 font-medium">Authors</span>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <div class="mb-6 flex flex-col md:flex-row justify-between items-start md:items-center">
        <div class="mb-4 md:mb-0">
            <h1 class="text-2xl font-bold text-gray-800">Authors</h1>
            <p class="text-gray-600">Manage author information for your books</p>
        </div>
        <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-2">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search authors..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                <div class="absolute left-3 top-1/2 transform -translate-y-1/2">
                    <i class="fas fa-search text-gray-400"></i>
                </div>
            </div>
            <a href="/authors/create" class="bg-indigo-600 hover:bg-indigo-700 text-white py-2 px-4 rounded-md flex items-center justify-center transition">
                <i class="fas fa-plus mr-2"></i> Add Author
            </a>
        </div>
    </div>

    <div id="notificationArea" class="mb-6 hidden">
        <div id="successNotification" class="hidden bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4 rounded flex items-start">
            <div class="flex-shrink-0">
                <i class="fas fa-check-circle mt-0.5"></i>
            </div>
            <div class="ml-3 flex-grow">
                <p class="text-sm font-medium" id="successMessage"></p>
            </div>
            <button onclick="hideNotification('successNotification')" class="ml-auto">
                <i class="fas fa-times text-green-700"></i>
            </button>
        </div>

        <div id="errorNotification" class="hidden bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded flex items-start">
            <div class="flex-shrink-0">
                <i class="fas fa-exclamation-circle mt-0.5"></i>
            </div>
            <div class="ml-3 flex-grow">
                <p class="text-sm font-medium" id="errorMessage"></p>
            </div>
            <button onclick="hideNotification('errorNotification')" class="ml-auto">
                <i class="fas fa-times text-red-700"></i>
            </button>
        </div>
    </div>

    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Author
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Gender
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Age
                    </th>
                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200" id="authorsTableBody">
                </tbody>
            </table>
        </div>
    </div>

    <div id="pagination-container"></div>
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
                            Delete Author
                        </h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-500" id="modal-description">
                                Are you sure you want to delete this author? This action cannot be undone.
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

<footer class="bg-white border-t mt-10 py-6">
    <div class="container mx-auto px-4">
        <div class="text-center text-gray-500 text-sm">
            &copy; 2025 BookApp Admin Panel. All rights reserved.
        </div>
    </div>
</footer>

<script>
    let authors = [];

    async  function  loadAuthors(){
        const response=    await fetch("/api/authors");
        if(response.ok){
            authors  = await  response.json();

        }
    }

    document.addEventListener('DOMContentLoaded',async function() {
        await   loadAuthors();
        const mobileMenuButton = document.getElementById('mobileMenuButton');
        const mobileMenu = document.getElementById('mobileMenu');

        mobileMenuButton.addEventListener('click', function() {
            mobileMenu.classList.toggle('hidden');
        });

        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            showNotification('success', urlParams.get('success'));
        }

        populateAuthorsTable(authors);

        if (authors.length > 10) {
            setupPagination(authors.length);
        }

        const searchInput = document.getElementById('searchInput');
        searchInput.addEventListener('input', function() {
            const searchText = this.value.toLowerCase();
            filterAuthors(searchText);
        });
    });

    function populateAuthorsTable(authorsData) {
        const tableBody = document.getElementById('authorsTableBody');
        tableBody.innerHTML = '';

        if (authorsData.length === 0) {
            const emptyRow = document.createElement('tr');
            emptyRow.innerHTML = "<td colspan=\"4\" class=\"px-6 py-10 text-center text-sm text-gray-500\"><div class=\"flex flex-col items-center justify-center\"><i class=\"fas fa-user-slash text-4xl text-gray-300 mb-3\"></i><p>No authors found</p><a href=\"/authors/create\" class=\"mt-2 text-indigo-600 hover:text-indigo-800\">Add your first author</a></div></td>";
            tableBody.appendChild(emptyRow);
        } else {
            authorsData.forEach(author => {
                const row = document.createElement('tr');
                row.className = 'table-row-animate transition-all duration-200';
                row.setAttribute('data-id', author.id);
                row.setAttribute('data-name', author.name);

                const initials = author.name.charAt(0);

                let genderClass = '';
                if (author.gender === 'Male') {
                    genderClass = 'bg-blue-100 text-blue-800';
                } else if (author.gender === 'Female') {
                    genderClass = 'bg-pink-100 text-pink-800';
                } else {
                    genderClass = 'bg-purple-100 text-purple-800';
                }

                row.innerHTML = "<td class=\"px-6 py-4 whitespace-nowrap\"><div class=\"flex items-center\"><div class=\"flex-shrink-0 h-10 w-10\">" +
                    (author.imageUrl ?
                        "<img class=\"h-10 w-10 rounded-full object-cover\" src=\"" + author.imageUrl + "\" alt=\"" + author.name + "\">" :
                        "<div class=\"h-10 w-10 rounded-full bg-indigo-100 flex items-center justify-center\"><span class=\"text-indigo-700 font-medium text-lg\">" + initials + "</span></div>") +
                    "</div><div class=\"ml-4\"><div class=\"text-sm font-medium text-gray-900\">" + author.name + "</div></div></div></td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap\"><span class=\"px-2 inline-flex text-xs leading-5 font-semibold rounded-full " + genderClass + "\">" + author.gender + "</span></td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + author.age + " years</td>" +
                    "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\"><div class=\"flex justify-end space-x-2\">" +
                    "<a href=\"/authors/edit/" + author.id + "\" class=\"text-indigo-600 hover:text-indigo-900 btn-icon\" title=\"Edit\"><i class=\"fas fa-edit\"></i></a>" +
                    "<button onclick=\"confirmDelete('" + author.id + "', '" + author.name + "')\" class=\"text-red-600 hover:text-red-900 btn-icon\" title=\"Delete\"><i class=\"fas fa-trash-alt\"></i></button>" +
                    "</div></td>";
                tableBody.appendChild(row);
            });
        }
    }

    function filterAuthors(searchText) {
        const filteredAuthors = authors.filter(author =>
            author.name.toLowerCase().includes(searchText)
        );

        populateAuthorsTable(filteredAuthors);

        const tableBody = document.getElementById('authorsTableBody');
        if (filteredAuthors.length === 0 && searchText !== '') {
            const noResultsRow = document.createElement('tr');
            noResultsRow.className = 'search-empty-row';
            noResultsRow.innerHTML = "<td colspan=\"4\" class=\"px-6 py-8 text-center text-sm text-gray-500\"><div class=\"flex flex-col items-center\"><i class=\"fas fa-search text-3xl text-gray-300 mb-2\"></i><p>No authors found matching \"<span class=\"font-medium\">" + searchText + "</span>\"</p></div></td>";
            tableBody.appendChild(noResultsRow);
        }
    }

    function setupPagination(totalItems) {
        const paginationContainer = document.getElementById('pagination-container');
        const totalPages = Math.ceil(totalItems / 10);

        paginationContainer.innerHTML = "<div class=\"bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6 mt-4 rounded-lg shadow-md\"><div class=\"flex-1 flex justify-between sm:hidden\"><a href=\"#\" class=\"relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50\">Previous</a><a href=\"#\" class=\"ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50\">Next</a></div><div class=\"hidden sm:flex-1 sm:flex sm:items-center sm:justify-between\"><div><p class=\"text-sm text-gray-700\">Showing <span class=\"font-medium\">1</span> to <span class=\"font-medium\">10</span> of <span class=\"font-medium\">" + totalItems + "</span> results</p></div><div><nav class=\"relative z-0 inline-flex rounded-md shadow-sm -space-x-px\" aria-label=\"Pagination\"><a href=\"#\" class=\"relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50\"><span class=\"sr-only\">Previous</span><i class=\"fas fa-chevron-left h-5 w-5\"></i></a><a href=\"#\" aria-current=\"page\" class=\"z-10 bg-indigo-50 border-indigo-500 text-indigo-600 relative inline-flex items-center px-4 py-2 border text-sm font-medium\">1</a>" +
            (totalPages > 1 ? "<a href=\"#\" class=\"bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium\">2</a>" : "") +
            (totalPages > 2 ? "<a href=\"#\" class=\"bg-white border-gray-300 text-gray-500 hover:bg-gray-50 hidden md:inline-flex relative items-center px-4 py-2 border text-sm font-medium\">3</a>" : "") +
            (totalPages > 3 ? "<span class=\"relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700\">...</span>" : "") +
            (totalPages > 3 ? "<a href=\"#\" class=\"bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium\">" + totalPages + "</a>" : "") +
            "<a href=\"#\" class=\"relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50\"><span class=\"sr-only\">Next</span><i class=\"fas fa-chevron-right h-5 w-5\"></i></a></nav></div></div></div>";
    }

    let currentAuthorId = null;

    function confirmDelete(id, name) {
        currentAuthorId = id;
        document.getElementById('modal-description').innerText = 'Are you sure you want to delete "' + name + '"? This action cannot be undone.';
        document.getElementById('deleteModal').classList.remove('hidden');
        document.getElementById('confirmDeleteBtn').addEventListener('click', deleteAuthor);
    }

    function closeModal() {
        document.getElementById('deleteModal').classList.add('hidden');
        document.getElementById('confirmDeleteBtn').removeEventListener('click', deleteAuthor);
        currentAuthorId = null;
    }

    function deleteAuthor() {
        if (!currentAuthorId) return;

        const row = document.querySelector('tr[data-id=\"' + currentAuthorId + '\"]');
        const authorName = row ? row.getAttribute('data-name') : '';

        const deleteBtn = document.getElementById('confirmDeleteBtn');
        const originalBtnText = deleteBtn.innerHTML;
        deleteBtn.innerHTML = '<i class=\"fas fa-spinner fa-spin mr-2\"></i> Deleting...';
        deleteBtn.disabled = true;

        fetch('/api/authors/' + currentAuthorId, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) {
                    if (response.status === 404) {
                        throw new Error('Author not found');
                    } else {
                        return response.json().then(data => {
                            throw new Error(data.error || 'Failed to delete author');
                        });
                    }
                }

                closeModal();

                if (row) {
                    row.style.backgroundColor = '#FEE2E2';
                    row.style.transition = 'opacity 0.5s ease';
                    setTimeout(() => {
                        row.style.opacity = '0';
                        setTimeout(() => {
                            row.remove();

                            const remainingRows = document.querySelectorAll('#authorsTableBody tr[data-id]');
                            if (remainingRows.length === 0) {
                                const tableBody = document.getElementById('authorsTableBody');
                                const emptyRow = document.createElement('tr');
                                emptyRow.innerHTML = '<td colspan=\"4\" class=\"px-6 py-10 text-center text-sm text-gray-500\"><div class=\"flex flex-col items-center justify-center\"><i class=\"fas fa-user-slash text-4xl text-gray-300 mb-3\"></i><p>No authors found</p><a href=\"/authors/create\" class=\"mt-2 text-indigo-600 hover:text-indigo-800\">Add your first author</a></div></td>';
                                tableBody.appendChild(emptyRow);
                            }

                            showNotification('success', 'Author "' + authorName + '" has been deleted successfully.');
                        }, 500);
                    }, 100);
                } else {
                    showNotification('success', 'Author has been deleted successfully.');
                }
            })
            .catch(error => {
                closeModal();
                showNotification('error', error.message);
            });
    }

    function showNotification(type, message) {
        const notificationArea = document.getElementById('notificationArea');
        const successNotification = document.getElementById('successNotification');
        const errorNotification = document.getElementById('errorNotification');

        successNotification.classList.add('hidden');
        errorNotification.classList.add('hidden');

        if (type === 'success') {
            document.getElementById('successMessage').textContent = message;
            successNotification.classList.remove('hidden');
        } else {
            document.getElementById('errorMessage').textContent = message;
            errorNotification.classList.remove('hidden');
        }

        notificationArea.classList.remove('hidden');

        setTimeout(() => {
            hideNotification(type === 'success' ? 'successNotification' : 'errorNotification');
        }, 5000);
    }

    function hideNotification(id) {
        document.getElementById(id).classList.add('hidden');

        if (document.getElementById('successNotification').classList.contains('hidden') &&
            document.getElementById('errorNotification').classList.contains('hidden')) {
            document.getElementById('notificationArea').classList.add('hidden');
        }
    }
</script>
</body>
</html>
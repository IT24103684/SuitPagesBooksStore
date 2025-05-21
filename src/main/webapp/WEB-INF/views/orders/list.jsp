<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management - BookStore</title>
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

        .book-image {
            width: 60px;
            height: 90px;
            object-fit: cover;
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
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
                    <a href="/orders" class="hover:text-indigo-200 transition font-medium border-b-2 border-white pb-1">Orders</a>
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
                <a href="/orders" class="py-2 bg-indigo-800 px-2 rounded">Orders</a>
            </div>
        </div>
    </div>
</nav>

<div class="bg-white shadow">
    <div class="container mx-auto px-4 py-3">
        <div class="flex items-center text-sm text-gray-600">
            <a href="/admin" class="hover:text-indigo-600">Dashboard</a>
            <span class="mx-2">/</span>
            <span class="text-gray-800 font-medium">Orders</span>
        </div>
    </div>
</div>

<div class="container mx-auto px-4 py-8">
    <div class="mb-6 flex flex-col md:flex-row justify-between items-start md:items-center">
        <div class="mb-4 md:mb-0">
            <h1 class="text-2xl font-bold text-gray-800">Order Management</h1>
            <p class="text-gray-600">View and manage customer orders</p>
        </div>
        <div class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-2">
            <div class="relative">
                <input type="text" id="searchInput" placeholder="Search orders..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                <div class="absolute left-3 top-1/2 transform -translate-y-1/2">
                    <i class="fas fa-search text-gray-400"></i>
                </div>
            </div>
            <select id="statusFilter" class="border border-gray-300 rounded-md px-4 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                <option value="">All Statuses</option>
                <option value="PENDING">Pending</option>
                <option value="COMPLETED">Completed</option>
                <option value="CANCELLED">Cancelled</option>
                <option value="DELIVERED">Delivered</option>
            </select>
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
                        Order ID
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Customer
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Date
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Items
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Total
                    </th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Status
                    </th>
                    <th scope="col" class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200" id="ordersTableBody">
                <tr>
                    <td colspan="7" class="px-6 py-10 text-center text-sm text-gray-500">
                        <div class="flex flex-col items-center justify-center">
                            <i class="fas fa-spinner fa-spin text-4xl text-gray-300 mb-3"></i>
                            <p>Loading orders...</p>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div id="pagination-container"></div>
</div>

<div id="viewOrderModal" class="fixed z-10 inset-0 overflow-y-auto hidden">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <div class="fixed inset-0 transition-opacity" aria-hidden="true">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>

        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

        <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                <div class="sm:flex sm:items-start">
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left w-full">
                        <h3 class="text-lg leading-6 font-medium text-gray-900" id="viewOrderModalLabel">
                            Order Details
                        </h3>
                        <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <h4 class="text-sm font-medium text-gray-500">Order Information</h4>
                                <div class="mt-2 space-y-1">
                                    <p class="text-sm"><span class="font-medium">Order ID:</span> <span id="viewOrderId"></span></p>
                                    <p class="text-sm"><span class="font-medium">Date:</span> <span id="viewOrderDate"></span></p>
                                    <p class="text-sm"><span class="font-medium">Customer:</span> <span id="viewCustomerName"></span></p>
                                    <p class="text-sm"><span class="font-medium">Shipping Address:</span> <span id="viewAddress"></span></p>
                                </div>
                            </div>
                            <div>
                                <h4 class="text-sm font-medium text-gray-500">Status</h4>
                                <div class="mt-2">
                                    <span id="viewCurrentStatus" class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"></span>
                                </div>

                                <h4 class="text-sm font-medium text-gray-500 mt-4">Update Status</h4>
                                <div class="mt-2 flex">
                                    <select id="updateStatus" class="flex-1 rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                                        <option value="PENDING">Pending</option>
                                        <option value="COMPLETED">Completed</option>
                                        <option value="CANCELLED">Cancelled</option>
                                        <option value="DELIVERED">Delivered</option>
                                    </select>
                                    <button id="updateStatusBtn" class="ml-2 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                        Update
                                    </button>
                                </div>
                            </div>
                        </div>

                        <h4 class="text-sm font-medium text-gray-500 mt-6">Order Items</h4>
                        <div id="viewOrderItems" class="mt-2 space-y-3">
                        </div>

                        <div class="mt-4 flex justify-end">
                            <h4 class="text-lg font-medium">Total: <span id="viewOrderTotal"></span></h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <button type="button" onclick="closeModal('viewOrderModal')" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<div id="deleteOrderModal" class="fixed z-10 inset-0 overflow-y-auto hidden">
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
                        <h3 class="text-lg leading-6 font-medium text-gray-900">
                            Delete Order
                        </h3>
                        <div class="mt-2">
                            <p class="text-sm text-gray-500">
                                Are you sure you want to delete this order? This action cannot be undone.
                            </p>
                            <p class="text-sm font-medium mt-2"><span>Order ID: </span><span id="deleteOrderId"></span></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <button type="button" id="confirmDeleteBtn" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm">
                    Delete
                </button>
                <button type="button" onclick="closeModal('deleteOrderModal')" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                    Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<div class="loading-overlay" id="loadingOverlay" style="display: none;">
    <div class="flex flex-col items-center">
        <i class="fas fa-spinner fa-spin text-4xl text-indigo-600 mb-3"></i>
        <p class="text-gray-600">Loading...</p>
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
    let allOrders = [];
    let filteredOrders = [];
    let userCache = {};
    let bookCache = {};
    let currentOrderId = null;

    const ordersTableBody = document.getElementById("ordersTableBody");
    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");
    const loadingOverlay = document.getElementById("loadingOverlay");

    document.addEventListener("DOMContentLoaded", function() {
        const mobileMenuButton = document.getElementById('mobileMenuButton');
        const mobileMenu = document.getElementById('mobileMenu');

        mobileMenuButton.addEventListener('click', function() {
            mobileMenu.classList.toggle('hidden');
        });

        fetchOrders();

        searchInput.addEventListener("input", filterOrders);
        statusFilter.addEventListener("change", filterOrders);

        document.getElementById("updateStatusBtn").addEventListener("click", updateOrderStatus);

        document.getElementById("confirmDeleteBtn").addEventListener("click", deleteOrder);
    });

    function showLoading() {
        loadingOverlay.style.display = "flex";
    }

    function hideLoading() {
        loadingOverlay.style.display = "none";
    }

    function fetchOrders() {
        showLoading();

        fetch("/api/orders")
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to fetch orders");
                }
                return response.json();
            })
            .then(orders => {
                allOrders = orders;
                filteredOrders = [...orders];

                if (orders.length === 0) {
                    showEmptyOrders();
                } else {
                    enrichOrdersData(orders);
                }
            })
            .catch(error => {
                console.error("Error fetching orders:", error);
                showNotification('error', "Failed to load orders. Please try again later.");
                hideLoading();
            });
    }

    function enrichOrdersData(orders) {
        const userPromises = [];
        const bookPromises = [];

        const userIds = [...new Set(orders.map(order => order.userId))];
        const bookIds = [...new Set(orders.flatMap(order => order.items.map(item => item.bookId)))];

        userIds.forEach(userId => {
            if (!userCache[userId]) {
                const promise = fetch("/api/users/" + userId)
                    .then(response => response.ok ? response.json() : { id: userId, name: "Unknown User" })
                    .then(user => {
                        userCache[userId] = user;
                        return user;
                    })
                    .catch(error => {
                        console.error("Error fetching user " + userId + ":", error);
                        userCache[userId] = { id: userId, name: "Unknown User" };
                    });
                userPromises.push(promise);
            }
        });

        bookIds.forEach(bookId => {
            if (!bookCache[bookId]) {
                const promise = fetch("/api/books/" + bookId)
                    .then(response => response.ok ? response.json() : { id: bookId, name: "Unknown Book", imageUrl: "" })
                    .then(book => {
                        bookCache[bookId] = book;
                        return book;
                    })
                    .catch(error => {
                        console.error("Error fetching book " + bookId + ":", error);
                        bookCache[bookId] = { id: bookId, name: "Unknown Book", imageUrl: "" };
                    });
                bookPromises.push(promise);
            }
        });

        Promise.all([...userPromises, ...bookPromises])
            .then(() => {
                renderOrdersTable(filteredOrders);
                hideLoading();
            })
            .catch(error => {
                console.error("Error enriching orders data:", error);
                renderOrdersTable(filteredOrders);
                hideLoading();
            });
    }

    function filterOrders() {
        const searchTerm = searchInput.value.toLowerCase();
        const statusValue = statusFilter.value;

        filteredOrders = allOrders.filter(order => {
            if (statusValue && order.status !== statusValue) {
                return false;
            }

            if (searchTerm) {
                const user = userCache[order.userId] || { name: "Unknown User" };

                return order.id.toLowerCase().includes(searchTerm) ||
                    user.name.toLowerCase().includes(searchTerm) ||
                    order.address.toLowerCase().includes(searchTerm);
            }

            return true;
        });

        renderOrdersTable(filteredOrders);
    }

    function renderOrdersTable(orders) {
        if (orders.length === 0) {
            ordersTableBody.innerHTML =
                "<tr>" +
                "<td colspan=\"7\" class=\"px-6 py-10 text-center text-sm text-gray-500\">" +
                "<div class=\"flex flex-col items-center justify-center\">" +
                "<i class=\"fas fa-box-open text-4xl text-gray-300 mb-3\"></i>" +
                "<p>No orders match your search criteria.</p>" +
                "</div>" +
                "</td>" +
                "</tr>";
            return;
        }

        let html = "";

        orders.forEach(order => {
            const user = userCache[order.userId] || {name: "Unknown User"};
            const orderDate = new Date(order.orderDate);
            const formattedDate = orderDate.toLocaleDateString("en-US", {
                year: "numeric", month: "short", day: "numeric"
            });

            let orderTotal = 0;
            order.items.forEach(item => {
                orderTotal += item.price * item.quantity;
            });


            let statusClass = "";
            switch(order.status) {
                case "PENDING":
                    statusClass = "bg-yellow-100 text-yellow-800";
                    break;
                case "COMPLETED":
                    statusClass = "bg-green-100 text-green-800";
                    break;
                case "CANCELLED":
                    statusClass = "bg-red-100 text-red-800";
                    break;
                case "DELIVERED":
                    statusClass = "bg-blue-100 text-blue-800";
                    break;
                default:
                    statusClass = "bg-gray-100 text-gray-800";
            }

            html +=
                "<tr class=\"table-row-animate transition-all duration-200\" data-id=\"" + order.id + "\">" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-900\">" +
                order.id.substring(0, 8) + "..." +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<div class=\"text-sm text-gray-900\">" + user.name + "</div>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                formattedDate +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                order.items.length +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" +
                "$" + orderTotal.toFixed(2) +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap\">" +
                "<span class=\"px-2.5 py-0.5 rounded-full text-xs font-medium " + statusClass + "\">" +
                order.status +
                "</span>" +
                "</td>" +
                "<td class=\"px-6 py-4 whitespace-nowrap text-right text-sm font-medium\">" +
                "<div class=\"flex justify-end space-x-2\">" +
                "<button onclick=\"openViewModal('" + order.id + "')\" class=\"text-indigo-600 hover:text-indigo-900 btn-icon\" title=\"View\">" +
                "<i class=\"fas fa-eye\"></i>" +
                "</button>" +
                "<button onclick=\"openDeleteModal('" + order.id + "')\" class=\"text-red-600 hover:text-red-900 btn-icon\" title=\"Delete\">" +
                "<i class=\"fas fa-trash-alt\"></i>" +
                "</button>" +
                "</div>" +
                "</td>" +
                "</tr>";
        });

        ordersTableBody.innerHTML = html;
    }

    function showEmptyOrders() {
        ordersTableBody.innerHTML =
            "<tr>" +
            "<td colspan=\"7\" class=\"px-6 py-10 text-center text-sm text-gray-500\">" +
            "<div class=\"flex flex-col items-center justify-center\">" +
            "<i class=\"fas fa-box-open text-4xl text-gray-300 mb-3\"></i>" +
            "<h3 class=\"text-lg font-medium\">No Orders Found</h3>" +
            "<p>There are no orders in the system yet.</p>" +
            "</div>" +
            "</td>" +
            "</tr>";
        hideLoading();
    }

    function openViewModal(orderId) {
        currentOrderId = orderId;
        const order = allOrders.find(o => o.id === orderId);
        if (!order) return;

        const user = userCache[order.userId] || {name: "Unknown User"};
        const orderDate = new Date(order.orderDate);
        const formattedDate = orderDate.toLocaleDateString("en-US", {
            year: "numeric", month: "long", day: "numeric",
            hour: "2-digit", minute: "2-digit"
        });

        let orderTotal = 0;
        order.items.forEach(item => {
            orderTotal += item.price * item.quantity;
        });

        document.getElementById("viewOrderId").textContent = order.id;
        document.getElementById("viewOrderDate").textContent = formattedDate;
        document.getElementById("viewCustomerName").textContent = user.name;
        document.getElementById("viewAddress").textContent = order.address;

        const statusElement = document.getElementById("viewCurrentStatus");
        statusElement.textContent = order.status;

        let statusClass = "";
        switch(order.status) {
            case "PENDING":
                statusClass = "bg-yellow-100 text-yellow-800";
                break;
            case "COMPLETED":
                statusClass = "bg-green-100 text-green-800";
                break;
            case "CANCELLED":
                statusClass = "bg-red-100 text-red-800";
                break;
            case "DELIVERED":
                statusClass = "bg-blue-100 text-blue-800";
                break;
            default:
                statusClass = "bg-gray-100 text-gray-800";
        }
        statusElement.className = "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium " + statusClass;

        document.getElementById("updateStatus").value = order.status;

        document.getElementById("viewOrderTotal").textContent = "$" + orderTotal.toFixed(2);

        const viewOrderItems = document.getElementById("viewOrderItems");
        let itemsHtml = "";

        order.items.forEach(item => {
            const book = bookCache[item.bookId] || {name: "Unknown Book", imageUrl: ""};
            const itemTotal = item.quantity * item.price;

            itemsHtml +=
                "<div class=\"flex items-start border-b border-gray-100 pb-3 last:border-0\">" +
                "<img src=\"" + (book.imageUrl || 'https://via.placeholder.com/60x90?text=No+Image') + "\" " +
                "class=\"book-image rounded mr-3\" " +
                "alt=\"" + book.name + "\">" +
                "<div class=\"flex-1\">" +
                "<div class=\"flex justify-between\">" +
                "<h5 class=\"text-sm font-medium text-gray-900\">" + book.name + "</h5>" +
                "<span class=\"text-sm text-gray-900\">\$" + item.price.toFixed(2) + "</span>" +
                "</div>" +
                "<div class=\"flex justify-between mt-1\">" +
                "<p class=\"text-xs text-gray-500\">Qty: " + item.quantity + "</p>" +
                "<p class=\"text-xs text-gray-500\">Total: \$" + itemTotal.toFixed(2) + "</p>" +
                "</div>" +
                "</div>" +
                "</div>";
        });

        viewOrderItems.innerHTML = itemsHtml;

        document.getElementById('viewOrderModal').classList.remove('hidden');
    }

    function updateOrderStatus() {
        showLoading();

        const newStatus = document.getElementById("updateStatus").value;

        fetch("/api/orders/" + currentOrderId + "/status", {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ status: newStatus })
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.error || "Failed to update order status");
                    });
                }
                return response.json();
            })
            .then(updatedOrder => {
                const index = allOrders.findIndex(o => o.id === currentOrderId);
                if (index !== -1) {
                    allOrders[index] = updatedOrder;

                    const statusElement = document.getElementById("viewCurrentStatus");
                    statusElement.textContent = updatedOrder.status;

                    let statusClass = "";
                    switch(updatedOrder.status) {
                        case "PENDING":
                            statusClass = "bg-yellow-100 text-yellow-800";
                            break;
                        case "COMPLETED":
                            statusClass = "bg-green-100 text-green-800";
                            break;
                        case "CANCELLED":
                            statusClass = "bg-red-100 text-red-800";
                            break;
                        case "DELIVERED":
                            statusClass = "bg-blue-100 text-blue-800";
                            break;
                        default:
                            statusClass = "bg-gray-100 text-gray-800";
                    }
                    statusElement.className = "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium " + statusClass;

                    filterOrders();
                }

                hideLoading();
                showNotification("success", "Order status updated successfully");
            })
            .catch(error => {
                console.error("Error updating order status:", error);
                hideLoading();
                showNotification("error", error.message || "Failed to update order status");
            });
    }

    function openDeleteModal(orderId) {
        currentOrderId = orderId;
        document.getElementById("deleteOrderId").textContent = orderId;
        document.getElementById('deleteOrderModal').classList.remove('hidden');
    }

    function deleteOrder() {
        showLoading();

        fetch("/api/orders/" + currentOrderId, {
            method: "DELETE"
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to delete order");
                }

                allOrders = allOrders.filter(o => o.id !== currentOrderId);
                filterOrders();

                closeModal('deleteOrderModal');
                hideLoading();

                showNotification("success", "Order deleted successfully");
            })
            .catch(error => {
                console.error("Error deleting order:", error);
                hideLoading();
                showNotification("error", "Failed to delete order");
            });
    }

    function closeModal(modalId) {
        document.getElementById(modalId).classList.add('hidden');
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
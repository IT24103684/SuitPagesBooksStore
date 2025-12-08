<%@ page import="java.util.List" %>
<%@ page import="com.bookstore.dtos.OrderDTO" %>
<%@ page import="com.bookstore.services.OrderService" %>
<%@ page import="com.bookstore.repositories.OrderRepository" %>
<%@ page import="com.bookstore.repositories.CartRepository" %>
<%@ page import="com.bookstore.repositories.BookRepository" %>
<%@ page import="com.bookstore.repositories.UserRepository" %>
<%@ page import="com.bookstore.models.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .order-container {
            margin-bottom: 1.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            padding: 25px;
            border: 1px solid #e9ecef;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .order-container:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }
        .order-header {
            border-bottom: 2px solid #f1f3f5;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .order-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f8f9fa;
            align-items: center;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .book-image {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .order-status {
            font-weight: 600;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-pending {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            color: #856404;
            border: 1px solid #ffd43b;
        }
        .status-completed {
            background: linear-gradient(135deg, #d4edda, #a8e6cf);
            color: #155724;
            border: 1px solid #38d9a9;
        }
        .status-cancelled {
            background: linear-gradient(135deg, #f8d7da, #ffb8b8);
            color: #721c24;
            border: 1px solid #ff6b6b;
        }
        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
        }
        .empty-orders i {
            font-size: 64px;
            color: #dee2e6;
            margin-bottom: 20px;
            opacity: 0.7;
        }
        .empty-orders h3 {
            color: #495057;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .empty-orders p {
            color: #6c757d;
            margin-bottom: 25px;
            font-size: 1.1rem;
        }
        .loading-container {
            text-align: center;
            padding: 50px 0;
        }
        .spinner-border {
            width: 3rem;
            height: 3rem;
            border-width: 0.25em;
        }
        .order-id {
            color: #495057;
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .total-amount {
            color: #e94560;
            font-weight: 700;
            font-size: 1.25rem;
        }
        h1 {
            color: #1a1a2e;
            font-weight: 700;
            padding-bottom: 10px;
            border-bottom: 3px solid #e94560;
            display: inline-block;
        }
    </style>
</head>
<body>
<jsp:include page="../common/navbar.jsp"/>

<div class="container mt-5 mb-5">
    <h1 class="mb-4">My Orders</h1>

    <div id="ordersContainer">
        <div class="loading-container">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3 text-muted">Loading your orders...</p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const userId = localStorage.getItem('userId');
        const ordersContainer = document.getElementById('ordersContainer');

        if (!userId) {
            ordersContainer.innerHTML = '<div class="alert alert-warning text-center">' +
                '<i class="fas fa-exclamation-triangle me-2"></i>' +
                'Please login to view your orders' +
                '</div>';
            return;
        }

        loadOrders(userId);
    });

    function loadOrders(userId) {
        fetch('http://localhost:8080/api/orders/user/' + userId)
            .then(response => {
                if (response.status === 404) {
                    // Handle "no orders" case gracefully
                    showEmptyOrders();
                    return [];
                }
                if (!response.ok) {
                    throw new Error('Failed to fetch orders');
                }
                return response.json();
            })
            .then(orders => {
                if (!orders || orders.length === 0) {
                    showEmptyOrders();
                    return;
                }

                // Add loading message while fetching book details
                const ordersContainer = document.getElementById('ordersContainer');
                ordersContainer.innerHTML = '<div class="text-center py-4 text-muted">' +
                    '<i class="fas fa-spinner fa-spin me-2"></i>Loading order details...' +
                    '</div>';

                return fetchOrderDetails(orders);
            })
            .then(ordersWithBooks => {
                if (ordersWithBooks && ordersWithBooks.length > 0) {
                    renderOrders(ordersWithBooks);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                const ordersContainer = document.getElementById('ordersContainer');
                ordersContainer.innerHTML = '<div class="alert alert-danger text-center">' +
                    '<i class="fas fa-exclamation-circle me-2"></i>' +
                    'Failed to load orders. Please try again later.' +
                    '</div>';
            });
    }

    function fetchOrderDetails(orders) {
        if (!orders) return Promise.resolve([]);

        const orderPromises = orders.map(order => {
            const itemPromises = order.items.map(item => {
                return fetch('http://localhost:8080/api/books/' + item.bookId)
                    .then(response => {
                        if (!response.ok) {
                            // Return default book info if fetch fails
                            return {
                                name: 'Unknown Book',
                                imageUrl: 'https://via.placeholder.com/80x120?text=Book',
                                price: item.price || 0
                            };
                        }
                        return response.json();
                    })
                    .then(book => {
                        return {
                            ...item,
                            bookName: book.name || 'Unknown Book',
                            bookImage: book.imageUrl || 'https://via.placeholder.com/80x120?text=Book',
                            bookPrice: book.price || item.price || 0
                        };
                    });
            });

            return Promise.all(itemPromises)
                .then(itemsWithBooks => {
                    return {
                        ...order,
                        items: itemsWithBooks
                    };
                });
        });

        return Promise.all(orderPromises);
    }

    function renderOrders(orders) {
        const ordersContainer = document.getElementById('ordersContainer');
        ordersContainer.innerHTML = '';

        orders.forEach(order => {
            const orderDate = new Date(order.orderDate);
            const formattedDate = orderDate.toLocaleDateString('en-US', {
                year: 'numeric', month: 'long', day: 'numeric',
                hour: '2-digit', minute: '2-digit'
            });

            const statusClass = getStatusClass(order.status);
            const statusText = order.status.charAt(0).toUpperCase() + order.status.slice(1).toLowerCase();

            const orderDiv = document.createElement('div');
            orderDiv.className = 'order-container';

            let orderItemsHTML = '';
            let orderTotal = 0;

            order.items.forEach(item => {
                const itemPrice = item.bookPrice || item.price || 0;
                const itemTotal = item.quantity * itemPrice;
                orderTotal += itemTotal;

                orderItemsHTML += '<div class="order-item">' +
                    '<img src="' + item.bookImage + '" class="book-image" alt="' + item.bookName + '">' +
                    '<div class="flex-grow-1">' +
                    '<h5 class="mb-2">' + item.bookName + '</h5>' +
                    '<div class="d-flex justify-content-between text-muted mb-2">' +
                    '<div><i class="fas fa-hashtag me-1"></i>Quantity: ' + item.quantity + '</div>' +
                    '<div><i class="fas fa-tag me-1"></i>Price: $' + itemPrice.toFixed(2) + '</div>' +
                    '</div>' +
                    '<div class="text-end">' +
                    '<strong>Item Total: $' + itemTotal.toFixed(2) + '</strong>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            });

            orderDiv.innerHTML = '<div class="order-header">' +
                '<div class="d-flex justify-content-between align-items-start">' +
                '<div>' +
                '<h4 class="mb-2">Order <span class="order-id">#' + (order.id ? order.id.substring(0, 8) : 'N/A') + '</span></h4>' +
                '<p class="text-muted mb-0"><i class="far fa-calendar-alt me-2"></i>' + formattedDate + '</p>' +
                '</div>' +
                '<div class="text-end">' +
                '<span class="order-status ' + statusClass + '">' + statusText + '</span>' +
                '</div>' +
                '</div>' +
                (order.address ? '<div class="mt-3"><strong><i class="fas fa-map-marker-alt me-2"></i>Shipping Address:</strong> ' + order.address + '</div>' : '') +
                '</div>' +
                orderItemsHTML +
                '<div class="text-end mt-4 pt-3 border-top">' +
                '<h4 class="total-amount mb-0"><i class="fas fa-receipt me-2"></i>Order Total: $' + orderTotal.toFixed(2) + '</h4>' +
                '</div>';

            ordersContainer.appendChild(orderDiv);
        });
    }

    function getStatusClass(status) {
        if (!status) return 'status-pending';

        switch(status.toUpperCase()) {
            case 'PENDING':
                return 'status-pending';
            case 'COMPLETED':
                return 'status-completed';
            case 'CANCELLED':
                return 'status-cancelled';
            case 'DELIVERED':
                return 'status-completed';
            default:
                return 'status-pending';
        }
    }

    function showEmptyOrders() {
        const ordersContainer = document.getElementById('ordersContainer');
        ordersContainer.innerHTML = '<div class="empty-orders">' +
            '<i class="fas fa-box-open"></i>' +
            '<h3>No Orders Yet</h3>' +
            '<p>Start your reading journey by placing your first order!</p>' +
            '<a href="/" class="btn btn-primary btn-lg px-4">' +
            '<i class="fas fa-book me-2"></i>Browse Books' +
            '</a>' +
            '</div>';
    }
</script>
</body>
</html>
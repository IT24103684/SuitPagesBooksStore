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
        }
        .order-container {
            margin-bottom: 2rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .order-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        .order-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f5f5f5;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .book-image {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 20px;
        }
        .order-status {
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .empty-orders {
            text-align: center;
            padding: 50px 0;
        }
        .empty-orders i {
            font-size: 50px;
            color: #ddd;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../common/navbar.jsp"/>

<div class="container mt-5">
    <h1 class="mb-4">My Orders</h1>

    <div id="ordersContainer">

        <div class="text-center">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p>Loading your orders...</p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const userId = localStorage.getItem('userId');
        const ordersContainer = document.getElementById('ordersContainer');

        if (!userId) {
            ordersContainer.innerHTML = '<div class="alert alert-warning">Please login to view your orders</div>';
            return;
        }


        fetch('http://localhost:8080/api/orders/user/' + userId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to fetch orders');
                }
                return response.json();
            })
            .then(orders => {
                if (orders.length === 0) {
                    showEmptyOrders();
                    return;
                }


                const orderPromises = orders.map(order => {
                    const itemPromises = order.items.map(item => {
                        return fetch('http://localhost:8080/api/books/' + item.bookId)
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Failed to fetch book details');
                                }
                                return response.json();
                            })
                            .then(book => {
                                return {
                                    ...item,
                                    bookName: book.name,
                                    bookImage: book.imageUrl,
                                    bookPrice: book.price
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
            })
            .then(ordersWithBooks => {
                renderOrders(ordersWithBooks);
            })
            .catch(error => {
                console.error('Error:', error);
                ordersContainer.innerHTML = '<div class="alert alert-danger">Failed to load orders. Please try again later.</div>';
            });
    });

    function renderOrders(orders) {
        const ordersContainer = document.getElementById('ordersContainer');
        ordersContainer.innerHTML = '';

        if (orders.length === 0) {
            showEmptyOrders();
            return;
        }

        orders.forEach(order => {
            const orderDate = new Date(order.orderDate);
            const formattedDate = orderDate.toLocaleDateString('en-US', {
                year: 'numeric', month: 'long', day: 'numeric',
                hour: '2-digit', minute: '2-digit'
            });

            const statusClass = getStatusClass(order.status);

            const orderDiv = document.createElement('div');
            orderDiv.className = 'order-container';

            let orderItemsHTML = '';
            let orderTotal = 0;

            order.items.forEach(item => {
                const itemTotal = item.quantity * item.price;
                orderTotal += itemTotal;

                orderItemsHTML += '<div class="order-item">' +
                    '<img src="' + (item.bookImage || 'https://via.placeholder.com/80x120?text=No+Image') + '" class="book-image" alt="' + item.bookName + '">' +
                    '<div class="flex-grow-1">' +
                    '<h5>' + item.bookName + '</h5>' +
                    '<div class="d-flex justify-content-between">' +
                    '<div>Quantity: ' + item.quantity + '</div>' +
                    '<div>Price: $' + item.price.toFixed(2) + '</div>' +
                    '</div>' +
                    '<div class="text-end mt-2">' +
                    '<strong>Total: $' + itemTotal.toFixed(2) + '</strong>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            });

            orderDiv.innerHTML = '<div class="order-header">' +
                '<div class="d-flex justify-content-between">' +
                '<div>' +
                '<h4>Order #' + order.id.substring(0, 8) + '</h4>' +
                '<p class="text-muted">' + formattedDate + '</p>' +
                '</div>' +
                '<div>' +
                '<span class="order-status ' + statusClass + '">' + order.status + '</span>' +
                '</div>' +
                '</div>' +
                '<p><strong>Shipping Address:</strong> ' + order.address + '</p>' +
                '</div>' +
                orderItemsHTML +
                '<div class="text-end mt-3">' +
                '<h4>Order Total: $' + orderTotal.toFixed(2) + '</h4>' +
                '</div>';

            ordersContainer.appendChild(orderDiv);
        });
    }

    function getStatusClass(status) {
        switch(status.toUpperCase()) {
            case 'PENDING':
                return 'status-pending';
            case 'COMPLETED':
                return 'status-completed';
            case 'CANCELLED':
                return 'status-cancelled';
            default:
                return '';
        }
    }

    function showEmptyOrders() {
        const ordersContainer = document.getElementById('ordersContainer');
        ordersContainer.innerHTML = '<div class="empty-orders">' +
            '<i class="fas fa-box-open"></i>' +
            '<h3>No orders found</h3>' +
            '<p>You haven\'t placed any orders yet.</p>' +
            '<a href="books.jsp" class="btn btn-primary">Browse Books</a>' +
            '</div>';
    }
</script>
</body>
</html>
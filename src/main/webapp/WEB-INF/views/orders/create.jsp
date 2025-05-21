<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .cart-item {
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .form-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
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
            z-index: 1000;
            visibility: hidden;
        }
        .spinner {
            width: 3rem;
            height: 3rem;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container mt-5 mb-5">
    <h2 class="mb-4">Checkout</h2>

    <div class="row">
        <div class="col-md-8">
            <div class="form-container">
                <h4 class="mb-3">Shipping Information</h4>
                <form id="orderForm">
                    <div class="mb-3">
                        <label for="address" class="form-label">Shipping Address</label>
                        <textarea class="form-control" id="address" rows="3" required></textarea>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" id="placeOrderBtn">
                        Place Order
                    </button>
                </form>
            </div>
        </div>

        <div class="col-md-4">
            <div class="order-summary">
                <h4 class="mb-3">Order Summary</h4>
                <div id="cartItemsContainer">
                    <p class="text-center">Loading cart items...</p>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                    <h5>Total:</h5>
                    <h5 id="cartTotal">$0.00</h5>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner-border text-primary spinner" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const userId = localStorage.getItem("userId");
    let cartItems = [];
    let bookDetails = {};
    let cartTotal = 0;

    const cartItemsContainer = document.getElementById("cartItemsContainer");
    const cartTotalElement = document.getElementById("cartTotal");
    const orderForm = document.getElementById("orderForm");
    const addressInput = document.getElementById("address");
    const loadingOverlay = document.getElementById("loadingOverlay");

    if (!userId) {
        window.location.href = "/login?redirect=/checkout";
    }

    document.addEventListener("DOMContentLoaded", function() {
        fetchCartItems();
    });

    function fetchCartItems() {
        showLoading();

        fetch("/api/carts/" + userId)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to fetch cart");
                }
                return response.json();
            })
            .then(data => {
                cartItems = data.items || [];

                if (cartItems.length === 0) {
                    showEmptyCart();
                } else {
                    fetchBookDetails();
                }
            })
            .catch(error => {
                console.error("Error loading cart:", error);
                hideLoading();
                showError("Failed to load cart items. Please try again.");
            });
    }

    function fetchBookDetails() {
        const bookIds = cartItems.map(item => item.bookId);
        const promises = bookIds.map(bookId =>
            fetch("/api/books/" + bookId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch book details");
                    }
                    return response.json();
                })
        );

        Promise.all(promises)
            .then(books => {
                books.forEach(book => {
                    bookDetails[book.id] = book;
                });
                renderCartItems();
                hideLoading();
            })
            .catch(error => {
                console.error("Error loading book details:", error);
                hideLoading();
                showError("Failed to load book details. Please try again.");
            });
    }

    function renderCartItems() {
        if (cartItems.length === 0) {
            showEmptyCart();
            return;
        }

        let html = "";
        cartTotal = 0;

        cartItems.forEach(item => {
            const book = bookDetails[item.bookId];
            if (book) {
                const itemTotal = book.price * item.quantity;
                cartTotal += itemTotal;

                html += "<div class=\"cart-item\">";
                html += "<div class=\"d-flex justify-content-between\">";
                html += "<div>";
                html += "<h6>" + book.name + "</h6>";
                html += "<small class=\"text-muted\">Qty: " + item.quantity + "</small>";
                html += "</div>";
                html += "<div>$" + itemTotal.toFixed(2) + "</div>";
                html += "</div>";
                html += "</div>";
            }
        });

        cartItemsContainer.innerHTML = html;
        cartTotalElement.textContent = "$" + cartTotal.toFixed(2);
    }

    function showEmptyCart() {
        cartItemsContainer.innerHTML = "<p class=\"text-center\">Your cart is empty</p>";
        cartTotalElement.textContent = "$0.00";
        document.getElementById("placeOrderBtn").disabled = true;
    }

    orderForm.addEventListener("submit", function(event) {
        event.preventDefault();

        if (!validateForm()) {
            return;
        }

        placeOrder();
    });

    function validateForm() {
        let isValid = true;

        if (!addressInput.value.trim()) {
            addressInput.classList.add("is-invalid");
            isValid = false;
        } else {
            addressInput.classList.remove("is-invalid");
        }

        return isValid;
    }

    function placeOrder() {
        showLoading();

        const orderData = {
            userId: userId,
            address: addressInput.value.trim()
        };

        fetch("/api/orders", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(orderData)
        })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(data => {
                        throw new Error(data.error || "Failed to place order");
                    });
                }
                return response.json();
            })
            .then(data => {
                hideLoading();
                // Store success message in session storage
                sessionStorage.setItem("orderSuccess", "Your order has been placed successfully!");
                // Redirect to home page
                window.location.href = "/";
            })
            .catch(error => {
                console.error("Error placing order:", error);
                hideLoading();
                showError(error.message || "Failed to place order. Please try again.");
            });
    }

    function showLoading() {
        loadingOverlay.style.visibility = "visible";
    }

    function hideLoading() {
        loadingOverlay.style.visibility = "hidden";
    }

    function showError(message) {
        alert(message);
    }
</script>
</body>
</html>

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
        body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .container {
            padding-top: 30px;
            padding-bottom: 50px;
        }

        h2 {
            color: white;
            font-weight: 800;
            font-size: 2.5rem;
            text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            position: relative;
            padding-bottom: 20px;
            margin-bottom: 40px;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 150px;
            height: 5px;
            background: linear-gradient(90deg, #e94560, #4a90e2);
            border-radius: 3px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow:
                    0 20px 50px rgba(0, 0, 0, 0.25),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .form-container:hover {
            transform: translateY(-5px);
        }

        .order-summary {
            background: linear-gradient(135deg,
            rgba(233, 69, 96, 0.15) 0%,
            rgba(74, 144, 226, 0.15) 100%);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 35px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow:
                    0 20px 50px rgba(0, 0, 0, 0.25),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            height: fit-content;
            position: sticky;
            top: 30px;
        }

        h4 {
            color: white;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }

        h4:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, #e94560, #4a90e2);
            border-radius: 2px;
        }

        .cart-item {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            margin: 10px 0;
            background: rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease;
        }

        .cart-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .cart-item h6 {
            color: white;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .cart-item small {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-label {
            color: white;
            font-weight: 600;
            margin-bottom: 12px;
            font-size: 1rem;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.08);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: white;
            padding: 15px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: #e94560;
            box-shadow:
                    0 0 0 3px rgba(233, 69, 96, 0.2),
                    0 5px 20px rgba(233, 69, 96, 0.3);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .btn-primary {
            background: linear-gradient(135deg, #e94560 0%, #4a90e2 100%);
            border: none;
            padding: 16px 35px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(233, 69, 96, 0.4);
            width: 100%;
            margin-top: 20px;
        }

        .btn-primary:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
            );
            transition: left 0.6s;
        }

        .btn-primary:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(233, 69, 96, 0.6);
        }

        .btn-primary:hover:before {
            left: 100%;
        }

        .btn-primary:disabled {
            background: linear-gradient(135deg, #666 0%, #888 100%);
            box-shadow: none;
            transform: none;
            cursor: not-allowed;
        }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(26, 26, 46, 0.95);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .spinner {
            width: 70px;
            height: 70px;
            border: 5px solid rgba(255, 255, 255, 0.1);
            border-top: 5px solid #e94560;
            border-right: 5px solid #4a90e2;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        #cartTotal {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(90deg, #e94560, #4a90e2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        hr {
            border-color: rgba(255, 255, 255, 0.2);
            margin: 25px 0;
        }

        .d-flex.justify-content-between {
            color: white;
            font-size: 1.1rem;
        }

        .text-muted {
            color: rgba(255, 255, 255, 0.7) !important;
        }

        .text-center {
            color: rgba(255, 255, 255, 0.9);
            padding: 30px 0;
        }

        .invalid-feedback {
            color: #ff6b8b;
            font-weight: 500;
            margin-top: 8px;
        }

        .form-control.is-invalid {
            border-color: #ff6b8b;
            box-shadow: 0 0 0 3px rgba(255, 107, 139, 0.2);
        }

        * {
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<div class="container mt-4 mb-5">
    <h2><i class="fas fa-credit-card me-3"></i>Checkout</h2>

    <div class="row">
        <div class="col-lg-8 mb-4 mb-lg-0">
            <div class="form-container">
                <h4 class="mb-4"><i class="fas fa-truck me-2"></i>Shipping Information</h4>
                <form id="orderForm">
                    <div class="mb-4">
                        <label for="address" class="form-label">
                            <i class="fas fa-map-marker-alt me-2"></i>Shipping Address
                        </label>
                        <textarea class="form-control" id="address" rows="4"
                                  placeholder="Enter your complete shipping address" required></textarea>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary" id="placeOrderBtn">
                        <i class="fas fa-paper-plane me-2"></i>Place Order
                    </button>
                </form>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="order-summary">
                <h4 class="mb-4"><i class="fas fa-receipt me-2"></i>Order Summary</h4>
                <div id="cartItemsContainer">
                    <p class="text-center">
                        <i class="fas fa-spinner fa-spin me-2"></i>Loading cart items...
                    </p>
                </div>
                <hr>
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Total:</h5>
                    <h3 id="cartTotal">$0.00</h3>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="loading-overlay" id="loadingOverlay">
    <div class="spinner"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- ALL JAVASCRIPT CODE REMAINS EXACTLY THE SAME -->
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
        cartItemsContainer.innerHTML = "<p class=\"text-center\"><i class=\"fas fa-shopping-cart me-2\"></i>Your cart is empty</p>";
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
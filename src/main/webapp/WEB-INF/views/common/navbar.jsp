<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuitPages - Premium Suits Literature</title>
    <style>
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #1a1a2e;
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }

        .navbar-brand i {
            margin-right: 0.5rem;
            font-size: 1.8rem;
        }

        .auth-link {
            background-color: #e94560;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-weight: 500;
        }

        .auth-link:hover {
            background-color: #c73e54;
        }

        .auth-link.profile {
            background-color: transparent;
            border: 1px solid #e94560;
        }

        .auth-link.profile:hover {
            background-color: rgba(233, 69, 96, 0.1);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
        <i class="fas fa-book"></i> SuitPages
    </a>
    <div id="auth-container">
    </div>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const authContainer = document.getElementById('auth-container');
        const userId = localStorage.getItem('userId');

        if (userId) {
            authContainer.innerHTML = '<a href="/profile" class="auth-link profile"><i class="fas fa-user"></i> My Profile</a>';
        } else {
            authContainer.innerHTML = '<a href="/login" class="auth-link"><i class="fas fa-sign-in-alt"></i> Login</a>';
        }
    });
</script>
</body>
</html>
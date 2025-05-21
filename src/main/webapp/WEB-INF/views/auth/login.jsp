<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SuitPages</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <style>
        body {
            padding: 0;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.wallpaperscraft.com/image/single/books_library_shelves_138556_1920x1080.jpg') no-repeat center center fixed, #f0f0f0;
        }

        @keyframes libraryShift {
            0% {
                background-position: 0 0, 0 0, 0 0;
            }
            100% {
                background-position: 0 0, 0 60px, 60px 0;
            }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .login-container {
            max-width: 450px;
            margin: 2rem auto;
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                    linear-gradient(90deg, #8B4513 2%, transparent 2%),
                    linear-gradient(90deg, #DEB887 4%, transparent 4%),
                    linear-gradient(90deg, #A0522D 6%, transparent 6%),
                    linear-gradient(to bottom, #4A2F1A 10%, #3C2515 90%);
            background-size: 50px 100%, 50px 100%, 50px 100%, 100% 100%;
            animation: slideBookshelf 12s linear infinite;
            z-index: -1;
            opacity: 0.7;
        }

        @keyframes slideBookshelf {
            0% {
                background-position: 0 0, 0 0, 0 0, 0 0;
            }
            100% {
                background-position: 100px 0, 100px 0, 100px 0, 0 0;
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-title {
            font-size: 1.8rem;
            color: #1a1a2e;
            margin-bottom: 0.5rem;
            animation: welcomeFadeIn 1.5s ease-in-out forwards;
        }

        @keyframes welcomeFadeIn {
            0% {
                opacity: 0;
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        .login-subtitle {
            color: #666;
            font-size: 1rem;
        }

        .login-form {
            margin-top: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .form-input:focus {
            border-color: #e94560;
            outline: none;
        }

        .form-input-icon {
            position: relative;
        }

        .form-input-icon i {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            right: 10px;
            color: #999;
        }

        .form-input-icon input {
            padding-right: 40px;
        }

        .form-checkbox {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .form-checkbox input {
            margin-right: 10px;
        }

        .form-checkbox label {
            color: #666;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 0.85rem;
            background-color: #e94560;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-align: center;
        }

        .btn:hover {
            background-color: #c73e54;
        }

        .btn-loading {
            position: relative;
            pointer-events: none;
            background-color: #e94560;
        }

        .btn-loading:after {
            content: "";
            display: block;
            width: 1.2rem;
            height: 1.2rem;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -0.6rem;
            margin-top: -0.6rem;
            border-radius: 50%;
            border: 2px solid #fff;
            border-color: #fff transparent #fff transparent;
            animation: spin 1.2s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .login-footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        .login-footer p {
            color: #666;
            margin-bottom: 0.5rem;
        }

        .login-footer a {
            color: #e94560;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .login-footer a:hover {
            color: #c73e54;
            text-decoration: underline;
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 0.8rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            font-size: 0.9rem;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .error-message i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
<jsp:include page="../common/navbar.jsp"/>

<div class="container">
    <div class="login-container">
        <div class="login-header">
            <h1 class="login-title">Welcome Back</h1>
            <p class="login-subtitle">Sign in to access your account</p>
        </div>

        <div id="error-message" class="error-message">
            <i class="fas fa-exclamation-circle"></i>
            <span id="error-text">Invalid email or password. Please try again.</span>
        </div>

        <form id="login-form" class="login-form">
            <div class="form-group">
                <label for="email" class="form-label">Email Address</label>
                <div class="form-input-icon">
                    <input type="email" id="email" name="email" class="form-input" placeholder="Enter your email" required>
                    <i class="fas fa-envelope"></i>
                </div>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <div class="form-input-icon">
                    <input type="password" id="password" name="password" class="form-input" placeholder="Enter your password" required>
                    <i class="fas fa-lock"></i>
                </div>
            </div>

            <div class="form-checkbox">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember me</label>
            </div>

            <button type="submit" id="login-btn" class="btn">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>
        </form>

        <div class="login-footer">
            <p>Don't have an account? <a href="register">Register here</a></p>

        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loginForm = document.getElementById('login-form');
        const loginBtn = document.getElementById('login-btn');
        const errorMessage = document.getElementById('error-message');
        const errorText = document.getElementById('error-text');

        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();

            errorMessage.classList.remove('show');

            loginBtn.classList.add('btn-loading');
            loginBtn.innerHTML = '';

            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const remember = document.getElementById('remember').checked;

            const payload = {
                email: email,
                password: password
            };

            fetch('/api/users/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Login failed');
                    }
                    return response.json();
                })
                .then(data => {
                    localStorage.setItem('userId', data.id);


                    if (data.name) {
                        localStorage.setItem('userName', data.name);
                    }

                    if (data.email) {
                        localStorage.setItem('userEmail', data.email);
                    }

                    if (remember) {
                        localStorage.setItem('rememberUser', 'true');
                    }



                    window.location.href = "/";
                })
                .catch(error => {
                    console.error('Login error:', error);

                    loginBtn.classList.remove('btn-loading');
                    loginBtn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Sign In';

                    errorText.textContent = 'Invalid email or password. Please try again.';
                    errorMessage.classList.add('show');
                });
        });

        function getParameterByName(name) {
            const url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
            const results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }

        if (localStorage.getItem('userId')) {
            window.location.href = 'index';
        }
    });
</script>
</body>
</html>
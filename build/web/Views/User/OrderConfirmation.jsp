<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác Nhận Đơn Hàng | Helios Jewels</title>
        <link
            rel="icon"
            type="image/png"
            href="https://ext.same-assets.com/718871603/3418794103.png"
            />
        <style>
            /* Reset some defaults */
            html,
            body {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background: #0c0f11;
                color: #fff;
                font-family: 'SVN-Futura', Arial, Helvetica, sans-serif;
            }

            /* Navbar */
            .navbar {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1.3rem 2.5rem 1.3rem 1.8rem;
                box-sizing: border-box;
                font-size: 1.08rem;
                background: #3c4146;
            }

            .nav-section {
                display: flex;
                align-items: center;
            }

            .nav-left .nav-link,
            .nav-right .nav-link {
                color: #fff;
                margin-right: 1.5rem;
                text-decoration: none;
                letter-spacing: 0.01em;
                font-weight: 400;
                transition: color 0.2s;
            }

            .nav-left .nav-link:last-child,
            .nav-right .nav-link:last-child {
                margin-right: 0;
            }

            .nav-link.nav-highlight {
                background: #ffc34a;
                color: #1a1717;
                font-weight: bold;
                border-radius: 3px;
                padding: 0.4rem 1.35rem;
                margin-right: 1.5rem;
                margin-left: 0.35rem;
                box-shadow: 0 3px 6px rgba(255, 195, 74, 0.08);
                transition: background 0.25s, color 0.25s;
            }

            .logo {
                font-family: 'Old English Text MT', 'Cinzel Decorative', serif;
                font-size: 2.5rem;
                color: #fff;
                letter-spacing: 0.15em;
                text-transform: uppercase;
                text-align: center;
                font-weight: 600;
            }

            .nav-center {
                flex: 1;
                justify-content: center;
                display: flex;
            }

            .nav-section.nav-left {
                min-width: 380px;
            }

            .nav-section.nav-right {
                min-width: 390px;
                justify-content: flex-end;
                gap: 0.5rem;
            }

            .nav-icon img {
                vertical-align: middle;
                filter: brightness(95%);
            }

            .nav-icon.cart {
                position: relative;
                margin-left: 0.1rem;
            }

            .cart-count {
                position: absolute;
                top: -6px;
                right: -9px;
                background: #ffc34a;
                color: #cdb7b7;
                border-radius: 50%;
                font-size: 0.7rem;
                width: 18px;
                height: 18px;
                line-height: 18px;
                text-align: center;
                font-weight: bold;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            .dropdown span {
                cursor: pointer;
                font-size: 1rem;
                margin-right: 1.7rem;
            }

            /* Order Confirmation Page Styles */
            .confirmation-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 20px;
            }

            .confirmation-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .confirmation-title {
                font-size: 2rem;
                color: #ffc34a;
                margin-bottom: 1rem;
            }

            .confirmation-message {
                font-size: 1.2rem;
                color: #f0ece7;
                margin-bottom: 2rem;
            }

            .order-number {
                color: #ffc34a;
                font-weight: bold;
            }

            .confirmation-content {
                display: flex;
                flex-wrap: wrap;
                gap: 2rem;
            }

            .order-details {
                flex: 2;
                min-width: 300px;
            }

            .order-summary {
                flex: 1;
                background: #1f1c1c;
                padding: 1.5rem;
                border-radius: 12px;
                height: fit-content;
            }

            .section-title {
                font-size: 1.4rem;
                color: #ffc34a;
                margin-bottom: 1.5rem;
                border-bottom: 1px solid #3c4146;
                padding-bottom: 0.5rem;
            }

            .shipping-info {
                background: #1f1c1c;
                padding: 1.5rem;
                border-radius: 12px;
                margin-bottom: 2rem;
            }

            .info-row {
                margin-bottom: 0.8rem;
                font-size: 1.1rem;
            }

            .info-label {
                color: #bbb8ae;
                display: inline-block;
                width: 150px;
            }

            .info-value {
                color: #f0ece7;
            }

            .order-items {
                background: #1f1c1c;
                padding: 1.5rem;
                border-radius: 12px;
            }

            .order-item {
                display: flex;
                padding: 1rem 0;
                border-bottom: 1px solid #3c4146;
                gap: 1.5rem;
            }

            .order-item:last-child {
                border-bottom: none;
            }

            .order-item-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 6px;
            }

            .order-item-details {
                flex: 1;
            }

            .order-item-title {
                font-size: 1.1rem;
                color: #f0ece7;
                margin: 0 0 0.5rem 0;
            }

            .order-item-variant {
                font-size: 0.9rem;
                color: #bbb8ae;
                margin-bottom: 0.5rem;
            }

            .order-item-price {
                font-size: 1rem;
                color: #ffc34a;
            }

            .order-item-quantity {
                font-size: 0.9rem;
                color: #bbb8ae;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
                font-size: 1.1rem;
            }

            .summary-total {
                font-weight: bold;
                font-size: 1.3rem;
                margin-top: 1.5rem;
                border-top: 1px solid #3c4146;
                padding-top: 1rem;
            }

            .continue-btn {
                display: inline-block;
                width: 100%;
                padding: 12px;
                background: #ffc34a;
                color: #1a1717;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 1.1rem;
                cursor: pointer;
                margin-top: 1.5rem;
                text-align: center;
                text-decoration: none;
                transition: background 0.3s;
            }

            .continue-btn:hover {
                background: #e6b042;
            }

            /* Footer Styling */
            footer {
                background: #101011;
                color: #fff;
                padding-top: 2.8rem;
                padding-bottom: 0.7rem;
                margin-top: 3rem;
                width: 100vw;
            }

            .footer-inner {
                max-width: 1250px;
                margin: 0 auto;
                width: 95%;
            }

            .footer-cols {
                display: flex;
                flex-wrap: wrap;
                gap: 2.5rem;
                justify-content: space-between;
            }

            .footer-col {
                flex: 1 1 220px;
                min-width: 200px;
                margin-bottom: 2.6rem;
            }

            .footer-col h3 {
                font-size: 1.08rem;
                margin-bottom: 0.7rem;
                color: #ffc34a;
                font-weight: 600;
                letter-spacing: 0.04em;
            }

            .footer-col p {
                font-size: 1rem;
                margin: 5px 0 16px 0;
                color: #f0ece7;
            }

            .footer-col ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .footer-col li {
                margin-bottom: 0.45rem;
            }

            .footer-col a {
                color: #f7eadf;
                text-decoration: none;
                transition: color 0.2s;
            }

            .footer-col a:hover {
                color: #ffc34a;
            }

            .footer-social a {
                display: inline-block;
                margin-right: 0.6rem;
                margin-top: 0.2rem;
            }

            .footer-social img {
                height: 28px;
                width: 28px;
                filter: grayscale(0) brightness(0.96);
                transition: filter 0.2s;
            }

            .footer-social img:hover {
                filter: grayscale(0) brightness(1) drop-shadow(0 0 4px #ffc34a77);
            }

            /* Bottom Row */
            .footer-bottom {
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-top: 1.5px solid #242526;
                padding-top: 1rem;
                padding-bottom: 0.3rem;
            }

            .footer-left {
                display: flex;
                align-items: center;
                gap: 1.1rem;
            }

            .footer-logo {
                vertical-align: middle;
            }

            .copyright {
                font-size: 1rem;
                opacity: 0.88;
                color: #bbb8ae;
            }

            .footer-links {
                gap: 1.5rem;
                display: flex;
            }

            .footer-links a {
                color: #fff;
                font-size: 1rem;
                text-decoration: none;
                opacity: 0.94;
                margin-left: 1rem;
                transition: color 0.17s, opacity 0.17s;
            }

            .footer-links a:hover {
                color: #ffc34a;
                opacity: 1;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .confirmation-content {
                    flex-direction: column;
                }

                .order-item {
                    flex-direction: column;
                    gap: 1rem;
                }

                .order-item-img {
                    width: 100%;
                    height: auto;
                    max-height: 200px;
                }
            }

            @media (max-width: 1020px) {
                .footer-cols {
                    flex-direction: column;
                    gap: 0.7rem;
                }

                .footer-bottom {
                    flex-direction: column;
                    gap: 0.5rem;
                    align-items: flex-start;
                }
            }

            @media (max-width: 650px) {
                .footer-inner {
                    width: 100vw;
                    padding: 0 1.5vw;
                }

                .info-label {
                    width: 120px;
                    font-size: 1rem;
                }
            }

            @media (max-width: 900px) {
                .navbar {
                    flex-direction: column;
                    padding: 1rem;
                }

                .nav-section.nav-left,
                .nav-section.nav-right {
                    min-width: auto;
                }

                .nav-center {
                    margin: 0.7rem 0 0.4rem 0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="../Partials/Header.jsp" %>

        <!-- Main Content -->
        <main class="confirmation-container">
            <div class="confirmation-header">
                <h1 class="confirmation-title">ĐẶT HÀNG THÀNH CÔNG</h1>
                <p class="confirmation-message">
                    Cảm ơn bạn đã mua hàng! Mã đơn hàng của bạn là: 
                    <span class="order-number">#${order.id}</span>
                </p>
            </div>

            <div class="confirmation-content" style="justify-content: center">
                <img src="${pageContext.request.contextPath}/images/${urlImg}" style="height: 550px; width:1000px"/>
            </div>
        </main>

        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>
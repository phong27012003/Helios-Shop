<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ Hàng | Helios Jewels</title>
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

            /* Cart Page Styles */
            .cart-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 20px;
            }

            .cart-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .cart-title {
                font-size: 2rem;
                color: #ffc34a;
                margin-bottom: 1rem;
            }

            .cart-content {
                display: flex;
                flex-wrap: wrap;
                gap: 2rem;
            }

            .cart-items {
                flex: 2;
                min-width: 300px;
            }

            .cart-summary {
                flex: 1;
                background: #1f1c1c;
                padding: 1.5rem;
                border-radius: 12px;
                height: fit-content;
            }

            .summary-title {
                font-size: 1.4rem;
                color: #ffc34a;
                margin-bottom: 1.5rem;
                border-bottom: 1px solid #3c4146;
                padding-bottom: 0.5rem;
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

            .checkout-btn {
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
                transition: background 0.3s;
            }

            .checkout-btn:hover {
                background: #e6b042;
            }

            .cart-item {
                display: flex;
                background: #1f1c1c;
                padding: 1.5rem;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                gap: 1.5rem;
            }

            .cart-item-img {
                width: 120px;
                height: 120px;
                object-fit: cover;
                border-radius: 8px;
            }

            .cart-item-details {
                flex: 1;
            }

            /* Updated: Title and controls on same line */
            .cart-item-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 0.5rem;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .cart-item-title {
                font-size: 1.2rem;
                color: #f0ece7;
                margin: 0;
                flex: 1;
                min-width: 200px;
            }

            .cart-item-controls {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-shrink: 0;
            }

            .cart-item-price {
                font-size: 1.1rem;
                color: #ffc34a;
                margin-bottom: 0.5rem;
            }

            .quantity-control {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .quantity-btn {
                background: #3c4146;
                color: #fff;
                border: none;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.2s;
            }

            .quantity-btn:hover {
                background: #4a5056;
            }

            .quantity-input {
                width: 40px;
                text-align: center;
                background: transparent;
                border: 1px solid #3c4146;
                color: #fff;
                padding: 5px;
                border-radius: 4px;
            }

            .remove-btn {
                background: none;
                border: none;
                color: #e74c3c;
                cursor: pointer;
                font-size: 0.9rem;
                padding: 5px 10px;
                border-radius: 4px;
                transition: background 0.2s;
            }

            .remove-btn:hover {
                background: rgba(231, 76, 60, 0.1);
            }

            .continue-shopping {
                display: inline-block;
                margin-top: 1.5rem;
                color: #ffc34a;
                text-decoration: none;
                font-size: 1rem;
            }

            .continue-shopping:hover {
                text-decoration: underline;
            }

            .empty-cart {
                text-align: center;
                padding: 3rem;
                background: #1f1c1c;
                border-radius: 12px;
            }

            .empty-cart-title {
                font-size: 1.5rem;
                margin-bottom: 1rem;
                color: #ffc34a;
            }

            .empty-cart-message {
                margin-bottom: 1.5rem;
                color: #f0ece7;
            }

            .shop-btn {
                display: inline-block;
                padding: 10px 20px;
                background: #ffc34a;
                color: #1a1717;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background 0.3s;
            }

            .shop-btn:hover {
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
                .cart-item {
                    flex-direction: column;
                }

                .cart-item-img {
                    width: 100%;
                    height: auto;
                }

                .cart-content {
                    flex-direction: column;
                }

                .cart-item-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.5rem;
                }

                .cart-item-controls {
                    align-self: flex-end;
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

            @media (max-width: 580px) {
                .cart-item-title {
                    min-width: auto;
                    font-size: 1.1rem;
                }

                .quantity-control {
                    gap: 0.3rem;
                }

                .quantity-btn {
                    width: 28px;
                    height: 28px;
                    font-size: 0.9rem;
                }

                .quantity-input {
                    width: 35px;
                }
            }
            
        </style>
    </head>
    <body>
        <!-- Header -->
        <%@include file="../Partials/Header.jsp" %>

        <!-- Main Content -->
        <main class="cart-container">
            <div class="cart-header">
                <h1 class="cart-title">GIỎ HÀNG CỦA BẠN ${userId} </h1>
                <a href="showAllProduct" class="continue-shopping">← Tiếp tục mua sắm</a>
            </div>

        <div class="cart-content">
                <div class="cart-items">
                    <c:choose>
                        <c:when test="${empty cartList || cartList.size() == 0}">
                            <div class="empty-cart">
                                <h2 class="empty-cart-title">Giỏ hàng của bạn đang trống</h2>
                                <p class="empty-cart-message">Hãy khám phá các sản phẩm của chúng tôi và thêm vào giỏ hàng!</p>
                                <a href="showAllProduct" class="shop-btn">MUA SẮM NGAY</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cart" items="${cartList}">
                                <div class="cart-item">
                                    <img src="${cart.variant.getProduct().getImageUrls().get(0)}" 
                                         alt="${cart.variant.getProduct().getName()}" 
                                         class="cart-item-img"/>
                                    <div class="cart-item-details">
                                        <div class="cart-item-header">
                                            <h3 class="cart-item-title">${cart.variant.getProduct().getName()}</h3>
                                            <div class="cart-item-controls">
                                                <form action="update-cart" method="post" class="quantity-control">
                                                    <input type="hidden" name="variantId" value="${cart.variant.getVariantId()}">
                                                    <button type="submit" name="action" value="decrease" class="quantity-btn">-</button>
                                                    <input type="text" name="quantity" value="${cart.quantity}" 
                                                           class="quantity-input" readonly>
                                                    <button type="submit" name="action" value="increase" class="quantity-btn">+</button>
                                                </form>
                                                <form action="remove-from-cart" method="post">
                                                    <input type="hidden" name="variantId" value="${cart.variant.getVariantId()}">
                                                    <button type="submit" class="remove-btn">Xóa</button>
                                                </form>
                                            </div>
                                        </div>

                                        <p>Phân loại: 
                                            <c:if test="${not empty cart.variant.getColor()}">
                                                Màu: ${cart.variant.getColor()}
                                            </c:if>
                                            <c:if test="${not empty cart.variant.getSize()}">
                                                | Size: ${cart.variant.getSize()}
                                            </c:if>
                                        </p>

                                        <p>Giá gốc: 
                                            <fmt:formatNumber value="${cart.variant.getProduct().getPrice()}" type="currency" currencySymbol="₫" />
                                        </p>
                                        <p>Giá sau giảm: <fmt:formatNumber value="${cart.variant.getProduct().getDiscountedPrice()}" type="currency" currencySymbol="₫"/></p>
                                        <p>Thành tiền: 
                                            <fmt:formatNumber 
                                                value="${(cart.variant.getProduct().getPrice() - cart.variant.getProduct().getPrice() * cart.variant.getProduct().getDiscount()) * cart.quantity}" 
                                                type="currency" 
                                                currencySymbol="₫" />
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="cart-summary">
                    <div class="summary-title">Tóm Tắt Đơn Hàng</div>

                    <c:set var="totalAmount" value="0" />
                    <c:set var="totalQuantity" value="0" />
                    <c:set var="totalDiscount" value="0" />

                    <c:forEach var="item" items="${cartList}">
                        <c:set var="price" value="${item.variant.getProduct().getPrice()}" />
                        <c:set var="discount" value="${item.variant.getProduct().getDiscount()}" />
                        <c:set var="quantity" value="${item.quantity}" />

                        <c:set var="itemTotal" value="${(price - (price * discount)) * quantity}" />
                        <c:set var="itemDiscountAmount" value="${(price * discount) * quantity}" />

                        <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                        <c:set var="totalDiscount" value="${totalDiscount + itemDiscountAmount}" />
                        <c:set var="totalQuantity" value="${totalQuantity + quantity}" />
                    </c:forEach>

                    <div class="summary-row">
                        <span>Tổng sản phẩm:</span>
                        <span>${totalQuantity}</span>
                    </div>

                    <div class="summary-row">
                        <span>Giảm giá:</span>
                        <span><fmt:formatNumber value="${totalDiscount}" type="currency" currencySymbol="₫" /></span>
                    </div>

                    <div class="summary-row summary-total">
                        <span>Tổng tiền:</span>
                        <span><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫" /></span>
                    </div>

                    <form action="checkout" method="post">
                        <button type="submit" class="checkout-btn">Tiến hành thanh toán</button>
                    </form>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>
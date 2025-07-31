<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.lang.Math" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Helios Shop</title>
        <style>
            /* 1. Hero Section Styles */
            @import url('https://fonts.googleapis.com/css2?family=UnifrakturCook:wght@700&display=swap');
            /* Gothic font close match */
            @import url('https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap');

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
                /* Placeholder: will setup custom gothic font*/
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
                color: #1a1717;
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

            .hero {
                position: relative;
                width: 100vw;
                min-height: 70vh;
                display: flex;
                align-items: center;
                justify-content: center;
                box-sizing: border-box;
                overflow: hidden;
                background: #101314;
            }

            .hero-bg {
                position: absolute;
                inset: 0;
                width: 100%;
                height: 100%;
                background: url('https://ext.same-assets.com/837853198/2015606937.jpeg') center center/cover no-repeat;
                z-index: 1;
                filter: brightness(0.6);
            }

            .hero-content {
                position: relative;
                z-index: 2;
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding-top: 5vh;
                padding-bottom: 7vh;
            }

            .hero-collection {
                color: #fff;
                font-size: 1.3rem;
                font-weight: 300;
                margin: 0 0 2vh 0;
                letter-spacing: 0.04em;
            }

            .hero-title {
                font-family: 'UnifrakturCook', 'Old English Text MT', serif;
                font-size: clamp(3.3rem, 7vw, 6.5rem);
                color: #fff;
                margin: 0 0 2.2vh 0;
                text-shadow: 0 3px 12px #000;
                letter-spacing: 0.12em;
            }

            .hero-btn {
                font-size: 1.16rem;
                text-decoration: none;
                padding: 0.9rem 2.2rem;
                background: #fff;
                color: #0c0f11;
                border: none;
                border-radius: 8px;
                margin-top: 1.4vh;
                font-family: inherit;
                font-weight: 500;
                box-shadow: 0 4px 18px rgba(0, 0, 0, 0.04);
                transition: background 0.2s, color 0.2s;
                cursor: pointer;
                display: inline-block;
            }

            .hero-btn:hover {
                background: #ffc34a;
                color: #1a1717;
            }

            /* 2. Slogan/Script Section */
            .slogan-bar {
                width: 100%;
                background: #18191a;
                text-align: center;
                padding: 2rem 0.2rem 1.2rem 0.2rem;
                margin: 0;
                box-shadow: 0 2px 15px 0 rgba(0, 0, 0, 0.06);
            }

            .slogan-script {
                font-family: 'Indie Flower', cursive;
                font-size: 1.4rem;
                color: #ded7d0;
                letter-spacing: 0.06em;
                line-height: 2.1rem;
                filter: brightness(0.95);
            }

            /* Dropdown menu for MENU */
            .menu-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .menu-main {
                position: relative;
                z-index: 40;
            }

            .menu-dropdown {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                margin-top: 9px;
                min-width: 420px;
                max-width: 700px;
                background: #181a1b;
                color: #f7f7f5;
                border-radius: 12px;
                box-shadow: 0 14px 42px 0 rgba(20, 15, 12, 0.13);
                padding: 1.2rem 1.5rem 1.1rem 1.5rem;
                flex-direction: row;
                gap: 2.4rem;
                z-index: 39;
                animation: menuFadeIn .2s;
            }

            .menu-dropdown-wrapper:hover .menu-dropdown,
            .menu-dropdown-wrapper:focus-within .menu-dropdown {
                display: flex;
            }

            .menu-col {
                display: flex;
                flex-direction: column;
                min-width: 155px;
                padding-right: 7px;
            }

            .menu-header {
                color: #ffc34a;
                font-weight: bold;
                font-size: 1.02rem;
                margin-bottom: 4px;
                margin-top: 11px;
                letter-spacing: 0.02em;
            }

            .menu-col a {
                font-size: 1rem;
                color: #f7f7f5;
                text-decoration: none;
                padding: 4px 0 4px 2px;
                margin-bottom: 1px;
                border-radius: 5px;
                transition: background 0.18s, color 0.16s;
                cursor: pointer;
            }

            .menu-col a:hover {
                background: #25201b;
                color: #ffc34a;
            }

            @keyframes menuFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(18px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 900px) {
                .menu-dropdown {
                    left: 0;
                    top: 100%;
                    min-width: 240px;
                    padding: 0.7rem 0.7rem 0.8rem 0.7rem;
                    gap: 0.6rem;
                }

                .menu-col {
                    min-width: 98px;
                }
            }

            /* 3. Footer Styling */
            footer {
                background: #101011;
                color: #fff;
                padding-top: 2.8rem;
                padding-bottom: 0.7rem;
                margin-top: 0;
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
                .hero {
                    min-height: 55vh;
                    padding-bottom: 30px;
                }

                .hero-content {
                    padding: 7vw 2vw;
                }

                .footer-inner {
                    width: 100vw;
                    padding: 0 1.5vw;
                }
            }




            /* Dropdown menu for MENU */
            .menu-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .menu-main {
                position: relative;
                z-index: 40;
            }

            .menu-dropdown {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                margin-top: 9px;
                min-width: 420px;
                max-width: 700px;
                background: #181a1b;
                color: #f7f7f5;
                border-radius: 12px;
                box-shadow: 0 14px 42px 0 rgba(20, 15, 12, 0.13);
                padding: 1.2rem 1.5rem 1.1rem 1.5rem;
                flex-direction: row;
                gap: 2.4rem;
                z-index: 39;
                animation: menuFadeIn .2s;
            }

            .menu-dropdown-wrapper:hover .menu-dropdown,
            .menu-dropdown-wrapper:focus-within .menu-dropdown {
                display: flex;
            }

            .menu-col {
                display: flex;
                flex-direction: column;
                min-width: 155px;
                padding-right: 7px;
            }

            .menu-col a {
                font-size: 1rem;
                color: #f7f7f5;
                text-decoration: none;
                padding: 4px 0 4px 2px;
                margin-bottom: 1px;
                border-radius: 5px;
                transition: background 0.18s, color 0.16s;
                cursor: pointer;
            }

            .menu-col a:hover {
                background: #25201b;
                color: #ffc34a;
            }

            @keyframes menuFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(18px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 900px) {
                .menu-dropdown {
                    left: 0;
                    top: 100%;
                    min-width: 240px;
                    padding: 0.7rem 0.7rem 0.8rem 0.7rem;
                    gap: 0.6rem;
                }

                .menu-col {
                    min-width: 98px;
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
        <!--Main-->
        <main>
            <section class="hero">
                <div class="hero-bg"></div>
                <div class="hero-content">
                    <h2 class="hero-collection">New Collection</h2>
                    <h1 class="hero-title">CHRYSABER</h1>
                    <a class="hero-btn" href="#">Khám phá ngay</a>
                </div>
            </section>
            <section class="slogan-bar">
                <span class="slogan-script">
                    Có những thứ các bạn trong người đàn ông, đó là những mong chờ, lặp
                    lại, luôn tồn tại. <br />
                    Họ kỹ lưỡng, lỳ lợm và đứng thẳng - cũng tồn trong những giá trị, cảm
                    xúc và câu chuyện.
                </span>
            </section>
        </main>
        <!-- Footer -->
        <%@include file="../Partials/Footer.jsp" %>
    </body>
</html>

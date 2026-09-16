# 🛒 Fruits E-Commerce App

A complete Flutter e-commerce application with a powerful Admin Panel, Firebase integration, online payment, push notifications, localization, and a production-ready backend.

## 📱 Overview

Fruits is a full-featured e-commerce application built with Flutter.

The project includes both:

- 📱 Customer Mobile App
- 🖥️ Admin Panel
- ⚙️ Backend API

The application provides a complete shopping experience from browsing products to placing orders and completing online payments.

## ✨ Features

### 👤 Customer App

- 🔐 Authentication
  - Sign Up
  - Login
  - Logout
  - Firebase Authentication

- 🛍️ Products
  - Browse products
  - Product details
  - Product categories
  - Search and filtering

- 🛒 Shopping Cart
  - Add products to cart
  - Remove products
  - Update quantities
  - Calculate subtotal and total price

- 📦 Orders
  - Create orders
  - Track order status
  - View order details

- 💳 Online Payment
  - Paymob integration
  - Secure online card payments
  - Payment status handling
  - Payment confirmation through backend webhooks

- 🔔 Push Notifications
  - Firebase Cloud Messaging (FCM)
  - Notifications for users
  - Admin can send notifications to customers

- 🌍 Localization
  - Multi-language support
  - Localized application content
  - Easy language switching

- 📱 Responsive UI
  - Responsive layouts
  - Adaptive UI
  - Smooth user experience

## 🖥️ Admin Panel

The project includes a complete Admin Panel for managing the application.

### Admin Features

- 📦 Product Management
  - Add products
  - Edit products
  - Delete products
  - Manage product information

- 🗂️ Category Management

- 📰 Content Management
  - Manage news/content
  - Manage banners and advertisements

- 📋 Order Management
  - View orders
  - Manage order status
  - View customer order details
  - Track payment status

- 🔔 Notification Management
  - Send push notifications
  - Send notifications to all users

- 👥 User Management

The Admin Panel allows the application data and customer experience to be managed from a centralized dashboard.

## ⚙️ Backend

The project uses a separate Node.js + TypeScript backend.

### Backend Technologies

- Node.js
- TypeScript
- Express.js
- Firebase Admin SDK
- Firestore
- Paymob API
- Railway

### Backend Responsibilities

- Create Paymob payment sessions
- Handle Paymob webhooks
- Verify payment HMAC
- Update payment status
- Update order status
- Secure communication with Paymob
- Manage server-side operations

## 🔥 Firebase

Firebase is used for several parts of the application:

- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Admin SDK

## 💳 Payment Flow

The online payment flow works as follows:

```text
Flutter App
    ↓
Create Order
    ↓
Backend API
    ↓
Paymob
    ↓
Customer Completes Payment
    ↓
Paymob Webhook
    ↓
Backend HMAC Verification
    ↓
Firestore
    ↓
Order Status = Paid

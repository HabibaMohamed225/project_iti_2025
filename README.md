# 🍽️ Relax - Restaurant App
[![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Backend-orange)](https://firebase.google.com/)
[![Dart](https://img.shields.io/badge/Dart-Language-blue)](https://dart.dev/)

**Relax** is a modern restaurant application built with **Flutter** and fully integrated with **Firebase** for authentication and data management.  
It provides an intuitive interface for customers to order food and an admin panel to manage the restaurant menu.

> 💡 Developed as a **team project** by **Shorouk Nasser**, **Shadya Fathi**, and **Habiba Mohamed**.

---
## 🎬 Live Demo
<img src="https://images2.imgbox.com/7b/b6/zHsnVYXg_o.gif" alt="App Demo GIF" width="400">
### 👨‍💼 Admin
- Add new products to the menu.
- Delete existing products.
- Update product details (name, price, image).
- Data stored directly in **Firebase Firestore**.

### 👤 Regular User
1. **Sign Up & Login**
   - Create a new account or log in with email and password (**Firebase Auth**).
2. **Profile Page**
   - View user details.
   - Navigate to Home page.
3. **Home Page**
   - View restaurant menu.
   - Add products to the cart.
4. **Cart**
   - View selected products.
   - Increase/decrease quantity or remove products.
   - See total order amount.
   - Proceed to delivery page.
5. **Delivery Page**
   - Enter address and contact details.
6. **Confirmed Order**
   - Display order confirmation message.

---

## 🎬 Demo Video (Preview + Full)

<img src="https://i.ibb.co/DfmMwtv4/fianal2.gif" alt="Demo Video" width="400">

> The GIF above is a short preview. Click the link to watch the full demo video.

---

## 🖼️ Screenshots (Animated GIFs)

## 🛠️ Tech Stack
- **Flutter** – UI development  
- **Firebase Authentication** – Login & Signup  
- **Firebase Firestore** – Data storage  
- **Bloc State Management** – State handling  
- **Dart** – Programming language  

---

## 📂 Project Structure

```text
lib/
├─ blocs/
│  ├─ admin/
│  │  ├─ admin_bloc.dart
│  │  ├─ admin_event.dart
│  │  └─ admin_state.dart
│  ├─ cart/
│  │  ├─ cart_bloc.dart
│  │  ├─ cart_event.dart
│  │  └─ cart_state.dart
│  ├─ home/
│  │  ├─ menu_bloc.dart
│  │  ├─ menu_event.dart
│  │  └─ menu_state.dart
│  └─ auth/
│     ├─ auth_bloc.dart
│     ├─ auth_event.dart
│     └─ auth_state.dart
├─ core/
│  ├─ constants/
│  │  ├─ app_colors.dart
│  │  └─ app_strings.dart
│  └─ themes/
│     └─ app_themes.dart
├─ utils/
│  └─ firebase_options.dart
├─ data/
├─ presentation/
│  ├─ screens/
│  │  ├─ admin/
│  │  │  ├─ admin_add_screan.dart
│  │  │  ├─ admin_add_screan_content.dart
│  │  │  ├─ admin_page_screan.dart
│  │  │  └─ admin_page_screan_content.dart
│  │  ├─ cart/
│  │  │  ├─ cart_screen.dart
│  │  │  └─ cart_screen_content.dart
│  │  ├─ confirmed_order/
│  │  │  ├─ confirmed_order_content_screen.dart
│  │  │  └─ confirmed_order_screen.dart
│  │  ├─ delivery/
│  │  │  ├─ delivery_screen.dart
│  │  │  └─ delivery_screen_content.dart
│  │  ├─ home/
│  │  │  ├─ home_screen.dart
│  │  │  └─ home_screen_content.dart
│  │  ├─ login/
│  │  │  ├─ login_screen.dart
│  │  │  └─ login_screen_content.dart
│  │  ├─ profile/
│  │  │  ├─ profile_screen.dart
│  │  │  └─ profile_screen_content.dart
│  │  └─ signup/
│  │     ├─ sign_up_screen_content.dart
│  │     └─ signup_screen.dart
│  └─ widgets/
│     ├─ admin_widge/
│     │  ├─ build_product_card.dart
│     │  ├─ image_preview.dart
│     │  ├─ product_form_actions.dart
│     │  ├─ product_form_fields.dart
│     │  ├─ product_form_listener.dart
│     │  ├─ product_info_row.dart
│     │  └─ stat_card.dart
│     ├─ auth/
│     │  ├─ app_bottom_nav.dart
│     │  ├─ auth_header.dart
│     │  └─ firebase_auth.dart
│     ├─ cart_widgets/
│     │  └─ cart_item_tile.dart
│     └─ delivery_widget/
│        ├─ delivery_form.dart
│        ├─ custom_text_field.dart
│        ├─ primary_button.dart
│        └─ shared_card.dart
├─ main.dart
└─ my_app.dart

android/
ios/
web/
windows/
linux/
macos/
assets/
.gitignore
.metadata
README.md
analysis_options.yaml
firebase.json
pubspec.lock
pubspec.yaml

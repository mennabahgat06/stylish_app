# Stylish – E-Commerce App (Flutter + Dio)

Connected to the **NTI e-commerce API** (`ecommerce.json` in this folder):
```
https://nti-ecommerce-api-production-8a47.up.railway.app/api/
```
The url is in `lib/core/network/end_points.dart` (the only place to change it).

Run: `flutter pub get` then `flutter run`.

## Endpoints used by the app
| Screen | Method | Endpoint | Body |
|---|---|---|---|
| Register | POST | register | form-data: name, email, phone, password, image? |
| Login | POST | login | form-data: email, password |
| (automatic, every 15 min) | POST | refresh_token | Bearer **refresh** token |
| Profile | GET | get_user_data | – |
| Edit Profile | PUT | update_profile | form-data: name, phone, image? |
| Profile → Delete Account | DELETE | delete_user | – |
| Home banner | GET | sliders | – (no token) |
| Home categories | GET | categories | – |
| Home – Best Seller | GET | best_seller_products | – |
| Home – Top Rated | GET | top_rated_products | – |
| Items tab / category page | GET | products | – (category = filter by category_id) |
| Search | GET | products/search?q= | – |
| Product → heart | POST | add_to_favorite | form-data: product_id |
| Checkout | POST | place_order | JSON: {"items": [{"product_id": 1, "quantity": 2}]} |
| My Orders | GET | orders | – |
| My Orders → Cancel | POST | orders/cancel/{id} | – |

Tokens: `login` returns an **access token (15 min)** and a **refresh token (30 days)**.
`AuthInterceptor` adds the access token to every request and refreshes it automatically on 401.

## What the API does not have (handled in the app)
* **Cart** – no cart endpoints → the cart is saved on the device and sent with `place_order`.
* **Favorites list / remove** – only `add_to_favorite` → the list is also saved on the device.
* **Product details / products by category** – no GET endpoint → details come from the list,
  category pages filter `products` by `category_id`.
* Admin endpoints (new/edit/delete product, category, slider, complete order) are not used by
  a customer app.

## Structure (one class per file)
```
lib/
  main.dart
  core/
    network/  api_consumer, api_exception, dio_consumer, dio_factory, auth_interceptor,
              multipart_helper, end_points
    storage/  token_storage, cart_storage, favorite_storage
    utils/    app_colors, app_navigator, app_snack_bar, json_helper, price_formatter, validators
    widgets/  custom_button, custom_text_field, back_app_bar, app_network_image, image_picker_box,
              confirm_dialog, loading_view, error_view, empty_view, stylish_logo
  features/
    splash/ onboarding/ auth/ home/ categories/ products/ search/
    cart/ orders/ favorites/ profile/
```

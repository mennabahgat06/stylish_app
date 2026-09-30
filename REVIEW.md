# Review – Stylish

> Now connected to the real NTI e-commerce API (ecommerce.json). See README.md for the endpoint table.

## What was there
A nice UI, but **no screen was connected to an API**. `end_points.dart` listed paths that were
never called, and every screen showed fixed sample data ("Mens Starry", "₹399", "John Doe").

| Screen | Before | Now |
|---|---|---|
| Splash | Always went to onboarding | Logged in → Home, otherwise → Onboarding |
| Onboarding (3 pages) | OK (lorem ipsum text) | Real text, page data in a model |
| Get Started | OK | Same design |
| Login | Button just opened Home, fields not read | POST login (email, password), saves access + refresh token |
| Register | Button just went back | POST register (+ optional photo), validation, logs in |
| Home | 4 fake cards, fake categories, fixed banner | GET sliders, categories, best_seller_products, top_rated_products |
| Items | 6 fake cards | GET products |
| Search | Text field did nothing, "2 Items" fixed | GET products/search?q= (category: products filtered) |
| Product details | Fixed product, heart not clickable, Add to cart only a message | Real product, POST add_to_favorite, add to cart with quantity |
| Cart | Fixed items and totals | Real cart saved on the device, remove item, totals |
| Checkout | Fixed text | POST place_order with the cart items |
| My Orders | Fixed rows | GET orders split by status, cancel active orders |
| Favorites | 4 fake cards | Products you added with add_to_favorite |
| Profile | "John Doe" fixed, logout only popped | GET get_user_data, edit profile, delete account, logout |

## Other fixes
* Bottom tabs rebuilt every time → now `IndexedStack` (tabs keep their data).
* Password "eye" icon did nothing → now shows / hides the password.
* Category list in Home did nothing → opens the products of that category.
* Home banner now shows the real sliders from the API.
* New: Edit Profile (with photo), Delete Account, Cancel order, photo on Register.
* Access token (15 min) is refreshed automatically with the refresh token.
* Packages added: `shared_preferences`, `image_picker`.

## Refactor
One class per file (a StatefulWidget and its private State stay together).
Repeated code moved to widgets: ProductCard, ProductGrid, RatingStars, QuantitySelector,
FavoriteButton, CategoryItem, CategoriesList, SliderBanner, SlideCard, CartItemTile, CartSummary,
PriceRow, OrderTile, OrdersList, BackAppBar, ConfirmDialog, ImagePickerBox, EmptyView, ErrorView,
LoadingView, StylishLogo …

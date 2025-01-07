import { createBrowserRouter } from "react-router-dom";
import App from "./App";
import ProductListPage from "./pages/ProductListPage/ProductListPage";
import ShopApplicationWrapper from "./pages/ShopApplicationWrapper";
import ProductDetails from "./pages/ProductDetailPage/ProductDetails";
import { loadProductBySlug } from "./routes/products";
import AuthenticationWrapper from "./pages/AuthenticationWrapper";
import Login from "./pages/Login/Login";
import Register from "./pages/Register/Register";
import OAuth2LoginCallback from "./pages/OAuth2LoginCallback";
import Cart from "./pages/Cart/Cart";
import ProtectedRoute from "./components/ProtectedRoute/ProtectedRoute";
import Account from "./pages/Account/Account";
import Checkout from "./pages/Checkout/Checkout";
import PaymentPage from "./pages/PaymentPage/PaymentPage";
import OrderConfirmationPage from "./pages/OrderConfirmation/OrderConfirmationPage";
import PaymentFailedPage from "./pages/PaymentFailed/PaymentFailedPage";
import Profile from "./pages/Account/Profile";
import Orders from "./pages/Account/Orders";
import Settings from "./pages/Account/Settings";
import AdminPanel from "./pages/AdminPanel/AdminPanel";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <ShopApplicationWrapper />,
    children: [
      {
        path: "/",
        element: <App />,
      },
      {
        path: "/women",
        element: <ProductListPage categoryType={"WOMEN"} />,
      },
      {
        path: "/men",
        element: <ProductListPage categoryType={"MEN"} />,
      },
      {
        path: "/kids",
        element: <ProductListPage categoryType={"KIDS"} />,
      },
      {
        path: "/product/:slug",
        loader: loadProductBySlug,
        element: <ProductDetails />,
      },
      {
        path: "/cart-items",
        element: <Cart />,
      },
      {
        path: "/account-details",
        element: (
          <ProtectedRoute>
            <Account />
          </ProtectedRoute>
        ),
        children: [
          {
            path: "profile",
            element: (
              <ProtectedRoute>
                <Profile />
              </ProtectedRoute>
            ),
          },
          {
            path: "orders",
            element: (
              <ProtectedRoute>
                <Orders />
              </ProtectedRoute>
            ),
          },
          {
            path: "settings",
            element: (
              <ProtectedRoute>
                <Settings />
              </ProtectedRoute>
            ),
          },
        ],
      },
      {
        path: "/checkout",
        element: (
          <ProtectedRoute>
            <Checkout />
          </ProtectedRoute>
        ),
      },
    ],
  },
  {
    path: "/v1/",
    element: <AuthenticationWrapper />,
    children: [
      {
        path: "login",
        element: <Login />,
      },
      {
        path: "register",
        element: <Register />,
      },
    ],
  },
  {
    path: "/oauth2/callback",
    element: <OAuth2LoginCallback />,
  },
  {
    path: "/payment",
    element: (
      <ProtectedRoute>
        <PaymentPage />
      </ProtectedRoute>
    ),
  },
  {
    path: "/order-confirmation",
    element: (
      <ProtectedRoute>
        <OrderConfirmationPage />
      </ProtectedRoute>
    ),
  },
  {
    path: "/payment-failed",
    element: (
      <ProtectedRoute>
        <PaymentFailedPage />
      </ProtectedRoute>
    ),
  },
  {
    path: "/admin/*",
    element: (
      <ProtectedRoute>
        <AdminPanel />
      </ProtectedRoute>
    ),
  },
]);

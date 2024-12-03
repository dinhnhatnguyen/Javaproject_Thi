import React from "react";
import { useSelector } from "react-redux";
import { useLocation, useNavigate } from "react-router-dom";
import Spinner from "../../components/Spinner/Spinner";

const OrderConfirmationPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { orderId, paymentMethod } = location.state || {};

  return (
    <>
      <div className="flex flex-col items-center justify-center min-h-screen bg-green-50">
        <div className="p-8 bg-white rounded-lg shadow-lg text-center">
          <h1 className="text-3xl font-bold text-green-600 mb-4">
            Order Confirmed!
          </h1>
          <p className="mb-2">Your order has been successfully placed.</p>
          <p className="mb-4">
            Order ID: <span className="font-bold">{orderId}</span>
          </p>
          <p className="mb-6">Payment Method: {paymentMethod}</p>

          <div className="flex justify-center space-x-4">
            <button
              onClick={() => navigate("/")}
              className="px-6 py-2 bg-black text-white rounded-lg hover:bg-gray-800"
            >
              Continue Shopping
            </button>
            <button
              onClick={() => navigate("/orders")}
              className="px-6 py-2 border border-black rounded-lg hover:bg-gray-100"
            >
              View Orders
            </button>
          </div>
        </div>
      </div>
    </>
  );
};

export default OrderConfirmationPage;

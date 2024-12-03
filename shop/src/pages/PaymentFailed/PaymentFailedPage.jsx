import React from "react";
import { useLocation, useNavigate } from "react-router-dom";

const PaymentFailedPage = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { orderId } = location.state || {};

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-red-50">
      <div className="p-8 bg-white rounded-lg shadow-lg text-center">
        <h1 className="text-3xl font-bold text-red-600 mb-4">Payment Failed</h1>
        <p className="mb-2">We could not process your payment.</p>
        <p className="mb-4">
          Order ID: <span className="font-bold">{orderId}</span>
        </p>

        <div className="flex justify-center space-x-4">
          <button
            onClick={() => navigate("/checkout")}
            className="px-6 py-2 bg-black text-white rounded-lg hover:bg-gray-800"
          >
            Try Again
          </button>
          <button
            onClick={() => navigate("/")}
            className="px-6 py-2 border border-black rounded-lg hover:bg-gray-100"
          >
            Back to Home
          </button>
        </div>
      </div>
    </div>
  );
};

export default PaymentFailedPage;

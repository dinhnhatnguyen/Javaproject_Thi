import React, { useCallback, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { selectCartItems } from "../../store/features/cart";
import { placeOrderAPI, confirmPaymentAPI } from "../../api/order";
import { createOrderRequest } from "../../utils/order-util";
import { setLoading } from "../../store/features/common";
import { useLocation, useNavigate } from "react-router-dom";

const CheckoutForm = () => {
  const dispatch = useDispatch();
  const cartItems = useSelector(selectCartItems);
  const location = useLocation();
  const navigate = useNavigate();

  const { userId, addressId, paymentMethod } = location.state || {};
  const [error, setError] = useState("");

  const handleSubmit = useCallback(
    async (event) => {
      event?.preventDefault();

      // Validate input
      if (!userId || !addressId || !paymentMethod) {
        setError("Missing payment information");
        return;
      }

      dispatch(setLoading(true));
      setError("");

      try {
        // Create order
        const orderRequest = createOrderRequest(
          cartItems,
          userId,
          addressId,
          paymentMethod
        );

        const orderResponse = await placeOrderAPI(orderRequest);

        /**
         * simulating the payment status for different payment methods
         *  If paymentMethod is "COD" (Cash on Delivery), the paymentStatus is always set to "COMPLETED".
         *  For any other payment method
         *  =>  It's return 90%  COMPLETED ang 10% FAILED
         */
        const paymentStatus =
          paymentMethod === "COD"
            ? "COMPLETED"
            : Math.random() > 0.1
            ? "COMPLETED"
            : "FAILED";

        // Update payment status
        const paymentUpdateResponse = await confirmPaymentAPI({
          orderId: orderResponse.orderId,
          status: paymentStatus,
        });

        // Navigate based on payment result
        if (paymentStatus === "COMPLETED") {
          navigate("/order-confirmation", {
            state: {
              orderId: orderResponse.orderId,
              paymentMethod,
            },
          });
        } else {
          navigate("/payment-failed", {
            state: {
              orderId: orderResponse.orderId,
            },
          });
        }
      } catch (err) {
        setError("Payment processing failed");
      } finally {
        dispatch(setLoading(false));
      }
    },
    [cartItems, userId, addressId, paymentMethod, dispatch, navigate]
  );

  return (
    <div className="flex flex-col items-center p-8">
      <form
        onSubmit={handleSubmit}
        className="w-[320px] flex flex-col items-center"
      >
        <div className="w-full p-4 border rounded-lg">
          <h2 className="text-xl font-bold mb-4">Payment Details</h2>

          {paymentMethod === "CARD" && (
            <div className="mb-4">
              <label className="block mb-2">Card Number</label>
              <input
                type="text"
                placeholder="1234 5678 9012 3456"
                className="w-full p-2 border rounded"
                required
              />
            </div>
          )}

          {paymentMethod === "UPI" && (
            <div className="mb-4">
              <label className="block mb-2">UPI ID</label>
              <input
                type="text"
                placeholder="user@upi"
                className="w-full p-2 border rounded"
                required
              />
            </div>
          )}

          {paymentMethod === "COD" && (
            <p className="text-gray-600">
              You will pay the total amount upon delivery.
            </p>
          )}
        </div>

        <button
          type="submit"
          className="w-full mt-4 bg-black text-white py-3 rounded-lg hover:bg-gray-800"
        >
          Complete Order
        </button>

        {error && <p className="text-red-500 mt-4">{error}</p>}
      </form>
    </div>
  );
};

export default CheckoutForm;

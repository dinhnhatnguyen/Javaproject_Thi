import axios from "axios";
import { API_BASE_URL, getHeaders } from "./constant";

export const placeOrderAPI = async (data) => {
  const url = API_BASE_URL + "/api/order";
  try {
    const response = await axios.post(url, data, {
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    console.error("Order placement error:", err);
    throw err;
  }
};

export const confirmPaymentAPI = async (data) => {
  console.log("Payment confirmation data:", data);
  const url = API_BASE_URL + "/api/order/update-payment";
  try {
    const response = await axios.post(
      url,
      {
        paymentIntent: data.orderId,
        status: data.status,
      },
      {
        headers: getHeaders(),
      }
    );
    return response?.data;
  } catch (err) {
    console.error("Payment confirmation error:", err.response?.data);
    throw err;
  }
};

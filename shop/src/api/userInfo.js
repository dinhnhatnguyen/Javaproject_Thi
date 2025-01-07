import axios from "axios";
import { API_BASE_URL, getHeaders } from "./constant";

export const fetchUserDetails = async () => {
  const url = API_BASE_URL + "/api/user/profile";
  try {
    const response = await axios(url, {
      method: "GET",
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    throw new Error(err);
  }
};

export const addAddressAPI = async (data) => {
  const url = API_BASE_URL + "/api/address";
  try {
    const response = await axios(url, {
      method: "POST",
      data: data,
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    throw new Error(err);
  }
};

export const deleteAddressAPI = async (id) => {
  const url = API_BASE_URL + `/api/address/${id}`;
  try {
    const response = await axios(url, {
      method: "DELETE",
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    throw new Error(err);
  }
};

export const fetchOrderAPI = async () => {
  const url = API_BASE_URL + `/api/order/user`;
  try {
    const response = await axios(url, {
      method: "GET",
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    throw new Error(err);
  }
};

export const cancelOrderAPI = async (id) => {
  const url = API_BASE_URL + `/api/order/cancel/${id}`;
  try {
    const response = await axios(url, {
      method: "POST",
      headers: getHeaders(),
    });
    return response?.data;
  } catch (err) {
    throw new Error(err);
  }
};

export const updateProfileAPI = async (userData) => {
  try {
    const response = await axios.put("/api/user/profile", userData);
    if (response.data.code === 200) {
      return response.data;
    } else {
      throw new Error(response.data.message);
    }
  } catch (error) {
    throw error;
  }
};

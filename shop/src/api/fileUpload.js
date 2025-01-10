import axios from "axios";
import { API_BASE_URL, getHeaders } from "./constant";

export const fileUploadAPI = async (data) => {
  const url = API_BASE_URL + `/api/file`;
  try {
    const response = await axios(url, {
      method: "POST",
      headers: {
        ...getHeaders(),
        "Content-Type": "multipart/form-data",
      },
      data: data,
      withCredentials: true,
      maxRedirects: 0,
    });
    return response?.data;
  } catch (err) {
    if (err.response?.status === 302) {
      // Xử lý redirect url nếu cần
      window.location.href = err.response.headers.location;
      return;
    }
    throw new Error(err);
  }
};

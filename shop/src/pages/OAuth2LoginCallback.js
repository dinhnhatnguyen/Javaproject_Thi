import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { saveToken } from "../utils/jwt-helper";

const OAuth2LoginCallback = () => {
  const navigate = useNavigate();

  useEffect(() => {
    const token = new URLSearchParams(window.location.search).get("token");

    if (token) {
      saveToken(token);
      navigate("/");
    }

    if (token) {
      console.log("token:", token);
      saveToken(token);
      navigate("/");
    } else {
      navigate("/v1/login");
    }
  }, [navigate]);
  return <div>Đang xác thực...</div>;
};

export default OAuth2LoginCallback;

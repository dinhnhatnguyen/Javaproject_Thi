import React from "react";
import CheckoutForm from "./CheckoutPayment";
import { useSelector } from "react-redux";
import Spinner from "../../components/Spinner/Spinner";

const PaymentPage = () => {
  const isLoading = useSelector((state) => state?.commonState?.loading);
  return (
    <>
      <div className="container mx-auto px-4">
        <CheckoutForm />
      </div>
      {isLoading && <Spinner />}
    </>
  );
};

export default PaymentPage;

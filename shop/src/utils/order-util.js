export const createOrderRequest = (
  cartItems,
  userId,
  addressId,
  paymentMethod
) => {
  let request = {};
  request.userId = userId;
  request.addressId = addressId;
  request.orderDate = new Date().toISOString();
  let orderItems = [];
  let amount = 0;

  cartItems?.forEach((item) => {
    amount += item?.subTotal;
    orderItems.push({
      productId: item.productId,
      productVariantId: item?.variant?.id,
      discount: 0,
      quantity: item?.quantity,
    });
  });

  request.orderItemRequests = orderItems;
  request.totalAmount = amount?.toFixed(2);
  request.discount = 0;
  request.paymentMethod = paymentMethod;

  // Callculate the delivery date ( 5 days from now)
  const deliveryDate = new Date();
  deliveryDate.setDate(deliveryDate.getDate() + 5);
  request.expectedDeliveryDate = deliveryDate.toISOString();

  request.currency = "usd";
  return request;
};

export const getStepCount = {
  PENDING: 1,
  IN_PROGRESS: 2,
  SHIPPED: 3,
  DELIVERED: 4,
};

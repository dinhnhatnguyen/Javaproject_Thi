import content from "../data/content.json";

export const loadProductById = ({ params }) => {
  const product = content?.products.find(
    (product) => product?.id === Number(params?.productId)
  );

  return { product };
};

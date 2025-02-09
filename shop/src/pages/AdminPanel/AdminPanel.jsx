import React from "react";
import {
  Admin,
  fetchUtils,
  Resource,
  withLifecycleCallbacks,
} from "react-admin";
import simpleRestProvider from "ra-data-simple-rest";
import ProductList from "./ProductList";
import EditProduct from "./EditProduct";
import CreateProduct from "./CreateProduct";
import CategoryList from "./Category/CategoryList";
import CategoryEdit from "./Category/CategoryEdit";
import { fileUploadAPI } from "../../api/fileUpload";
import { Cat } from "lucide-react";
import CategoryTypeInput from "./Category/CategoryTypeInput";

// const CDN_URL = "https://codedev.b-cdn.net";
const CDN_URL =
  "https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products";

// const httpClient = (url, options = {}) => {
//   const token = localStorage.getItem("authToken");
//   if (!options.headers) options.headers = new Headers();
//   options.headers.set("Authorization", `Bearer ${token}`);
//   return fetchUtils.fetchJson(url, options);
// };

const httpClient = (url, options = {}) => {
  const token = localStorage.getItem("authToken");
  if (!options.headers) options.headers = new Headers();
  options.headers.set("Authorization", `Bearer ${token}`);
  options.credentials = "include";
  return fetchUtils.fetchJson(url, options);
};

// const dataProvider = withLifecycleCallbacks(
//   simpleRestProvider("http://localhost:8080/api", httpClient),
//   [
//     {
//       resource: "products",
//       beforeSave: async (params, dataProvider) => {
//         console.log("Params ", params);
//         let requestBody = {
//           ...params,
//         };
//         let productResList = params?.productResources ?? [];
//         const fileName = params?.thumbnail?.rawFile?.name?.replaceAll(" ", "-");
//         const formData = new FormData();
//         formData.append("file", params?.thumbnail?.rawFile);
//         formData.append("fileName", fileName);

//         const thumbnailResponse = await fileUploadAPI(formData);
//         requestBody.thumbnail = CDN_URL + "/" + fileName;

//         const newProductResList = await Promise.all(
//           productResList?.map(async (productResource) => {
//             const fileName = productResource?.url?.rawFile?.name?.replaceAll(
//               " ",
//               "-"
//             );
//             const formData = new FormData();
//             formData.append("file", productResource?.url?.rawFile);
//             formData.append("fileName", fileName);
//             const fileUploadRes = await fileUploadAPI(formData);
//             return {
//               ...productResource,
//               url: CDN_URL + "/" + fileName,
//             };
//           })
//         );
//         //console.log("Params ",params,fileName);
//         const request = {
//           ...requestBody,
//           productResources: newProductResList,
//         };
//         console.log("Request Body ", request);
//         return request;
//       },
//     },
//   ]
// );
const dataProvider = withLifecycleCallbacks(
  simpleRestProvider("http://localhost:8080/api", httpClient),
  [
    {
      resource: "products",
      beforeSave: async (params, dataProvider) => {
        let requestBody = { ...params };
        let productResList = params?.productResources ?? [];

        // Upload các ảnh trong productResources trước
        const newProductResList = await Promise.all(
          productResList?.map(async (productResource) => {
            // kiểm tra có file mới upload không
            if (productResource?.url?.rawFile) {
              const fileName = productResource?.url?.rawFile?.name?.replaceAll(
                " ",
                "-"
              );
              const formData = new FormData();
              formData.append("file", productResource?.url?.rawFile);
              formData.append("fileName", fileName);
              await fileUploadAPI(formData);
              return {
                ...productResource,
                url: CDN_URL + "/" + fileName,
              };
            }
            return productResource;
          })
        );

        // Tự động lấy URL của ảnh đầu tiên trong productResources làm thumbnail
        if (newProductResList.length > 0) {
          const primaryImage =
            newProductResList.find((resource) => resource.isPrimary) ||
            newProductResList[0];
          requestBody.thumbnail = primaryImage.url;
        }

        return {
          ...requestBody,
          productResources: newProductResList,
        };
      },
    },
  ]
);

export const AdminPanel = () => {
  return (
    <Admin dataProvider={dataProvider} basename="/admin">
      <Resource
        name="products"
        list={ProductList}
        edit={EditProduct}
        create={CreateProduct}
      />
      <Resource
        name="category"
        list={CategoryList}
        edit={CategoryEdit}
        create={CategoryTypeInput}
      />
    </Admin>
  );
};

export default AdminPanel;

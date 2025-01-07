import React, { useEffect, useMemo, useState } from "react";
import content from "../../data/content.json";
import FilterIcon from "../../components/common/FilterIcon";
import Categories from "../../components/Filters/Categories";
import PriceFilter from "../../components/Filters/PriceFilter";
import ColorsFilter from "../../components/Filters/ColorsFilter";
import SizeFilter from "../../components/Filters/SizeFilter";
import ProductCard from "./ProductCard";
import { useSelector } from "react-redux";
import { getAllProducts } from "../../api/fetchProducts";
import { useDispatch } from "react-redux";
import { setLoading } from "../../store/features/common";

const categories = content?.categories;

const ProductListPage = ({ categoryType }) => {
  const categoryData = useSelector((state) => state?.categoryState?.categories);
  const dispatch = useDispatch();

  // Products state
  const [products, setProducts] = useState([]);
  const [filteredProducts, setFilteredProducts] = useState([]);

  // Filters state
  const [selectedTypes, setSelectedTypes] = useState([]);
  const [priceRange, setPriceRange] = useState({ min: 10, max: 250 });
  const [selectedColors, setSelectedColors] = useState([]);
  const [selectedSizes, setSelectedSizes] = useState([]);

  const categoryContent = useMemo(() => {
    return categories?.find((category) => category.code === categoryType);
  }, [categoryType]);

  const category = useMemo(() => {
    return categoryData?.find((element) => element?.code === categoryType);
  }, [categoryData, categoryType]);

  // Fetch initial products
  useEffect(() => {
    dispatch(setLoading(true));
    getAllProducts(category?.id)
      .then((res) => {
        setProducts(res);
        setFilteredProducts(res);
      })
      .catch((err) => {
        console.error("Error fetching products:", err);
      })
      .finally(() => {
        dispatch(setLoading(false));
      });
  }, [category?.id, dispatch]);

  console.log(products);
  // Apply filters
  useEffect(() => {
    let filtered = [...products];

    // Filter by type
    if (selectedTypes.length > 0) {
      filtered = filtered.filter((product) =>
        selectedTypes.includes(product.type)
      );
    }

    // Filter by price range
    filtered = filtered.filter(
      (product) =>
        product.price >= priceRange.min && product.price <= priceRange.max
    );

    // Filter by colors
    if (selectedColors.length > 0) {
      filtered = filtered.filter((product) =>
        product.colors?.some((color) => selectedColors.includes(color))
      );
    }

    // Filter by sizes
    if (selectedSizes.length > 0) {
      filtered = filtered.filter((product) =>
        product.sizes?.some((size) => selectedSizes.includes(size))
      );
    }

    setFilteredProducts(filtered);
  }, [products, selectedTypes, priceRange, selectedColors, selectedSizes]);

  // Filter handlers
  const handleTypeChange = (types) => {
    setSelectedTypes(types);
  };

  const handlePriceChange = (range) => {
    setPriceRange(range);
  };

  const handleColorChange = (colors) => {
    setSelectedColors(colors);
  };

  const handleSizeChange = (sizes) => {
    setSelectedSizes(sizes);
  };

  return (
    <div>
      <div className="flex">
        <div className="w-[20%] p-[10px] border rounded-lg m-[20px]">
          {/* Filters */}
          <div className="flex justify-between">
            <p className="text-[16px] text-gray-600">Filter</p>
            <FilterIcon />
          </div>
          <div>
            {/* Product types */}
            <p className="text-[16px] text-black mt-5">Categories</p>
            <Categories
              types={categoryContent?.types}
              onChange={handleTypeChange}
            />
            <hr />
          </div>
          {/* Price */}
          <PriceFilter onChange={handlePriceChange} />
          <hr />
          {/* Colors */}
          <ColorsFilter
            colors={categoryContent?.meta_data?.colors}
            onChange={handleColorChange}
          />
          <hr />
          {/* Sizes */}
          <SizeFilter
            sizes={categoryContent?.meta_data?.sizes}
            onChange={handleSizeChange}
          />
        </div>

        <div className="p-[15px]">
          <p className="text-black text-lg">{category?.description}</p>
          {/* Products */}
          <div className="pt-4 grid grid-cols-1 lg:grid-cols-3 md:grid-cols-2 gap-8 px-2">
            {filteredProducts?.map((item, index) => (
              <ProductCard
                key={item?.id + "_" + index}
                {...item}
                title={item?.name}
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductListPage;

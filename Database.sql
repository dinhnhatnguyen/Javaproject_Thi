--
-- PostgreSQL database dump
--

-- Dumped from database version 15.10
-- Dumped by pg_dump version 15.10 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.address (
    id uuid NOT NULL,
    city character varying(255) NOT NULL,
    name character varying(255),
    phone_number character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    street character varying(255) NOT NULL,
    zip_code character varying(255) NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.address OWNER TO neondb_owner;

--
-- Name: auth_authority; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.auth_authority (
    id uuid NOT NULL,
    role_code character varying(255) NOT NULL,
    role_description character varying(255) NOT NULL
);


ALTER TABLE public.auth_authority OWNER TO neondb_owner;

--
-- Name: auth_user_authority; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.auth_user_authority (
    user_id uuid NOT NULL,
    authorities_id uuid NOT NULL
);


ALTER TABLE public.auth_user_authority OWNER TO neondb_owner;

--
-- Name: auth_user_details; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.auth_user_details (
    id uuid NOT NULL,
    created_on timestamp(6) without time zone,
    email character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255),
    phone_number character varying(255),
    provider character varying(255),
    updated_on timestamp(6) without time zone,
    verification_code character varying(255)
);


ALTER TABLE public.auth_user_details OWNER TO neondb_owner;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO neondb_owner;

--
-- Name: category_type; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.category_type (
    id uuid NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    category_id uuid NOT NULL
);


ALTER TABLE public.category_type OWNER TO neondb_owner;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    item_price double precision,
    product_variant_id uuid,
    quantity integer NOT NULL,
    order_id uuid NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.order_items OWNER TO neondb_owner;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    discount double precision,
    expected_delivery_date timestamp(6) without time zone,
    order_date timestamp(6) without time zone,
    order_status character varying(255) NOT NULL,
    payment_method character varying(255) NOT NULL,
    shipment_tracking_number character varying(255),
    total_amount double precision NOT NULL,
    address_id uuid NOT NULL,
    user_id uuid NOT NULL,
    CONSTRAINT orders_order_status_check CHECK (((order_status)::text = ANY ((ARRAY['PENDING'::character varying, 'SHIPPED'::character varying, 'DELIVERED'::character varying, 'CANCELLED'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO neondb_owner;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment (
    id uuid NOT NULL,
    amount double precision NOT NULL,
    payment_date timestamp(6) without time zone NOT NULL,
    payment_method character varying(255) NOT NULL,
    payment_status character varying(255) NOT NULL,
    order_id uuid NOT NULL,
    CONSTRAINT payment_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['PENDING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.payment OWNER TO neondb_owner;

--
-- Name: product_resources; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_resources (
    id uuid NOT NULL,
    is_primary boolean NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_resources OWNER TO neondb_owner;

--
-- Name: product_variant; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.product_variant (
    id uuid NOT NULL,
    color character varying(255) NOT NULL,
    size character varying(255) NOT NULL,
    stock_quantity integer NOT NULL,
    product_id uuid NOT NULL
);


ALTER TABLE public.product_variant OWNER TO neondb_owner;

--
-- Name: products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    brand character varying(255) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    description character varying(255),
    is_new_arrival boolean NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(38,2) NOT NULL,
    rating real,
    slug character varying(255) NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    category_id uuid NOT NULL,
    category_type_id uuid NOT NULL
);


ALTER TABLE public.products OWNER TO neondb_owner;

--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.address (id, city, name, phone_number, state, street, zip_code, user_id) VALUES ('2f94a77b-af6b-4728-bd21-4acabd187994', 'Hà Nội', 'Nguyễn hihi', '0987654321', 'Hà Nội', '123 Đường Nguyễn Trãi', '100000', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.address (id, city, name, phone_number, state, street, zip_code, user_id) VALUES ('d39f5a5c-a935-492e-b6e4-9d2b0cdbe117', ' Phú Hội', 'Nguyen Dinh Nhat', '0905452678', 'Thành phố Huế', 'Số 123, Đường Lê Lợi', ' 530000', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.address (id, city, name, phone_number, state, street, zip_code, user_id) VALUES ('8119a3e2-874b-44cc-8170-af98f4a985cb', 'Huế', 'Nguyễn Đình Nhật', '0987654321', 'Thừa Thiên Huế', '123 Đường Nguyễn Trãi', '530000', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.address (id, city, name, phone_number, state, street, zip_code, user_id) VALUES ('9b53e202-2aff-4410-bf1f-658519b600b6', 'Huế', 'Nhật', '0905571567', 'Thành phố Huế', 'Xóm 2 thôn Phú Ngạn, Thừa thiên huế', '101010', 'eeeff290-5481-41cc-af12-f70bc2b81e99');


--
-- Data for Name: auth_authority; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.auth_authority (id, role_code, role_description) VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'USER', 'Regular User');
INSERT INTO public.auth_authority (id, role_code, role_description) VALUES ('c56a4180-65aa-42ec-a945-5fd21dec0538', 'ADMIN', 'Administrator');


--
-- Data for Name: auth_user_authority; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.auth_user_authority (user_id, authorities_id) VALUES ('9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6', 'c56a4180-65aa-42ec-a945-5fd21dec0538');
INSERT INTO public.auth_user_authority (user_id, authorities_id) VALUES ('eeeff290-5481-41cc-af12-f70bc2b81e99', 'f47ac10b-58cc-4372-a567-0e02b2c3d479');
INSERT INTO public.auth_user_authority (user_id, authorities_id) VALUES ('1704217b-1a91-4982-91fc-a67faffa24a1', 'f47ac10b-58cc-4372-a567-0e02b2c3d479');


--
-- Data for Name: auth_user_details; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.auth_user_details (id, created_on, email, enabled, first_name, last_name, password, phone_number, provider, updated_on, verification_code) VALUES ('9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6', NULL, 'nhatnguyendinh188203@gmail.com', true, 'Nhat', 'Nguyen', '{bcrypt}$2a$10$kVYSOXCtx/rQxQV4hjip8uMb2cFDOCKbnsoq6enOUfaRE0pN9U7LO', '0362121505', 'manual', NULL, '376518');
INSERT INTO public.auth_user_details (id, created_on, email, enabled, first_name, last_name, password, phone_number, provider, updated_on, verification_code) VALUES ('eeeff290-5481-41cc-af12-f70bc2b81e99', NULL, 'nhatnguyen18823@gmail.com', true, 'Nhật', ' Nguyễn Đình', '{bcrypt}$2a$10$ZNEG2v7r3/QRjRvLs1abqOcmshiQxGFexIGcw9G3BE1i6BewYIz4S', '0905571567', 'manual', NULL, '618860');
INSERT INTO public.auth_user_details (id, created_on, email, enabled, first_name, last_name, password, phone_number, provider, updated_on, verification_code) VALUES ('1704217b-1a91-4982-91fc-a67faffa24a1', NULL, '21t1020557@husc.edu.vn', true, 'hihi', ' Nguyễn Đình', '{bcrypt}$2a$10$0Aj.F3mXZrNPTJSzFcnceeZZG0yzGuQ1nFrvlCmGVsXMBExTp0BaO', '0905571093', 'manual', NULL, '905579');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.categories (id, code, description, name) VALUES ('f7a63a36-bd07-432b-9f2e-458ec110893e', 'MEN', 'Men''s Clothing', 'Men');
INSERT INTO public.categories (id, code, description, name) VALUES ('36474182-6b13-4195-b577-5a1f70aef356', 'WOMEN', 'Women''s Clothing', 'Women');
INSERT INTO public.categories (id, code, description, name) VALUES ('3a5abd1b-5908-40ca-9c8c-619a7079d962', 'KIDS', 'Kids Clothing ', 'Kids');


--
-- Data for Name: category_type; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('61c40a2e-38b6-4f4e-a613-a02a60f2eb6f', 'JEANS', 'Men''s jeans', 'Jeans', 'f7a63a36-bd07-432b-9f2e-458ec110893e');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('a177b833-39a7-4615-a1c3-de4a4b9a3e88', 'SHIRTS', 'Men''s shirts', 'Shirts', 'f7a63a36-bd07-432b-9f2e-458ec110893e');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('e8f836a7-c434-4bdd-be45-736421847a24', 'SHORTS', 'Men''s shorts', 'Shorts', 'f7a63a36-bd07-432b-9f2e-458ec110893e');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('9147ca29-17c5-4498-b686-61cb5d18d1ec', 'TSHIRTS', 'Men''s t-shirts', 'T-shirts', 'f7a63a36-bd07-432b-9f2e-458ec110893e');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('186d703e-c064-469d-a55b-3771b5dbcad6', 'HOODIE', 'Men''s Hoodie', 'Hoodie''s', 'f7a63a36-bd07-432b-9f2e-458ec110893e');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('b3475319-36f7-472c-bcd8-73a580fec695', 'DRESSES', 'Women''s dresses', 'Dresses', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('5a53cad8-7584-4097-8839-15cead4e7445', 'CROPTOP', 'Women''s crop tops', 'Crop Top', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('f2aea52f-053c-4ca2-a0db-7c644b7ab8e9', 'SHORTS', 'Women''s shorts', 'Shorts', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('9fff08b9-b6b6-4152-9b23-7b7f548d2177', 'JEANS', 'Women''s jeans', 'Jeans', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('31e87d1b-ce0d-4d00-9cab-f399f490abba', 'TSHIRTS', 'Women''s t-shirts', 'T-shirt', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('40fc8116-c0db-46b8-9a32-be96fdf9d982', 'SWEATSHIRT', 'Women''s hoodies', 'Hoodie/Sweatshirt', '36474182-6b13-4195-b577-5a1f70aef356');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('d80e2f7e-91ee-4d38-b738-23b5f8b0ed10', 'JEANS', 'Jeans', 'Kids''s jeans', '3a5abd1b-5908-40ca-9c8c-619a7079d962');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('31ea62e6-00ea-4154-a709-1651594d8d19', 'SHORTS', 'Shorts', 'Kids''s shorts', '3a5abd1b-5908-40ca-9c8c-619a7079d962');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('0d527f21-b915-457e-b5cf-7c3e576ef89a', 'TSHIRTS', 'T-shirts', 'Kids''s t-shirts', '3a5abd1b-5908-40ca-9c8c-619a7079d962');
INSERT INTO public.category_type (id, code, description, name, category_id) VALUES ('dc9a84d4-e144-4d1f-913c-7a1260d839cc', 'DRESSES', 'Dresses', 'Kids''s dresses', '3a5abd1b-5908-40ca-9c8c-619a7079d962');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('0e1dc6c4-096d-4b3a-a875-cdce8c9934e9', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 1, 'abf67b90-ac4d-44e6-a596-956de4424eec', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('256f127e-afcb-4af6-9463-513689f39824', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 1, '723122e8-446e-4b09-87b2-f79826687373', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('01d2c7d1-db9d-43c7-b1da-678dddf794c1', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 3, 'aba96811-c35e-438c-8464-1e7f063b033b', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('ecde1caf-81e2-446c-8b1b-5a196ccd7c6d', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 5, 'da658b89-686a-4ea5-a39c-d6480b001023', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('0ed37b91-5e52-4e4f-8125-e6b147a21480', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 5, '0862d65a-ca36-45cc-a2f3-74ca2f8e67cc', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('22365727-517c-45b4-a63b-de598228b3e8', NULL, 'b865c6bb-8767-4c09-9bd0-0a61040dd82f', 5, 'a0dbc79a-378c-40d4-95e9-4c2e0372830c', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('c5d480f7-75cb-4ff1-8789-4f3a9f9d2f5a', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '0eefe11f-2f7a-43d9-a156-3086e13a233f', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('8bb22c8c-9c76-4a0f-92ef-f7a252a9957d', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '0eefe11f-2f7a-43d9-a156-3086e13a233f', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('79b373b4-4e12-4963-9365-034db43ec718', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '0eefe11f-2f7a-43d9-a156-3086e13a233f', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('307b8c0c-7211-4d0c-8c74-221bfc0bd9ea', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '16e15b0b-4f70-44a2-b334-278d47377f7b', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('68aeeca9-3376-492e-b4c2-a1502f2bd767', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '16e15b0b-4f70-44a2-b334-278d47377f7b', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('5fdd4dcb-6c55-488c-9818-13c5f53b693f', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '16e15b0b-4f70-44a2-b334-278d47377f7b', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('86853416-913b-4ba9-838f-a2e7698c7ff6', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '4d37cdf4-35e2-4c33-bf8a-24df95f7355e', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('3f82f7c0-ef20-4ddc-ab13-9485b443a245', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '4d37cdf4-35e2-4c33-bf8a-24df95f7355e', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('4bcfc0ed-333e-42da-8d63-cf5c869ab17d', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '4d37cdf4-35e2-4c33-bf8a-24df95f7355e', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('de5c2239-5a2d-4890-ac5c-9fdc276c9ed6', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '6deee316-52b1-4bcd-80d2-b5b6c62f64fb', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('df488044-2252-4e07-93e0-7d6a7e0c180a', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '6deee316-52b1-4bcd-80d2-b5b6c62f64fb', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('8023868f-bab6-4e00-b593-f4fb772a2677', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, '6deee316-52b1-4bcd-80d2-b5b6c62f64fb', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('6ed7bb76-5b68-4230-a7df-21b2f8d7e243', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, 'a4f4dfd2-6fd7-4497-a3a3-2e9f2eb5394e', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('7e3f7869-82d4-46ef-a43e-8bb6237786a7', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'a4f4dfd2-6fd7-4497-a3a3-2e9f2eb5394e', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('43a3f77a-a04e-4c03-a0c5-fb41f1e3d8c3', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'a4f4dfd2-6fd7-4497-a3a3-2e9f2eb5394e', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('aedd4be8-e14c-4b56-adf9-33a1f89ab580', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, 'f3e65234-61e3-4d56-8282-df209d7607c6', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('d680e17a-c019-4ac8-a58b-07889647fb31', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'f3e65234-61e3-4d56-8282-df209d7607c6', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('9a68baa8-3a9a-43c6-b6bf-5e20bf701cf7', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'f3e65234-61e3-4d56-8282-df209d7607c6', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('f64bd8bc-5f1e-4a6c-989c-fa4e7232256b', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, 'e0e53c99-c97a-4052-b7a6-903a0b71aa96', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('dbed3b1a-683d-45e3-8856-f3fd65d3dedb', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'e0e53c99-c97a-4052-b7a6-903a0b71aa96', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('a6c87737-fd54-4e4a-acf4-3bd1b5611349', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'e0e53c99-c97a-4052-b7a6-903a0b71aa96', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('877eb1fe-7658-4a71-a7e0-c75af11e6fb7', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, 'c271e764-1908-4ef6-84d8-501874c963fd', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('3b7624ad-272d-40ee-be7c-110184ac40f7', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'c271e764-1908-4ef6-84d8-501874c963fd', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('266aad7f-6141-42c5-ba40-1dfb5c90fdb1', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 2, 'c271e764-1908-4ef6-84d8-501874c963fd', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('49d9e728-9e4a-4d8d-aa83-f7a9e557af0a', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '62f9026b-2f79-497d-912b-d70dfa102afc', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('71060b99-c176-4d3b-bf89-a2c3fb931061', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '62f9026b-2f79-497d-912b-d70dfa102afc', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('c4274530-4022-4af0-b112-32f84402cb93', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '62f9026b-2f79-497d-912b-d70dfa102afc', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('830ddede-d641-481e-99bb-0dc0e1868ce7', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '047f48f4-2a03-435c-8573-7ec527d451a7', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('09986993-d0eb-4169-89a9-77bb66b087bb', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '047f48f4-2a03-435c-8573-7ec527d451a7', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('bf9f4f25-8f47-49ae-abbc-262f2c138abc', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '047f48f4-2a03-435c-8573-7ec527d451a7', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('a4d611e6-86c3-4432-8af4-352f10b7c9c4', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '8a5f291e-6c45-4d8a-84bc-c598f0734b21', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('f1df2d9a-62f8-4bdb-8063-ab288628b839', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '8a5f291e-6c45-4d8a-84bc-c598f0734b21', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('33bdb988-782a-42d3-805d-3d4ca59fc0ad', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '8a5f291e-6c45-4d8a-84bc-c598f0734b21', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('40660485-67d9-4cf8-9aca-6d53a2a82c50', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '50f0df95-a7ba-45fe-bec4-502a5b608d84', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('5312d27e-d44d-41f2-8535-c709dff96f10', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '50f0df95-a7ba-45fe-bec4-502a5b608d84', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('b8f3da2c-81be-4c1a-a0ae-cec4eac676c9', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '50f0df95-a7ba-45fe-bec4-502a5b608d84', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('65547556-9277-45c1-8b92-49e821d95e0f', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 1, '374b493f-f2dc-4791-9ef4-a22dd658d5fb', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('a3aa2b88-92a4-409d-9ec8-0bbb3dbcfdb8', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 2, '6c7d8b36-7245-436d-b7c7-8056071aba17', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('8cf9e5ca-1e44-4f8f-98e6-ce896e3b367f', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 2, 'd2e0a3a2-67be-4a69-9e61-2796f2de82c4', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('02566fc6-3ed3-4a6f-97ca-b7510d41cdf9', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 2, 'ddc18aab-5227-4236-be02-68fa13b30fd2', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('5e556a41-ca40-44a5-87ca-b8933766473e', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 1, '8552b8ef-db73-44a5-8daf-fd2e2e2758d2', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('299c6905-9175-4ecd-b896-82d853373db2', NULL, 'a9d4b6e8-15a6-4a0c-a0bb-4c5af1d5aec4', 1, '8552b8ef-db73-44a5-8daf-fd2e2e2758d2', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('bf4606c5-72ee-48e4-8f57-11200082d35e', NULL, '0a8cded1-49a6-4b15-9d1c-77c0993a1b83', 1, '8552b8ef-db73-44a5-8daf-fd2e2e2758d2', '51b2bcc3-6d19-4234-9563-a4586b13d5e0');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('c3acbb5b-55d6-4b42-aa94-685ce76f6986', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 1, '2ce2ef40-09b0-4593-ad92-4513e630206e', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('90dc04c5-521d-4fb4-9d8b-2bc1f71b2405', NULL, 'a9d4b6e8-15a6-4a0c-a0bb-4c5af1d5aec4', 1, '2ce2ef40-09b0-4593-ad92-4513e630206e', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('f3de5d40-64d6-403d-b6ed-62ef2463ffc4', NULL, '0a8cded1-49a6-4b15-9d1c-77c0993a1b83', 1, '2ce2ef40-09b0-4593-ad92-4513e630206e', '51b2bcc3-6d19-4234-9563-a4586b13d5e0');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('cd5f7181-1b41-43d5-8be1-a2339d0c0654', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 1, '6fff7184-f8b5-4f00-91f7-84a9bc7f25cd', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('aac3cf1e-08b0-4665-94dd-aaf277ab34a0', NULL, 'a9d4b6e8-15a6-4a0c-a0bb-4c5af1d5aec4', 1, '6fff7184-f8b5-4f00-91f7-84a9bc7f25cd', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('0a3f88b6-0419-4ad2-8cb8-0a76381c1654', NULL, 'ae4dba0e-f8ca-4993-b3cf-f7410f4a5edc', 2, '6fff7184-f8b5-4f00-91f7-84a9bc7f25cd', 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('0c8c40ca-3ac3-40c8-81ba-af7b00a7c474', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 2, '250418a8-b943-40a0-9ea8-f6e6ff3ec013', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('1bb6f274-d784-4b87-a9ea-46dc9ccc473f', NULL, 'ae4dba0e-f8ca-4993-b3cf-f7410f4a5edc', 2, '250418a8-b943-40a0-9ea8-f6e6ff3ec013', 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('853c5839-850a-4833-9da5-99d5676ac720', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 2, '1f4051d4-1c81-429c-a29f-440374f292b3', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('22b6a0a6-dba3-438d-bed1-58e3e07c7f1c', NULL, 'ae4dba0e-f8ca-4993-b3cf-f7410f4a5edc', 2, '1f4051d4-1c81-429c-a29f-440374f292b3', 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('87e94f3c-1a00-44ea-b493-5089e152e6b1', NULL, 'a2377a44-e40e-488d-a731-b150bed1ab51', 1, 'e9e2287a-a9b2-4fc4-a443-28ab3fc4dd34', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('3674629c-d60d-4997-ad84-40743890d532', NULL, 'ae4dba0e-f8ca-4993-b3cf-f7410f4a5edc', 2, 'e9e2287a-a9b2-4fc4-a443-28ab3fc4dd34', 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('859b7789-abf1-46fa-8d6c-5f45af3e4fdd', NULL, '40a9d498-aa0f-4e28-8ce3-a0be34738ff1', 1, '0a6bf4c6-3050-4a48-aa34-3bfba48b3345', '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('5a4dfe1b-6dce-4854-b59b-85eefe39f02a', NULL, '8e616a68-0e98-46e9-a02f-c166f5d87566', 1, '0a6bf4c6-3050-4a48-aa34-3bfba48b3345', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('4cc686bd-b4bd-4d12-88ac-e4cbd01ffff3', NULL, 'bd4824b5-2936-4923-b48b-6acab98ffc55', 1, '0a6bf4c6-3050-4a48-aa34-3bfba48b3345', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('932a6ac4-91a1-40db-951a-da9652117536', NULL, 'a9d4b6e8-15a6-4a0c-a0bb-4c5af1d5aec4', 1, '9ca8fd9d-e692-4def-8496-b4e521961188', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('e42df0da-bd7e-4e1c-8535-151e328f7ffd', NULL, '7f3572b1-db5b-422b-8c19-bfbf5a163865', 1, 'df1ba91c-03af-4413-99f1-007827e9fbd9', 'cdeca450-1e11-43c7-9470-77038d297a2b');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('00ba533c-c20a-4fd3-9458-775d5840a1e6', NULL, '9e8923d9-800a-4618-a626-405b8e2a0132', 2, 'ee46035d-08b4-4305-99f3-887503360dd5', 'fea42892-a816-4888-acba-776218cb25b0');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('04c17fbb-515f-463f-927c-dbe938badc57', NULL, '9e8923d9-800a-4618-a626-405b8e2a0132', 5, '9f83bd90-3aa7-46f3-9cd1-2cebf5b9c5df', 'fea42892-a816-4888-acba-776218cb25b0');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('dcf68cdc-6c6b-467d-8cac-008167e90911', NULL, '2ec0b716-9bcd-4c44-9990-ae64d4fd110e', 1, '2486b613-a74b-4d60-8d92-3e9aade0de4f', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.order_items (id, item_price, product_variant_id, quantity, order_id, product_id) VALUES ('719291ef-26ad-4f6d-baae-46769a9d5dd7', NULL, '7f3572b1-db5b-422b-8c19-bfbf5a163865', 1, '76ce5423-d011-4054-9661-16127dc621f1', 'cdeca450-1e11-43c7-9470-77038d297a2b');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('a0dbc79a-378c-40d4-95e9-4c2e0372830c', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'PENDING', 'NOT THING', NULL, 6, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('6deee316-52b1-4bcd-80d2-b5b6c62f64fb', 0, '2024-12-04 16:09:28.897', '2024-11-29 16:09:28.897', 'PENDING', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('a4f4dfd2-6fd7-4497-a3a3-2e9f2eb5394e', 0, '2024-12-04 16:09:54.981', '2024-11-29 16:09:54.981', 'PENDING', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('e0e53c99-c97a-4052-b7a6-903a0b71aa96', 0, '2024-12-04 16:11:50.36', '2024-11-29 16:11:50.36', 'PENDING', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('62f9026b-2f79-497d-912b-d70dfa102afc', 0, '2024-12-05 19:30:55.9', '2024-11-30 19:30:55.9', 'PENDING', 'COD', NULL, 184.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('047f48f4-2a03-435c-8573-7ec527d451a7', 0, '2024-12-05 19:35:52.09', '2024-11-30 19:35:52.089', 'PENDING', 'COD', NULL, 184.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('50f0df95-a7ba-45fe-bec4-502a5b608d84', 0, '2024-12-05 19:36:14.22', '2024-11-30 19:36:14.22', 'PENDING', 'COD', NULL, 184.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('374b493f-f2dc-4791-9ef4-a22dd658d5fb', 0, '2024-12-05 19:43:13.884', '2024-11-30 19:43:13.884', 'PENDING', 'CARD', NULL, 49.99, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('6c7d8b36-7245-436d-b7c7-8056071aba17', 0, '2024-12-05 19:46:42.058', '2024-11-30 19:46:42.057', 'CANCELLED', 'UPI', NULL, 99.98, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('d2e0a3a2-67be-4a69-9e61-2796f2de82c4', 0, '2024-12-05 19:47:17.889', '2024-11-30 19:47:17.889', 'PENDING', 'COD', NULL, 99.98, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('ddc18aab-5227-4236-be02-68fa13b30fd2', 0, '2024-12-05 19:47:21.304', '2024-11-30 19:47:21.304', 'PENDING', 'COD', NULL, 99.98, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('8552b8ef-db73-44a5-8daf-fd2e2e2758d2', 0, '2024-12-06 08:53:28.897', '2024-12-01 08:53:28.897', 'PENDING', 'UPI', NULL, 169.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('2ce2ef40-09b0-4593-ad92-4513e630206e', 0, '2024-12-06 08:53:29.746', '2024-12-01 08:53:29.746', 'PENDING', 'UPI', NULL, 169.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('6fff7184-f8b5-4f00-91f7-84a9bc7f25cd', 0, '2024-12-06 08:57:57.235', '2024-12-01 08:57:57.234', 'PENDING', 'CARD', NULL, 189.96, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('250418a8-b943-40a0-9ea8-f6e6ff3ec013', 0, '2024-12-08 09:50:53.178', '2024-12-03 09:50:53.178', 'PENDING', 'COD', NULL, 179.96, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('1f4051d4-1c81-429c-a29f-440374f292b3', 0, '2024-12-08 15:04:46.43', '2024-12-03 15:04:46.43', 'PENDING', 'COD', NULL, 179.96, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('0eefe11f-2f7a-43d9-a156-3086e13a233f', 0, '2024-10-06 04:11:46.202', '2024-11-29 15:55:04.222', 'SHIPPED', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('16e15b0b-4f70-44a2-b334-278d47377f7b', 0, '2024-10-06 04:11:46.202', '2024-11-29 15:55:49.12', 'SHIPPED', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('c271e764-1908-4ef6-84d8-501874c963fd', 0, '2024-12-05 17:36:48.653', '2024-11-30 17:36:48.653', 'DELIVERED', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('f3e65234-61e3-4d56-8282-df209d7607c6', 0, '2024-12-04 16:11:14.514', '2024-11-29 16:11:14.514', 'DELIVERED', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('4d37cdf4-35e2-4c33-bf8a-24df95f7355e', 0, '2024-12-04 16:09:26.78', '2024-11-29 16:09:26.78', 'SHIPPED', 'COD', NULL, 324.95, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('8a5f291e-6c45-4d8a-84bc-c598f0734b21', 0, '2024-12-05 19:35:53.822', '2024-11-30 19:35:53.821', 'DELIVERED', 'COD', NULL, 184.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('e9e2287a-a9b2-4fc4-a443-28ab3fc4dd34', 0, '2024-12-09 07:13:58.078', '2024-12-04 07:13:58.078', 'PENDING', 'CARD', NULL, 129.97, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('abf67b90-ac4d-44e6-a596-956de4424eec', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'CANCELLED', 'string', NULL, 1, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('723122e8-446e-4b09-87b2-f79826687373', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'CANCELLED', 'string', NULL, 1, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('aba96811-c35e-438c-8464-1e7f063b033b', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'CANCELLED', 'string', NULL, 3, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('da658b89-686a-4ea5-a39c-d6480b001023', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'CANCELLED', 'string', NULL, 3, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('0862d65a-ca36-45cc-a2f3-74ca2f8e67cc', 0, '2024-11-27 18:25:39.38', '2024-11-27 18:25:39.38', 'CANCELLED', 'string', NULL, 6, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('0a6bf4c6-3050-4a48-aa34-3bfba48b3345', 0, '2025-01-11 13:09:00.96', '2025-01-06 13:09:00.96', 'PENDING', 'COD', NULL, 164.97, 'd39f5a5c-a935-492e-b6e4-9d2b0cdbe117', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('9ca8fd9d-e692-4def-8496-b4e521961188', 0, '2025-01-13 10:08:24.202', '2025-01-08 10:08:24.202', 'PENDING', 'COD', NULL, 59.99, 'd39f5a5c-a935-492e-b6e4-9d2b0cdbe117', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('df1ba91c-03af-4413-99f1-007827e9fbd9', 0, '2025-01-14 15:26:33.489', '2025-01-09 15:26:33.489', 'CANCELLED', 'CARD', NULL, 15, 'd39f5a5c-a935-492e-b6e4-9d2b0cdbe117', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('ee46035d-08b4-4305-99f3-887503360dd5', 0, '2025-01-14 18:03:57.199', '2025-01-09 18:03:57.199', 'PENDING', 'COD', NULL, 20, 'd39f5a5c-a935-492e-b6e4-9d2b0cdbe117', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('9f83bd90-3aa7-46f3-9cd1-2cebf5b9c5df', 0, '2025-01-14 18:39:18.894', '2025-01-09 18:39:18.893', 'PENDING', 'COD', NULL, 50, 'd39f5a5c-a935-492e-b6e4-9d2b0cdbe117', '1704217b-1a91-4982-91fc-a67faffa24a1');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('2486b613-a74b-4d60-8d92-3e9aade0de4f', 0, '2025-01-14 18:49:27.151', '2025-01-09 18:49:27.151', 'PENDING', 'COD', NULL, 24.99, '9b53e202-2aff-4410-bf1f-658519b600b6', 'eeeff290-5481-41cc-af12-f70bc2b81e99');
INSERT INTO public.orders (id, discount, expected_delivery_date, order_date, order_status, payment_method, shipment_tracking_number, total_amount, address_id, user_id) VALUES ('76ce5423-d011-4054-9661-16127dc621f1', 0, '2025-01-15 09:29:53.414', '2025-01-10 09:29:53.414', 'PENDING', 'COD', NULL, 15, '2f94a77b-af6b-4728-bd21-4acabd187994', '9bc48e5d-0886-4d25-bb4d-2edd3a38f9d6');


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('d30a4390-64b4-4a18-a6fb-f683f29c653b', 1, '2024-11-27 18:35:27.809', 'string', 'PENDING', 'abf67b90-ac4d-44e6-a596-956de4424eec');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('b865ae9d-7289-47b4-bb82-9424fe23f8d5', 1, '2024-11-27 18:35:50.649', 'string', 'PENDING', '723122e8-446e-4b09-87b2-f79826687373');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('653bb5f8-4193-483a-9309-aa5a603728c1', 3, '2024-11-27 18:36:56.744', 'string', 'PENDING', 'aba96811-c35e-438c-8464-1e7f063b033b');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('3fb9fe64-5ece-42bd-b50e-114dd5348fd9', 3, '2024-11-28 08:22:58.417', 'string', 'PENDING', 'da658b89-686a-4ea5-a39c-d6480b001023');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('d34dd160-3f79-483d-8358-ddfcced591d6', 6, '2024-11-28 08:50:01.184', 'string', 'PENDING', '0862d65a-ca36-45cc-a2f3-74ca2f8e67cc');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('9315fb99-9dd1-4baa-9405-ce7eebc928cb', 6, '2024-11-28 08:53:59.521', 'NOT THING', 'PENDING', 'a0dbc79a-378c-40d4-95e9-4c2e0372830c');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('0befc97c-c087-4bfc-9738-e3095eefda65', 324.95, '2024-11-29 15:55:06.435', 'COD', 'PENDING', '0eefe11f-2f7a-43d9-a156-3086e13a233f');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('952ba2fb-015b-4428-ba5b-e32e17c233ad', 324.95, '2024-11-29 15:55:51.031', 'COD', 'PENDING', '16e15b0b-4f70-44a2-b334-278d47377f7b');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('0b0dfbf7-6abf-4330-b883-9c415d42cee1', 324.95, '2024-11-29 16:09:28.711', 'COD', 'PENDING', '4d37cdf4-35e2-4c33-bf8a-24df95f7355e');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('bf7e2784-085e-49e0-ba39-4269eb1587fe', 324.95, '2024-11-29 16:09:30.759', 'COD', 'PENDING', '6deee316-52b1-4bcd-80d2-b5b6c62f64fb');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('646a6f06-63ad-4e9c-b8f5-a453da1c89d8', 324.95, '2024-11-29 16:09:56.882', 'COD', 'PENDING', 'a4f4dfd2-6fd7-4497-a3a3-2e9f2eb5394e');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('cec5d363-ced1-4154-a9a3-a8c728c387d9', 324.95, '2024-11-29 16:11:16.486', 'COD', 'PENDING', 'f3e65234-61e3-4d56-8282-df209d7607c6');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('63a86b16-9302-41a1-a0e0-cf5b4aba6bab', 324.95, '2024-11-29 16:11:52.262', 'COD', 'PENDING', 'e0e53c99-c97a-4052-b7a6-903a0b71aa96');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('e955a6be-60be-4cf5-b703-e4b68fd4f15b', 324.95, '2024-11-30 17:36:50.556', 'COD', 'PENDING', 'c271e764-1908-4ef6-84d8-501874c963fd');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('e4f46bac-bb6a-46f3-9f03-8d43bffe23dc', 184.97, '2024-11-30 19:30:57.99', 'COD', 'PENDING', '62f9026b-2f79-497d-912b-d70dfa102afc');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('e3691e07-b7fe-485f-ba38-8c04ec471aba', 184.97, '2024-11-30 19:35:54.1', 'COD', 'COMPLETED', '047f48f4-2a03-435c-8573-7ec527d451a7');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('fd58432a-b5ee-402f-9ce2-8bedaf6d7d3d', 184.97, '2024-11-30 19:35:55.696', 'COD', 'COMPLETED', '8a5f291e-6c45-4d8a-84bc-c598f0734b21');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('8e2c4bf5-3af6-41a2-9b2e-e8f9e3d0f1ba', 184.97, '2024-11-30 19:36:16.118', 'COD', 'COMPLETED', '50f0df95-a7ba-45fe-bec4-502a5b608d84');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('6ca6aff0-ed21-4942-a159-a0c9ffe8737b', 49.99, '2024-11-30 19:43:15.593', 'CARD', 'COMPLETED', '374b493f-f2dc-4791-9ef4-a22dd658d5fb');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('df9e81ef-ad0b-4d2b-be75-bcf434a789be', 99.98, '2024-11-30 19:46:43.797', 'UPI', 'FAILED', '6c7d8b36-7245-436d-b7c7-8056071aba17');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('643a7bbd-d697-4989-9c56-0f424b29a25e', 99.98, '2024-11-30 19:47:19.595', 'COD', 'COMPLETED', 'd2e0a3a2-67be-4a69-9e61-2796f2de82c4');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('9eace2b4-87ea-4a6a-888d-619bc7a34e9e', 99.98, '2024-11-30 19:47:22.943', 'COD', 'COMPLETED', 'ddc18aab-5227-4236-be02-68fa13b30fd2');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('4bf9bff9-9186-4f54-a6d3-6b423129984c', 169.97, '2024-12-01 08:53:31.157', 'UPI', 'COMPLETED', '8552b8ef-db73-44a5-8daf-fd2e2e2758d2');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('76651d5f-9d6a-4677-ad01-cb6acb83a8b4', 169.97, '2024-12-01 08:53:31.977', 'UPI', 'COMPLETED', '2ce2ef40-09b0-4593-ad92-4513e630206e');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('d0d719c0-a19b-43c3-9402-89c2536e7502', 189.96, '2024-12-01 08:57:59.41', 'CARD', 'COMPLETED', '6fff7184-f8b5-4f00-91f7-84a9bc7f25cd');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('50a640ab-021d-4088-8498-98c406612ca0', 179.96, '2024-12-03 09:50:54.649', 'COD', 'COMPLETED', '250418a8-b943-40a0-9ea8-f6e6ff3ec013');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('2af0c0cf-478b-445b-8712-578adf6d53a4', 179.96, '2024-12-03 15:04:48.335', 'COD', 'COMPLETED', '1f4051d4-1c81-429c-a29f-440374f292b3');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('2570d18d-72b2-4ed6-bfd9-43ee08ff5de7', 129.97, '2024-12-04 07:14:00.699', 'CARD', 'COMPLETED', 'e9e2287a-a9b2-4fc4-a443-28ab3fc4dd34');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('8d3947c4-45a9-4528-aa22-c7ba8bd60e65', 164.97, '2025-01-06 13:09:03.223', 'COD', 'COMPLETED', '0a6bf4c6-3050-4a48-aa34-3bfba48b3345');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('62105cb4-59ef-41cb-ac20-b3317f625eeb', 59.99, '2025-01-08 10:08:26.074', 'COD', 'COMPLETED', '9ca8fd9d-e692-4def-8496-b4e521961188');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('e3c92741-981d-44c8-8a89-664cdf53f112', 15, '2025-01-09 15:26:34.585', 'CARD', 'COMPLETED', 'df1ba91c-03af-4413-99f1-007827e9fbd9');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('0638b9d6-5fcc-4bb8-89b6-ce8a75cf981f', 20, '2025-01-09 18:03:58.382', 'COD', 'COMPLETED', 'ee46035d-08b4-4305-99f3-887503360dd5');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('74142430-1838-4371-8665-0029ac9018f3', 50, '2025-01-09 18:39:20.06', 'COD', 'COMPLETED', '9f83bd90-3aa7-46f3-9cd1-2cebf5b9c5df');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('2c417261-4219-48ec-b4d8-8af1da135ad3', 24.99, '2025-01-09 18:49:28.221', 'COD', 'COMPLETED', '2486b613-a74b-4d60-8d92-3e9aade0de4f');
INSERT INTO public.payment (id, amount, payment_date, payment_method, payment_status, order_id) VALUES ('16711240-d992-4f5c-9529-d2dc0e555b5e', 15, '2025-01-10 09:29:54.755', 'COD', 'COMPLETED', '76ce5423-d011-4054-9661-16127dc621f1');


--
-- Data for Name: product_resources; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('994c25bb-7c55-47a5-97ea-e15519305456', false, 'hodie', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/7eb5f77364b67ed209f4ed971839c27a.jpg', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('0c0c2339-9c8c-4607-9774-5dbfa6384895', true, 'thumbnail-white-hoodie.jpg', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/2654c6e0ef35773cdcfccc8364a521df.jpg', '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('de7adf72-ad51-4749-92e9-a8daafdd456b', true, 'thumbnail-blue-jeans.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/bluejean.jpg', '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('48b189ed-b89e-4481-b7fd-26af120c8a44', true, 'thumnails', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/b8721a4622b28524e3753e78880714aa.jpg', 'fea42892-a816-4888-acba-776218cb25b0');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('4da76a39-bbc0-49a6-8704-5569b8133a53', true, 'thumnails', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/drfk.jpg', 'cdeca450-1e11-43c7-9470-77038d297a2b');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('d1bbb887-60d5-4c48-89bd-03dd23c7aa19', true, 'black-tshirt.jpeg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/black-t-shirt-tapered.jpeg', '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('339966f3-8141-473d-9a9e-a2dd29c82d05', true, 'thumbnail-purple-hoodie.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/girl-math-hoodie-women-lavender-HOODIE-GIRLMATH-LAV-1.jpeg', 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('cbedb3ea-5feb-4c94-b1e3-d9e9b43ed054', true, 'thumbnail-gray-shorts.jpg', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/0881c29dd0a4c32d31f7d0a580c57d1a.jpg', '9f6cce1d-b48e-4614-9e8b-0f2019c08c4b');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('72ac4f40-41c9-4803-8ff6-4808260a28a9', true, 'thumbnail-leaves-pattern-white-dress.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/AD3750Black3_800x.jpeg', '2141ed0e-e4c3-44f5-8e75-d13a42e0072b');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('a2e79c84-eff7-4c05-9cd9-471a414fae46', true, 'thumbnail-white-graphic-crop-top.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/White-CropTeeFront_9ff47ceb-b4f2-442b-af15-842c24b678fd.jpeg', 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('97bfb487-6e8a-4426-9702-c7b8caf6f06a', true, 'thumbnail-women''s-skinny-jeans.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/1104_2352HZN_MARGUERITE_GROVE.jpeg', '67fcf16a-045b-4435-b4a7-9512e2c51020');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('59a363a8-2a67-4db9-b729-9f4d363cfe48', true, 'thumbnail-crewneck-sweatshirt.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/61l4FqJ1mbL._AC_UY1000_.jpg', 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('54511a93-a71e-402c-8df0-dab73e301900', true, 'thumbnail-denim-shorts.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/denimsort.jpg', '7aab8d37-f912-49a1-88bb-e1ab73b426f5');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('eb4a1a69-f9f8-4528-b01c-321d17dc0899', true, 'thumbnail-black-plain-t-shirt.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blackplain.jpeg', 'bf9622dd-52cf-4dfd-9792-7755695bdd02');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('7370d8f2-5a9a-4c14-af9a-46dc030f58f8', true, 'thumbnail-black-crop-top.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blackcroptop.jpg', '15e308ea-65ab-474e-8e0f-88a2d2008b57');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('1599514b-8719-4065-a2c8-e048984a4cce', true, 'thumbnail-black-hoodie.jpg', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blackhodiemen.jpg', '51b2bcc3-6d19-4234-9563-a4586b13d5e0');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('f009b353-27a5-43e0-be05-39c9dff37feb', false, 'details', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blsw.jpg', '1e796e15-dac1-47fe-ac29-a336788699ad');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('72489581-48be-4ba8-adbf-d1efce821853', true, 'thumbnail-black-shorts.jpg', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blackshortw.jpg', '1e796e15-dac1-47fe-ac29-a336788699ad');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('8d65a43f-c903-4ce4-9ce2-3fb39b22f5fa', true, 'tshirt-white.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/wtsw.jpg', '47f11dbb-9f09-4ea6-b939-cec1bea4d145');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('8b6ef929-be87-4456-806e-97f820688015', true, 'thumnails', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blkts.jpg', 'cace8956-863e-49cd-8127-2be184a4880b');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('79f5e5e7-21cc-4e09-9e6e-b857d2fce791', false, 'woman-black-shirt.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/Unisex-Plain-Black-sweatshirt-Muselot.jpeg', '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('559168dc-05a7-4e0d-a4ed-6f6ea7747736', true, 'sweatshirt-black.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/blackSwearShirt.jpg', '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('7beecf61-0cd4-4794-bf38-e4d4a34905e1', false, 'thumbnail-blue-flower-print-crop-top.jpg', 'IMAGE', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/bluecroptop.jpg', 'e9091019-6ddc-4a90-8a96-532868f611b5');
INSERT INTO public.product_resources (id, is_primary, name, type, url, product_id) VALUES ('38f45ba6-6013-4d49-bcaa-1df04a16645d', true, 'resource-blue-flower-print-crop-top.jpg', 'image', 'https://titokclonephp.s3.ap-southeast-2.amazonaws.com/products/flpct.jpg', 'e9091019-6ddc-4a90-8a96-532868f611b5');


--
-- Data for Name: product_variant; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('89aec615-06da-4998-b8aa-3ded0f03fead', 'Black', 'S', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('40a9d498-aa0f-4e28-8ce3-a0be34738ff1', 'Black', 'M', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('16c19056-1249-4efc-a495-7cc935276b63', 'Black', 'L', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('608192f9-0a35-44d6-8baa-0aa55c90361e', 'Blue', 'S', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('3f8c62aa-4575-4655-bc35-23669228f778', 'Blue', 'M', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('b682ad94-3ac0-45cb-bd25-68e7b085499d', 'Blue', 'L', 100, '425d440e-5333-4c21-8732-34b96b57f2a5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('9ebeb6cf-4d37-4f11-a21e-b1b20b00b0c8', 'White', 'S', 100, '47f11dbb-9f09-4ea6-b939-cec1bea4d145');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('4bd32682-93c6-45e0-89e1-04328360b07d', 'White', 'M', 100, '47f11dbb-9f09-4ea6-b939-cec1bea4d145');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('42d46347-1baf-4c7b-b96c-22c0923360d1', 'White', 'L', 100, '47f11dbb-9f09-4ea6-b939-cec1bea4d145');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('2ec0b716-9bcd-4c44-9990-ae64d4fd110e', 'Black', 'M', 100, '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('b865c6bb-8767-4c09-9bd0-0a61040dd82f', 'Black', 'L', 100, '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('e52ea7f7-4b67-48a4-92bc-063b9faa2708', 'Black', 'XL', 100, '056309d0-91a9-420d-a255-305038db5783');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('bd4824b5-2936-4923-b48b-6acab98ffc55', 'Purple', 'S', 100, 'a3906cc3-6ed5-4b32-ac48-394f26b6a3a8');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('18332c7e-2129-4ce8-bfb2-2a714d9e03c4', 'White', 'S', 100, '2141ed0e-e4c3-44f5-8e75-d13a42e0072b');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('ae4dba0e-f8ca-4993-b3cf-f7410f4a5edc', 'White', 'S', 100, 'b542a68a-fcc1-45a2-ab65-410e191ff89b');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('89f7c0a8-15f8-4051-8417-f6a2bdc81772', 'Black', 'S', 100, '1e796e15-dac1-47fe-ac29-a336788699ad');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('758b43fa-a9bf-4541-a3fb-a16e598f3fd2', 'Blue', 'S', 100, '67fcf16a-045b-4435-b4a7-9512e2c51020');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('8e616a68-0e98-46e9-a02f-c166f5d87566', 'Gray', 'S', 100, 'ba214db9-9448-48a2-af37-d23c3c9bee64');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('e1e98819-b49e-4e4e-845b-3965c63ef75f', 'Blue', 'S', 100, '7aab8d37-f912-49a1-88bb-e1ab73b426f5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('a053a30f-8a37-4d16-a607-24dc4be79158', 'Black', 'S', 100, 'bf9622dd-52cf-4dfd-9792-7755695bdd02');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('ef11f05b-6ac9-45dd-b785-956f58167758', 'Blue', 'S', 100, 'e9091019-6ddc-4a90-8a96-532868f611b5');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('ec77b923-2580-433a-a019-12be054caba5', 'Black', 'S', 100, '15e308ea-65ab-474e-8e0f-88a2d2008b57');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('a9d4b6e8-15a6-4a0c-a0bb-4c5af1d5aec4', 'White', 'M', 100, '1becc6ec-f3f0-4435-8788-14ea376e746f');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('a2377a44-e40e-488d-a731-b150bed1ab51', 'Blue', 'M', 100, '9a968999-3062-41f8-b6d6-4204b8a7e09d');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('f522cdaa-929b-44e9-abfd-b0bd0211a566', 'Gray', 'M', 100, '9f6cce1d-b48e-4614-9e8b-0f2019c08c4b');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('0a8cded1-49a6-4b15-9d1c-77c0993a1b83', 'Black', 'M', 100, '51b2bcc3-6d19-4234-9563-a4586b13d5e0');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('e0cd0385-3add-4b77-8d32-c41c6ed9cf1a', 'Gray', 'M', 90, '2141ed0e-e4c3-44f5-8e75-d13a42e0072b');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('9f858edc-2861-4776-a995-fe810c84256c', 'Blue', 'S', 0, 'fea42892-a816-4888-acba-776218cb25b0');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('9e8923d9-800a-4618-a626-405b8e2a0132', 'Blue', 'M', 10, 'fea42892-a816-4888-acba-776218cb25b0');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('7f3572b1-db5b-422b-8c19-bfbf5a163865', 'Orange', 'M', 10, 'cdeca450-1e11-43c7-9470-77038d297a2b');
INSERT INTO public.product_variant (id, color, size, stock_quantity, product_id) VALUES ('8a85bf50-6437-44ea-9d0a-2adb34a8ac75', 'Black', 'M', 9, 'cace8956-863e-49cd-8127-2be184a4880b');


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('a3906cc3-6ed5-4b32-ac48-394f26b6a3a8', 'Nike', '2024-11-27 12:41:13.241898', 'A cozy purple hoodie for women', true, 'Purple Hoodie', 69.99, 4.6, 'purple-hoodie', '2025-01-07 11:04:52.153', '36474182-6b13-4195-b577-5a1f70aef356', '40fc8116-c0db-46b8-9a32-be96fdf9d982');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('b542a68a-fcc1-45a2-ab65-410e191ff89b', 'TrendyWear', '2024-11-27 12:41:13.241898', 'A trendy white graphic crop top for women', true, 'White Graphic Crop Top', 39.99, 4.3, 'white-graphic-crop-top', '2025-01-07 11:11:39.989', '36474182-6b13-4195-b577-5a1f70aef356', '5a53cad8-7584-4097-8839-15cead4e7445');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('cace8956-863e-49cd-8127-2be184a4880b', 'nhat nguyen shop', '2025-01-09 15:32:56.745', 'Black t-shirt outfit for kids', true, 'Black t-shirt outfit', 20.00, 4.5, 'kids-tshirt-oufit', '2025-01-09 15:33:55.696', '3a5abd1b-5908-40ca-9c8c-619a7079d962', '0d527f21-b915-457e-b5cf-7c3e576ef89a');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('67fcf16a-045b-4435-b4a7-9512e2c51020', 'ChicStyle', '2024-11-27 12:41:13.241898', 'Trendy women''s skinny jeans for a stylish look', true, 'Women''s Skinny Jeans', 59.99, 4.8, 'women''s-skinny-jeans', '2025-01-07 11:15:24.117', '36474182-6b13-4195-b577-5a1f70aef356', '9fff08b9-b6b6-4152-9b23-7b7f548d2177');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('ba214db9-9448-48a2-af37-d23c3c9bee64', 'TrendyWear', '2024-11-27 12:41:13.241898', 'Comfortable crewneck sweatshirt for women', true, 'Crewneck Sweatshirt', 44.99, 4.6, 'crewneck-sweatshirt', '2025-01-07 11:16:58.673', '36474182-6b13-4195-b577-5a1f70aef356', '40fc8116-c0db-46b8-9a32-be96fdf9d982');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('7aab8d37-f912-49a1-88bb-e1ab73b426f5', 'SummerVibes', '2024-11-27 12:41:13.241898', 'Stylish denim shorts for women', true, 'Denim Shorts', 39.99, 4.7, 'denim-shorts', '2025-01-07 11:17:53.971', '36474182-6b13-4195-b577-5a1f70aef356', 'f2aea52f-053c-4ca2-a0db-7c644b7ab8e9');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('bf9622dd-52cf-4dfd-9792-7755695bdd02', 'Nike', '2024-11-27 12:41:13.241898', 'Classic black plain t-shirt for women', true, 'Black Plain T-shirt', 24.99, 4.5, 'black-plain-t-shirt', '2025-01-07 11:19:46.073', '36474182-6b13-4195-b577-5a1f70aef356', '31e87d1b-ce0d-4d00-9cab-f399f490abba');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('15e308ea-65ab-474e-8e0f-88a2d2008b57', 'TrendyWear', '2024-11-27 12:41:13.241898', 'Stylish black crop top for women', true, 'Black Crop Top', 29.99, 4.2, 'black-crop-top', '2025-01-07 11:23:38.958', '36474182-6b13-4195-b577-5a1f70aef356', '5a53cad8-7584-4097-8839-15cead4e7445');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('1becc6ec-f3f0-4435-8788-14ea376e746f', 'Adidas', '2024-11-27 12:41:13.241898', 'Comfortable white hoodie for men', true, 'White Hoodie', 59.99, 4.7, 'white-hoodie', '2025-01-07 11:24:55.644', 'f7a63a36-bd07-432b-9f2e-458ec110893e', '186d703e-c064-469d-a55b-3771b5dbcad6');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('056309d0-91a9-420d-a255-305038db5783', 'Nike', '2024-11-24 08:06:28.280201', 'Classic black t-shirt for men', true, 'Black T-Shirt', 24.99, 4.5, 'black-t-shirt-3', '2025-01-07 11:01:54.564', 'f7a63a36-bd07-432b-9f2e-458ec110893e', '9147ca29-17c5-4498-b686-61cb5d18d1ec');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('9a968999-3062-41f8-b6d6-4204b8a7e09d', 'Levis', '2024-11-27 12:41:13.241898', 'Stylish blue jeans for men', true, 'Blue Jeans', 49.99, 4.6, 'blue-jeans', '2025-01-07 11:25:50.536', 'f7a63a36-bd07-432b-9f2e-458ec110893e', '61c40a2e-38b6-4f4e-a613-a02a60f2eb6f');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('9f6cce1d-b48e-4614-9e8b-0f2019c08c4b', 'Puma', '2024-11-27 12:41:13.241898', 'Comfortable gray shorts for men', true, 'Gray Shorts', 29.99, 4.4, 'gray-shorts', '2025-01-07 11:33:35.604', 'f7a63a36-bd07-432b-9f2e-458ec110893e', 'e8f836a7-c434-4bdd-be45-736421847a24');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('51b2bcc3-6d19-4234-9563-a4586b13d5e0', 'Adidas', '2024-11-27 12:41:13.241898', 'Comfortable black hoodie for men', true, 'Black Hoodie', 59.99, 4.8, 'black-hoodie', '2025-01-07 11:34:31.07', 'f7a63a36-bd07-432b-9f2e-458ec110893e', '186d703e-c064-469d-a55b-3771b5dbcad6');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('1e796e15-dac1-47fe-ac29-a336788699ad', 'Nike', '2024-11-27 12:41:13.241898', 'Stylish black shorts for women', true, 'Black Shorts', 34.99, 4.5, 'black-shorts', '2025-01-07 11:37:04.764', '36474182-6b13-4195-b577-5a1f70aef356', 'f2aea52f-053c-4ca2-a0db-7c644b7ab8e9');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('47f11dbb-9f09-4ea6-b939-cec1bea4d145', 'TrendyWear', '2024-11-24 08:06:28.280201', 'A stylish white t-shirt for women', true, 'White T-shirt', 29.99, 4.5, 'white-t-shirt-2', '2025-01-07 11:38:58.583', '36474182-6b13-4195-b577-5a1f70aef356', '31e87d1b-ce0d-4d00-9cab-f399f490abba');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('425d440e-5333-4c21-8732-34b96b57f2a5', 'Nike', '2024-11-24 08:06:28.280201', '100% Bio-washed Cotton – makes the fabric extra soft & silky...', true, 'Black Sweatshirt', 49.99, 4.5, 'black-sweatshirt-1', '2025-01-07 20:10:06.527', '36474182-6b13-4195-b577-5a1f70aef356', '40fc8116-c0db-46b8-9a32-be96fdf9d982');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('e9091019-6ddc-4a90-8a96-532868f611b5', 'TrendyWear', '2024-11-27 12:41:13.241898', 'Stylish blue flower print crop top for women', true, 'Blue Flower Print Crop Top', 34.99, 4.3, 'blue-flower-print-crop-top', '2025-01-08 10:17:44.97', '36474182-6b13-4195-b577-5a1f70aef356', '5a53cad8-7584-4097-8839-15cead4e7445');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('2141ed0e-e4c3-44f5-8e75-d13a42e0072b', 'SummerVibes', '2024-11-27 12:41:13.241898', 'A beautiful leaves pattern white dress for women', true, 'Leaves Pattern White Dress', 79.99, 4.7, 'leaves-pattern-white-dress', '2025-01-09 11:03:19.854', '36474182-6b13-4195-b577-5a1f70aef356', 'b3475319-36f7-472c-bcd8-73a580fec695');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('fea42892-a816-4888-acba-776218cb25b0', 'nhat nguyen shop', '2025-01-09 15:13:50.087', 'Jeans for kids', true, 'Jeans for kids', 10.00, 4.5, 'jeans-for-kids', '2025-01-09 15:20:48.036', '3a5abd1b-5908-40ca-9c8c-619a7079d962', 'd80e2f7e-91ee-4d38-b738-23b5f8b0ed10');
INSERT INTO public.products (id, brand, created_at, description, is_new_arrival, name, price, rating, slug, updated_at, category_id, category_type_id) VALUES ('cdeca450-1e11-43c7-9470-77038d297a2b', 'nhat nguyen shop', '2025-01-09 15:23:11.599', 'Cuties dresse for baby girl', false, 'Fancy dresses ', 15.00, 3.4, 'dresses-cuties-for-kids', '2025-01-09 15:23:11.599', '3a5abd1b-5908-40ca-9c8c-619a7079d962', 'dc9a84d4-e144-4d1f-913c-7a1260d839cc');


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: auth_authority auth_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.auth_authority
    ADD CONSTRAINT auth_authority_pkey PRIMARY KEY (id);


--
-- Name: auth_user_details auth_user_details_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.auth_user_details
    ADD CONSTRAINT auth_user_details_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_type category_type_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.category_type
    ADD CONSTRAINT category_type_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: product_resources product_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT product_resources_pkey PRIMARY KEY (id);


--
-- Name: product_variant product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT product_variant_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: auth_user_details uki096w0jnvgjp70hpgqx5v1tbi; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.auth_user_details
    ADD CONSTRAINT uki096w0jnvgjp70hpgqx5v1tbi UNIQUE (email);


--
-- Name: payment ukmf7n8wo2rwrxsd6f3t9ub2mep; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT ukmf7n8wo2rwrxsd6f3t9ub2mep UNIQUE (order_id);


--
-- Name: products ukostq1ec3toafnjok09y9l7dox; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT ukostq1ec3toafnjok09y9l7dox UNIQUE (slug);


--
-- Name: products fk2pw105qhy1aca2a6bqc19rbxn; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk2pw105qhy1aca2a6bqc19rbxn FOREIGN KEY (category_type_id) REFERENCES public.category_type(id);


--
-- Name: orders fk2r5d9dwditf15m06s7x6yusmf; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk2r5d9dwditf15m06s7x6yusmf FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- Name: product_resources fk3k1pn3x472fqhckh85qc6m6y7; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_resources
    ADD CONSTRAINT fk3k1pn3x472fqhckh85qc6m6y7 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: order_items fkbioxgbv59vetrxe0ejfubep1w; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkbioxgbv59vetrxe0ejfubep1w FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: orders fkf5464gxwc32ongdvka2rtvw96; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fkf5464gxwc32ongdvka2rtvw96 FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- Name: payment fklouu98csyullos9k25tbpk4va; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fklouu98csyullos9k25tbpk4va FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: category_type fkmgwrsyriidy42m9273cybb8tr; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.category_type
    ADD CONSTRAINT fkmgwrsyriidy42m9273cybb8tr FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: auth_user_authority fkn7t2r8oft6j1w61po11wnb19w; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.auth_user_authority
    ADD CONSTRAINT fkn7t2r8oft6j1w61po11wnb19w FOREIGN KEY (authorities_id) REFERENCES public.auth_authority(id);


--
-- Name: auth_user_authority fko4vmid5kx45903pdsst9qu1p0; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.auth_user_authority
    ADD CONSTRAINT fko4vmid5kx45903pdsst9qu1p0 FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- Name: order_items fkocimc7dtr037rh4ls4l95nlfi; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkocimc7dtr037rh4ls4l95nlfi FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products fkog2rp4qthbtt2lfyhfo32lsw9; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fkog2rp4qthbtt2lfyhfo32lsw9 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: address fkpv9a6lyjtfiv5c58fdswiamc7; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT fkpv9a6lyjtfiv5c58fdswiamc7 FOREIGN KEY (user_id) REFERENCES public.auth_user_details(id);


--
-- Name: product_variant fktk6wrh1xwqq4vn2pf11mwycgv; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.product_variant
    ADD CONSTRAINT fktk6wrh1xwqq4vn2pf11mwycgv FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES  TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--


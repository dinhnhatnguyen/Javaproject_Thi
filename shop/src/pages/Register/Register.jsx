import React, { useCallback, useState } from "react";
import GoogleSignIn from "../../components/Buttons/GoogleSignIn";
import { Link } from "react-router-dom";
import { setLoading } from "../../store/features/common";
import { useDispatch } from "react-redux";
import { registerAPI } from "../../api/authentication";
import VerifyCode from "./VerifyCode";
import { Eye, EyeOff } from "lucide-react";

const Register = () => {
  const [values, setValues] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    firstName: "",
    lastName: "",
    phoneNumber: "",
  });
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [error, setError] = useState("");
  const dispatch = useDispatch();
  const [enableVerify, setEnableVerify] = useState(false);

  const onSubmit = useCallback(
    (e) => {
      e.preventDefault();
      setError("");

      if (values.password !== values.confirmPassword) {
        setError("Passwords do not match!");
        return;
      }

      dispatch(setLoading(true));
      registerAPI(values)
        .then((res) => {
          if (res?.code === 200) {
            setEnableVerify(true);
          }
        })
        .catch((err) => {
          setError("Invalid or Email already exists!");
        })
        .finally(() => {
          dispatch(setLoading(false));
        });
    },
    [dispatch, values]
  );

  const handleOnChange = useCallback((e) => {
    e.persist();
    setValues((values) => ({
      ...values,
      [e.target.name]: e.target?.value,
    }));
  }, []);

  return (
    <div className="px-8 w-full lg:w-[70%]">
      {!enableVerify && (
        <>
          <p className="text-3xl font-bold pb-4 pt-4">Sign Up</p>
          <GoogleSignIn />
          <p className="text-gray-500 items-center text-center w-full py-2">
            OR
          </p>

          <div className="pt-4">
            <form onSubmit={onSubmit} autoComplete="off">
              <div className="flex gap-4 mb-4">
                <div className="flex-1">
                  <label>First Name</label>
                  <input
                    type="text"
                    name="firstName"
                    value={values.firstName}
                    onChange={handleOnChange}
                    placeholder="First Name"
                    className="h-[48px] w-full border p-2 mt-2 border-gray-400"
                    required
                  />
                </div>
                <div className="flex-1">
                  <label>Last Name</label>
                  <input
                    type="text"
                    name="lastName"
                    value={values.lastName}
                    onChange={handleOnChange}
                    placeholder="Last Name"
                    className="h-[48px] w-full border p-2 mt-2 border-gray-400"
                    required
                  />
                </div>
              </div>

              <label>Email Address</label>
              <input
                type="email"
                name="email"
                value={values.email}
                onChange={handleOnChange}
                placeholder="Email address"
                className="h-[48px] w-full border p-2 mt-2 mb-4 border-gray-400"
                required
                autoComplete="off"
              />

              <label>Phone Number</label>
              <input
                type="tel"
                name="phoneNumber"
                value={values.phoneNumber}
                onChange={handleOnChange}
                placeholder="Phone Number"
                className="h-[48px] w-full border p-2 mt-2 mb-4 border-gray-400"
                required
              />

              <div className="relative">
                <label>Password</label>
                <input
                  type={showPassword ? "text" : "password"}
                  name="password"
                  value={values.password}
                  onChange={handleOnChange}
                  placeholder="Password"
                  className="h-[48px] mt-2 w-full border p-2 border-gray-400"
                  required
                  autoComplete="new-password"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-12 text-gray-500"
                >
                  {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
                </button>
              </div>

              <div className="relative mt-4">
                <label>Confirm Password</label>
                <input
                  type={showConfirmPassword ? "text" : "password"}
                  name="confirmPassword"
                  value={values.confirmPassword}
                  onChange={handleOnChange}
                  placeholder="Confirm Password"
                  className="h-[48px] mt-2 w-full border p-2 border-gray-400"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute right-3 top-12 text-gray-500"
                >
                  {showConfirmPassword ? (
                    <EyeOff size={20} />
                  ) : (
                    <Eye size={20} />
                  )}
                </button>
              </div>

              <button className="border w-full rounded-lg h-[48px] mb-4 bg-black text-white mt-4 hover:opacity-80">
                Sign Up
              </button>
            </form>
          </div>
          {error && <p className="text-lg text-red-700">{error}</p>}
          <Link
            to={"/v1/login"}
            className="underline text-gray-500 hover:text-black"
          >
            Already have an account? Log in
          </Link>
        </>
      )}
      {enableVerify && <VerifyCode email={values?.email} />}
    </div>
  );
};

export default Register;

// import React, { useCallback, useState } from "react";
// import GoogleSignIn from "../../components/Buttons/GoogleSignIn";
// import { Link } from "react-router-dom";
// import { setLoading } from "../../store/features/common";
// import { useDispatch } from "react-redux";
// import { registerAPI } from "../../api/authentication";
// import VerifyCode from "./VerifyCode";

// const Register = () => {
//   const [values, setValues] = useState({
//     email: "",
//     password: "",
//     firstName: "",
//     lastName: "",
//     phone: "",
//   });
//   const [error, setError] = useState("");
//   const dispatch = useDispatch();
//   const [enableVerify, setEnableVerify] = useState(false);

//   const onSubmit = useCallback(
//     (e) => {
//       e.preventDefault();
//       setError("");
//       dispatch(setLoading(true));
//       registerAPI(values)
//         .then((res) => {
//           if (res?.code === 200) {
//             setEnableVerify(true);
//           }
//         })
//         .catch((err) => {
//           setError("Invalid or Email already exist!");
//         })
//         .finally(() => {
//           dispatch(setLoading(false));
//         });
//     },
//     [dispatch, values]
//   );

//   const handleOnChange = useCallback((e) => {
//     e.persist();
//     setValues((values) => ({
//       ...values,
//       [e.target.name]: e.target?.value,
//     }));
//   }, []);

//   return (
//     <div className="px-8 w-full lg:w-[70%]">
//       {!enableVerify && (
//         <>
//           <p className="text-3xl font-bold pb-4 pt-4">Sign Up</p>
//           <GoogleSignIn />
//           <p className="text-gray-500 items-center text-center w-full py-2">
//             OR
//           </p>

//           <div className="pt-4">
//             <form onSubmit={onSubmit} autoComplete="off">
//               <label>Email Address</label>
//               <input
//                 type="email"
//                 name="email"
//                 value={values?.userName}
//                 onChange={handleOnChange}
//                 placeholder="Email address"
//                 className="h-[48px] w-full border p-2 mt-2 mb-4 border-gray-400"
//                 required
//                 autoComplete="off"
//               />
//               <label>Password</label>
//               <input
//                 type="password"
//                 name="password"
//                 value={values?.password}
//                 onChange={handleOnChange}
//                 placeholder="Password"
//                 className="h-[48px] mt-2 w-full border p-2 border-gray-400"
//                 required
//                 autoComplete="new-password"
//               />
//               <button className="border w-full rounded-lg h-[48px] mb-4 bg-black text-white mt-4 hover:opacity-80">
//                 Sign Up
//               </button>
//             </form>
//           </div>
//           {error && <p className="text-lg text-red-700">{error}</p>}
//           <Link
//             to={"/v1/login"}
//             className="underline text-gray-500 hover:text-black"
//           >
//             Already have an account? Log in
//           </Link>
//         </>
//       )}
//       {enableVerify && <VerifyCode email={values?.email} />}
//     </div>
//   );
// };

// export default Register;

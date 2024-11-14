import logo from "./logo.svg";

import Navigation from "./components/Navigation/Navigation";
import HeroSection from "./components/HeroSection/HeroSection";
import NewArrivals from "./components/Sections/NewArrivals";
import Category from "./components/Sections/Categories/Category";
import content from "./data/content.json";
import Footer from "./components/Footer/Footer";

function App() {
  return (
    <div className="App">
      <Navigation />
      <HeroSection />
      <NewArrivals />
      {content?.pages?.shop?.sections &&
        content?.pages?.shop?.sections?.map((item, index) => (
          <Category key={item?.title + index} {...item} />
        ))}
      <Footer content={content?.footer} />
    </div>
  );
}

export default App;

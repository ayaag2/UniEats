import React, { useMemo, useState, useEffect } from "react";  
import "./App.css";
//import { restaurants } from "./data/restaurants";
//import { campuses } from "./data/campuses";
// import { cuisines } from "./data/cuisines"; 
//import { campusProximity } from "./data/campusProximity";
import { ratings } from "./data/ratings";
import Header from "./components/Header";
import FiltersBar from "./components/FiltersBar";
import RestaurantCard from "./components/RestaurantCard";

//replace these with API calls to backend later once completed above 

function App() {
  const [search, setSearch] = useState("");
  const [selectedCampuses, setSelectedCampuses] = useState([]);
  const [selectedCuisine, setSelectedCuisine] = useState("all");
  const [takeOutOnly, setTakeOutOnly] = useState(false);
  const [deliveryOnly, setDeliveryOnly] = useState(false);
  const [sortBy, setSortBy] = useState("distance");

  const [cuisines, setCuisines] = useState([]);
  const [restaurants, setRestaurants] = useState([]);
  const [campuses, setCampuses] = useState([]);
  const [campusProximity, setCampusProximity] = useState([]);

  useEffect(() => {
    fetch("http://localhost:5001/cuisine")
      .then((res) => res.json())
      .then((data) => setCuisines(data))
      .catch((err) => console.error("Failed to load cuisines:", err));
  }, []);

  useEffect(() => {
    fetch("http://localhost:5001/campuses")
      .then((res) => res.json())
      .then((data) => setCampuses(data))
      .catch((err) => console.error("Failed to load campuses:", err));
  }, []);

  useEffect(() => {
    fetch("http://localhost:5001/restaurants")
      .then((res) => res.json())
      .then((data) => {
        console.log("Fetched restaurants:", data); //log
        setRestaurants(data);
      })
      .catch((err) => console.error("Failed to load restaurants:", err));
  }, []);

  useEffect(() => {
    fetch("http://localhost:5001/campusProximity")
      .then((res) => res.json())
      .then((data) => setCampusProximity(data))
      .catch((err) => console.error("Failed to load campusProximity:", err));
  }, []);

  const restaurantWithComputedFields = useMemo(() => {
    return restaurants.map((r) => {
      const proximity = campusProximity.filter(
        (cp) => cp.restaurantid === r.id
      );
      const restRatings = ratings.filter((rt) => rt.restaurantid === r.id);
      const avgRating =
        restRatings.length === 0
          ? null
          : restRatings.reduce((sum, rt) => sum + rt.value, 0) /
            restRatings.length;

      const closest =
        proximity.length === 0
          ? null
          : proximity.reduce((min, cp) =>
              cp.distance < min.distance ? cp : min
            );

      const closestCampus =
        closest && campuses.find((c) => c.id === closest.campusId);

      return {
        ...r,
        proximity,
        avgRating,
        closestDistance: closest ? closest.distance : null,
        closestCampusName: closestCampus ? closestCampus.name : null,
      };
    });
  }, []);

  const filtered = useMemo(() => {
    return restaurantWithComputedFields
      .filter((r) => {
        const query = search.trim().toLowerCase();
        if (query) {
          const cuisineLabel =
            cuisines.find((c) => c.id === r.cuisineid)?.name || "";
          const haystack = (r.name + " " + cuisineLabel).toLowerCase();
          if (!haystack.includes(query)) return false;
        }
        return true;
      })
      .filter((r) => {
        if (selectedCuisine === "all") return true;
        return String(r.cuisineid) === String(selectedCuisine);
      })
      .filter((r) => {
        if (!takeOutOnly && !deliveryOnly) return true;
        if (takeOutOnly && !r.takeoutavailable) return false;
        if (deliveryOnly && !r.deliveryavailable) return false;
        return true;
      })
      .filter((r) => {
        if (selectedCampuses.length === 0) return true;
        const proximities = campusProximity.filter(
          (cp) => cp.restaurantid === r.id
        );
        const campusIds = proximities.map((cp) => cp.campusId);
        return selectedCampuses.some((id) => campusIds.includes(id));
      })
      .sort((a, b) => {
        if (sortBy === "rating") {
          const ar = a.avgRating ?? 0;
          const br = b.avgRating ?? 0;
          return br - ar;
        }
        if (sortBy === "price") {
          const priceOrder = ["<$5", "$5-$10", "$10-$20"];
          return (
            priceOrder.indexOf(a.priceRange) -
            priceOrder.indexOf(b.priceRange)
          );
        }
        // distance
        const ad = a.closestDistance ?? Number.POSITIVE_INFINITY;
        const bd = b.closestDistance ?? Number.POSITIVE_INFINITY;
        return ad - bd;
      });
  }, [
    restaurantWithComputedFields,
    search,
    selectedCuisine,
    takeOutOnly,
    deliveryOnly,
    selectedCampuses,
    sortBy,
    cuisines, 
    restaurants,
    campuses,
    campusProximity
  ]);

  return (
    <div className="app-shell">
      <Header />
      <main className="app-main">
        <section className="panel surface">
          <FiltersBar
            search={search}
            onSearchChange={setSearch}
            campuses={campuses}
            cuisines={cuisines}   
            selectedCampuses={selectedCampuses}
            setSelectedCampuses={setSelectedCampuses}
            selectedCuisine={selectedCuisine}
            setSelectedCuisine={setSelectedCuisine}
            takeOutOnly={takeOutOnly}
            setTakeOutOnly={setTakeOutOnly}
            deliveryOnly={deliveryOnly}
            setDeliveryOnly={setDeliveryOnly}
            sortBy={sortBy}
            setSortBy={setSortBy}
          />
        </section>

        <section className="results-panel surface">
          <header className="results-header">
            <div>
              <h2>Results</h2>
              <p className="results-subtitle">
                Showing {filtered.length} restaurant
                {filtered.length === 1 ? "" : "s"} near Chicago campuses
              </p>
            </div>
          </header>

          {filtered.length === 0 ? (
            <div className="empty-state">
              <p className="empty-title">No matches yet</p>
              <p className="empty-text">
                Try broadening your filters or searching for a different
                cuisine.
              </p>
            </div>
          ) : (
            <div className="cards-grid">
              {filtered.map((r) => (
                <RestaurantCard key={r.id} restaurant={r} />
              ))}
            </div>
          )}
        </section>
      </main>

      <footer className="app-footer">
        <p>UNI EATS · Built for hungry students in Chicago</p>
      </footer>
    </div>
  );
}

export default App;

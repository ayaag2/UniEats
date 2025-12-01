// src/App.js
import React, { useState, useEffect } from "react";
import "./App.css";
import Header from "./components/Header";
import FiltersBar from "./components/FiltersBar";
import RestaurantCard from "./components/RestaurantCard";

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
  const [userRatings, setUserRatings] = useState([]);

  // --- Data fetching ---

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
        console.log("Fetched restaurants:", data);
        setRestaurants(data);
      })
      .catch((err) => console.error("Failed to load restaurants:", err));
  }, []);

  useEffect(() => {
    fetch("http://localhost:5001/campusProximity")
      .then((res) => res.json())
      .then((data) => {
        console.log("Fetched campusProximity:", data);
        setCampusProximity(data);
      })
      .catch((err) => console.error("Failed to load campusProximity:", err));
  }, []);

  useEffect(() => {
    // Expects: [{ restaurantid: number, value: number }, ...]
    fetch("http://localhost:5001/userRatings")
      .then((res) => res.json())
      .then((data) => {
        console.log("Fetched userRatings:", data);
        setUserRatings(data);
      })
      .catch((err) => console.error("Failed to load userRatings:", err));
  }, []);

  // --- Compute extra fields for each restaurant ---

  const restaurantsWithComputedFields = restaurants.map((r) => {
    // All proximity records for this restaurant
    const proximity = campusProximity.filter((cp) => cp.restaurantid === r.id);

    // Ratings + average rating
    const restRatings = userRatings.filter((rt) => rt.restaurantid === r.id);

    const avgRating =
      restRatings.length === 0
        ? null
        : restRatings.reduce((sum, rt) => sum + Number(rt.value || 0), 0) /
          restRatings.length;

    // Closest campus record
    const closest =
      proximity.length === 0
        ? null
        : proximity.reduce((min, cp) =>
            cp.distance < min.distance ? cp : min
          );

    // Campus name for the closest campus (string-compare IDs to be safe)
    const closestCampus =
      closest &&
      campuses.find((c) => String(c.id) === String(closest.campusId));

    return {
      ...r,
      proximity,
      avgRating,
      closestDistance: closest ? closest.distance : null,
      closestCampusName: closestCampus ? closestCampus.name : null,
    };
  });

  // --- Apply filters + sorting ---

  const filtered = restaurantsWithComputedFields
    .filter((r) => {
      // Search by name or cuisine
      const query = search.trim().toLowerCase();
      if (!query) return true;

      const cuisineLabel =
        cuisines.find((c) => c.id === r.cuisineid)?.name || "";
      const haystack = (r.name + " " + cuisineLabel).toLowerCase();

      return haystack.includes(query);
    })
    .filter((r) => {
      // Filter by cuisine dropdown
      if (selectedCuisine === "all") return true;
      return String(r.cuisineid) === String(selectedCuisine);
    })
    .filter((r) => {
      // Takeout / delivery filters
      if (!takeOutOnly && !deliveryOnly) return true;
      if (takeOutOnly && !r.takeoutavailable) return false;
      if (deliveryOnly && !r.deliveryavailable) return false;
      return true;
    })
    .filter((r) => {
      // Campus filter USING precomputed r.proximity
      if (selectedCampuses.length === 0) return true;

      const campusIds = r.proximity.map((cp) => String(cp.campusId));

      return selectedCampuses.some((id) => campusIds.includes(String(id)));
    })
    .sort((a, b) => {
      if (sortBy === "rating") {
        const ar = a.avgRating ?? 0;
        const br = b.avgRating ?? 0;
        return br - ar; // highest rating first
      }

      if (sortBy === "price") {
        const priceOrder = ["<$5", "$5-$10", "$10-$20"];
        return (
          priceOrder.indexOf(a.priceRange) - priceOrder.indexOf(b.priceRange)
        );
      }

      // Default: sort by distance
      const ad = a.closestDistance ?? Number.POSITIVE_INFINITY;
      const bd = b.closestDistance ?? Number.POSITIVE_INFINITY;
      return ad - bd;
    });

  // --- Render ---

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

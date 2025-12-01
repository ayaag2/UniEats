import React from "react";
import "./FiltersBar.css";

function FiltersBar({
  search,
  onSearchChange,
  campuses,
  cuisines,
  selectedCampuses,
  setSelectedCampuses,
  selectedCuisine,
  setSelectedCuisine,
  takeOutOnly,
  setTakeOutOnly,
  deliveryOnly,
  setDeliveryOnly,
  sortBy,
  setSortBy,
}) {
  const toggleCampus = (id) => {
    if (selectedCampuses.includes(id)) {
      setSelectedCampuses(selectedCampuses.filter((c) => c !== id));
    } else {
      setSelectedCampuses([...selectedCampuses, id]);
    }
  };

  return (
    <div className="filters-shell">
      <div className="filters-group">
        <label className="field-label">Search</label>
        <div className="search-field">
          <span className="search-icon" aria-hidden="true">
            🔍
          </span>
          <input
            value={search}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Search by restaurant or cuisine"
          />
        </div>
      </div>

      <div className="filters-grid">
        <div className="filters-group">
          <label className="field-label">Campus proximity</label>
          <div className="chips-row">
            {campuses.map((c) => {
              const active = selectedCampuses.includes(c.id);
              return (
                <button
                  key={c.id}
                  type="button"
                  className={active ? "chip chip-active" : "chip"}
                  onClick={() => toggleCampus(c.id)}
                >
                  {c.shortlabel ?? c.name}
                </button>
              );
            })}
          </div>
        </div>

        <div className="filters-group">
          <label className="field-label">Cuisine</label>
          <select
            value={selectedCuisine}
            onChange={(e) =>
              setSelectedCuisine(
                e.target.value === "all" ? "all" : Number(e.target.value)
              )
            }
          >
            <option value="all">All cuisines</option>
            {cuisines.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </div>

        <div className="filters-group">
          <label className="field-label">Services</label>
          <div className="toggles-row">
            <label className="toggle">
              <input
                type="checkbox"
                checked={takeOutOnly}
                onChange={(e) => setTakeOutOnly(e.target.checked)}
              />
              <span>Take-out</span>
            </label>
            <label className="toggle">
              <input
                type="checkbox"
                checked={deliveryOnly}
                onChange={(e) => setDeliveryOnly(e.target.checked)}
              />
              <span>Delivery</span>
            </label>
          </div>
        </div>

        <div className="filters-group">
          <label className="field-label">Sort by</label>
          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value)}
          >
            <option value="distance">Closest walk</option>
            <option value="rating">Best rated</option>
            <option value="price">Price (low → high)</option>
          </select>
        </div>
      </div>
    </div>
  );
}

export default FiltersBar;

import React from "react";
import "./RestaurantCard.css";
import RatingsBadge from "./RatingsBadge";

function RestaurantCard({ restaurant }) {
  const {
    name,
    priceRange,
    thumbnailUrl,
    walkDistance,
    takeOutAvailable,
    deliveryAvailable,
    avgRating,
    closestDistance,
    closestCampusName,
  } = restaurant;

  return (
    <article className="restaurant-card">
      <div className="restaurant-thumb">
        <img src={thumbnailUrl} alt={name} />
        {avgRating && (
          <div className="restaurant-rating-chip">
            <RatingsBadge rating={avgRating} />
          </div>
        )}
      </div>
      <div className="restaurant-body">
        <div className="restaurant-top-row">
          <h3 className="restaurant-name">{name}</h3>
          <span className="price-pill">{priceRange}</span>
        </div>
        <p className="restaurant-meta">
          {closestCampusName && closestDistance != null ? (
            <>
              <span>{closestCampusName}</span>
              <span className="dot">•</span>
              <span>{closestDistance.toFixed(1)} mi walk</span>
            </>
          ) : (
            <span>Distance info coming soon</span>
          )}
        </p>
        <p className="restaurant-meta">
          <span>
            <strong>{walkDistance.toFixed(1)} mi</strong> est. from your campus
          </span>
        </p>
        <div className="restaurant-services">
          {takeOutAvailable && <span className="service-tag">Take-out</span>}
          {deliveryAvailable && (
            <span className="service-tag service-tag-alt">Delivery</span>
          )}
          {!takeOutAvailable && !deliveryAvailable && (
            <span className="service-tag-muted">Dine-in only</span>
          )}
        </div>
      </div>
    </article>
  );
}

export default RestaurantCard;

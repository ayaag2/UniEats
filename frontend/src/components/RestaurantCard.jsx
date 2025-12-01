import React from "react";
import "./RestaurantCard.css";
import RatingsBadge from "./RatingsBadge";

function RestaurantCard({ restaurant }) {
  const {
    name,
    pricerange,
    thumbnailurl,
    walkdistance,
    takeoutavailable,
    deliveryavailable,
    avgRating,
    closestDistance,
    closestCampusName,
  } = restaurant;

  return (
    <article className="restaurant-card">
      <div className="restaurant-thumb">
        <img src={thumbnailurl} alt={name} />
        {avgRating && (
          <div className="restaurant-rating-chip">
            <RatingsBadge rating={avgRating} />
          </div>
        )}
      </div>
      <div className="restaurant-body">
        <div className="restaurant-top-row">
          <h3 className="restaurant-name">{name}</h3>
          <span className="price-pill">{pricerange}</span>
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
            <strong>{walkdistance.toFixed(1)} mi</strong> est. from your campus
          </span>
        </p>
        <div className="restaurant-services">
          {takeoutavailable && <span className="service-tag">Take-out</span>}
          {deliveryavailable && (
            <span className="service-tag service-tag-alt">Delivery</span>
          )}
          {!takeoutavailable && !deliveryavailable && (
            <span className="service-tag-muted">Dine-in only</span>
          )}
        </div>
      </div>
    </article>
  );
}

export default RestaurantCard;

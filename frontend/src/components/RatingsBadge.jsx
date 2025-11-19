import React from "react";
import "./RatingsBadge.css";

function RatingsBadge({ rating }) {
  const rounded = Math.round(rating * 10) / 10;
  let tone = "rating-good";
  if (rounded >= 4.5) tone = "rating-great";
  else if (rounded < 3.5) tone = "rating-okay";

  return (
    <div className={`rating-pill ${tone}`}>
      <span className="rating-score">{rounded.toFixed(1)}</span>
      <span className="rating-label">rating</span>
    </div>
  );
}

export default RatingsBadge;

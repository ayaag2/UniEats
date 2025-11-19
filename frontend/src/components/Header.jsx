import React from "react";
import "./Header.css";

function Header() {
  return (
    <header className="header-shell surface">
      <div className="header-left">
        <div className="logo-circle">uni</div>
        <div>
          <h1 className="header-title">UNI EATS</h1>
          <p className="header-subtitle">
            Affordable eats within walking distance of your campus.
          </p>
        </div>
      </div>
      <div className="header-right">
        <p className="pill pill-soft">Chicago · Student-friendly · Fast picks</p>
      </div>
    </header>
  );
}

export default Header;

import React from "react";
import { render, screen } from "@testing-library/react";
import TopBar from "./TopBar";

test("render url shorterner on the page", () => {
  render(<TopBar />);
  const headerElement = screen.getByText(/URL Shortener/i);
  expect(headerElement).toBeInTheDocument();
});

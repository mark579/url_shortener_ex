import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

jest.mock("react-router-dom", () => ({
  ...jest.requireActual("react-router-dom"),
  useLocation: () => ({
    pathname: "localhost:5000/",
  }),
}));

test('renders the top bar', () => {
  render(<App />);
  const headerElement = screen.getByText(/URL Shortener/i);
  expect(headerElement).toBeInTheDocument();
});

test('renders the URL Form', () => {
  render(<App />);
  const longLabel = screen.getByLabelText(/Long URL/i);
  const shortLabel = screen.getByLabelText(/Short URL/i);

  expect(longLabel).toBeInTheDocument();
  expect(shortLabel).toBeInTheDocument();
});

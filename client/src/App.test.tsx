import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

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

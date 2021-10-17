import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import UrlForm from "./UrlForm";

jest.mock("react-router-dom", () => ({
  ...jest.requireActual("react-router-dom"),
  useLocation: () => ({
    pathname: "localhost:5000/?STATUS=NOT_FOUND",
  }),
}));

beforeEach(() => {
  fetchMock.resetMocks();
});

test("renders the form and buttons", () => {
  render(<UrlForm />);
  const shortBox = screen.getByLabelText(/Short URL/i);
  const longBox = screen.getByLabelText(/Long URL/i);
  const shortenButton = screen.getByText(/Shorten!/i);
  const clipBoardButton = screen.getByTestId("ContentCopyIcon");

  expect(shortBox).toBeInTheDocument();
  expect(longBox).toBeInTheDocument();
  expect(shortenButton).toBeInTheDocument();
  expect(shortenButton).toBeDisabled();
  expect(clipBoardButton).toBeInTheDocument();
});

test("renders invalid url format when a 400 is returned", async () => {
  fetchMock.once('{ "error": "Invalid URL" }', { status: 400 });
  render(<UrlForm />);
  const longBox = screen.getByLabelText(/Long URL/i);

  fireEvent.change(longBox, {
    target: { value: "hellobadURL" },
  });
  const shorten = screen.getByText(/Shorten!/i);
  expect(shorten).toBeEnabled();
  fireEvent.click(shorten);
  expect(fetchMock.mock.calls.length).toEqual(1);
  await waitFor(() =>
    expect(screen.getByText("Invalid URL Format")).toBeInTheDocument()
  );
});

test("renders url with slug and port when successfull", async () => {
  const slug = "ABCDEFGH";
  fetchMock.once(`{ "slug": "${slug}" }`, { status: 200 });
  render(<UrlForm />);
  const longBox = screen.getByLabelText(/Long URL/i);

  fireEvent.change(longBox, {
    target: { value: "http://hellogoodurl.com/" },
  });
  fireEvent.click(screen.getByText(/Shorten!/i));
  expect(fetchMock.mock.calls.length).toEqual(1);
  await waitFor(() =>
    expect(
      screen.getByText(`http://localhost:5000/${slug}`)
    ).toBeInTheDocument()
  );
  const clipBoardButton = screen.getByTestId("ContentCopyIcon");
  expect(clipBoardButton).toBeEnabled();
});

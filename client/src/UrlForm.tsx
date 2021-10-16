import * as React from "react";
import Box from "@mui/material/Box";
import { Button } from "@mui/material";
import TextField from "@mui/material/TextField";
import { Typography } from "@mui/material";

export default function UrlForm() {
  const [longURL, setLongURL] = React.useState("");
  const [shortURL, setShortURL] = React.useState("");
  const [error, setError] = React.useState("");

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setLongURL(event.target.value);
    setShortURL("");
  };

  const shortenUrl = () => {
    function handleErrors(response: any) {
      if (!response.ok) {
        if (response.status === 400) {
          setError("Invalid URL Format");
          setShortURL("");
          return { raw: "" };
        } else {
          setError("Encountered and Error generating URL");
          throw Error("Error creating Shortened URL");
        }
      } else {
        setError("");
      }
      return response.json();
    }
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ raw: longURL }),
    };
    fetch("/api/urls", requestOptions)
      .then(handleErrors)
      .then((data) =>
        setShortURL(data.slug ? `http://localhost:5000/${data.slug}` : "")
      )
      .catch((error) => {
        console.error("There was an error!", error);
      });
  };

  return (
    <>
      <Box
        component="form"
        sx={{
          "& .MuiTextField-root": { m: 2 },
        }}
        noValidate
        autoComplete="off"
      >
        <Box>
          <Typography variant="overline" component="div">
            Long URL
          </Typography>
          <TextField
            id="outlined-multiline-flexible"
            label="Long URL"
            multiline
            maxRows={4}
            value={longURL}
            helperText={error}
            error={error.length > 0}
            onChange={handleChange}
          />
        </Box>
        <Box>
          <Typography variant="overline" component="div">
            Shortened URL
          </Typography>
          <TextField
            id="outlined-multiline-flexible"
            label="Short URL"
            multiline
            disabled
            maxRows={4}
            value={shortURL}
            onChange={handleChange}
          />
        </Box>
        <Button onClick={shortenUrl} variant="outlined">
          Shorten!
        </Button>
      </Box>
    </>
  );
}

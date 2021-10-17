import * as React from "react";
import { useLocation } from "react-router-dom";
import Box from "@mui/material/Box";
import { Button, IconButton } from "@mui/material";
import ContentCopyIcon from "@mui/icons-material/ContentCopy";
import Snackbar from "@mui/material/Snackbar";
import TextField from "@mui/material/TextField";
import { Typography } from "@mui/material";

export default function UrlForm() {
  const search = useLocation().search;
  const paramStatus = new URLSearchParams(search).get("status");

  const [longURL, setLongURL] = React.useState("");
  const [shortURL, setShortURL] = React.useState("");
  const [error, setError] = React.useState("");
  const [open, setOpen] = React.useState(false);
  const [status, setStatus] = React.useState(paramStatus);

  const handleLongUrlChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setLongURL(event.target.value);
    setShortURL("");
  };

  const handleStatusClose = (
    event: React.SyntheticEvent | React.MouseEvent,
    reason?: string
  ) => {
    if (reason === "clickaway") {
      return;
    }

    setStatus("");
  };

  const handleClipBoardClose = (
    event: React.SyntheticEvent | React.MouseEvent,
    reason?: string
  ) => {
    if (reason === "clickaway") {
      return;
    }

    setOpen(false);
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

  const copyToClipBoard = async () => {
    if ("clipboard" in navigator) {
      setOpen(true);
      return await navigator.clipboard.writeText(shortURL);
    } else {
      setOpen(true);
      return document.execCommand("copy", true, shortURL);
    }
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
            onChange={handleLongUrlChange}
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
          />
        </Box>
        <Box sx={{ mx: 1 }} component="span">
          <Button
            onClick={shortenUrl}
            variant="outlined"
            disabled={longURL.length === 0}
          >
            Shorten!
          </Button>
        </Box>
        <Box sx={{ mx: 1 }} component="span">
          <IconButton
            onClick={copyToClipBoard}
            aria-label="copy to clipboard"
            disabled={shortURL.length === 0}
          >
            <ContentCopyIcon />
          </IconButton>
        </Box>
      </Box>
      <Snackbar
        open={open}
        autoHideDuration={2000}
        onClose={handleClipBoardClose}
        message="Copied to Clipboard"
      />
      <Snackbar
        open={status === "NOT_FOUND"}
        autoHideDuration={5000}
        onClose={handleStatusClose}
        message="Shortened URL not Found!"
      />
    </>
  );
}

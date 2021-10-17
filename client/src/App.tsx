import React from "react";
import CssBaseline from "@mui/material/CssBaseline";
import Container from "@mui/material/Container";
import TopBar from "./TopBar";
import "./App.css";
import UrlForm from "./UrlForm";

function App() {
  return (
    <div className="App">
      <TopBar />
      <React.Fragment>
        <CssBaseline />
        <Container maxWidth="sm">
          <UrlForm></UrlForm>
        </Container>
      </React.Fragment>
    </div>
  );
}

export default App;

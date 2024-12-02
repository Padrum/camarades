import React from "react";
import ReactDOM from "react-dom";
import { createBrowserHistory } from "history";
import { Router, Route, Switch } from "react-router-dom";
import { MuiPickersUtilsProvider } from '@material-ui/pickers';
import MomentUtils from '@date-io/moment';
import "moment/locale/fr";

import "assets/scss/material-kit-react.scss?v=1.8.0";

// pages for this product
import LandingPage from "views/LandingPage/LandingPage.js";
import LoginPage from "views/LoginPage/LoginPage.js";
import RegisterPage from "views/RegisterPage/RegisterPage.js";
import ConfidentialityPage from "./views/FooterPage/ConfidentialityPage";
import FaqPage from "./views/FooterPage/FaqPage";
import ContactPage from "./views/FooterPage/ContactPage";
import ProfilePage from "./views/ProfilePage/ProfilePage";

import { CookiesProvider } from 'react-cookie';

var hist = createBrowserHistory();

ReactDOM.render(
    <CookiesProvider>
        <MuiPickersUtilsProvider utils={MomentUtils} locale="fr">
          <Router history={hist}>
            <Switch>
                <Route path="/login" component={LoginPage} />
                <Route path="/register" component={RegisterPage} />
                <Route path="/faq" component={FaqPage} />
                <Route path="/contact" component={ContactPage} />
                <Route path="/profile" component={ProfilePage} />
                <Route path="/politique-confidentialite" component={ConfidentialityPage} />
                <Route path="/" component={LandingPage} />
            </Switch>
          </Router>
        </MuiPickersUtilsProvider>
    </CookiesProvider>,
  document.getElementById("root")
);
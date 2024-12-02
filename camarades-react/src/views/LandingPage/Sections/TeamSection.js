import React from "react";
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";

// @material-ui/icons

// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import Button from "components/CustomButtons/Button.js";
import Card from "components/Card/Card.js";
import CardBody from "components/Card/CardBody.js";
import CardFooter from "components/Card/CardFooter.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/teamStyle.js";

import charlie from "assets/img/faces/charlie.jpg";
//import theo from "assets/img/faces/theo.jpg";
import owen from "assets/img/faces/owen.jpg";

const useStyles = makeStyles(styles);

export default function TeamSection() {
  const classes = useStyles();
  const imageClasses = classNames(
    classes.imgRaised,
    classes.imgRoundedCircle,
    classes.imgFluid
  );
  return (
    <div className={classes.section}>
      <h2 className={classes.title}>Voici notre équipe</h2>
      <div>
        <GridContainer>
          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src={charlie} alt="Photo de Charlie Guerry" className={imageClasses} />
              </GridItem>
              <h4 className={classes.cardTitle}>
                Charlie Guerry
                <br />
                <small className={classes.smallTitle}>Développeur</small>
              </h4>
              <CardBody>
                <p className={classes.description}>
                  Le mec qui fait du flutter et qui aime le poker.
                </p>
              </CardBody>

            </Card>
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src="https://picsum.photos/200" alt="Photo de Théo Vignon" className={imageClasses} />
              </GridItem>
              <h4 className={classes.cardTitle}>
                Théo Vignon
                <br />
                <small className={classes.smallTitle}>Développeur</small>
              </h4>
              <CardBody>
                <p className={classes.description}>
                  Le mec qui aime le poker et les machines à sous.
                </p>
              </CardBody>
              <CardFooter className={classes.justifyCenter}>

              </CardFooter>
            </Card>
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src={owen} alt="Photo de Owen Sessiecq" className={imageClasses} />
              </GridItem>
              <h4 className={classes.cardTitle}>
                Owen Sessiecq
                <br />
                <small className={classes.smallTitle}>Développeur</small>
              </h4>
              <CardBody>
                <p className={classes.description}>
                  Le mec qui est chef de projet mais qui comprend pas pourquoi.
                </p>
              </CardBody>
              <CardFooter className={classes.justifyCenter}>

              </CardFooter>
            </Card>
          </GridItem>
        </GridContainer>
      </div>
    </div>
  );
}

import React from "react";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";

// @material-ui/icons
import Chat from "@material-ui/icons/Chat";
import SchoolIcon from '@material-ui/icons/School';
import EventIcon from '@material-ui/icons/Event';
// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import InfoArea from "components/InfoArea/InfoArea.js";

import styles from "assets/jss/material-kit-react/views/landingPageSections/productStyle.js";

const useStyles = makeStyles(styles);

export default function ProductSection() {
  const classes = useStyles();
  return (
    <div className={classes.section}>
      <GridContainer justify="center">
        <GridItem xs={12} sm={12} md={8}>
          <h2 className={classes.title}>Qu'est ce que Camarades ?</h2>
          <h5 className={classes.description}>
            Camarades est une application.
              <br/>
              <br/>
              <br/>
              <br/>
              <br/>
              <br/>
            Merci à tous de votre attention !
          </h5>
        </GridItem>
      </GridContainer>
      <div>
        <GridContainer>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Tchatter en temps réel avec les étudiants et les professionnels"
              description="Dans Camarades tu peux tchatter en temps réel avec les étudiants de n'importe quel école qui t'intéresse !"
              icon={Chat}
              iconColor="info"
              vertical
            />
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Trouver sa voie"
              description="Le but principal de Camarades est de te permettre de trouver le parcours d'étude qui te convient."
              icon={SchoolIcon}
              iconColor="success"
              vertical
            />
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <InfoArea
              title="Se mettre au courant"
              description="Grâce à Camarades tu peux te mettre au courant des portes ouvertes ou des évènements de toutes les écoles et groupes de Camarades auxquels tu t'es abonné."
              icon={EventIcon}
              iconColor="danger"
              vertical
            />
          </GridItem>
        </GridContainer>
      </div>
    </div>
  );
}

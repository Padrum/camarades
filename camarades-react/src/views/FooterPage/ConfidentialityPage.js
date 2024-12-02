import React from "react";
import classNames from "classnames";
import Footer from "../../components/Footer/Footer";

import { makeStyles } from "@material-ui/core/styles";

import basicContentPageStyle from "../../assets/jss/camarades/views/basicContentPage";
import Header from "../../components/Header/Header";
import HeaderLinks from "../../components/Header/HeaderLinks";
import GridContainer from "../../components/Grid/GridContainer";
import GridItem from "../../components/Grid/GridItem";
import {Link} from "react-router-dom";

const dashboardRoutes = [];

const useStyles = makeStyles(basicContentPageStyle);

export default function ConfidentialityPage(props){
    const classes = useStyles();
    const { ...rest } = props;

    return(
        <div>
            <Header
                color="white"
                routes={dashboardRoutes}
                brand="Camarades"
                rightLinks={<HeaderLinks />}
                fixed
                {...rest}
            />
            <div className={classNames(classes.main, classes.mainRaised)}>
                <div className={classes.container}>
                    <GridContainer>
                        <GridItem xs={12} sm={12} md={6}>
                            <h1 className={classes.title}>Politique de confidentialité</h1>
                            <h4>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.

                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                Fusce fringilla fringilla laoreet.
                                Nam tempor vel neque cursus porta.
                                Cras imperdiet elit diam, id facilisis elit interdum at.
                                Nunc ac libero pharetra, semper purus quis, varius quam.
                                Nam et lobortis magna. Suspendisse faucibus sagittis tristique.
                                In vehicula malesuada enim, non lacinia est tempor quis.
                            </h4>
                        </GridItem>
                    </GridContainer>
                </div>
            </div>
            <Footer/>
        </div>
    );
}
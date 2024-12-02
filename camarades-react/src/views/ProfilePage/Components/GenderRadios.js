import {InputLabel, makeStyles, Radio} from "@material-ui/core";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import {FiberManualRecord} from "@material-ui/icons";
import React from "react";
import styles from "assets/jss/material-kit-react/customCheckboxRadioSwitch.js";
import GridItem from "../../../components/Grid/GridItem";
const useStyles = makeStyles(styles);

export default function GenderRadios(props){
    const classes = useStyles();
    return (
        <div>
            <InputLabel >
                Genre
            </InputLabel>
            <GridItem xs={12} sm={12} md={12}>
            <FormControlLabel
                control={
                <Radio
                    checked={props.gender === "homme"}
                    onChange={() => props.handleChange("homme")}
                    value="homme"
                    name="Homme"
                    aria-label="Homme"
                    icon={
                        <FiberManualRecord
                            className={classes.radioUnchecked}
                        />
                    }
                    checkedIcon={
                        <FiberManualRecord className={classes.radioChecked} />
                    }
                    classes={{
                        checked: classes.radio
                    }}
                />
            }
            classes={{
                label: classes.label,
                    disabled: classes.disabledCheckboxAndRadio
            }}
            label="Homme"
                />
                <FormControlLabel
            control={
            <Radio
                checked={props.gender === "femme"}
                onChange={() => props.handleChange("femme")}
                value="femme"
                name="Femme"
                aria-label="Femme"
                icon={
                    <FiberManualRecord
                        className={classes.radioUnchecked}
                    />
                }
                checkedIcon={
                    <FiberManualRecord className={classes.radioChecked} />
                }
                classes={{
                    checked: classes.radio
                }}
            />
        }
            classes={{
                label: classes.label,
                    disabled: classes.disabledCheckboxAndRadio
            }}
            label="Femme"
                />
                </GridItem>
            <GridItem xs={12} sm={12} md={12}>
                <FormControlLabel
                    control={
                        <Radio
                            checked={props.gender === "autre"}
                            onChange={() => props.handleChange("autre")}
                            value="autre"
                            name="Autre"
                            aria-label="Autre"
                            icon={
                                <FiberManualRecord
                                    className={classes.radioUnchecked}
                                />
                            }
                            checkedIcon={
                                <FiberManualRecord className={classes.radioChecked} />
                            }
                            classes={{
                                checked: classes.radio
                            }}
                        />
                    }
                    classes={{
                        label: classes.label,
                        disabled: classes.disabledCheckboxAndRadio
                    }}
                    label="Autre"
                />
            </GridItem>
        </div>
    );
}
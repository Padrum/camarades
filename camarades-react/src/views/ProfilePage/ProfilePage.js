import React,{useState, useEffect} from "react";
import Datetime from "react-datetime";
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components
import { makeStyles } from "@material-ui/core/styles";
// @material-ui/icons
import Settings from "@material-ui/icons/Settings";
import Profile from "@material-ui/icons/Person";
// core components
import Header from "components/Header/Header.js";
import Footer from "components/Footer/Footer.js";
import Button from "components/CustomButtons/Button.js";
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import HeaderLinks from "components/Header/HeaderLinks.js";
import NavPills from "components/NavPills/NavPills.js";

import profile from "assets/img/faces/owen.jpg";

import styles from "assets/jss/camarades/views/profilePage.js";


import CustomInput from "../../components/CustomInput/CustomInput";
import {
    KeyboardDatePicker,
} from '@material-ui/pickers';
import moment from "moment";
import Axios from "axios";
import GenderRadios from "./Components/GenderRadios";
import {Check, Close, Warning} from "@material-ui/icons";
import Snackbar from "@material-ui/core/Snackbar";
import IconButton from "@material-ui/core/IconButton";
import SnackbarContent from "@material-ui/core/SnackbarContent";

const useStyles = makeStyles(styles);
Axios.defaults.withCredentials = true;


export default function ProfilePage(props) {
  const classes = useStyles();
  const { ...rest } = props;
  const imageClasses = classNames(
    classes.imgRaised,
    classes.imgRoundedCircle,
    classes.imgFluid
  );

  const [profileData, setProfileData] = useState({
        firstName: '',
        lastName: '',
        birthDate: new Date(),
        gender: '',
    });

    const [status, setStatus] = useState("");

  const [newEmailData, setNewEmailData] = useState({
    'email' : '',
    'actualPassword' : ''
  });

  const [notificationData, setNotificationData] = useState({
    isPresent: false,
      message: '',
      type: 'info',
      icon: 'info_outline'
  });



  const [newPasswordData, setNewPasswordData] = useState({
      newPassword: '',
      confirmPassword: '',
      oldPassword: ''
    });

  const notificationMessage = (message, type) => {
      let icon;
      switch(type){
          case 'success':
              icon = Check;
              break;
          case 'warning':
          case 'danger':
              icon = Warning;
              break;
          default:
              icon = 'info_outline'
      }
      console.debug(icon);


      return {
          message,
          type,
          icon,
          isPresent: true
      };
  };

   const handleNotificationClose = () => {
       setNotificationData({
           isPresent: false,
           message: '',
           type: 'info',
           icon: 'info_outline'
       });
   };

  useEffect(() => {
      Axios.get('http://localhost:4000/user/profile').then(response => {
         setNewEmailData({email: response.data.email});
         setStatus(response.data.status);
         setProfileData({
             firstName: response.data.firstName,
             lastName: response.data.lastName,
             birthDate: moment(response.data.birthDate),
             gender: response.data.gender,
         })
      }).catch(error => {
          console.error("Une erreur est survenue dans la récupération des données de cet utilisateur : " + error.message);
          setNotificationData(notificationMessage( 'Vos données ont été mises à jour !', 'success'));
      });
  }, []);

  const handleProfileSubmit = () => {
      Axios.post('http://localhost:4000/user/profile', profileData).then(response => {
        if(response.data.success && response.data.rowsUpdated > 0){
            console.debug('Les données du profil ont été mises à jour');
            setNotificationData(notificationMessage( 'Vos données ont été mises à jour !', 'success'));
        }
        else{
            console.warning('Une erreur est survenue lors de la mise à jour du profil');
            setNotificationData(notificationMessage(response.data.error, 'warning'));
        }
      }).catch(err=>{
          console.error(err.message);
          setNotificationData(notificationMessage('Une erreur est survenue pendant la mise à jour de votre profil', 'danger'));
      });
  };

  //Gestion des composants "CustomInput" pour la partie profil
  const handleProfileDataChange = name => event => {
    setProfileData({...profileData, [name]: event.target.value});
  };

  const handleGenderChange = value => {
      setProfileData({...profileData, gender: value});
  };

  const handleBirthDateChange = value => {
      setProfileData({...profileData, birthDate: value});
  };

  const handleNewEmailData = name => event => {
      setNewEmailData({...newEmailData, [name]: event.target.value});
  };

  const handleEmailSubmit = event => {
      Axios.post('http://localhost:4000/authentication/email', newEmailData).then(response => {
          if(response.data.success && response.data.rowsUpdated > 0){
              console.log("L'adresse email a été mise à jour");
              setNewEmailData({
                 ...newEmailData,
                  actualPassword: ''
              });
              setNotificationData(notificationMessage('Votre adresse email a été mise à jour', 'success'));
          }
          else{
              console.warn("Une erreur est survenue lors de la mise à jour de l'adresse email");
              setNotificationData(notificationMessage(response.data.error, 'warning'));
          }
      }).catch(err=>{
          console.error(err.message);
          setNotificationData(notificationMessage('Une erreur est survenue lors de la mise à jour de votre adresse email', 'danger'));
      });
  };

  const handleNewPasswordDataChange = name => event => {
      setNewPasswordData({...newPasswordData, [name]: event.target.value});
  };

    const handleNewPasswordSubmit = event => {
        Axios.post('http://localhost:4000/authentication/change-password', newPasswordData).then(response => {
            if(response.data.success && response.data.rowsUpdated > 0){
                console.debug("Le mot de passe a été changé");
                //On vide les champ mot de passes (actuel, nouveau et confirmation)
                setNewPasswordData({
                    newPassword: '',
                    confirmPassword: '',
                    oldPassword: ''
                });
                setNotificationData(notificationMessage('Votre mot de passe a bien été changé', 'success'));
            }
            else{
                console.warn("Une erreur est survenue lors de la mise à jour du mot de passe");
                setNotificationData(notificationMessage(response.data.error, 'warning'));
            }
        }).catch(err=>{
            console.error(err.message);
        });
    };



  return (
    <div>
        <Header
            color="white"
            brand="Camarades"
            rightLinks={<HeaderLinks />}
            fixed
            {...rest}
        />
      <div className={classNames(classes.main, classes.mainRaised)}>
          <Snackbar
              open={notificationData.isPresent}
              autoHideDuration={6000}
              onClose={handleNotificationClose}
          >
              <SnackbarContent
                  message={
                      <span>
                        {notificationData.message}
                      </span>
                  }
                 icon={notificationData.icon}
                 variant={notificationData.type}
                  action={[
                      <IconButton key="close" aria-label="close" color="inherit" onClick={handleNotificationClose}>
                          <Close className={{fontSize: 20}} />
                      </IconButton>,
                  ]}
              />
          </Snackbar>
        <div>
          <div className={classes.container}>
            <GridContainer justify="center">
              <GridItem xs={12} sm={12} md={6}>
                <div className={classes.profile}>
                  <div>
                    <img src={profile} alt="Image de profil de Owen SESSIECQ" className={imageClasses} />
                  </div>
                  <div className={classes.name}>
                    <h3 className={classes.title}>{profileData.firstName} {profileData.lastName}</h3>
                    <h6>{status}</h6>
                  </div>
                </div>
              </GridItem>
            </GridContainer>
            <div className={classes.description}>
              <p>
                Description de l'utilisateur
              </p>
            </div>
                <NavPills
                    color="primary"
                    tabs={[
                        {
                            tabIcon: Profile,
                            tabButton: "Profil",
                            tabContent: (
                                <div className={classes.container}>
                                    <h3>Changement de vos informations personnelles</h3>
                                    <GridContainer >
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Prénom"
                                                id="first_name"
                                                inputProps={{
                                                    value: profileData.firstName,
                                                    onChange: handleProfileDataChange('firstName')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true
                                                }}

                                            />
                                        </GridItem>
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Nom"
                                                id="last_name"
                                                inputProps={{
                                                    value: profileData.lastName,
                                                    onChange: handleProfileDataChange('lastName')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true
                                                }}
                                            />
                                        </GridItem>

                                        <GridItem xs={12} sm={12} md={6}>
                                            <KeyboardDatePicker
                                                format="DD/MM/YYYY"
                                                margin="normal"
                                                label="Date de naissance"
                                                value={profileData.birthDate}
                                                onChange={handleBirthDateChange}
                                                KeyboardButtonProps={{
                                                    'aria-label': 'change date',
                                                }}
                                            />
                                        </GridItem>

                                        <GridItem xs={12} sm={12} md={6}>
                                            <GenderRadios gender={profileData.gender} handleChange={handleGenderChange}/>
                                        </GridItem>
                                    </GridContainer>
                                    <Button type="button" color="primary" onClick={handleProfileSubmit} >Enregistrer</Button>
                                </div>
                            )
                        },
                        {
                            tabIcon: Settings,
                            tabButton: "Paramètres",
                            tabContent: (
                                <div className={classes.container}>
                                    <h3>Changement de votre adresse email</h3>
                                    <GridContainer justify="center">
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Adresse email"
                                                id="email"
                                                inputProps={{
                                                    value: newEmailData.email,
                                                    onChange: handleNewEmailData('email')
                                                }}

                                                formControlProps={{
                                                    fullWidth: true
                                                }}
                                            />
                                        </GridItem>
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Mot de passe actuel"
                                                id="password"
                                                inputProps={{
                                                    value: newEmailData.actualPassword,
                                                    type: "password",
                                                    onChange: handleNewEmailData('actualPassword')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true,
                                                }}
                                            />
                                        </GridItem>
                                    </GridContainer>
                                    <Button id="save_email_btn" type="button" color="primary" onClick={handleEmailSubmit}>Enregistrer</Button>
                                    <h3>Changement de votre mot de passe</h3>
                                    <GridContainer >
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Mot de passe actuel"
                                                id="old_password"
                                                inputProps={{
                                                    value: newPasswordData.oldPassword,
                                                    type: "password",
                                                    onChange: handleNewPasswordDataChange('oldPassword')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true
                                                }}
                                            />
                                        </GridItem>
                                    </GridContainer>
                                    <GridContainer>
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Nouveau mot de passe"
                                                id="new_password"
                                                inputProps={{
                                                    value: newPasswordData.newPassword,
                                                    type: "password",
                                                    onChange: handleNewPasswordDataChange('newPassword')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true
                                                }}
                                            />
                                        </GridItem>
                                        <GridItem xs={12} sm={12} md={6}>
                                            <CustomInput
                                                labelText="Confirmation mot de passe"
                                                id="confirm_password"
                                                inputProps={{
                                                    value: newPasswordData.confirmPassword,
                                                    type: "password",
                                                    onChange: handleNewPasswordDataChange('confirmPassword')
                                                }}
                                                formControlProps={{
                                                    fullWidth: true
                                                }}
                                            />
                                        </GridItem>

                                    </GridContainer>
                                    <Button id="save_new_password_btn" type="button" color="primary" onClick={handleNewPasswordSubmit}>Enregistrer</Button>
                                </div>
                            )
                        },
                    ]}
                />

          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
}

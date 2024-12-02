/**
 * Enumérateur contenant les différents rôles
 * Correspond aux même valeurs que l'énumérateur Users.role en base de données
 * @type {{School: string, User: string, Admin: string}}
 */
module.exports = {
  Admin: 'admin', //Administrateur
  User: 'user', //Utilisateur
  School: 'school' //École
};
enum Status {
  etudiant,
  professeur,
  professionnel,
  non_actif,
}

String getStatusNameOf(Status statut) {
  switch (statut) {
    case Status.etudiant:
      return "Etudiant";
    case Status.professeur:
      return "Professeur";
    case Status.professionnel:
      return "Professionnel";
    case Status.non_actif:
      return "Non actif";
    default:
      return null;
  }
}

enum Gender {
  homme,
  femme,
  humain,
}

String getGenderNameOf(Gender g) {
  if (g == Gender.homme)
    return "Homme";
  else if (g == Gender.femme)
    return "Femme";
  else
    return "Transgenre";
}

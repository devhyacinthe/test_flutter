class AppRouteName {
  AppRouteName._();

  static const String addUser = 'add';
  static const String search = 'search';
  static const String home = 'home';
}

class AppText {
  AppText._();

  static const String nameTextFieldLabel = "Nom & Prénom(s)";
  static const String emailTextFieldLabel = "Email";
  static const String streetTextFieldLabel = "Rue";
  static const String cityTextFieldLabel = "Ville";

  static const String onBoardingDescription =
      "Application utilisant l'API Random user pour afficher des utilisateurs aléatoire";

  static const String onBoardingTitle = 'Random user';
  static const String deleteDialogDescription =
      'Vous allez supprimer cet utilisateur, voulez vous continuez?';
  static const String quitDialogDescription =
      "Voulez-vous quitter l'application?";
}

class NetworkFailureMessage {
  static const getRequestMessage = "GET REQUEST FAILED";
  static const postRequestMessage = "POST REQUEST FAILED";
  static const putRequestMessage = "PUT REQUEST FAILED";
  static const deleteRequestMessage = "DELETE REQUEST FAILED";

  static const jsonParsingFailed = "FAILED TO PARSE JSON RESPONSE";
}

class LogLabel {
  static const auth = "AUTH";
  static const httpGet = "HTTP/GET";
  static const httpPost = "HTTP/POST";
  static const httpPut = "HTTP/PUT";
  static const httpDelete = "HTTP/DELETE";
}

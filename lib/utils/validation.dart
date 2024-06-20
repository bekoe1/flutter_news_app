abstract class Validation {
  static String? ValidateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Введите данные";
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern);

      if (!regex.hasMatch(email)) {
        return "Некорректный email";
      }

      return null;
    }
  }

  static String? ValidateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "Введите данные";
    } else {
      String pattern = r'^[a-zA-Z]{4,}\d*$';
      RegExp regEx = RegExp(pattern);
      if (!regEx.hasMatch(username)) {
        return "Некорректное имя пользователя";
      }
    }
  }

  static String? ValidateNumber(String? number) {
    if (number == null || number.isEmpty) {
      return "Введитее данные";
    } else {
      String pattern =
          r"^(?:\+7|8)\s?\(?\d{3}\)?[\s-]?\d{3}[\s-]?\d{2}[\s-]?\d{2}$";
      RegExp regEx = RegExp(pattern);
      if (!regEx.hasMatch(number)) {
        return "Некорректный номер";
      }

      return null;
    }
  }

  static String? ValidatePass(String? password) {
    if (password == null || password.isEmpty) {
      return "Введите данные";
    } else {
      //TODO null check
      // RegExp passwordRegExp = new RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-=[\]{};:.<>?]).{6,}$');
      // if(!passwordRegExp.hasMatch(password)){
      //   return "Некорректный пароль";
      // }

      RegExp onlyCapsLetters = new RegExp(r'[A-Z]+');
      if (!onlyCapsLetters.hasMatch(password)) {
        return "Пароль должен содержать хотя бы одну заглавную букву";
      }

      RegExp onlyNumber = new RegExp(r'[\d+]');
      if (!onlyNumber.hasMatch(password)) {
        return "Пароль должен содержать хотя хотя бы одну цифру";
      }

      RegExp onlySymbols = new RegExp(r'[^\w\s]');
      if (!onlySymbols.hasMatch(password)) {
        return "Пароль должен содержать хотя хотя бы один символ";
      }

      RegExp moreThanSix = new RegExp(r'.{6,}');
      if (!moreThanSix.hasMatch(password)) {
        return "Пароль слишком короткий";
      }

      return null;
    }
  }
}

Map<String, String> kDHeader({String token}) => {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": token,
    };

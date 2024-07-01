enum UserRole {
  retailor,
  manufacturer,
}

Map<UserRole, String> userRoleMap = {
  UserRole.retailor: "Retailer",
  UserRole.manufacturer: "Manufacturer",
};

UserRole? userRoleFromString(String? role) {
  if (role == "Retailer") {
    return UserRole.retailor;
  } else if (role == "Manufacturer") {
    return UserRole.manufacturer;
  } else {
    return null; // or throw an error, or handle it as needed
  }
}
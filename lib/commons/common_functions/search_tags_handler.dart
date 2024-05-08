Map<String, dynamic> userSearchTagsHandler({
  required String name,
  required String email,
}) {
  Map<String, dynamic>? searchTags = <String, bool>{};
  if (name != '') {
    name.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  if (email != "") {
    email.trim().split(' ').forEach((val) {
      searchTags[val.toLowerCase()] = true;
    });
  }

  return searchTags;
}

Map<String, dynamic> vesselSearchTags({
  required String name,
  required String shipperName,
  required String unlcode,
}) {
  Map<String, dynamic> searchTags = {};

  // Function to generate all permutations of a string
  List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }

  if (name.isNotEmpty) {
    name.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (shipperName.isNotEmpty) {
    shipperName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  if (unlcode.isNotEmpty) {
    unlcode.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}

//
// Map<String, dynamic> choferesSearchTagsHandler({
//   required String firstName,
//   required String lastName,
//   required String choferNationalId,
//
// }) {
//   Map<String, dynamic>? searchTags = <String, bool>{};
//   if(firstName != ''){
//     firstName.trim().split(' ').forEach((val) {
//       searchTags[val.toLowerCase()] = true;
//     });
//   }
//
//   if(choferNationalId != ""){
//     choferNationalId.trim().split(' ').forEach((val) {
//       searchTags[val.toLowerCase()] = true;
//     });
//   }
//
//
//   return searchTags;
// }

Map<String, dynamic> choferesSearchTagsHandler({
  required String firstName,
  required String lastName,
  required String choferNationalId,
}) {
  Map<String, dynamic> searchTags = {};

  // Function to generate all permutations of a string
  List<String> generatePermutations(String str) {
    List<String> permutations = [];
    for (int i = 0; i < str.length; i++) {
      for (int j = i + 1; j <= str.length; j++) {
        permutations.add(str.substring(i, j).toLowerCase());
      }
    }
    return permutations;
  }

  // Add all permutations of the first name to search tags
  if (firstName.isNotEmpty) {
    firstName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  // Add all permutations of the last name to search tags
  if (lastName.isNotEmpty) {
    lastName.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  // Add all permutations of the national ID to search tags
  if (choferNationalId.isNotEmpty) {
    choferNationalId.trim().split(' ').forEach((val) {
      generatePermutations(val).forEach((perm) {
        searchTags[perm] = true;
      });
    });
  }

  return searchTags;
}

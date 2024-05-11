import '../../models/viajes_models/viajes_model.dart';

List<ViajesModel> sortByEntryTimeToPortDescending(List<ViajesModel> viajesList) {
  // Sort the list based on entryTimeToPort in descending order (latest first)
  viajesList.sort((a, b) => b.entryTimeToPort.compareTo(a.entryTimeToPort));
  return viajesList;
}
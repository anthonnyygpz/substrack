const Map<int, String> dayIn = {
  1: "Dia",
  7: "Semana",
  15: "Quinsena",
  30: "Mes",
  365: "Año",
  730: "2 años",
};

String formatDay(int days) {
  return dayIn[days] ?? "$days dias";
}

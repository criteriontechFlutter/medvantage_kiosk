class MedicineReminderDataModal {
  int? id;
  int? isReminder;
  int? medicineId;
  String? medicineName;
  String? dosageFormName;
  String? strength;
  String? unitName;
  String? frequencyName;
  int? durationInDays;

  MedicineReminderDataModal({
    this.id,
    this.isReminder,
    this.medicineId,
    this.medicineName,
    this.dosageFormName,
    this.strength,
    this.unitName,
    this.frequencyName,
    this.durationInDays,
  });

  factory MedicineReminderDataModal.fromJson(Map<String, dynamic> json) =>
      MedicineReminderDataModal(
        id: json['id'],
        isReminder: json['isReminder'],
        medicineId: json['medicineId'],
        medicineName: json['medicineName'],
        dosageFormName: json['dosageFormName'],
        strength: json['strength'],
        unitName: json['unitName'],
        frequencyName: json['frequencyName'],
        durationInDays: json['durationInDays'],
      );
}

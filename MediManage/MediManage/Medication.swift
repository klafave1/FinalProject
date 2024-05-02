import Foundation

enum MedicationFrequency: String, Codable {
    case daily
    case weekly
    case justOnce
}

enum DayOfWeek: Int, CaseIterable, Codable {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}

class Medication: Codable {
    var name: String
    var dosage: String
    var timeOfDay: Date
    var frequency: MedicationFrequency
    var selectedDaysOfWeek: [DayOfWeek]

    init(name: String, dosage: String, timeOfDay: Date, frequency: MedicationFrequency, selectedDaysOfWeek: [DayOfWeek]) {
        self.name = name
        self.dosage = dosage
        self.timeOfDay = timeOfDay
        self.frequency = frequency
        self.selectedDaysOfWeek = selectedDaysOfWeek
    }

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case name, dosage, timeOfDay, frequency, selectedDaysOfWeek
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        dosage = try container.decode(String.self, forKey: .dosage)
        timeOfDay = try container.decode(Date.self, forKey: .timeOfDay)
        frequency = try container.decode(MedicationFrequency.self, forKey: .frequency)
        selectedDaysOfWeek = try container.decode([DayOfWeek].self, forKey: .selectedDaysOfWeek)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(dosage, forKey: .dosage)
        try container.encode(timeOfDay, forKey: .timeOfDay)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(selectedDaysOfWeek, forKey: .selectedDaysOfWeek)
    }
}

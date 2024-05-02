import UIKit

protocol EditMedicationDelegate: AnyObject {
    func didEditMedication(_ medication: Medication)
}
class EditMedicationViewController: UIViewController {
    weak var delegate: EditMedicationDelegate?
    var medication: Medication?

    private let nameTextField = UITextField()
    private let dosageTextField = UITextField()
    private let timePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Medication"
        
        addGradientBackground()
        
        setupTextFields()
        setupTimePicker()
        setupSaveButton()
    }

    private func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupTextFields() {
        guard let medication = medication else { return }

        nameTextField.placeholder = "Medication Name"
        nameTextField.text = medication.name
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .black 
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)

        dosageTextField.placeholder = "Dosage"
        dosageTextField.text = medication.dosage
        dosageTextField.borderStyle = .roundedRect
        dosageTextField.textColor = .black
        dosageTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dosageTextField)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            dosageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dosageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dosageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dosageTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupTimePicker() {
        guard let medication = medication else { return }

        timePicker.datePickerMode = .dateAndTime
        timePicker.preferredDatePickerStyle = .compact
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        timePicker.date = medication.timeOfDay ?? Date()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker)

        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: dosageTextField.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: dosageTextField.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: dosageTextField.trailingAnchor)
        ])
    }

    private func setupSaveButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveMedication))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func saveMedication() {
        guard let name = nameTextField.text, !name.isEmpty,
              let dosage = dosageTextField.text, !dosage.isEmpty else { return }

        medication?.name = name
        medication?.dosage = dosage
        medication?.timeOfDay = timePicker.date

        delegate?.didEditMedication(medication!)
        navigationController?.popViewController(animated: true)
    }
}


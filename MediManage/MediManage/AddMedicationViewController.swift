import UIKit

protocol AddMedicationDelegate: AnyObject {
    func didAddMedication(_ medication: Medication)
}

class AddMedicationViewController: UIViewController {
    weak var delegate: AddMedicationDelegate?
    
    private let nameTextField = UITextField()
    private let dosageTextField = UITextField()
    private let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Medication"
        addGradientBackground()
        
        setupTextFields()
        setupTimePicker()
        setupSaveButton()
    }
    
    private func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupTextFields() {
        nameTextField.placeholder = "Medication Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .black
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        dosageTextField.placeholder = "Dosage"
        dosageTextField.borderStyle = .roundedRect
        dosageTextField.textColor = .black
        view.addSubview(dosageTextField)
        dosageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dosageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dosageTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            dosageTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            dosageTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTimePicker() {
        timePicker.datePickerMode = .dateAndTime
        timePicker.preferredDatePickerStyle = .compact
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        view.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
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
              let dosage = dosageTextField.text, !dosage.isEmpty else {
            // Show alert for invalid input
            let alertController = UIAlertController(title: "Error", message: "Please enter medication name and dosage", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let startDate = timePicker.date
        
        let medication = Medication(name: name, dosage: dosage, timeOfDay: startDate, frequency: .daily, selectedDaysOfWeek: DayOfWeek.allCases)
        
        delegate?.didAddMedication(medication)
        navigationController?.popViewController(animated: true)
    }
}


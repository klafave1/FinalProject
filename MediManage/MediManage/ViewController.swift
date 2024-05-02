import UIKit

class ViewController: UIViewController, CalendarViewDelegate, MedicationListViewControllerDelegate {
    func didSelectMedication(_ medication: Medication) {
    }
    
    private let calendarView = CalendarView()
    private var currentDate: Date?
    private var medicationListViewController: MedicationListViewController?
    

    private var eventDates: Set<Date> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MediCal"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Calendar", style: .plain, target: nil, action: nil)
        
        setupNavigationBar()
        setupCalendarView()
        showMedicationList(for: Date())
        setupEventDates()
        
        setGradientBackground(colors: [UIColor.systemPink.cgColor, UIColor.systemTeal.cgColor], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(toggleView))
    }
    
    private func setupCalendarView() {
        calendarView.delegate = self
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        calendarView.eventDates = eventDates
    }
    
    private func setupEventDates() {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        eventDates = [today, tomorrow, nextWeek]
        
        calendarView.eventDates = eventDates
    }

    func didSelectDate(_ date: Date) {
        self.currentDate = date
        showMedicationList(for: date)
    }

    private func showMedicationList(for date: Date) {
        medicationListViewController = MedicationListViewController()
        medicationListViewController?.selectedDate = date
        medicationListViewController?.delegate = self
        if let medicationListViewController = medicationListViewController {
            navigationController?.pushViewController(medicationListViewController, animated: true)
        }
    }

    @objc private func toggleView() {
        if navigationController?.topViewController is MedicationListViewController {
            navigationItem.rightBarButtonItem?.title = "Calendar"
            navigationItem.title = "MediManage"
            navigationController?.popViewController(animated: true)
        } else {
            navigationItem.rightBarButtonItem?.title = "Medication List"
            navigationItem.title = "MediManage"
            showMedicationList(for: Date())
        }
    }

    func didEditMedication() {
        if let date = currentDate {
            calendarView.reloadData()
        }
    }

    private func setGradientBackground(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = view.bounds
        
        if let existingGradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingGradientLayer.removeFromSuperlayer()
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// Sources:
// https://developer.apple.com/documentation/uikit
// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/

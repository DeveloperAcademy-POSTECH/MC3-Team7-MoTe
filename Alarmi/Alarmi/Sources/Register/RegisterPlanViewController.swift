//
//  SettingPlanViewController.swift
//  Alarmi
//
//  Created by 임 용관 on 2022/07/18.
//  Copyright © 2022 MoTe. All rights reserved.
//

import UIKit
import CoreData

protocol RegisterPlanViewControllerDelegate: AnyObject {
    func gotoRegisterNotifyViewController()
}

protocol MainTabRegisterPlanViewControllerDelegate: AnyObject {
    func gotoBack()
}

final class RegisterPlanViewController: UIViewController {
    
    @IBOutlet private var startDatePicker: UIDatePicker!
    @IBOutlet private var containerViews: [UIView]!
    @IBOutlet private var settingDayLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var settingDayStepper: UIStepper!
    
    private lazy var callTimePeriod = 7 {
        didSet {
            settingDayLabel.text = String(callTimePeriod) + "일에 한 번"
        }
    }
    
    private let encoder = JSONEncoder()
    private var goal = Goal(startDate: Date(), period: 7)
    
    private lazy var button: AMButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.title = "다음"
        $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return $0
    }(AMButton())
    
    weak var delegate: RegisterPlanViewControllerDelegate?
    weak var tabDelegate: MainTabRegisterPlanViewControllerDelegate?
    
    enum ButtonType: String {
        case register = "다음"
        case setting = "수정하기"
    }
    
    var type: ButtonType = .register {
        didSet {
            button.setTitle(type.rawValue, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        containerViews.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        startDatePicker.minimumDate = Date()
        settingDayStepper.value = Double(callTimePeriod)
    }
    
    private func layout() {
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction private func settingDayStepper(_ sender: UIStepper) {
        let value = sender.value
        callTimePeriod = Int(value)
        goal.period = callTimePeriod
    }
    
    @IBAction private func settingStartDatePicker(_ sender: UIDatePicker) {
        goal.startDate = sender.date
    }
    
    var coreDataList = [CoreDataDate]()
    
    func fetch() -> [NSManagedObject] {
            // 앱 델리게이트 객체 참조
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // 관리 객체 컨텍스트 참조
            let context = appDelegate.persistentContainer.viewContext
            // 요청 객체 생성
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataDate")
            // 데이터 가져오기
            let result = try? context.fetch(fetchRequest)
        return result!
        }
    
    lazy var list: [NSManagedObject] = {
            return self.fetch()
        }()
    
    @IBAction func saveAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataDate")
        let object = NSEntityDescription.insertNewObject(forEntityName: "CoreDataDate", into: context)
        object.setValue(Date(), forKey: "callDate")
//        let entity = NSEntityDescription.entity(forEntityName: "CoreDataDate", in: context)
        
        print(context)
        print(request)
        print(object)
        
        do {
            try context.save()
            self.list.append(object)
//            self.coreDataList.append(contentsOf: object)
            return
        } catch {
            context.rollback()
            return
        }
        
//        print(entity)
    }
    
    func delete(object: NSManagedObject) -> Bool {
            // 앱 델리게이트 객체 참조
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // 관리 객체 컨텍스트 참조
            let context = appDelegate.persistentContainer.viewContext
            // 컨텍스트로부터 해당 객체 삭제
            context.delete(object)
            
            // 영구 저장소에 커밋
            do {
                try context.save()
                return true
            } catch {
                context.rollback()
                return false
            }
        }
}

extension RegisterPlanViewController {
    @objc private func buttonDidTap() {
        switch type {
        case .register:
            delegate?.gotoRegisterNotifyViewController()
        case .setting:
            tabDelegate?.gotoBack()
        }
        
        if let encoded = try? encoder.encode(goal) {
            UserDefaults.standard.setValue(encoded, forKey: "Goal")
        }
    }
}

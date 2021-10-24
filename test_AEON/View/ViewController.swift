//
//  ViewController.swift
//  test_AEON
//
//  Created by Andrey on 20.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let service = Service()
    
    var payments = [Payments]()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Payments"
        configureTableView()
        loadContent()
        addBurButton()
        
    }
    
    func addBurButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutAction))
    }
    
    @objc func logOutAction() {
        UserDefaults.standard.removeObject(forKey: "token")
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view)
        tableView.rowHeight = 200
        setTableViewDelegates()
        tableView.register(PaymentCell.self, forCellReuseIdentifier: "PaymentCell")
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadContent() {
        service.getRequest { payments in
            self.payments = payments
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell") as! PaymentCell
        let payment = payments[indexPath.row]
        cell.set(payment: payment)
        
        return cell
    }
    
    
}


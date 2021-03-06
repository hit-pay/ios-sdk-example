//
//  ViewController.swift
//  HitPay-iOS-SDK
//
//  Created by 1bannamgiauten on 07/24/2021.
//  Copyright (c) 2021 1bannamgiauten. All rights reserved.
//

import UIKit
import HitPay_iOS_SDK

class ViewController: UIViewController {

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var qrImageView: UIImageView!
  @IBOutlet weak var qrImageSwitch: UISwitch!
  @IBOutlet weak var cancelSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.stopLoading()
  }

  private func startLoading() {
    self.activityIndicator.superview?.isHidden = false
    self.activityIndicator.startAnimating()
  }

  private func stopLoading() {
    self.activityIndicator.stopAnimating()
    self.activityIndicator.superview?.isHidden = true
  }

  private func alert(title: String, text: String) {
    let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func loginButtonPressed(_ sender: Any) {
    HitPay.shared.initiateAuthentication(from: self) { [weak self] in
      self?.alert(title: "Done", text: "initiateAuthentication")
    }
  }

  @IBAction func terminalButtonPressed(_ sender: Any) {
    HitPay.shared.initiateTerminalSetup(from: self) { [weak self] in
      self?.alert(title: "Done", text: "initiateTerminalSetup")
    }
  }

  @IBAction func terminalPaymentPressed(_ sender: Any) {
    let alert = UIAlertController(title: "Amount", message: "Enter amount:", preferredStyle: .alert)
    var textField: UITextField?
    alert.addTextField(configurationHandler: { textField = $0 })
    alert.addAction(UIAlertAction(title: "Pay", style: .default, handler: { [weak self] _ in
      let amount = Double(textField?.text ?? "2") ?? 2
      self?.startLoading()
      HitPay.shared.makeTerminalPayment(amount: amount, currency: "sgd") { success, error in
        self?.stopLoading()
        if success {
          UIPasteboard.general.string = error ?? ""
          self?.alert(title: "Success: \(success)", text: "charge_id: \(error ?? ""). Copied to clipboard")
        } else {
          self?.alert(title: "Error:", text: error ?? "")
        }
      }
      if self?.cancelSwitch.isOn == true {
        // Simulate cancel terminal payment after 1s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          HitPay.shared.cancelTerminalPayment { success, error in
            if success {
              self?.alert(title: "[cancelTerminalPayment] Success: \(success)", text: "\(error ?? "")")
            } else {
              self?.alert(title: "[cancelTerminalPayment] Error:", text: error ?? "")
            }
          }
        }
      }
    }))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func paynowButtonPressed(_ sender: Any) {
    let generateQrImage = self.qrImageSwitch.isOn
    let alert = UIAlertController(title: "Amount", message: "Enter amount:", preferredStyle: .alert)
    var textField: UITextField?
    alert.addTextField(configurationHandler: { textField = $0 })
    alert.addAction(UIAlertAction(title: "Pay", style: .default, handler: { [weak self] _ in
      let amount = Double(textField?.text ?? "2") ?? 2
      self?.startLoading()
      HitPay.shared.makePayNowPayment(amount: amount, currency: "sgd", generateImage: generateQrImage) { qrCode, qrImage, success, error in
        if let qrCode = qrCode, success == false && error == nil {
          if let qrImage = qrImage {
            self?.qrImageView.image = qrImage
            self?.qrImageView.isHidden = false
          } else {
            self?.alert(title: "QR CODE", text: qrCode)
          }
        } else if success {
          self?.qrImageView.isHidden = true
          self?.stopLoading()
          self?.alert(title: "Success: \(success)", text: "")
        } else if let error = error {
          self?.qrImageView.isHidden = true
          self?.stopLoading()
          self?.alert(title: "Error", text: error)
        }
      }
    }))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func refundButtonPressed(_ sender: Any) {
    let alert = UIAlertController(title: "Refund", message: "Enter charge_id:", preferredStyle: .alert)
    var textField: UITextField?
    alert.addTextField(configurationHandler: { textField = $0 })
    alert.addAction(UIAlertAction(title: "Refund", style: .default, handler: { [weak self] _ in
      let charge_id = textField?.text ?? ""
      self?.startLoading()
      HitPay.shared.refundCharge(charge_id: charge_id) { success, error in
        self?.stopLoading()
        if success {
          self?.alert(title: "Success: \(success)", text: "")
        } else {
          self?.alert(title: "Error:", text: error ?? "")
        }
      }
    }))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func logoutButtonPressed(_ sender: Any) {
    HitPay.shared.signOut()
    self.alert(title: "Sign Out", text: "Success")
  }
  
}


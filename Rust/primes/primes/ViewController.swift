//
//  ViewController.swift
//  primes
//
//  Created by Guillermo Lella on 1/28/21.
//

import UIKit
import Goprimes

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var threadsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Actions
    @IBAction func startRustSingleThread(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = CInt(text) ?? 1
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = rust_1_thread(num)
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: Int(result), start: start, end: end)
    }
    
    @IBAction func startRustMultipleThreads(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = CInt(text) ?? 1
        let threads = CInt(stepper.value)
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = rust_n_threads(num, threads)
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: Int(result), start: start, end: end)
    }
    
    @IBAction func startSwift_1Thread(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = swift_1_Thread(limit: num)
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: result, start: start, end: end)
    }
    
    @IBAction func startSwiftMultipleThreads(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let threads = Int(stepper.value)
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = swift_n_threads(limit: num, threads: threads)
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: result, start: start, end: end)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        threadsLabel.text = Int(sender.value).description
    }
    
    @IBAction func startCSingleThread(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = c_1_Thread(Int32(num))
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: Int(result), start: start, end: end)
    }
    
    @IBAction func startsCppSingleThread(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = cpp_1_Thread(Int32(num))
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: Int(result), start: start, end: end)
    }
    
    @IBAction func startsObjCSingleThread(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = objC_1_Thread(Int32(num))
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: Int(result), start: start, end: end)
    }
    
    @IBAction func startGoMultipleThreads(_ sender: UIButton) {
        let text = textField.text ?? ""
        let num = Int(text) ?? 1
        let threads = Int(stepper.value)
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        let result = GoprimesGoNThreads(num, threads)
        let end = DispatchTime.now()   // <<<<<<<<<<   End time
        displayResults(result: result, start: start, end: end)
    }
    
    func displayResults(result: Int, start: DispatchTime, end: DispatchTime) {
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        resultLabel.text = "\(result)"
        timeLabel.text = String(format: "%.3f", timeInterval)
    }
    
}


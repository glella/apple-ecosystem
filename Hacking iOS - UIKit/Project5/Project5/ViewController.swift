//
//  ViewController.swift
//  Project5
//
//  Created by Guillermo Lella on 9/5/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // try? means "call this code, and if it throws an error just send me back nil instead."
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This one and the one below does seem to work exacty the same
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Word")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    @objc func promptForAnswer () {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        // weak - self (the current view controller) and ac (our UIAlertController) to be captured as weak references inside the closure
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            // view controller method - that's why we captured self AND
            // every call to a method or property of the current view controller must prefixed with "self?.”
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        //let errorTitle: String
        //let errorMessage: String
        
        if title?.lowercased() == lowerAnswer {
            showErrorMessage(errTitle: "Same as original word", errMessage: "Cannot use the same word as the original")
            return
        }
        
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    //return
                } else {
                    showErrorMessage(errTitle: "Word not recognised", errMessage: "You can't just make them up")
                }
            } else {
                showErrorMessage(errTitle: "Word used already", errMessage: "Be more original")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errTitle: "Word not possible", errMessage: "You can't spell that word from \(title)")
        }
        
    }
     

    
    /// Shows error alert - cmd + option + / before function =>  autogenerates its docs
    /// - Parameters:
    ///   - errTitle: Title of the alert
    ///   - errMessage: message of the alert
    func showErrorMessage(errTitle: String, errMessage: String) {
        let ac = UIAlertController(title: errTitle, message: errMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    // is the word possible, is it original, and is it real?
    
    func isPossible(word: String) -> Bool {
        //if it exists, where? firstIndex(of:) - so we can remove it and keep checking in a loop
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                 return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) // not using return keyword is the same in this case
    }
    
    // spell checker!!! - Awesome but convoluted! Who would THINK of using "rangeOfMisspelledWord" without reading the docs?
    func isReal(word: String) -> Bool {
        // no snawers shorter than 3 letters
        if word.utf16.count < 3 {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count) // Wow! Confusing usage of utf16
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
        /*
        The answer is an annoying backwards compatibility quirk: Swift’s strings natively store international characters as individual
         characters, e.g. the letter “é” is stored as precisely that. However, UIKit was written in Objective-C before Swift’s strings came along, and it uses a different character system called UTF-16 – short for 16-bit Unicode Transformation Format –
        where the accent and the letter are stored separately.
        It’s a subtle difference, and often it isn’t a difference at all, but it’s becoming increasingly problematic because of the rise of emoji. Emoji are actually just special character combinations behind the scenes, and they are measured differently with Swift strings and UTF-16 strings: Swift strings count them as 1- letter strings, but UTF-16 considers them to be 2-letter strings. This means if you use count with UIKit methods, you run the risk of miscounting the string length.
        I realize this seems like pointless additional complexity, so let me try to give you a simple rule: when you’re working with UIKit, SpriteKit, or any other Apple framework, use utf16.count for the character count. If it’s just your own code - i.e. looping over characters and processing each one individually – then use count instead.
         */
    }

}


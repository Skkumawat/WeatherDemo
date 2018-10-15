//
//  HelpVC.swift
//  WeatherDemo
//
//  Created by Sharvan  Kumawat on 10/12/18.
//  Copyright © 2018 Sharvan. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    static func storyboardInstance() -> HelpVC {
        return Storyboard.kMainStoryboard.instantiateViewController(withIdentifier: HelpVC.stringRepresentation) as! HelpVC
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = ScreenTitle.help.rawValue
        
        loadRequest()
        // Do any additional setup after loading the view.
    }
    /**
     Creates a method for load url in the webview.
     
     - Parameter recipient: URL
     
     - Throws: If internet not working then getting error of network connectivity
     
     - Returns:
     */
    func loadRequest()  {
        
        let url = NSURL (string: helpURL)
        let request = URLRequest(url: url! as URL)
        self.webView.loadRequest(request)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HelpVC: UIWebViewDelegate {
     // MARK: - UIWebiew delegate method
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        Utility.ShowProgressHud(onView: self.view)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        Utility.HideProgressHud(onView: self.view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        Utility.HideProgressHud(onView: self.view)
    }
}

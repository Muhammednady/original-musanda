import UIKit
import Flutter
import SafariServices
import GoogleMaps
import Firebase
import FirebaseMessaging

struct Colors {
    static let red = "📕"
    static let green = "📗"
    static let yellow = "📔"
    static let blue = "📘"
    static let orange = "📙"
}

@available(iOS 11.0, *)
@objc
@UIApplicationMain
class AppDelegate: FlutterAppDelegate, OPPCheckoutProviderDelegate, SFSafariViewControllerDelegate, PKPaymentAuthorizationViewControllerDelegate {
    
    var type: String = ""
    var mode: String = ""
    var checkoutID: String = ""
    var brand: String = ""
    var stcPay: String = ""
    var number: String = ""
    var holder: String = ""
    var year: String = ""
    var month: String = ""
    var cvv: String = ""
    var madaRegexV: String = ""
    var madaRegexM: String = ""
    var brands: String = ""
    var amount: Double = 1
    var safariVC: SFSafariViewController?
    var transaction: OPPTransaction?
    var provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    var checkoutProvider: OPPCheckoutProvider?
    var pResult: FlutterResult?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {

        FirebaseApp.configure()

        if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        } else {
        let settings: UIUserNotificationSettings =  UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        
        application.registerForRemoteNotifications()
        
        
        GMSServices.provideAPIKey("AIzaSyCsE5KDJqjPpbTHsQFqSjnJHclQuCBw8c4")
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let batteryChannel = FlutterMethodChannel(name: "com.fnrco.musaneda/channel", binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in self!.pResult = result
            
            if call.method == "get_hyperpay_response" {
                
                    
                    let args = call.arguments as? [String: Any]
                
                    self!.type = (args!["type"] as? String)!
                    self!.brand = (args!["brand"] as? String)!
                    self!.mode = (args!["mode"] as? String)!
                    self!.checkoutID = (args!["checkoutID"] as? String)!
                
                    if self!.type == "ReadyUI" {
                        DispatchQueue.main.async {
                            self!.openCheckoutUI(checkoutID: self!.checkoutID, result1: result)
                        }
                    } else {
                        
                        print("arg!['brand']: \(args!["brand"])")
                        
                        if let brand = (args!["brand"] as? String) {
                            print("*********** brand: \(brand)")
                            print("*********** self!.brand: \(self!.brand)")
                            print("*********** self!.brands: \(self!.brands)")
                            self!.brand = brand
                            self!.number = (args!["card_number"] as? String)!
                            self!.holder = (args!["holder_name"] as? String)!
                            self!.year = (args!["year"] as? String)!
                            self!.month = (args!["month"] as? String)!
                            self!.cvv = (args!["cvv"] as? String)!
                            self!.madaRegexV = (args!["MadaRegexV"] as? String)!
                            self!.madaRegexM = (args!["MadaRegexM"] as? String)!
                        }
                        if let amount = (args!["Amount"] as? Double) {
                            self!.amount = amount
                        }
                        if let stcPay = (args!["stcPay"] as? String) {
                            self!.stcPay = stcPay
                        }
                        self!.openCustomUI(checkoutID: self!.checkoutID, result1: result)
                    }
                } else {
                    result(FlutterError(code: "1", message: "Method name is not found", details: ""))
                }
        })
        
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().token { token, error in if let error = error {
                print("Error FCM token: \(error)")
            } else if let token = token {
                print(Colors.green + "Success FCM token:\(Colors.green) \(token)")
            }
        }
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }



    private func openCheckoutUI(checkoutID: String,result1: @escaping FlutterResult) {
        print(Colors.green + "START OPEN CHECKOUTUI WITH (BRAND): (\(self.brand))" + Colors.green)
        
        DispatchQueue.main.async{
            let checkoutSettings = OPPCheckoutSettings()
            if self.brand == "mada" {
                checkoutSettings.paymentBrands = ["MADA"]
            } else if self.brand == "credit" {
                checkoutSettings.paymentBrands = ["VISA", "MASTER"]
            } else if self.brand == "APPLEPAY" {
                print(Colors.green + "START PAYING WITH APPLE PAY" + Colors.green)
                let paymentRequest = OPPPaymentProvider.paymentRequest(
                    withMerchantIdentifier: "merchant.com.fnrco.musaneda.liveApplePay",
                    countryCode: "SA"
                )
                if #available(iOS 12.1.1, *) {
                    paymentRequest.supportedNetworks = [ PKPaymentNetwork.mada,PKPaymentNetwork.visa, PKPaymentNetwork.masterCard ]
                } else {
                    paymentRequest.supportedNetworks = [ PKPaymentNetwork.visa, PKPaymentNetwork.masterCard ]
                }
                checkoutSettings.applePayPaymentRequest = paymentRequest
                checkoutSettings.paymentBrands = ["APPLEPAY"]
                print(Colors.green +  "END PAYING WITH APPLE PAY"  + Colors.green)
            }
            checkoutSettings.language = "ar"
            checkoutSettings.shopperResultURL = "com.fnrco.musaneda.payments://result"

            if self.mode == "LIVE" {
                self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
            }

            self.checkoutProvider = OPPCheckoutProvider(
                paymentProvider: self.provider,
                checkoutID: checkoutID,
                settings: checkoutSettings
            )!
            self.checkoutProvider?.delegate = self
            self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                guard let transaction = transaction else {
                    print("4-\(error.debugDescription)")
                    return
                }
                self.transaction = transaction
                if transaction.type == .synchronous {
                    DispatchQueue.main.async {
                        result1("SYNC")
                    }
                } else if transaction.type == .asynchronous {
                    NotificationCenter.default.addObserver(
                        self,
                        selector: #selector(self.didReceiveAsynchronousPaymentCallback),
                        name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"),
                        object: nil
                    )
                } else {
                    print(Colors.orange + "5-\(self.transaction.debugDescription)" + Colors.orange)
                }
            }, cancelHandler: {
                print(Colors.orange + "6-\(self.transaction.debugDescription)" + Colors.orange)
            })
        }
    }

    private func openCustomUI(checkoutID: String,result1: @escaping FlutterResult) {
        print(Colors.green + "START OPEN CUSTOMUI WITH (BRAND): (\(self.brand))" +  Colors.green)
        if self.mode == "LIVE" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        }
        if self.stcPay == "enabled" {
            do {
                let params = try OPPPaymentParams(checkoutID: checkoutID,paymentBrand: "STC_PAY")
                params.shopperResultURL = "com.fnrco.musaneda.payments://result"
            
                self.transaction  = OPPTransaction(paymentParams: params)
                self.provider.submitTransaction(self.transaction!) { (transaction, error) in guard
                    let transaction = self.transaction else {
                    print(Colors.red + "open custome ui stc pay: \(error.debugDescription)" + Colors.red)
                        self.createAlert(titleText: error as! String, msgText: "")
                        return
                    }
                    if transaction.type == .asynchronous {
                        NotificationCenter.default.addObserver(
                            self,
                            selector: #selector(self.didReceiveAsynchronousPaymentCallback),
                            name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"),
                            object: nil
                        )
                        self.safariVC = SFSafariViewController(url: self.transaction!.redirectURL!)
                        self.safariVC?.delegate = self;
                    } else if transaction.type == .synchronous {
                        result1("success")
                    } else {
                        print(Colors.red + "self.transaction.debugDescription: \(self.transaction.debugDescription)" + Colors.red)
                        self.createAlert(titleText: error as! String, msgText: "OPEN CUSTOM UI ERROR")
                    }
                }
            } catch let error as NSError {
                print(Colors.red + "NSError->error.debugDescription: \(error.debugDescription)" + Colors.red)
                self.createAlert(titleText: error.localizedDescription, msgText: "")
            }
        } else {
            if self.brand == "APPLEPAY" {
                print(Colors.green + "START PAYING WITH APPLE PAY" + Colors.green)
                let request = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.com.fnrco.musaneda.liveApplePay", countryCode: "SA")
            
                request.currencyCode = "SAR"
                self.amount = Double(String(format: "%.2f", self.amount))!
                request.paymentSummaryItems = [
                    PKPaymentSummaryItem(
                        label: "Musaneda Services - مساندة للخدمات",
                        amount: NSDecimalNumber(value: self.amount)
                    )
                ]
                
                if OPPPaymentProvider.canSubmitPaymentRequest(request) {
                
                    if let vc = PKPaymentAuthorizationViewController(paymentRequest: request) as PKPaymentAuthorizationViewController? {
                        
                        vc.delegate = self
                        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
                    
                    } else {
                        NSLog("Apple Pay not supported.");
                    }
                }
                
            } else if !OPPCardPaymentParams.isNumberValid(self.number, luhnCheck: true) {
                
                self.createAlert(titleText: "Card Number is Invalid", msgText: "\(self.number)")
                
            } else if !OPPCardPaymentParams.isHolderValid(self.holder) {
                
                self.createAlert(titleText: "Card Holder is Invalid", msgText: "\(self.holder)")
                
            } else if !OPPCardPaymentParams.isCvvValid(self.cvv) {
                
                self.createAlert(titleText: "CVV is Invalid", msgText: "\(self.cvv)")
                
            } else if !OPPCardPaymentParams.isExpiryYearValid(self.year) {
                
                self.createAlert(titleText: "Expiry Year is Invalid", msgText: "20\(self.year)")
                
            } else  if !OPPCardPaymentParams.isExpiryMonthValid(self.month) {
                
                self.createAlert(titleText: "Expiry Month is Invalid", msgText: "20\(self.month)")
                
            } else {
                do {
                    if self.brand == "mada" {
                        let bin = self.number.prefix(6)
                        let range = NSRange(location: 0, length: String(bin).utf16.count)
                        let madaRegexV = try! NSRegularExpression(pattern: self.madaRegexV)
                        let madaRegexM = try! NSRegularExpression(pattern: self.madaRegexM)
                        
//                        if madaRegexV.firstMatch(in: String(bin), options: [], range: range) != nil || madaRegexM.firstMatch(in: String(bin), options: [], range: range) != nil {
                            
                            print("************ MADA ******************")
                            self.brands = "MADA"
//                        } else {
                            print("##############################")
//                            self.createAlert(titleText:  "This card is not Mada card", msgText: "")
//                        }
                    } else if self.number.prefix(1) == "4" {
                        self.brands = "VISA"
                    } else if self.number.prefix(1) == "5" {
                        self.brands = "MASTER";
                    }
                    
                    let params = try OPPCardPaymentParams(
                        checkoutID: checkoutID,
                        paymentBrand: self.brands,
                        holder: self.holder,
                        number: self.number,
                        expiryMonth: self.month,
                        expiryYear: self.year,
                        cvv: self.cvv
                    )
                    
                    params.shopperResultURL = "com.fnrco.musaneda.payments://result"

                    print(Colors.green + "{ccv: \(self.cvv), month: \(self.month), year: \(self.year), holder: \(self.holder), number: \(self.number),  brands: \(self.brands),  brand: \(self.brand), checkoutID: \(checkoutID)}" + Colors.green)
                    
                    self.transaction  = OPPTransaction(paymentParams: params)
                    self.provider.submitTransaction(self.transaction!) { (transaction, error) in
                        guard let transaction = self.transaction else {
                            print(Colors.red + "7-\(error.debugDescription)" + Colors.red)
                            self.createAlert(titleText: error as! String, msgText: "\(self.transaction.debugDescription)")
                            return
                        }
                        if transaction.type == .asynchronous {
                            self.safariVC = SFSafariViewController(url: self.transaction!.redirectURL!)
                            self.safariVC?.delegate = self;
                            self.window?.rootViewController?.present(self.safariVC!, animated: true, completion: nil)
                        } else if transaction.type == .synchronous {
                            result1("success")
                        } else {
                            print(Colors.red + "1-\(error)" + Colors.red)
                            self.createAlert(titleText: error as! String, msgText: "")
                        }
                    }
                } catch let error as NSError {
                    print(Colors.red + "2-\(error.description)" + Colors.red)
                    self.createAlert(titleText: error.localizedDescription, msgText: "")
                }
            }
        }
    }

    @objc func didReceiveAsynchronousPaymentCallback(result: @escaping FlutterResult) {
        print(Colors.red + "did Receive Asynchronous Payment Callback" + Colors.red)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        if self.type == "ReadyUI" {
            self.checkoutProvider?.dismissCheckout(animated: true) {
                DispatchQueue.main.async {
                    result("success")
                }
            }
        } else {
            self.safariVC?.dismiss(animated: true) {
                DispatchQueue.main.async {
                    result("success")
                }
            }
        }
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(Colors.yellow + "urlscheme:" + (url.scheme)! + Colors.yellow)
        var handler:Bool = false
        if url.scheme?.caseInsensitiveCompare("com.fnrco.musaneda.payments") == .orderedSame {
            didReceiveAsynchronousPaymentCallback(result: self.pResult!)
            handler = true
        }
        return handler
    }

    func createAlert(titleText:String,msgText:String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: titleText, message: msgText, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default,handler: { (action) in alertController.dismiss(animated: true, completion: nil)}))
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        if let params = try? OPPApplePayPaymentParams(checkoutID: self.checkoutID, tokenData: payment.token.paymentData) as OPPApplePayPaymentParams? {
            params.shopperResultURL = "com.fnrco.musaneda.payments://result"
            self.transaction  = OPPTransaction(paymentParams: params)
            self.provider.submitTransaction(OPPTransaction(paymentParams: params), completionHandler: { (transaction, error) in
                if (error != nil) {
                    print(Colors.red + "3-\(error.debugDescription)" + Colors.red)
                    self.createAlert(titleText: "APPLEPAY ERROR", msgText: "\(error.debugDescription)")
                } else {
                    completion(.success)
                    self.pResult!("success")
                }
            })
        }
    }

    func decimal(with string: String) -> NSDecimalNumber {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        return formatter.number(from: string) as? NSDecimalNumber ?? 0
    }

}

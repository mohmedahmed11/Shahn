//
//  CommonFunctions.swift
//  Prozata
//
//  Created by Sunil on 8/28/18.
//  Copyright © 2018 punk. All rights reserved.
//
import UIKit
import Foundation
class GlobalFunctions{
   
    
class func convertDateToString(PreviousDate:String) -> String
{
    let stringInDate = PreviousDate
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: stringInDate)
    dateFormatter.dateFormat = "dd MMM, yyyy"
    dateFormatter.locale = tempLocale
    let dateString = dateFormatter.string(from: date!)
    return "Valid till " + dateString
    
}
 class func setLeftDays(DiffInDays:String)->String{
    return DiffInDays + " Days Left"
 }
 class func convertPostedDate(CurrentDate:String) -> String{
    
    let stringInDate = CurrentDate
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: stringInDate)
    dateFormatter.dateFormat = "dd MMM, yyyy"
    dateFormatter.locale = tempLocale
    let dateString = dateFormatter.string(from: date!)
    return dateString
        
    }
    
    
    class func changeTime(time:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        if let showTime = dateFormatter.date(from: time){
            let dateFormatter2 = DateFormatter()
            dateFormatter2.setLocalizedDateFormatFromTemplate("h:mm a")
            let set_time = dateFormatter2.string(from: showTime).uppercased()
            return set_time
        }
        else{
            return ""
        }
    }
    
    
    class func changeOnTaskTime(time:String) -> String{
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let showTime = dateFormatter.date(from: time){
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            let set_time = dateFormatter.string(from: showTime)
            return set_time
        }
        else{
            return ""
        }
        
        
    }
    
    class func changeOn1TaskTime(time:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let showTime = dateFormatter.date(from: time){
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            let set_time = dateFormatter.string(from: showTime)
            return set_time
        }
        else{
            return ""
        }
        
        
    }
    class func ConvertDateBySpecificDate(Created_Date:String)->String{
        
        guard Created_Date != "0000-00-00 00:00:00" else {
            return ""
        }
        let stringInDate = Created_Date
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //"2019-04-15 08:10:17"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringInDate)
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)
        return dateString
        
    }
    
    class func ConvertDateBySpecificCPFeed(Created_Date:String)->String{
        
        guard Created_Date != "0000-00-00" else {
            return ""
        }
        let stringInDate = Created_Date
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //"2019-04-15 08:10:17"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringInDate)
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)
        return dateString
        
    }
    class func ConvertDateInSpecificFormat(previousDate:String)->String{
        
        var daysORMonth = ""
        let currentDate = GlobalFunctions.getDateINtoString()
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 2
        form.unitsStyle = .full
        form.allowedUnits = [.year, .month, .day]
        let DaysAndMonth = form.string(from: currentDate, to:GlobalFunctions.getPreviousDateINtoString(previousDate:previousDate) )
        
    
        
        if (DaysAndMonth?.starts(with: "-"))!{
            
            let A = DaysAndMonth?.dropFirst()
            
            daysORMonth = String((A ?? "") + " ago")
        }else{
            daysORMonth = DaysAndMonth ?? ""

        }
        return daysORMonth
        
    }
    class  func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
   class  func getFormattedDateFromString(dateString:String,toFormat:String,fromFormat:String) -> String{
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        //    dateFormatter.timeZone = NSTimeZone(name: "Asia/Singapore")! as TimeZone
       if let date = dateFormatter.date(from:dateString) {
           dateFormatter.dateFormat = toFormat
           let finalDate = dateFormatter.string(from: date)
           return finalDate
       }else {
           return dateString
       }
    }
    
    class func getFormattedDateFromDate(date:Date,toFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        dateFormatter.timeZone = NSTimeZone.local
        let finalDate = dateFormatter.string(from: date)
        return finalDate
    }
    func timeDifferenceInSeconds(fromTime:String, toTime:String, fromFormat:String) -> Int
    {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateFormat = fromFormat
        let fromDate = dateformatter.date(from:fromTime)!
        let toDate = dateformatter.date(from:toTime)!
        let datecomponents = NSCalendar.current.dateComponents([.minute], from: toDate, to: fromDate)
        let minute = datecomponents.minute!
        return minute
    }
    
    class func timeDifferences(fromTime:String, toTime:Date, fromFormat:String) -> DateComponents
    {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateFormat = fromFormat
        let fromDate = dateformatter.date(from:fromTime)!
        let toDate = toTime
        let datecomponents = NSCalendar.current.dateComponents([.minute, .day, .hour, .second], from: toDate, to: fromDate)
//        let minute = datecompon
        return datecomponents
    }
    
    class func timeDifferences(fromTime:Date, toTime:String, fromFormat:String) -> DateComponents
    {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US")
        dateformatter.dateFormat = fromFormat
        let fromDate = dateformatter.date(from:toTime)!
        let datecomponents = NSCalendar.current.dateComponents([.minute, .day, .hour, .second], from: fromDate, to:fromTime)
        return datecomponents
    }
    
    class func getDateBy(adding days: Int, toDate date: Date) ->Date?
    {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let datecomponents = NSCalendar.current.date(byAdding: dateComponent, to: date)
        return datecomponents
    }
    
    class func getDateByAdding(hours: Int, toDate date: Date) ->Date?
    {
        var dateComponent = DateComponents()
        dateComponent.hour = hours
        let datecomponents = NSCalendar.current.date(byAdding: dateComponent, to: date)
        return datecomponents
    }
    
    class func getFormattedDateFromString(date:String,fromFormat:String) -> Date{
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "en_US_POSIX")
        dateformatter.dateFormat = fromFormat
        let fromDate = dateformatter.date(from:date)!
        return fromDate
    }
    
    
   class func dayDiff(dateString:String,fromFormat:String)->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
       if let fromDate = dateFormatter.date(from:dateString) {
           let currentDate = Date()
           let difference = currentDate.timeIntervalSince(fromDate)
           let differenceInDays = Int(difference/(60 * 60 * 24 ))
           return differenceInDays
       }else {
           return 0
       }
    }

    
    class func getDateINtoString()->Date{
        
        let currentDate = Date()
        let formatter = DateFormatter()
        let myString = (String(describing: currentDate))
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let yourDate: Date? = formatter.date(from:myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        return yourDate ?? Date()
        
    }
    
    class func getPreviousDateINtoString(previousDate:String)->Date{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let yourDate: Date? = formatter.date(from:previousDate)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd-MMM-yyyy"
        return yourDate ?? Date()
        
    }
    
    
    class  func getFormattedDateFromStringCalenderEvent(dateString:String,toFormat:String,fromFormat:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        let finalDate = dateFormatter.date(from:dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return finalDate ?? Date()
    }
    
    class func getConvertDateInEEEFormat(eeeDate:String?)->String{
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = dateFormatter.date(from: eeeDate ?? "")
            let dateFormatter1 = DateFormatter()
            dateFormatter1.setLocalizedDateFormatFromTemplate("MMM")
            let Month = dateFormatter1.string(from: showDate!).uppercased()
            let dateFormatter2 = DateFormatter()
            dateFormatter2.setLocalizedDateFormatFromTemplate("d")
            let date = dateFormatter2.string(from: showDate!)
            let dateFormatter3 = DateFormatter()
            dateFormatter3.setLocalizedDateFormatFromTemplate("EEE")
            let day = dateFormatter3.string(from: showDate!).uppercased()
           return   day + "," + " " + Month + " " + date
            
        
        
    }
    class func getCurrentShortDate() -> String {
        
    let todaysDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat = dateFormatter.string(from: todaysDate)
    return DateInFormat
    }

    class func getYear() -> Int {
        
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy"
            let DateInFormat = dateFormatter.string(from: todaysDate)
        return Int(DateInFormat)!
    }
   

    class func decodeObject<Y: Decodable>(data: Data, completion: @escaping (Y) -> ()) {
        do {
            let model = try JSONDecoder().decode(Y.self, from: data)
            completion(model)
        } catch let jsonErr {
            print("failed to decode, \(jsonErr)")
        }
        
    }
   
    //MARK:-Chat Separate with section
    
   class func seperateDateWithTime(PreviousDate:String)->String{
        
        let stringInDate = PreviousDate
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringInDate)
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)
        return  dateString
    }
    
   class func convertChatDateToString(PreviousDate:Date)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let dateStr = dateFormatter.string(from: PreviousDate)
        return dateStr
        //return getChatDay(chatDate:PreviousDate)
    
    }
    
    class func setTime(dateStr:String)->String{

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateStr)
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = NSTimeZone.local
        let dateString = formatter.string(from: date!)
        return dateString
    }

     class func getDateWithTime(PreviousDate:String)->Date{
        let arrDate = PreviousDate.components(separatedBy:" ")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: arrDate.count>0 ? arrDate[0]: "2014-12-11 11:20:20")!
    }
    
    
   class func getChatDay(chatDate:Date)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let previousDate = dateFormatter.string(from:chatDate)
        let previousDateFormated : Date? = dateFormatter.date(from: previousDate)
        
        let currentCalendar = NSCalendar.current
        if currentCalendar.isDateInToday(previousDateFormated!){
           return "Today"
        }else if currentCalendar.isDateInTomorrow(previousDateFormated!){

             return "yesterday"
        }
        else{
            //let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "dd MMM, yyyy"
            let dateStr = dateFormatter.string(from: chatDate)
            return  dateStr
        }
    }
    

    class func ConvertDateSpecificFormat(PreviousDate:String,Format:String)->String{
        
        let stringInDate = PreviousDate
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = Format
        let date = dateFormatter.date(from: stringInDate)
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date!)
        return  dateString
    }
    
    class func convertTaskDate(CurrentDate:String, format:String) -> String{
        
        let stringInDate = CurrentDate
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: stringInDate)
        dateFormatter.dateFormat = "dd MMM, yyyy hh:mm a"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date ?? Date())
        return dateString
        
    }

}
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
     func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height/2, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Rubik-Light", size: 16.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 2
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect:CGRect = CGRect(x: 5, y: 0, width: 320, height: 10)
        return rect
    }
   
}




import Foundation
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 
 ## projectedValue
 There is another special property inside a property wrapper called the projectedValue.  You can use this to provide additional functionality
*/
/*:
**Example 1:** *When getting a date value, always print in the US Date format "MM-dd-yyyy*
*/
code(for: "Example 1") {
    @propertyWrapper struct USDate {
        var wrappedValue: Date
        var projectedValue: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-YYYY"
            return formatter.string(from: wrappedValue)
        }
    }
    struct Person {
      var name: String
      @USDate var birthDate: Date
    }
    let me = Person(name: "Stewart", birthDate: Date())
    
    print(me.$birthDate)
    print(me.birthDate)

}
/*:
 **Example 1.1:** *Allow for the input of any date format but default to "EEEE, MMM d, yyyy" if none provided*
 */
code(for: "Example 1.1") {
    @propertyWrapper struct FormattedDate {
        var wrappedValue: Date
        var format: String
        var projectedValue: String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: wrappedValue)
        }
        init(wrappedValue: Date, format: String = "EEEE, MMM d, yyyy") {
            self.wrappedValue = wrappedValue
            self.format = format
        }
    }
    struct Person {
      var name: String
        @FormattedDate(format: "yyyy-MM-dd") var birthDate: Date = Date()
    }
    let me = Person(name: "Stewart", birthDate: Date())
    
    print(me.$birthDate)
    print(me.birthDate)

}
/*:
 **Example 2:** *Display ratings as string of emojis*
 */
code(for: "Example 2") {
    @propertyWrapper struct Rating {
        var wrappedValue: Int
        var emoji: String
        var projectedValue: String {
            return String(repeating: emoji, count: wrappedValue)
        }
        init(wrappedValue: Int, emoji: String = "⭐️") {
            self.wrappedValue = wrappedValue
            self .emoji = emoji
        }
    }
    struct Review {
        var name: String
        @Rating var ambiance: Int = 0
        @Rating(emoji: "🍽") var food: Int = 0
    }
    
    let earlsReview = Review(name: "Earls", ambiance: 5, food: 4)
    print(earlsReview.$ambiance)
    print(earlsReview.$food)
}

/*:
 
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */

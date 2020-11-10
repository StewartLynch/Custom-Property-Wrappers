/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## wrappedValue
 You create a property wrapper by creating a struct, class or enum that uses the @propertyWrapper annotation. Inside the property wrapper you have to implement the wrappedValue property. By implementing property observers of wrappedValue you can add custom behaviour.
*/
/*:
**Example 1:** *Always return and print out the name in all caps*
*/
code(for: "Capitalize properties") {
    struct Name {
        var firstName: String {
            didSet {
                firstName = firstName.uppercased()
            }
        }
        var lastName: String {
            didSet {
                lastName = lastName.uppercased()
            }
        }
        init(firstName: String, lastName: String) {
            self.firstName = firstName.uppercased()
            self.lastName = lastName.uppercased()
        }
    }
    var me = Name(firstName: "Stewart", lastName: "Lynch")
//    me.firstName = "Stewart"
    print(me.firstName, me.lastName)
}
/*:
 *Indroducing Property Wrappers*
 */
code(for: "Introducing Property Wrappers") {
    @propertyWrapper struct AllCaps {
        var wrappedValue: String {
            didSet {
                wrappedValue = wrappedValue.uppercased()
            }
        }
        init(wrappedValue: String) {
            self.wrappedValue = wrappedValue.uppercased()
        }
    }
    struct Name {
      @AllCaps var firstName: String
      @AllCaps var lastName: String
    }
    
    var me = Name(firstName: "Stewart", lastName: "Lynch")
    print(me.firstName, me.lastName)

}
/*:
 **Example 2:** *Always ensure string values are trimmed so as not to have any leading or trailing white spaces*
 */
code(for: "Example 2") {
    @propertyWrapper struct Trimmed {
        private var text: String
        var wrappedValue: String {
            set {
               text = newValue
            }
            get {
                text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        init(wrappedValue: String) {
            text = wrappedValue
        }
    }
    struct Name {
        @Trimmed var firstName: String
        @Trimmed var lastName: String
    }
    let me = Name(firstName: "   Stewart  ", lastName: "  Lynch  ")
    print(me.firstName, me.lastName)
}
/*:
 **Example 3:** *Always ensure that a value is clamped within a range of 0...100*
 */
code(for: "Example 3") {
    @propertyWrapper struct InRange {
        private var score: Int
        var wrappedValue: Int {
            set {
              score = newValue
            }
            get {
                max(0, min(score, 100))
            }
        }
        init(wrappedValue: Int) {
            score = wrappedValue
            
        }
    }
    struct Exam {
        var student: String
        @InRange var score: Int
    }
    let physics = Exam(student: "Stewart", score: -5)
    print(physics.score)
    
}

/*:
 **Example 3.1:** *Allow input for range of Int limits*
 */
code(for: "Example 3.1") {
    @propertyWrapper struct InRange {
        private var score: Int
        private var minScore: Int
        private var maxScore: Int
        var wrappedValue: Int {
            set {
              score = newValue
            }
            get {
                max(minScore, min(score, maxScore))
            }
        }
        init(wrappedValue: Int, minScore: Int, maxScore: Int) {
            score = wrappedValue
            self.minScore = minScore
            self.maxScore = maxScore
            
        }
    }
    struct Exam {
        var student: String
        @InRange(minScore: 10, maxScore: 80) var score: Int = 0
    }
    let physics = Exam(student: "Stewart", score: 10)
    print(physics.score)
}
/*:
**Example 3.2:** *Allow any Numeric type for input*
*/
code(for: "Example 3.2") {
    @propertyWrapper struct InRange<T: Numeric & Comparable> {
        private var score: T
        private var minScore: T
        private var maxScore: T
        var wrappedValue: T {
            set {
              score = newValue
            }
            get {
                max(minScore, min(score, maxScore))
            }
        }
        init(wrappedValue: T, minScore: T, maxScore: T) {
            score = wrappedValue
            self.minScore = minScore
            self.maxScore = maxScore
            
        }
    }
    struct Exam {
        var student: String
        @InRange(minScore: 0.5, maxScore: 1.0) var score = 0
    }
    let physics = Exam(student: "Stewart", score: 0.8)
    print(physics.score)
}
/*:

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */

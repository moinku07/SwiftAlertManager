Custom Alert Manger for Swift

It works with Swift 1.2, swift 2.0, iOS 8 and iOS 7

Very easy to use.

Example:
<pre>
<code>

// Basic
AlertManager.showAlert(self, title: "Warning", message: "Please enter username", buttonNames: nil)

// here “self” is the view controller to show alert. you can pass nil to show alert in application window

// put buttonNames = nil to show “Okay” button only

// Advance

AlertManager.showAlert(self, title: "Alert", message: "Please provide a valid email", buttonNames: ["Cancel", "Okay"], completion: { (index) -> Void in
    if index == 0{
    	// to do for cancel
    }else if index == 1{
    	// to do for okay
    }
})
</code>
</pre>


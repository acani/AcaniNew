var target = UIATarget.localTarget();

// Example Features
// For more examples, search Xcode's documation for "Automating UI Testing."

// List element hierarchy.
var testName = "Log element tree.";
UIALogger.logStart(testName);
target.logElementTree();
UIALogger.logPass(testName);

// This is already tested in specs.
testName = "Set title to Users.";
UIALogger.logStart(testName);
if (target.frontMostApp().navigationBar().name() == "Users") {
    UIALogger.logPass();
} else {
    UIALogger.logFail();
}

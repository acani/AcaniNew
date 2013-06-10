// Learn: Search Xcode's documation for "Automating UI Testing."

// Run:
// instruments -t "`xcode-select -print-path`/../Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" <path_to_application> -e UIASCRIPT <path_to_script.js> -e UIARESULTSPATH <output_results_path>
// instruments -t "`xcode-select -print-path`/../Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "~/Library/Developer/Xcode/DerivedData/Acani-ffwmrznlynjjojfpyvujjoxxiorc/Build/Products/Debug-iphonesimulator/Acani.app/Acani" -e UIASCRIPT "${SRCROOT}/AcaniFeatures/AcaniFeatures.js" -e UIARESULTSPATH "~/Desktop/UI Automation Output"

var target = UIATarget.localTarget();
var frontMostApp = target.frontMostApp();
var mainWindow = frontMostApp.mainWindow();

// Log In
mainWindow.buttons()["Log In with Facebook"].tap();

// View Profile
mainWindow.collectionViews()[0].cells()["0Small.jpg"].tap();

// - hide chrome
mainWindow.scrollViews()[0].tap();
target.delay(0.5);

// - zoom in
mainWindow.scrollViews()[0].doubleTap();
target.delay(0.5);

// - zoom out
mainWindow.scrollViews()[0].doubleTap();
target.delay(0.5);

// - show chrome
mainWindow.scrollViews()[0].tap();

// - back
frontMostApp.navigationBar().leftButton().tap();

// Log Out

// - cancel
target.frontMostApp().navigationBar().leftButton().tap();
target.frontMostApp().actionSheet().cancelButton().tap();

// - log out
target.frontMostApp().navigationBar().leftButton().tap();
target.frontMostApp().actionSheet().buttons()["Log Out"].tap();


// Old Code

// Example Features
// For more examples, search Xcode's documation for "Automating UI Testing."

//// List element hierarchy.
//var testName = "Log element tree.";
//UIALogger.logStart(testName);
//target.logElementTree();
//UIALogger.logPass(testName);

//// This is already tested in specs.
//testName = "Set title to Users.";
//UIALogger.logStart(testName);
//if (target.frontMostApp().navigationBar().name() == "acani") {
//    UIALogger.logPass();
//} else {
//    UIALogger.logFail();
//}

//// TODO: Make some assertions.
//function AASAssertNotNull(thingie, message) {
//    var defMessage = '"((appDelegate) != nil)" should be true.';
//    assertTrue(thingie !== null && thingie.toString() != "[object UIAElementNil]",
//               message ? message + ": " + defMessage : defMessage);
//}

// Rotation
//target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
//target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);

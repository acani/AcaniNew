// Learn: Search Xcode's documation for "Automating UI Testing."

// Run:
// instruments -t "`xcode-select -print-path`/../Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" <path_to_application> -e UIASCRIPT <path_to_script.js> -e UIARESULTSPATH <output_results_path>
// instruments -t "`xcode-select -print-path`/../Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate" "~/Library/Developer/Xcode/DerivedData/Acani-ffwmrznlynjjojfpyvujjoxxiorc/Build/Products/Debug-iphonesimulator/Acani.app/Acani" -e UIASCRIPT "${SRCROOT}/AcaniFeatures/AcaniFeatures.js" -e UIARESULTSPATH "~/Desktop/UI Automation Output"

var target = UIATarget.localTarget();
var frontMostApp = target.frontMostApp();
var mainWindow = frontMostApp.mainWindow();

var rotate = function() {
  target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
  target.delay(1);
  target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
  target.delay(1);
};

// Log In
mainWindow.buttons()["Log In with Facebook"].tap();
target.delay(1);

rotate();

// View Profile
mainWindow.collectionViews()[0].cells()["0Small.jpg"].tap();

var scrollView = mainWindow.scrollViews()[0];

// - flick right
scrollView.flickInsideWithOptions({startOffset:{x:0.0, y:0.5}, endOffset:{x:0.9, y:0.5}});
target.delay(0.3);

// - flick left 8 times
for (var i = 0; i < 8; i++) {
  scrollView.flickInsideWithOptions({startOffset:{x:0.9, y:0.5}, endOffset:{x:0.1, y:0.5}});
  target.delay(0.3);
}

rotate();

// - hide chrome
scrollView.tap();
target.delay(0.5);

// - zoom in
scrollView.doubleTap();
target.delay(0.5);

// - zoom out
scrollView.doubleTap();
target.delay(0.5);

// - touch & hold
scrollView.touchAndHold();
frontMostApp.actionSheet().cancelButton().tap();

scrollView.touchAndHold();
frontMostApp.actionSheet().buttons()["Save Picture"].tap();

scrollView.touchAndHold();
frontMostApp.actionSheet().buttons()["Copy"].tap();

// - show chrome
scrollView.tap();

// - back
frontMostApp.navigationBar().leftButton().tap();

// Settings

// - cancel
frontMostApp.navigationBar().rightButton().tap();
frontMostApp.actionSheet().cancelButton().tap();

// - settings
frontMostApp.navigationBar().rightButton().tap();
frontMostApp.actionSheet().buttons()["Settings"].tap();

// - - done
frontMostApp.navigationBar().leftButton().tap();

// - settings
frontMostApp.navigationBar().rightButton().tap();
frontMostApp.actionSheet().buttons()["Settings"].tap();

rotate();

var cells = target.frontMostApp().mainWindow().tableViews()[0].cells();

cells["Privacy Policy"].tap();
frontMostApp.navigationBar().leftButton().tap();

cells["Send Feedback"].tap();
target.logElementTree(); // makes next line work #hack
target.frontMostApp().navigationBar().leftButton().tap();
target.frontMostApp().actionSheet().buttons()["Delete Draft"].tap();

// - log out - cancel
cells["Log Out"].tap();
frontMostApp.actionSheet().cancelButton().tap();

// - log out - log out
cells["Log Out"].tap();
frontMostApp.actionSheet().buttons()["Log Out"].tap();

// - delete account
mainWindow.buttons()["Log In with Facebook"].tap();
frontMostApp.navigationBar().rightButton().tap();
frontMostApp.actionSheet().buttons()["Settings"].tap();
mainWindow.tableViews()[0].buttons()["Delete Account"].tap();
target.frontMostApp().actionSheet().cancelButton().tap();
mainWindow.tableViews()[0].buttons()["Delete Account"].tap();
target.frontMostApp().actionSheet().buttons()["Delete Account"].tap();


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

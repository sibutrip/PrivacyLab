# PrivacyLab
Coding Activity for the Apple Developer Academy - Detroit

## Instructions

This activity consists of 3 sections, with the first section containing detailed, step-by-step instructions and the following 2 becoming more self-directed. 

Each section of the project is separated into a different tab item. At the start of the project, you'll see the app request Contacts, Location, and Health data as soon as you open the app.

Run the app in the simulator to test the app as you implement the changes.
To reset all permissions to their original state, delete the app from the simulator and run the app again from Xcode.

### For each section you will complete the following tasks:
- 1. Delay requesting the protected resource as long as possible.
- 2. Provide a screen that shows a description of how the user should enable the permission should they originally deny permission to the protected resource
- 3. Update the usage description in the app's Info.plist to give a better description as to why the app needs this permission.

Each section has different instructions. Contacts walks you through all the steps. Map has you solve easier problems yourself. Health is completely self-directed.

## `Contacts` (Bronze Difficulty)
- Step 1: First we need to delay requesting access to contacts for as long as possible. Right now the app requests permission to access the user's contacts before ContentView appears by calling `contactsViewModel.requestContactsPermission` (See above). Let's call this function only when the app actively needs to access the user's contacts. Before moving to Step 2, take a moment to explore the contacts portion of the app and figure out when this permission should be requested.
- Step 2: When the user taps 'Import From Contacts', that's the exact moment when we should request permission to the user's contacts. Remove the line of code requesting permission to the user's contacts from ContentView and paste it here instead. Make sure to call it asynchronously using the keyword `await`
- Step 3: If the user has declined to give the user access to contacts, we need to tell the user why this action is not allowed. When this happens, let's toggle an alert that gives a helpful description to the user. This description should include 1) Why the action failed and 2) How to enable permissions to allow for this action. We aleady have an alert with a proper description, but we need to set `triedToImportContactsWithoutPermission` to `true` in order to display it. Go ahead and do that here in this `else` block.
- Step 4: If the user taps 'Take me there' we should actually open the Settings app to PrivacyLab's permission page. We can do that by calling the `navigateToSettings` method of the `SettingService` class. This method is marked as a `static` method, meaning we call this method on the SettingsService type, rather than an instance of SettingsService. You can do that by typing `SettingsService.navigateToSettings()`.
- Step 5: As of now, the app gives no reason why it needs to access the user's contacts. Let's give a more descriptive reason so the user knows exactly how their personal data will be used. In the Navigator on the top left, click the blue project file labelled 'PrivacyLab' and click the 'Info' tab. Look for the key labelled 'Privacy - Contacts Usage Description' and give it a more useful value. For example 'PrivacyLab requires this permission in order to import your contacts names into your friend list.'
- Congratulations! You've completed all the steps. Delete the app, and run it again from Xcode. Take a moment to explore and see how the user experience has improved. Go ahead and move on to the `Location` section.

## `Location` (Silver Difficulty)

- Step 1: Delay requesting access to the user's location as long as possible. Where do we currently request permission to this resource? Where would be a better place to request that?
- Step 2: As of now, if you deny permission of the app, the show the user the `mapCameraPosition` which is centered on the United States. Instead of this, let's show the `mapCameraPosition` only if the user has enabled location permissions (use the `hasLocationPermission` property of our `MapViewModel`); otherwise, show a button that takes the user to PrivacyLab's Settings page (hint: use the `navigateToSettings` method in `SettingsService`, look at how we use it `ContactsView` if you get stuck).
-Step 3: Change the `NSLocationWhenInUseUsageDescription` description in PrivacyLab's info.plist to be more descriptive.
- Congratulations! You've completed all the steps. Delete the app, and run it again from Xcode. Take a moment to explore and see how the user experience has improved. For a more difficult task, move on to the `Health` section.

## `Health` (Gold Difficulty)

- Step 1: Go through the HealthKit documentation to find out how to request access the user's step count. You will also need to add this permission to the project's info.plist file.
- Step 2: Delay requesting access the user's step count for as long as possible.
- Step 3: If the user does not give permission to access their step count, show  a button that takes the user to PrivacyLab's Settings page.
- Step 4: If the user does not give permission to access their step count, show  a button that takes the user to PrivacyLab's Settings page.


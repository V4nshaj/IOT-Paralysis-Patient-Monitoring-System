Paramov 

Paralyzed people are unable to communicate their needs since they are unable to speak clearly. Improved communication between patients and caregivers can be achieved with a paralytic smart health system.  The smart gloves must provide real-time feedback on finger movements in order to assist caretakers in making informed judgments. The data is subsequently sent via  Wi-Fi to Paramov app, allowing doctors, nurses, or other caregivers to swiftly access and comprehend the user's present state of health. In order to address this issue, we developed a method that lets these people interact using simple gestures.

INSTRUCTION TO EXECUTE THE CODE:

STEP 1: The initial step includes connecting the sensors, ESP8266 and other components.

STEP 2: Design the code for the hardware in Arduino IDE to ensure that the data is collected by the sensors and sent to the cloud in real-time.

STEP 3: Setup the environment and create the flutter project to create the application for the user-interface where they can track their data.

STEP 4: Ensure that the application has the code for welcome screen, login screen, signup screen and dashboard screen where the data would be display. The code for the notification should also be implemented to ensure that the user gets appropriate notification based on the data received from the cloud.

STEP 5: Set up Firebase project. Add Firebase configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) to the Flutter project's appropriate directories. Enable necessary Firebase services such as Authentication, Firestore, Realtime Database, Cloud Messaging (FCM).

STEP 6: Connect a physical device or start an emulator/simulator. Run the Flutter app using the following command: flutter run.

STEP 7: Test the functionalities of the applications such as registration, login, receiving notifications, etc. Make sure to test on both Android emulators to ensure platform compatibility.

By following these steps, we should be able to set up and execute the provided code in our Flutter project. Make sure to resolve any dependencies or errors that may occur during the process.

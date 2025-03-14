# clock_this


# ? use when git push gets stuck: git reset --soft HEAD^
# ? Remove file from git cache: git rm -r --cached <file name>

# How to create a new build:

1) Version:
    (-) Go to [Link to Local File](pubspec.yaml) and increase the 'version' by:
        nothing -> When uploading a new build (but not version) for testers
        0.0.1 -> For minor updates/bug fixes
        0.1.0 -> Major updates
        1.0.0 -> Probably never
        
        (-) The number after the + is determined by android's version (since you can't delete older builds, and each new build has to have a higher version). This is done in order to keep android & ios versions synced.
        [-) [IMPORTANT]: After changing the version, run the app in order for local.properties to update
        

2) App Icon:
    (-) Make sure the right icon is selected
    (-) For IOS: Drag and drop into [Link to Local File](assets/images/app_icon.png) -> this will set it as the app's icon
    (-) For Android: Upload icon to https://icon.kitchen, and use the following settings: 
        { Icon: "image", Padding: "15%", Shape: "Circle"} then press Download. Unzip, android, 
        move icon to [Link to Local File](assets/images/), make sure the file name matches the one in [Link to Local File](pubspec.yaml) 'adaptive_icon_foreground' => Done. 
    (-) Set Android's notification icon: Drag and drop into [Link to Local File](android/app/src/main/res/drawable)
    (-) Change discord icon: https://discord.com/channels/1131162796885819494/1131162797800181840
    automatically use the app's icon)

    (-) Run this command to update the icons:
# flutter pub run flutter_launcher_icons:main

3) Bugs:
    Test the app thoroughly and make sure there aren't any bugs.

4) Xcode:
    (-) Make sure the right bundleId (com.meshi.clockthis) and development team are selected
    (-) Make sure the right configurations are selected: 
        => Go to [Link to Local File](ios/Runner.xcworkspace/),
        => view in finder
        => open
        => Project => Runner => Info => Configurations
        These are the recommended settings to use:
        Debug => Debug
        Release => Release
        Profile => Release

    (-) Make sure both the runner & widget extension belong to the same app group (group.clockthis)

5) Build IOS app with:
# (-) flutter build ios
  (-) Go to: Xcode => Product => Archive => Upload

6) Build android app with:
# flutter build appbundle
Access build file here: [Link to Local File](build/app/outputs/bundle/release/)

(-) Go to [Link to Local File](build/app/intermediates/merged_native_libs/release), 
compress all files and upload them as "Native debug symbols"


# How to change app name + bundleid:
Choose between: ios,macOS,androidxc

change name:
flutter pub global run rename --appname yourappname --target ios

change bundleid:
flutter pub global run rename --bundleId com.example.android.app --target ios

# How to refund in app purchases for sandbox accounts:
For android: Go to https://play.google.com/store/account/orderhistory, sign into the account you made the purchases from and request for a refund

For IOS: Go to https://appstoreconnect.apple.com/access/users/sandbox, Edit => Clear Purchase History

# How to recreate IOS/Android folders (make sure to restore certain values from git):
flutter create --platforms ios,android .

# How to fix "Requested but did not find extension point with identifier":

Delete podfile.lock in ios folder of the project
Run cd ios, pod repo update, pod install in the project folder

# How to deploy firestore rules:
1) Go to firestore.rules
2) Make changes
3) firebase deploy --only firestore:rules
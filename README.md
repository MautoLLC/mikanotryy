# mymikano_app


## Distribution for apple store

1. git pull origin Master
2. flutter build ios
3. Go to Xcode, open runner then
4. check the googleservices-info.plist that it contains the corresponding info
5. Runner->General-> make sure that the bundleId and versions are correct
6. Signing & capabilities : check the Team and identifier...
7. add push notification capability (signing and capabilities), click on the + button
8. Check background Modes : Location updates, background fetch, Remote notifications.
9. Product-scheme->choose scheme->in Runner -> any ios device
10. Window->organizer->choose archive-> distribute
11. Make sure the SKU of the app is good



## distribution for google play store

1. flutter build appbundle
## to run the second main use the command : flutter run -t lib/secondmain.dart

# mymikano_app


## Distribution for apple store

1. git pull origin Master
2. flutter build ios
3. Go to Xcode, open runner then
4. check the googleservices-info.plist that it contains the corresponding info
5. Runner->General-> make sure that the bundleId and versions are correct
6. Signing & capabilities : check the Team and identifier...
7. add push notification capability (signing and capabilities
8. check background Modes : Location updates, background fetch, Remote notifications.
9.product-scheme->choose scheme->in Runner -> any ios device
10.Window->organizer->choose archive-> distribute
11. make sure the SKU of the app is good



## distribution for google play store

1. flutter build appbundle

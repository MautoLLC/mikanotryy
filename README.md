# mymikano_app


## Distribution for apple store

1. git pull origin Master
2. flutter build ios
3. Go to Xcode, open runner then
4. Runner->General-> make sure that the bundleId and versions are correct
5. Signing & capabilities : check the Team and identifier...
6. add push notification capability (signing and capabilities
7. check background Modes : Location updates, background fetch, Remote notifications, Background processing.
8.product-scheme->choose scheme->in Runner -> any ios device
9.Window->organizer->choose archive-> distribute
10. make sure the SKU of the app is good



## distribution for google play store

1. flutter build appbundle

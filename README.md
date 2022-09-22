# mymikano_app


## Distribution for apple store

1. git pull origin Master
2. Go to Xcode, open runner then
3. Runner->General-> make sure that the bundleId and versions are correct
4. Signing & capabilities : check the Team and identifier...
5. add push notification capability (signing and capabilities
6. check background Modes : Location updates, background fetch, Remote notifications, Background processing.
7.product-scheme->choose scheme->in Runner -> any ios device
8.Window->organizer->choose archive-> distribute
9. make sure the SKU of the app is good



## distribution for google play store

1. flutter build appbundle

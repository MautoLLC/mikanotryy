const KeyCloakBaseUrl = 'https://dev.mauto.co';
const identifier = 'MymikanoApp';
const secret = '45475923-b3ef-46c5-aa70-79475824d3f9';
const authorizationEndpoint =
    '$KeyCloakBaseUrl/auth/realms/master/protocol/openid-connect/token';
const RegisterUserURL = '$KeyCloakBaseUrl/auth/admin/realms/master/users';

const userApiUrl = 'http://dev.codepickles.com:8083';
const userEditInfoUrl = '$userApiUrl/api/Users/{id}';
const userGetInfoUrl = '$userApiUrl/api/Users/{id}';
const deleteDeviceUrl = '$userApiUrl/api/Users/Devices';
const MikanoShopGetTermsState = '$userApiUrl/api/Users/TermsOfService/{id}';
const MikanoShopSetTermsState = '$userApiUrl/api/Users/TermsOfService/{id}';
const MikanoShopGetNotificationsState =
    '$userApiUrl/api/Users/NotificationsEnabled/{id}';
const MikanoShopSetNotificationsState =
    '$userApiUrl/api/Users/NotificationsEnabled/{id}';
const MikanoShopResetPassword = '$userApiUrl/api/Users/reset-credentials';

const MaintenanceApiBaseUrl = 'http://dev.codepickles.com:8085';
const GetMainCategoriesURL =
    '$MaintenanceApiBaseUrl/api/RealEstateMaintenanceCategories/MainRealEstateMaintenanceCategories';
const GetSubCategoriesURL =
    "$MaintenanceApiBaseUrl/api/RealEstateMaintenanceCategories/ChildrenRealEstateMaintenanceCategories/";
const GetAllCategoriesURL =
    "$MaintenanceApiBaseUrl/api/RealEstateMaintenanceCategories";
const PostMaintenaceRequestURL =
    '$MaintenanceApiBaseUrl/api/MaintenanceRequests';
const GetRealEstatesURL = '$MaintenanceApiBaseUrl/api/RealEstates';
const GetRealEstatesByIdURL = '$MaintenanceApiBaseUrl/api/RealEstates/{id}';
const GetMaintenaceRequestURL =
    '$MaintenanceApiBaseUrl/api/MaintenanceRequests';
const GetMaintenaceRequestByUserIdURL =
    '$MaintenanceApiBaseUrl/api/MaintenanceRequests/UserRequests/{userID}';
const MikanoShopContactUs = '$MaintenanceApiBaseUrl/api/ContactUs';
const RequestFormUrl =
    "$MaintenanceApiBaseUrl/api/MaintenanceRequests/UpdateMaintenanceRequestStatus/{idrequest}";
const MikanoFoundersUrl = '$MaintenanceApiBaseUrl/api/about-us/founders';
const MikanoCompanyInfoUrl = '$MaintenanceApiBaseUrl/api/Company';
const MikanoCarouselImagesUrl = '$MaintenanceApiBaseUrl/api/carousel-images';

const InspectionApiBaseUrl = 'http://dev.codepickles.com:8087';
const GetInspectionURL = '$InspectionApiBaseUrl/api/Inspections/';
const GetTechnicianInspectionURL =
    '$InspectionApiBaseUrl/api/Inspections/TechnicianInspections/';
const PostInspectionCustomChecklistItemURL =
    '$InspectionApiBaseUrl/api/Inspections/CustomChecklistItem?inspectionID=';
const DeleteInspectionCustomChecklistItemURL =
    '$InspectionApiBaseUrl/api/Inspections/CustomChecklistItem/{id}';
const GetPredefinedCheckListByCategURL =
    '$InspectionApiBaseUrl/api/PredefinedChecklistItems/CategoryChecklist?categoryID=';
const GetCustomCheckListByInspectionURL =
    '$InspectionApiBaseUrl/api/Inspections/InspectionChecklist/';
const ChangeStatusCustomCheckListURL =
    '/api/Inspections/InspectionChecklistItem';
const inspectionChecklistItemIDParameter = "inspectionChecklistItemID";
const componentStatusIDParameter = "componentStatusID";
const GetPredefinedComponentsURL =
    '$InspectionApiBaseUrl/api/Inspections/InspectionChecklist/predefined/{inspectionID}';
const GetCustomComponentsURL =
    '$InspectionApiBaseUrl/api/Inspections/InspectionChecklist/custom/{inspectionID}';
const ComponentsStatusURL = '$InspectionApiBaseUrl/api/ComponentStatus';
const InspectionPriceURL =
    '$InspectionApiBaseUrl/api/PricingNegotiations/maintenance/{maintenanceId}';
const ChangeComponentStatusURL =
    '$InspectionApiBaseUrl/api/Inspections/InspectionChecklistItem?inspectionChecklistItemID={inspectionChecklistItemID}&componentStatusID={componentStatusID}';

const MikanoShopMainURl = 'http://mikanoshop.mauto.co/api';
const MikanoShopTokenURL = '$MikanoShopMainURl/token';
const MikanoShopGetAllProductsURL = '$MikanoShopMainURl/products';
const MikanoShopAddShippingAddress =
    '$MikanoShopMainURl/customers/{customerId}/shippingaddress';
const MikanoShopGetUserById = '$MikanoShopMainURl/customers/{customerId}';
const MikanoShopGetLoggedInUser = '$MikanoShopMainURl/customers/me';
const MikanoFavoritAndCartItems = '$MikanoShopMainURl/shopping_cart_items';
const MikanoDeleteFavoritAndCartItems =
    '$MikanoShopMainURl/shopping_cart_items/delete';
const MikanoChangeQuantityCartItem =
    '$MikanoShopMainURl/shopping_cart_items/incrementqty';
const MikanoShopPlaceOrder = '$MikanoShopMainURl/orders';

const mainAppName = 'My Mikano App';

const PoppinsFamily = 'Poppins';

/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 34.0;

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;

const logoAsset = 'assets/SplashScreenMikanoLogo.png';
const ssidUrl = "http://192.168.4.1";
const ssidUri = "192.168.4.1";
const ssidRestartUrl = ssidUrl + '/restart';
const cloudIotMautoUrl = "https://iotapi.mauto.co/api";
const cloudIotMautoAuthUrl = cloudIotMautoUrl + "/User/token";
const cloudIotMautoSensorsUrl = cloudIotMautoUrl + "/generators/values/";
const cloudIotMautoUserGeneratorsUrl = cloudIotMautoUrl + "/generators/list/";
const lanESPUrl = "espapiendpoint";
const resetESPUrl = "http://"+lanESPUrl + "/reset";

const LocationUrl = 'http://dev.codepickles.com:8094';
const LocationSettingsUrl = '$LocationUrl/api/LocationSettings';
const LocationByDeviceUrl = '$LocationUrl/api/TrackedUsers/Location';

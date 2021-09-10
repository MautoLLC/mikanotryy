const KeyCloakBaseUrl = 'https://dev.codepickles.com:8443';
const identifier = 'MymikanoApp';
const secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';
const authorizationEndpoint =
    '$KeyCloakBaseUrl/auth/realms/master/protocol/openid-connect/token';
const RegisterUserURL = '$KeyCloakBaseUrl/auth/admin/realms/master/users';

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
const GetMaintenaceRequestURL =
    '$MaintenanceApiBaseUrl/api/MaintenanceRequests';

const InspectionApiBaseUrl = 'http://dev.codepickles.com:8087';
const GetInspectionURL = '$InspectionApiBaseUrl/api/Inspections/';
const GetTechnicianInspectionURL =
    '$InspectionApiBaseUrl/api/Inspections/TechnicianInspections/';
const PostInspectionCustomChecklistItemURL =
    '$InspectionApiBaseUrl/api/Inspections/CustomChecklistItem?inspectionID=';
const GetPredefinedCheckListByCategURL =
    '$InspectionApiBaseUrl/api/PredefinedChecklistItems/CategoryChecklist?categoryID=';
const GetCustomCheckListByInspectionURL =
    '$InspectionApiBaseUrl/api/Inspections/InspectionChecklist/';
const ChangeStatusCustomCheckListURL =
    '/api/Inspections/InspectionChecklistItem';
const inspectionChecklistItemIDParameter = "inspectionChecklistItemID";
const componentStatusIDParameter = "componentStatusID";
const ComponentsURL = '$InspectionApiBaseUrl/api/Components';
const ComponentsStatusURL = '$InspectionApiBaseUrl/api/ComponentStatus';

const mainAppName = 'My Mikano App';

const fontRegular = 'Roboto';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';

/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;
const textSizeXXLarge = 35.0;

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;

// Shared Pref
const appOpenCount = 'appOpenCount';

/// Linux - for linux, you have to change default window width in linux/my_application.cc
const applicationMaxWidth = 500.0;

const profileImage =
    'images/widgets/materialWidgets/mwInputSelectionWidgets/Checkbox/profile.png';
const isDarkModeOnPref = 'isDarkModeOnPref';
const dateFormat = 'MMM dd, yyyy';

const BaseUrl = 'https://iqonic.design/themeforest-images/prokit';
const BaseUrl2 = 'https://assets.iqonic.design/old-themeforest-images/prokit';
const SourceCodeUrl =
    'https://codecanyon.net/item/prokit-flutter-app-ui-design-templete-kit/25787190?s_rank=11';
const PlayStoreUrl = 'https://play.google.com/store/apps/details?id=';
const DocumentationUrl = 'https://iqonic.design/docs/product/prokit-flutter/';
const ChangeLogsUrl =
    'https://iqonic.design/docs/product/prokit-flutter/updates/change-logs/';
const MimikCloneUrl =
    'https://codecanyon.net/item/mimik-multi-category-flutter-app-ui-kit-clone/29382568?s_rank=2';
const mikano1Url = 'https://www.mikano-intl.com/philips';
const mikano2Url = 'https://www.mikano-intl.com/abb';

const bannerAdIdForAndroidRelease = "ca-app-pub-1399327544318575/5026584528";
const bannerAdIdForAndroid = "ca-app-pub-3940256099942544/6300978111";
const bannerAdIdForIos = "ca-app-pub-3940256099942544/2934735716";
const InterstitialAdIdForAndroidRelease =
    "ca-app-pub-1399327544318575/8774597158";
const InterstitialAdIdForAndroid = "ca-app-pub-3940256099942544/1033173712";
const interstitialAdIdForIos = "ca-app-pub-3940256099942544/4411468910";

const SampleImageUrl = '$BaseUrl/images/defaultTheme/slider/01.jpg';
const SampleImageUrl2 = '$BaseUrl/images/defaultTheme/slider/04.jpg';
const SampleImageUrl3 = '$BaseUrl/images/defaultTheme/slider/03.jpg';
const SampleImageUrl4 = '$BaseUrl/images/defaultTheme/slider/05.jpg';
const SampleProfileImageUrl =
    'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200';

const LoremText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text';

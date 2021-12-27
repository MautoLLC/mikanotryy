const KeyCloakBaseUrl = 'https://dev.mauto.co';
const identifier = 'MymikanoApp';
const secret = '45475923-b3ef-46c5-aa70-79475824d3f9';
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

const t13_name = "Name";
const t13_description = "Description";
const t13_provider = "Provider";
const t13_unit_price = "Unit Price";
const t13_status = "Status";
const t13_cancel = "Cancel";
const t13_save = "Save";

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
class ApiEndPoints
{
  static final String baseUrl = 'https://hmsktn06.kauverykonnect.com/hmsktnscripts/ASBMenuRest.dll/datasnap/rest/TASBMenuREST/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static final String baseUrltest = 'https://kcnhmstest.kauverykonnect.com/hmstestscripts/ASBMenuRest.dll/datasnap/rest/TASBMenuREST/';
  static final String mybaseurl='https://pdf.medicall.in/api/v1/';
}
class _AuthEndPoints
{
  final String qrcodegenerate = 'getchoices';
  final String loginEmail = 'Login';
  final String storepdqform='store-pdqform-entires';
}

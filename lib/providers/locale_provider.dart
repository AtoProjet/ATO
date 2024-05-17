import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Tr {
  appName,
  switchLang,
  iAmNewUser,
  iHaveAnAccount,
  notifications,
  orders,
  logout,
  clothes,
  books,
  toys,
  shoes,
  bags,
  categories,
  color,
  ok,
  accountType,
  selectAccountType,
  beneficiary,
  donor,
  description,
  size,
  addItem,
  men,
  women,
  children,
  termsAndConditions,
  withATO,
  goBackToRegister,
  add,
  itemDetails,
  communication,
  home,
  shopping,
  filter,
  searchResultsFor,
  cart,
  chat,
  support,
  profile,
  email,
  password,
  textContains6lettersOrMore,
  login,
  youDontHaveAnAccount,
  register,
  notFound,
  registrationError,
  verificationCode,
  checkYourEmail,
  verified,
  notVerified,
  checkStatus,
  goToHome,
  useAnotherAccount,
  didNotReceiveCode,
  resend,
  aNewVerificationEmailHasBeenSentTo,
  failedToResendVerificationEmail,
  forGender,
  details,
  manageAccounts,
  supportMustBeReviewed,
  donatedItems,
  disableAccount,
  enableAccount,
  disabled,
  enabled,
  failedToDisableAccount,
  failedToEnableAccount,
  typesOfEducationalMaterials,
  articlesWithPictures,
  announcementOfCampaigns,
  articles,
  title,
  content,
  itemsCategory,
  continueText,
  thankYou,
  yourCartIsEmpty,
  name,
  quantity,
  nameIsRequired,
  descriptionIsRequired,
  quantityIsRequired,
  itemAddedSuccessfully,
  removeItem,
  success,
  deliveryDetails,
  selectUsers, selectDeliveryTime, theOrderWillBeDeliveredByTheDonor, selectDeliveryDate,
  item,
  orderId,
  qty,
  noChatsAvailable,
  invalidCredential,


}

final Map<String, Map<Tr, String>> _lang = {
  "ar": {
    Tr.appName: 'آتو',
    Tr.switchLang: 'English',
    Tr.iAmNewUser: 'أنا مستخدم جديد',
    Tr.iHaveAnAccount: "لدي حساب",
    Tr.notifications: "التنبيهات",
    Tr.orders: "الطلبات",
    Tr.logout: "تسجيل الخروج",
    Tr.clothes: "الملابس",
    Tr.books: "الكتب",
    Tr.toys: "الألعاب",
    Tr.shoes: "الأحذية",
    Tr.bags: "الحقائب",
    Tr.categories: "التصنيفات",
    Tr.color: 'اللون',
    Tr.ok: 'موافق',
    Tr.accountType: 'نوع الحساب',
    Tr.selectAccountType: 'اختر نوع الحساب',
    Tr.beneficiary: 'المستفيد',
    Tr.donor: 'المتبرع',
    Tr.description: 'الوصف',
    Tr.size: 'المقاس',
    Tr.addItem: 'أضف عنصراً',
    Tr.men: 'رجالي',
    Tr.women: 'نسائي',
    Tr.children: 'أطفال',
    Tr.termsAndConditions: 'الشروط والأحكام',
    Tr.withATO: 'مع آتو',
    Tr.goBackToRegister: 'العودة للتسجيل',
    Tr.add: 'أضف',
    Tr.itemDetails: 'تفاصيل العنصر',
    Tr.communication: 'التواصل',
    Tr.home: 'الرئيسية',
    Tr.shopping: 'التسوق',
    Tr.filter: 'تصفية',
    Tr.searchResultsFor: 'نتائج البحث عن',
    Tr.cart: 'السلة',
    Tr.chat: 'المحادثة',
    Tr.support: 'الدعم',
    Tr.profile: 'الملف الشخصي',
    Tr.email: 'البريد الإلكتروني',
    Tr.password: 'كلمة المرور',
    Tr.textContains6lettersOrMore: 'يجب أن تحتوي النص على 6 أحرف أو أكثر',
    Tr.login: 'تسجيل الدخول',
    Tr.youDontHaveAnAccount: 'ليس لديك حساب؟',
    Tr.register: 'سجل الآن',
    Tr.notFound: 'غير موجود',
    Tr.registrationError: 'خطأ في التسجيل',
    Tr.verificationCode: 'كود التحقق',
    Tr.checkYourEmail: 'تحقق من بريدك الإلكتروني',
    Tr.verified: 'تم التحقق',
    Tr.notVerified: 'لم يتم التحقق',
    Tr.checkStatus: 'تحقق من الحالة',
    Tr.goToHome: 'الذهاب إلى الرئيسية',
    Tr.useAnotherAccount: 'استخدم حساب آخر',
    Tr.didNotReceiveCode: 'لم تستلم الرمز؟',
    Tr.resend: 'إعادة إرسال',
    Tr.aNewVerificationEmailHasBeenSentTo:
        'تم إرسال بريد إلكتروني جديد للتحقق إلى',
    Tr.failedToResendVerificationEmail: 'فشل في إعادة إرسال بريد التحقق',
    Tr.forGender: 'النوع',
    Tr.details: 'التفاصيل',
    Tr.continueText: 'إستمرار',
    Tr.thankYou: 'شكرا لاستخدامك آتو',
    Tr.yourCartIsEmpty: 'سلتك فارغة',
    Tr.name: 'الإسم',
    Tr.quantity: 'العدد',
    Tr.nameIsRequired: 'الإسم مطلوب!',
    Tr.descriptionIsRequired: 'الوصف مطلوب!',
    Tr.quantityIsRequired: 'العدد مطلوب!',
    Tr.itemAddedSuccessfully: "تمت الإضافة بنجاح",
    Tr.removeItem: "حذف العنصر",
    Tr.success: "نجاح",
    Tr.deliveryDetails: "معلومات التوصيل",



    Tr.manageAccounts: 'إدارة الحسابات',
    Tr.supportMustBeReviewed: 'يجب مراجعة الدعم',
    Tr.donatedItems: 'العناصر المتبرع بها',
    Tr.disableAccount: 'تعطيل الحساب',
    Tr.enableAccount: 'تمكين الحساب',
    Tr.enabled: 'ممكّن',
    Tr.disabled: 'عاجز',
    Tr.failedToDisableAccount: 'فشل في تعطيل الحساب',
    Tr.failedToEnableAccount: 'فشل في تمكين الحساب',
    Tr.typesOfEducationalMaterials: 'أنواع المواد التعليمية',
    Tr.articlesWithPictures: 'مقالات بالصور',
    Tr.announcementOfCampaigns: 'إعلان الحملات',
    Tr.articles: 'مقالات',
    Tr.title: 'عنوان',
    Tr.content: 'محتوى',
    Tr.itemsCategory: 'فئات العناصر',
    Tr.selectUsers: 'حدد المستخدمين',
    Tr.selectDeliveryTime:"اختر وقت التوصيل:",
    Tr.theOrderWillBeDeliveredByTheDonor:"سيتم توصيل الطلب بواسطة المتبرع",
    Tr.selectDeliveryDate:"اختر تاريخ التسليم:",

    Tr.item:"غرض",
    Tr.orderId:"رقم الأمر",
    Tr.qty:"كمية",
    Tr.noChatsAvailable:"لا توجد محادثات متاحة",
    Tr.invalidCredential:"شهادة اعتماد غير صالحة",


  },

  'en': {
    Tr.appName: 'ATO',
    Tr.switchLang: 'عربي',
    Tr.iAmNewUser: 'I am a new user',
    Tr.iHaveAnAccount: 'I have an Account',
    Tr.notifications: "Notifications",
    Tr.orders: "Orders",
    Tr.logout: "Logout",
    Tr.clothes: "Clothes",
    Tr.books: "Books",
    Tr.toys: "Toys",
    Tr.shoes: "Shoes",
    Tr.bags: "Bags",
    Tr.categories: "Categories",
    Tr.color: 'Color',
    Tr.ok: 'OK',
    Tr.accountType: 'Account Type',
    Tr.selectAccountType: 'Select Account Type',
    Tr.beneficiary: 'Beneficiary',
    Tr.donor: 'Donor',
    Tr.description: 'Description',
    Tr.size: 'Size',
    Tr.addItem: 'Add Item',
    Tr.men: 'Men',
    Tr.women: 'Women',
    Tr.children: 'Children',
    Tr.termsAndConditions: 'Terms and Conditions',
    Tr.withATO: 'With ATO',
    Tr.goBackToRegister: 'Go back to register',
    Tr.add: 'Add',
    Tr.itemDetails: 'Item Details',
    Tr.communication: 'Communication',
    Tr.home: 'Home',
    Tr.shopping: 'Shopping',
    Tr.filter: 'Filter',
    Tr.searchResultsFor: 'Search results for',
    Tr.cart: 'Cart',
    Tr.chat: 'Chat',
    Tr.support: 'Support',
    Tr.profile: 'Profile',
    Tr.email: 'Email',
    Tr.password: 'Password',
    Tr.textContains6lettersOrMore: 'Text contains 6 letters or more',
    Tr.login: 'Login',
    Tr.youDontHaveAnAccount: 'You don\'t have an account?',
    Tr.register: 'Register now',
    Tr.notFound: 'Not Found',
    Tr.registrationError: 'Registration Error',
    Tr.verificationCode: 'Verification Code',
    Tr.checkYourEmail: 'Check your email',
    Tr.verified: 'Verified',
    Tr.notVerified: 'Not Verified',
    Tr.checkStatus: 'Check Status',
    Tr.goToHome: 'Go to home',
    Tr.useAnotherAccount: 'Use another account',
    Tr.didNotReceiveCode: 'Did not receive the code?',
    Tr.resend: 'Resend',
    Tr.aNewVerificationEmailHasBeenSentTo:
        'A new verification email has been sent to',
    Tr.failedToResendVerificationEmail: 'Failed to resend verification email',
    Tr.forGender: 'For',
    Tr.details: 'Details',
    Tr.continueText: 'Continue',
    Tr.thankYou: 'Thank you for choosing ATO',
    Tr.yourCartIsEmpty: 'Your cart is empty!',
    Tr.name: 'Name',
    Tr.quantity: 'Quantity',
    Tr.nameIsRequired: 'Name is required!',
    Tr.descriptionIsRequired: 'Description is required!',
    Tr.quantityIsRequired: 'Quantity is required!',
    Tr.itemAddedSuccessfully: "÷tem Added Successfully",
    Tr.removeItem: "Remove Item",
    Tr.success: "Success",
    Tr.deliveryDetails: "Delivery Details",

    Tr.manageAccounts: 'Manage Accounts',
    Tr.supportMustBeReviewed: 'Support must be reviewed',
    Tr.donatedItems: 'Donated Items',
    Tr.disableAccount: 'Disable Account',
    Tr.enableAccount: 'Enable Account',
    Tr.enabled: 'Enabled',
    Tr.disabled: 'Disabled',
    Tr.failedToDisableAccount: 'Failed to Disable Account',
    Tr.failedToEnableAccount: 'Failed to Enable Account',
    Tr.typesOfEducationalMaterials: 'Types of Educational Materials',
    Tr.articlesWithPictures: 'Articles with Pictures',
    Tr.announcementOfCampaigns: 'Announcement of Campaigns',
    Tr.articles: 'Articles',
    Tr.title: 'Title',
    Tr.content: 'Content',
    Tr.itemsCategory: 'Items Category',
    Tr.selectUsers: 'Select Users',
    Tr.selectDeliveryTime:"Select Delivery Time:",
    Tr.theOrderWillBeDeliveredByTheDonor:"The order will be delivered by the donor",
    Tr.selectDeliveryDate:"Select Delivery Date:",
    Tr.item:"Item",
    Tr.orderId:"Order Id",
    Tr.qty:"Qty",
    Tr.noChatsAvailable:"No Chats Available",
    Tr.invalidCredential:"Invalid Credentials",


  },
};

class LocaleProvider extends ChangeNotifier {
  Locale get locale => _locale;
  Locale _locale = const Locale('en');
  final List<Locale> locales = [
    const Locale('ar'),
    const Locale('en'),
  ];

  void setLocale(Locale newLocale) {
    if (!locales.contains(newLocale)) {
      return;
    }
    _locale = newLocale;
    if(isAr()){
      _saveLang("ar");
    }
    else{
      _saveLang("en");
    }
    notifyListeners();
  }
  // void loadLang(){
  //   SharedPreferences.getInstance()
  //       .then((prefs){
  //     String lang= prefs.getString('lang') ?? "ar";
  //     if (lang == "en") {
  //       setLocale(en());
  //     } else {
  //       setLocale(ar());
  //     }
  //     notifyListeners();
  //   });
  // }

  void _saveLang(String lang) {
    SharedPreferences.getInstance()
    .then((prefs){

      prefs.setString('lang', lang);
    });
  }

  LocaleProvider() {
    print("in LocaleProvider");
    SharedPreferences.getInstance()
    .then((prefs){
      String lang= prefs.getString('lang') ?? "ar";
      if (lang == "en") {
        setLocale(en());
      } else {
        setLocale(ar());
      }
    });
  }

  bool isAr() {
    return _locale.languageCode == ar().languageCode;
  }

  bool isEn() {
    return _locale.languageCode == en().languageCode;
  }

  Locale ar() {
    return locales[0];
  }

  Locale en() {
    return locales[1];
  }

  String of(Tr key) {
    Map<Tr, String> trs = _lang[locale.languageCode]!;
    if (trs.containsKey(key)) {
      return trs[key]!;
    }
    return key.name;
  }

  ofStr(String text) {
    for (Tr tr in Tr.values) {
      if (tr.name == text) {
        return of(tr);
      }
    }
    return text;
  }
}

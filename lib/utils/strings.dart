enum AppLocale { en, tr }

class AppStrings {
  static AppLocale _locale = AppLocale.en;

  static AppLocale get locale => _locale;

  static void setLocale(AppLocale locale) {
    _locale = locale;
  }

  static String _t(String key) => _translations[key]![_locale]!;

  static String get email => _t('email');
  static String get signUp => _t('signUp');
  static String get password => _t('password');
  static String get forgotPassword => _t('forgotPassword');
  static String get signIn => _t('signIn');
  static String get dontHaveAnAccount => _t('dontHaveAnAccount');
  static String get username => _t('username');
  static String get fullname => _t('fullname');
  static String get bio => _t('bio');
  static String get aldreadyHaveAnAccount => _t('aldreadyHaveAnAccount');
  static String get photo => _t('photo');
  static String get changeProfilePhoto => _t('changeProfilePhoto');
  static String get save => _t('save');
  static String get comments => _t('comments');
  static String get send => _t('send');
  static String get message => _t('message');
  static String get delete => _t('delete');
  static String get deleted => _t('deleted');
  static String get report => _t('report');
  static String get sent => _t('sent');
  static String get showMore => _t('showMore');
  static String get policyText => _t('policyText');
  static String get seePolicy => _t('seePolicy');
  static String get policyComingSoon => _t('policyComingSoon');
  static String get conversations => _t('conversations');
  static String get deleteAll => _t('deleteAll');
  static String get deleteAllNotifications => _t('deleteAllNotifications');
  static String get no => _t('no');
  static String get yes => _t('yes');
  static String get sendResetPasswordLink => _t('sendResetPasswordLink');
  static String get resetPasswordSubtitle => _t('resetPasswordSubtitle');
  static String get emailIsBlank => _t('emailIsBlank');
  static String get fullnameIsBlank => _t('fullnameIsBlank');
  static String get usernameIsBlank => _t('usernameIsBlank');
  static String get usernameMustStartWithALowercaseLetter =>
      _t('usernameMustStartWithALowercaseLetter');
  static String get usernameCanOnlyContains => _t('usernameCanOnlyContains');
  static String get passwordMustContainAtLeastSixCharacters =>
      _t('passwordMustContainAtLeastSixCharacters');
  static String get emailOrPasswordIsWrong => _t('emailOrPasswordIsWrong');
  static String get invalidEmail => _t('invalidEmail');
  static String get userDisabled => _t('userDisabled');
  static String get emailAlreadyInUse => _t('emailAlreadyInUse');
  static String get usernameAlreadyInUse => _t('usernameAlreadyInUse');
  static String get operationNotAllowed => _t('operationNotAllowed');
  static String get weakPassword => _t('weakPassword');
  static String get feed => _t('feed');
  static String get like => _t('like');
  static String get likes => _t('likes');
  static String get share => _t('share');
  static String get enterYourCaption => _t('enterYourCaption');
  static String get profile => _t('profile');
  static String get search => _t('search');
  static String get discover => _t('discover');
  static String get cancel => _t('cancel');
  static String get uploadPost => _t('uploadPost');
  static String get shared => _t('shared');
  static String get postUploadFailed => _t('postUploadFailed');
  static String get notifications => _t('notifications');
  static String get likeNotificationMessage => _t('likeNotificationMessage');
  static String get commentNotificationMessage =>
      _t('commentNotificationMessage');
  static String get followNotificationMessage =>
      _t('followNotificationMessage');
  static String get posts => _t('posts');
  static String get followers => _t('followers');
  static String get following => _t('following');
  static String get follow => _t('follow');
  static String get editProfile => _t('editProfile');
  static String get profileUpdateFailed => _t('profileUpdateFailed');
  static String get noPostsYet => _t('noPostsYet');
  static String get feedLoadError => _t('feedLoadError');
  static String get alreadyReportedUser => _t('alreadyReportedUser');
  static String get userReported => _t('userReported');
  static String get language => _t('language');
  static String get settings => _t('settings');
  static String get logOut => _t('logOut');
  static String get english => _t('english');
  static String get turkish => _t('turkish');

  static const Map<String, Map<AppLocale, String>> _translations = {
    'email': {AppLocale.en: 'Email', AppLocale.tr: 'E-posta'},
    'signUp': {AppLocale.en: 'Sign Up', AppLocale.tr: 'Kayıt Ol'},
    'password': {AppLocale.en: 'Password', AppLocale.tr: 'Şifre'},
    'forgotPassword': {
      AppLocale.en: 'Forgot Password?',
      AppLocale.tr: 'Şifremi Unuttum'
    },
    'signIn': {AppLocale.en: 'Sign In', AppLocale.tr: 'Giriş Yap'},
    'dontHaveAnAccount': {
      AppLocale.en: 'Don\'t have an account?',
      AppLocale.tr: 'Hesabın yok mu?'
    },
    'username': {AppLocale.en: 'Username', AppLocale.tr: 'Kullanıcı Adı'},
    'fullname': {AppLocale.en: 'Full Name', AppLocale.tr: 'Tam Ad'},
    'bio': {AppLocale.en: 'Bio', AppLocale.tr: 'Hakkında'},
    'aldreadyHaveAnAccount': {
      AppLocale.en: 'Already have an account?',
      AppLocale.tr: 'Zaten hesabın var mı?'
    },
    'photo': {AppLocale.en: 'Photo', AppLocale.tr: 'Fotoğraf'},
    'changeProfilePhoto': {
      AppLocale.en: 'Change Profile Photo',
      AppLocale.tr: 'Profil Fotoğrafını Değiştir'
    },
    'save': {AppLocale.en: 'Save', AppLocale.tr: 'Kaydet'},
    'comments': {AppLocale.en: 'Comments', AppLocale.tr: 'Yorumlar'},
    'send': {AppLocale.en: 'Send', AppLocale.tr: 'Gönder'},
    'message': {AppLocale.en: 'Message', AppLocale.tr: 'Mesaj'},
    'delete': {AppLocale.en: 'Delete', AppLocale.tr: 'Sil'},
    'deleted': {AppLocale.en: 'Deleted', AppLocale.tr: 'Silindi'},
    'report': {AppLocale.en: 'Report', AppLocale.tr: 'Raporla'},
    'sent': {AppLocale.en: 'Sent', AppLocale.tr: 'Gönderildi'},
    'showMore': {AppLocale.en: 'show more', AppLocale.tr: 'devamı'},
    'policyText': {
      AppLocale.en:
          'By continuing you agree to our Privacy Policy and terms of service',
      AppLocale.tr:
          'Devam ederek Gizlilik Politikamızı ve hizmet şartlarımızı kabul etmiş olursunuz',
    },
    'seePolicy': {
      AppLocale.en: 'See Privacy Policy',
      AppLocale.tr: 'Gizlilik Politikasını gör'
    },
    'policyComingSoon': {
      AppLocale.en: 'Privacy Policy coming soon',
      AppLocale.tr: 'Gizlilik Politikası yakında',
    },
    'conversations': {AppLocale.en: 'Conversations', AppLocale.tr: 'Sohbetler'},
    'deleteAll': {AppLocale.en: 'Delete All', AppLocale.tr: 'Hepsini Sil'},
    'deleteAllNotifications': {
      AppLocale.en: 'Delete all notifications?',
      AppLocale.tr: 'Bütün bildirimler silinsin mi?',
    },
    'no': {AppLocale.en: 'No', AppLocale.tr: 'Hayır'},
    'yes': {AppLocale.en: 'Yes', AppLocale.tr: 'Evet'},
    'sendResetPasswordLink': {
      AppLocale.en: 'Send Reset Password Link',
      AppLocale.tr: 'Şifre Sıfırlama Bağlantısı Gönder',
    },
    'resetPasswordSubtitle': {
      AppLocale.en:
          'Enter your email and we\'ll send you a link to reset your password',
      AppLocale.tr:
          'E-postanızı girin, şifrenizi sıfırlamanız için bir bağlantı gönderelim',
    },
    'emailIsBlank': {
      AppLocale.en: 'Email field is blank!',
      AppLocale.tr: 'Email alanı boş!'
    },
    'fullnameIsBlank': {
      AppLocale.en: 'Full Name field is blank!',
      AppLocale.tr: 'Tam Ad alanı boş!'
    },
    'usernameIsBlank': {
      AppLocale.en: 'Username field is blank!',
      AppLocale.tr: 'Kullanıcı Adı boş!'
    },
    'usernameMustStartWithALowercaseLetter': {
      AppLocale.en: 'Username must start with a lowercase letter!',
      AppLocale.tr: 'Kullanıcı Adı küçük harfle başlamalıdır!',
    },
    'usernameCanOnlyContains': {
      AppLocale.en:
          'Username can only contain lowercase letters, numbers and underscores!',
      AppLocale.tr:
          'Kullanıcı Adı sadece küçük harf, sayı ve alt çizgi içerebilir!',
    },
    'passwordMustContainAtLeastSixCharacters': {
      AppLocale.en: 'Password must contain at least 6 characters!',
      AppLocale.tr: 'Şifre en az 6 karakter içermelidir!',
    },
    'emailOrPasswordIsWrong': {
      AppLocale.en: 'Email or password is wrong!',
      AppLocale.tr: 'Email veya şifre yanlış!',
    },
    'invalidEmail': {
      AppLocale.en: 'Invalid email address!',
      AppLocale.tr: 'E-posta adresi geçersiz!'
    },
    'userDisabled': {
      AppLocale.en: 'User disabled!',
      AppLocale.tr: 'Kullanıcı devre dışı!'
    },
    'emailAlreadyInUse': {
      AppLocale.en: 'This email address is already registered!',
      AppLocale.tr: 'Bu email adresi zaten kayıtlı!',
    },
    'usernameAlreadyInUse': {
      AppLocale.en: 'This username is already in use!',
      AppLocale.tr: 'Bu kullanıcı adı kullanımda!',
    },
    'operationNotAllowed': {
      AppLocale.en: 'Email/password accounts are not enabled!',
      AppLocale.tr: 'E-posta/şifre hesapları etkinleştirilmemiş!',
    },
    'weakPassword': {
      AppLocale.en: 'Password is not strong enough!',
      AppLocale.tr: 'Şifre yeterince güçlü değil!'
    },
    'feed': {AppLocale.en: 'Feed', AppLocale.tr: 'Öne Çıkanlar'},
    'like': {AppLocale.en: 'like', AppLocale.tr: 'beğeni'},
    'likes': {AppLocale.en: 'likes', AppLocale.tr: 'beğeni'},
    'share': {AppLocale.en: 'Share', AppLocale.tr: 'Paylaş'},
    'enterYourCaption': {
      AppLocale.en: 'Enter your caption',
      AppLocale.tr: 'Açıklamanızı girin'
    },
    'profile': {AppLocale.en: 'Profile', AppLocale.tr: 'Profil'},
    'search': {AppLocale.en: 'Search', AppLocale.tr: 'Arama'},
    'discover': {AppLocale.en: 'Discover', AppLocale.tr: 'Keşfet'},
    'cancel': {AppLocale.en: 'Cancel', AppLocale.tr: 'İptal'},
    'uploadPost': {AppLocale.en: 'Upload Post', AppLocale.tr: 'Gönderi Ekle'},
    'shared': {AppLocale.en: 'Shared', AppLocale.tr: 'Paylaşıldı'},
    'postUploadFailed': {
      AppLocale.en: 'Something went wrong sharing your post. Please try again.',
      AppLocale.tr:
          'Gönderin paylaşılırken bir sorun oluştu. Lütfen tekrar dene.',
    },
    'notifications': {
      AppLocale.en: 'Notifications',
      AppLocale.tr: 'Bildirimler'
    },
    'likeNotificationMessage': {
      AppLocale.en: 'liked one of your posts.',
      AppLocale.tr: 'bir gönderini beğendi.',
    },
    'commentNotificationMessage': {
      AppLocale.en: 'commented one of your posts.',
      AppLocale.tr: 'bir gönderine yorum yaptı.',
    },
    'followNotificationMessage': {
      AppLocale.en: 'started to follow you.',
      AppLocale.tr: 'seni takip etmeye başladı.',
    },
    'posts': {AppLocale.en: 'Posts', AppLocale.tr: 'Gönderi'},
    'followers': {AppLocale.en: 'Followers', AppLocale.tr: 'Takipçi'},
    'following': {AppLocale.en: 'Following', AppLocale.tr: 'Takip'},
    'follow': {AppLocale.en: 'Follow', AppLocale.tr: 'Takip Et'},
    'editProfile': {
      AppLocale.en: 'Edit Profile',
      AppLocale.tr: 'Profili Düzenle'
    },
    'profileUpdateFailed': {
      AppLocale.en: 'Something went wrong updating your profile. Please try again.',
      AppLocale.tr:
          'Profilin güncellenirken bir sorun oluştu. Lütfen tekrar dene.',
    },
    'noPostsYet': {
      AppLocale.en: 'No posts yet',
      AppLocale.tr: 'Henüz gönderi yok'
    },
    'feedLoadError': {
      AppLocale.en: 'Something went wrong loading posts. Pull to try again.',
      AppLocale.tr:
          'Gönderiler yüklenirken bir sorun oluştu. Tekrar denemek için çekin.',
    },
    'alreadyReportedUser': {
      AppLocale.en: 'You have already reported this user',
      AppLocale.tr: 'Bu kullanıcıyı zaten bildirdiniz',
    },
    'userReported': {
      AppLocale.en: 'User reported',
      AppLocale.tr: 'Kullanıcı bildirildi'
    },
    'language': {AppLocale.en: 'Language', AppLocale.tr: 'Dil'},
    'settings': {AppLocale.en: 'Settings', AppLocale.tr: 'Ayarlar'},
    'logOut': {AppLocale.en: 'Log Out', AppLocale.tr: 'Çıkış Yap'},
    'english': {AppLocale.en: 'English', AppLocale.tr: 'İngilizce'},
    'turkish': {AppLocale.en: 'Turkish', AppLocale.tr: 'Türkçe'},
  };
}

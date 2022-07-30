(function () {
  /* firebabse 웹 페이지 콘솔 -> 프로젝트 설정 -> sdk 설정 및 구성에서 복사
  const firebaseConfig = {
    apiKey: 'AIzaSyBY9tPiZh08ejKX16WpQknxb03BQVH-YV8',
    authDomain: 'testlogin-46429.firebaseapp.com',
    databaseURL: 'https://testlogin-46429-default-rtdb.firebaseio.com',
    projectId: 'testlogin-46429',
    storageBucket: 'testlogin-46429.appspot.com',
    messagingSenderId: '1009454182432',
    appId: '1:1009454182432:web:b704be0a4ff752088c0c45',
  };
*/
  firebase.initializeApp(firebaseConfig);

  const btnSignInWithGoogle = document.getElementById('signInWithGoogle');
  const btnSignInWithFacebook = document.getElementById('signInWithFacebook');
  const btnSignInWithTwitter = document.getElementById('signInWithTwitter');

  //check login state
  firebase.auth().onAuthStateChanged((firebaseUser) => {
    if (firebaseUser) {
      console.log(firebaseUser);
    } else {
      console.log('not logged in');
    }
  });

  function signInWithGoogle() {
    const googleProvider = new firebase.auth.GoogleAuthProvider();
    firebase.auth().languageCode = 'ko';
    firebase
      .auth()
      .signInWithPopup(googleProvider)
      .then(() => {
        window.location.assign('./main.html');
      })
      .catch((error) => {
        console.error(error);
      });
  }

  //need to change app id,password in firebase console at release Version
  //test version facebook id,password now
  function signInWithFacebook() {
    const facebookProvider = new firebase.auth.FacebookAuthProvider();
    firebase.auth().languageCode = 'ko';
    firebase
      .auth()
      .signInWithPopup(facebookProvider)
      .then(() => {
        window.location.assign('./main.html'); //일정 관리 페이지 주소
      })
      .catch((error) => {
        console.error(error);
      });
  }

  function signInWithTwitter() {
    const twitterProvider = new firebase.auth.TwitterAuthProvider();
    firebase.auth().languageCode = 'ko';
    firebase
      .auth()
      .signInWithPopup(twitterProvider)
      .then(() => {
        window.location.assign('./main.html'); // 일정 관리 페이지 주소
      })
      .catch((error) => {
        console.error(error);
      });
  }

  btnSignInWithGoogle.addEventListener('click', signInWithGoogle);
  btnSignInWithFacebook.addEventListener('click', signInWithFacebook);
  btnSignInWithTwitter.addEventListener('click', signInWithTwitter);
})();

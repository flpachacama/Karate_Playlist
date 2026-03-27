function fn() {
  function randomEmail() {
    var token = java.util.UUID.randomUUID().toString().substring(0, 8);
    return 'karate_' + token + '@mailinator.com';
  }

  return {
    buildCreatePayload: function () {
      var payload = read('classpath:data/account/create-account-base.json');
      payload.email = randomEmail();
      return payload;
    },
    buildUpdatePayload: function (email, password) {
      var payload = read('classpath:data/account/update-account-base.json');
      payload.email = email;
      payload.password = password;
      return payload;
    }
  };
}

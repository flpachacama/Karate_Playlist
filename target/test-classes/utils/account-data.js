function fn() {
  var createTemplate = read('classpath:data/account/create-account-base.json');
  var updateTemplate = read('classpath:data/account/update-account-base.json');

  function randomEmail() {
    var token = java.util.UUID.randomUUID().toString().substring(0, 8);
    return 'karate_' + token + '@mailinator.com';
  }

  return {
    buildCreatePayload: function () {
      var payload = karate.clone(createTemplate);
      payload.email = randomEmail();
      return payload;
    },
    buildUpdatePayload: function (email, password) {
      var payload = karate.clone(updateTemplate);
      payload.email = email;
      payload.password = password;
      return payload;
    }
  };
}

function fn() {
  var env = karate.env || 'dev';

  var environments = {
    dev: {
      baseUrl: 'https://automationexercise.com'
    },
    qa: {
      baseUrl: 'https://automationexercise.com'
    }
  };

  var selectedEnv = environments[env] || environments.dev;

  var config = {
    env: env,
    baseUrl: selectedEnv.baseUrl,
    commonHeaders: {
      Accept: 'application/json'
    }
  };

  karate.configure('headers', config.commonHeaders);
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);

  return config;
}

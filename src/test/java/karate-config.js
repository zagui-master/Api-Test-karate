function fn() {
  var env = karate.env; // get system property 'karate.env'

  var getUsernameFromEnv = java.lang.System.getenv('API_USER');
  var getPasswordFromEnv = java.lang.System.getenv('API_PASSWORD');

  if (!getUsernameFromEnv || !getPasswordFromEnv) {
    throw new Error('Las variables de entorno API_USER y API_PASSWORD deben estar configuradas.');
  }

  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    baseUrl:'https://restful-booker.herokuapp.com',
    credential:{
        "username": getUsernameFromEnv,
        "password": getPasswordFromEnv
       }
    }

  if (env == 'dev') {
   // Configuración para ambiente de desarrollo
  } else if (env == 'qa') {
   // Configuración para ambiente de qa
   }

  return config;
}
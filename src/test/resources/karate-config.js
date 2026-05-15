function fn() {
  var env = karate.env || 'qa';
  karate.log('======= ENVIRONMENT =======', env);

  var config = {
    env: env,
    baseUrl: 'https://reqres.in',
    apiKey: karate.properties['api.key'] || 'free_user_3DOxeEfMMUfli99bSkdNeoO0jEn'
  }
 if (env == 'qa') {
     config.testUser = 'qa_specialist_user';
   } else if (env == 'uat') {
     config.testUser = 'uat_business_user';
   }
   //Esa configuración se ejecuta AUTOMÁTICAMENTE antes de cada feature.
   karate.configure('headers', {
      'x-api-key': config.apiKey,
      'Content-Type': 'application/json'
   });
  // Tiempo máximo para establecer la conexión con el servidor
    karate.configure('connectTimeout', 5000);
   //Tiempo máximo de espera por la respuesta una vez establecida la conexión.
    karate.configure('readTimeout', 5000);
  return config;
}
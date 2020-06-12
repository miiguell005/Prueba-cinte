angular.module('Cinte')
  .factory("http", function ($q) {

    //Trabaja la intercepción de la query, cada vez que se hace una petición al servidor se envia
    //El token de autorización en la cabecera 
    return {
      request: function (config) {

          console.log("Si entra")
        config.headers = config.headers || {};

        if (amplify.store.sessionStorage("user"))
            config.headers.authorization = amplify.store.sessionStorage("user").idUsuario;

        return config;
      },
      response: function (response) {
        if (response.status === 401) {
          //asdasdasd
          console.log();
        }

        return response;
      }
    };

  });


angular.module('Cinte')
  .config(function ($httpProvider) {

    $httpProvider.interceptors.push("http");

  });

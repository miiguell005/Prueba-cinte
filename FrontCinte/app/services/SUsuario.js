angular.module('Cinte')
    .factory('SUsuario', SUsuario);

function SUsuario($resource, userService) {
    var urlService = userService.urlService;

    return $resource(urlService + "Api/Usuarios/:IdUsuario", { IdUsuario: "@IdUsuario" },
        {
            query: {
                method: 'GET', url: urlService + "Api/Usuarios", isArray: true
            },
            getUsuario: {
                method: 'GET', url: urlService + "Api/Usuarios/usuario/:IdUsuario", params: { IdUsuario: "@IdUsuario" }, isArray: false
            },
            post: {
                method: 'POST', url: urlService + "Api/Usuarios", isArray: false
            },
            put: {
                method: 'PUT', url: urlService + "Api/Usuarios/:IdUsuario", params: { IdUsuario: "@IdUsuario" }, isArray: false
            },
            remove: {
                method: 'Delete', url: urlService + "api/Usuarios/:IdUsuario", params: { IdUsuario: "@IdUsuario" }, isArray: false
            },
            login: {
                method: 'GET', url: urlService + "Api/Usuarios/login", isArray: false
            },
        });
}

angular.module('Cinte')
    .factory('STipoIdentificacion', STipoIdentificacion);

function STipoIdentificacion($resource, userService) {
    var urlService = userService.urlService;

    return $resource(urlService + "Api/TipoIdentificacion/:IdTipoIdentificacion", { IdTipoIdentificacion: "@IdTipoIdentificacion" },
        {
            query: {
                method: 'GET', url: urlService + "Api/TipoIdentificacion", isArray: true
            }
        });
}

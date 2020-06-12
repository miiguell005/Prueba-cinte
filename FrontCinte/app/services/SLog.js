angular.module('Cinte')
    .factory('SLog', SLog);

function SLog($resource, userService) {
    var urlService = userService.urlService;

    return $resource(urlService + "Api/Logs/:IdLog", { IdLog: "@IdLog" },
        {
            query: {
                method: 'GET', url: urlService + "Api/Logs", isArray: true
            }
        });
}

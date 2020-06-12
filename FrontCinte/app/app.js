
var app = angular.module('Cinte', ["ngAnimate", "ngRoute", "ngResource" ])

app.config(function ($routeProvider) {

    $routeProvider
        .when('/', {
            templateUrl: 'views/login/login.html',
            controller: 'loginController',
            controllerAs: 'login'
        })
        .when('/login', {
            templateUrl: 'views/login/login.html',
            controller: 'loginController',
            controllerAs: 'login'
        })
        .when('/log', {
            templateUrl: 'views/log/log.html',
            controller: 'logController',
            controllerAs: 'log'
        })
        .when('/triqui', {
            templateUrl: 'views/juegos/triqui.html',
            controller: 'triquiController',
            controllerAs: 'tri'
        })
        .when('/usuarios', {
            templateUrl: 'views/usuario/usuarios.html',
            controller: 'usuariosController',
            controllerAs: 'user'
        })
        .when('/usuario/:idUsuario', {
            templateUrl: 'views/usuario/editarUsuario.html',
            controller: 'editarUsuarioController',
            controllerAs: 'user'
        })
        .otherwise({
            redirectTo: '/'
        });
})
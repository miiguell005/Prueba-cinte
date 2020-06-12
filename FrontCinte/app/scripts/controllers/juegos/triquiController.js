
angular.module('Cinte')
    .controller('triquiController', function (STriqui, $scope, $location, $timeout) {

        //Contendra el juego de triqui
        $scope.juego;
        $scope.cantidadJugadores;
        $scope.mensajesError;

        $scope.init = function () {

            $scope.mensajesError = {};

            $scope.cantidadJugadores = 2;

            $scope.juego = STriqui.generarJuegoTriqui();
        }

        /**
         * 
         * @param {any} c
         */
        $scope.realizarJugada = function (c) {

            //El juego ya finalizó
            if ($scope.juego.mensaje || c.celda != "b" || ($scope.juego.contraMaquina && $scope.juego.turno == "jugador2"))
                return;

            //El jugador que tiene el turno realiza su jugada
            c.celda = $scope.juego[$scope.juego.turno].estrategia;

            //Revisa si ya hay triqui, si no y el jugador1 está jugando con la máquina, ésta realiza su jugada
            STriqui.revisarHayGanador();
        }

        $scope.hayErorr = function () {

            var keys = Object.keys($scope.mensajesError);

            for (var i = 0; i < keys.length; i++)
                if ($scope.mensajesError[keys[i]])
                    return true;

            return false;
        }

        $scope.asignarConfiguracion = function (jugadores, maquina, nombre) {
            $scope.cantidadJugadores = jugadores;
            $scope.juego.contraMaquina = maquina;
            $scope.juego.jugador2.nombre = nombre;
        }

        /**
         * Comienza el juego de triqui
         */
        $scope.comenzarJuego = function () {

            $scope.mensajesError["nombreJugador1"] = $scope.juego.jugador1.nombre ? "" : "Es necesario Ingresar el nombre";
            $scope.mensajesError["nombreJugador2"] = !$scope.juego.jugador2.nombre && $scope.cantidadJugadores == 2 ? "Es necesario Ingresar el nombre" : "";

            if ($scope.hayErorr())
                return;

            //Selecciona aleatoriamente que jugador va jugar de primeras
            STriqui.cambiarTurno();

            //Asigna la estrategia a los dos jugadores aleatoriamente
            STriqui.asignarEstrategiaJugadores();

            //Si el primer turno es de la máquina
            if ($scope.juego.contraMaquina === true && $scope.juego.turno == "jugador2" && $scope.juego.mensaje == "")
                STriqui.jugarTurnoMaquina();
        }

        $scope.init();
    });
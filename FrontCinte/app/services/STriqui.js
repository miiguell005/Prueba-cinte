angular.module('Cinte')

/**
 * Contiene la logica del triqui
 */
.service('STriqui', function ($timeout) {

    var vm = this;

    vm.juego = null;

    /*
     * Genera el juego de triqui 
     */
    vm.generarJuegoTriqui = function () {

        vm.juego = {
            contraMaquina: null,
            mensaje: "",
            turno: null,
            //Contiene el tablero de juego
            tablero: vm.generarTableroTriqui(),
            pusiblesTriqui: {},
            jugador1: {
                nombre: "",
                estrategia: null,
                ganador: null
            },
            jugador2: {
                nombre: "",
                estrategia: null,
                ganador: null
            }
        };

        //Realiza una de espacio de memoria de cada objeto del triqui, para que luego sea mas facil consultarlo
        vm.llenarPosiblesTriquis();

        return vm.juego;
    }

    /**
     * Crea el tablero de triqui
     */
    vm.generarTableroTriqui = function () {

        var tablero = [];

        for (var i = 0; i < 3; i++) {
            var columna = [];

            for (var j = 0; j < 3; j++)
                //la propiedad triqui es para realizar el trazado del canvas, con su dirección
                columna.push({ celda: "b", triqui: null });

            tablero.push({ columna: columna });
        }

        return tablero;
    }

    /**
     * 
     */
    vm.llenarObjetoArray = function (obj, propiedad, valor) {

        if (!obj[propiedad])
            obj[propiedad] = [];

        obj[propiedad].push(valor);
    }

    /**
     * Llena la propuedad del juego de posiblesTriquis
     */
    vm.llenarPosiblesTriquis = function () {

        //Revisa diagonales
        for (var i = 0; i < vm.juego.tablero.length; i++) {

            //Contiene las columnas del tablero
            var c = vm.juego.tablero[i];

            vm.llenarObjetoArray(vm.juego.pusiblesTriqui, "diagonalDe", c.columna[i]);
            vm.llenarObjetoArray(vm.juego.pusiblesTriqui, "diagonalIz", c.columna[2 - i]);

            for (var j = 0; j < vm.juego.tablero.length; j++) {

                vm.llenarObjetoArray(vm.juego.pusiblesTriqui, "fila" + i, c.columna[j]);

                var f = vm.juego.tablero[j];
                vm.llenarObjetoArray(vm.juego.pusiblesTriqui, "columna" + i, f.columna[i]);
            }
        }
    };

    vm.trazarLineaTriqui = function () {

    }

    /**
     * Revisa si hay ganador
     */
    vm.revisarHayGanador = function () {

        var triquiEncontrado = vm.revisarposibleTriqui(3);

        //Significa que se encontro un triqui
        if (triquiEncontrado) {

            for (var i = 0; i < triquiEncontrado.length; i++)
                triquiEncontrado[i].triqui = true;

            //Si gano el jugador 1
            if (triquiEncontrado[0].celda == vm.juego.jugador1.estrategia) {
                vm.juego.mensaje = "El ganador es " + vm.juego.jugador1.nombre;
                vm.juego.jugador1.ganador = true;
                vm.juego.jugador2.ganador = false;
            }

            //Si gano el jugador 2
            else if (triquiEncontrado[0].celda == vm.juego.jugador2.estrategia) {
                vm.juego.mensaje = "El ganador es " + vm.juego.jugador2.nombre;
                vm.juego.jugador2.ganador = true;
                vm.juego.jugador1.ganador = false;
            }

            return;
        }

        var empate = vm.revisarEmprate();

        //Si se encontró un empate
        if (empate) {
            vm.juego.mensaje = "Es un empate";
            vm.juego.jugador1.ganador = false;
            vm.juego.jugador2.ganador = false;

            return;
        }

        //Realiza el cambio de turno
        vm.cambiarTurno();

        //Si el jugador1 está jugando con la máquina
        if (vm.juego.contraMaquina === true && vm.juego.turno == "jugador2" && vm.juego.mensaje == "")
            $timeout(function () {
                vm.jugarTurnoMaquina();
            }, 1500);

    }

    /**
     * Si el juego es contra la maquina, la maquina realiza su jugada inteligente
     */
    vm.jugarTurnoMaquina = function () {

        //Verifica si la máquina tiene posibilidad de realizar triqui
        var posibleTriquiMaquina = vm.revisarposibleTriqui(vm.juego.jugador2.estrategia == "x" ? 2 : -2);

        //Verifica si el jugador 1 tiene posibilidad de hacer triqui
        var posibleTriquiJugador1 = vm.revisarposibleTriqui(vm.juego.jugador2.estrategia == "x" ? -2 : 2);

        //Realiza el ataque para realizar triqui
        if (posibleTriquiMaquina)
            for (var i = 0; i < posibleTriquiMaquina.length; i++)
                if (posibleTriquiMaquina[i].celda == "b") {
                    posibleTriquiMaquina[i].celda = vm.juego.jugador2.estrategia;
                    return vm.revisarHayGanador();
                }

        //Realiza la defensa de posible triqui por jugador
        if (posibleTriquiJugador1)
            for (var i = 0; i < posibleTriquiJugador1.length; i++)
                if (posibleTriquiJugador1[i].celda == "b") {
                    posibleTriquiJugador1[i].celda = vm.juego.jugador2.estrategia;
                    return vm.revisarHayGanador();
                }

        //Realiza la jugada aleatoria de la maquina
        vm.realizarJugadaAleatoriaMaquina();
        vm.revisarHayGanador();
    }

    /**
     * Realiza la jugada aleatoria de la máquina
     */
    vm.realizarJugadaAleatoriaMaquina = function () {

        var fila = vm.juego.tablero[Math.floor(Math.random() * vm.juego.tablero.length)];

        var c = fila.columna[Math.floor(Math.random() * vm.juego.tablero.length)];

        if (c.celda == "b")
            c.celda = vm.juego.jugador2.estrategia;
        else
            vm.realizarJugadaAleatoriaMaquina();
    }

    /**
     * Se utiliza para revisar que hay triqui ó si la maquina tiene laposibilidad de realizar el triqui
     * @param {any} valor El valor que se desea comprar con el contador, para verificar si hay posible triqui
     */
    vm.revisarposibleTriqui = function (valor) {

        var contador = 0;

        var keys = Object.keys(vm.juego.pusiblesTriqui);

        //Rectifica posibles triquis
        for (var i = 0; i < keys.length; i++) {

            contador = 0;
            var obj = vm.juego.pusiblesTriqui[keys[i]];

            for (var j = 0; j < obj.length; j++)
                if (obj[j].celda != "b")
                    contador += obj[j].celda == "x" ? 1 : -1;

            if (valor === contador || contador == 3 || contador == -3)
                return obj;
        }
    }

    /**
     * Revisa si se genero un empate
     */
    vm.revisarEmprate = function () {

        var tamanioMaximo = vm.juego.tablero.length * vm.juego.tablero.length;
        var contador = 0;

        for (var i = 0; i < vm.juego.tablero.length; i++) {
            var obj = vm.juego.pusiblesTriqui["fila" + i];

            for (var j = 0; j < vm.juego.tablero.length; j++)
                if (obj[j].celda != "b")
                    contador++;
        }

        if (contador == tamanioMaximo)
            return true;

        return false;
    }

    /**
     * Asigna la estrategia aleatoriamente a los dos jugadores
     */
    vm.asignarEstrategiaJugadores = function () {

        var estrategia = (Math.floor(Math.random() * 2) == 0) ? "x" : "o";

        vm.juego.jugador1.estrategia = estrategia;
        vm.juego.jugador2.estrategia = estrategia == "x" ? "o" : "x";
    }

    /**
     * Realiza el cambio de turno (ejemplo: jugador1 => jugador2)
     */
    vm.cambiarTurno = function () {

        //Si no se ha definido el turno, define el turno y la estrategui de cada jugador
        if (vm.juego.turno == null)
            vm.juego.turno = (Math.floor(Math.random() * 2) == 0) ? "jugador1" : "jugador2";

        //Realiza el cambio de turno de jugadores
        else
            vm.juego.turno = (vm.juego.turno == "jugador1") ? "jugador2" : "jugador1";
    }
});

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Prueba_Cinte.Context;
using Prueba_Cinte.Context.Models;
using Prueba_Cinte.Modulo;

namespace Prueba_Cinte.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly AppDbContext _context;
        LogModulo modulo;

        public UsuariosController(AppDbContext context)
        {
            _context = context;
            modulo = new LogModulo(context);
        }

        // GET: api/Usuarios
        [HttpGet]
        public Usuario[] GetUsuario()
        {
            return _context.Usuario.ToArray();
        }

        // GET: api/Usuarios/5
        [HttpGet]
        [Route("Usuario")]
        public Usuario GetUsuario(int idUsuario)
        {
            var usuario = _context.Usuario.Find(idUsuario);

            if (usuario == null)
                throw new Exception("No se encontro el usuario con id: " + idUsuario);

            //Para que se muestre la contraseña en la respuesta
            usuario.Contrasenia = "";

            return usuario;
        }

        [Route("Login")]
        public dynamic GetLogin(string Contrasenia, string numeroIdentificacion)
        {
            try
            {
                var usuario = _context.Usuario.Where(u => u.Contrasenia == Contrasenia && u.NumeroIdentificacion == numeroIdentificacion).FirstOrDefault();

                if (usuario == null)
                    throw new Exception("El número de identificacion o la contraseña es incorrecta");

                var user = new
                {
                    IdUsuario = usuario.IdUsuario,
                    Nombre = usuario.Nombre,
                    Apellido = usuario.Apellido,
                    Correo = usuario.Correo,
                };

                //Realiza el registro en el log
                modulo.GuardarLog("Login", "Login exitoso", usuario.IdUsuario);

                return user;
            }
            catch (Exception ex)
            {
                //Realiza el registro en el log
                modulo.GuardarLog("Login", $"Número de identificación: {numeroIdentificacion}", null, ex);
                throw new Exception(ex.Message, ex);
            }
        }

        // PUT: api/Usuarios/5
        [HttpPut("{id}")]
        public Usuario PutUsuario(int id, Usuario usuarioDto)
        {
            try
            {
                if (id != usuarioDto.IdUsuario)
                    throw new Exception("El id del usuario no concuerda ");

                var usuario = _context.Usuario.Find(id);

                if (usuario == null)
                    throw new Exception($"No se ha encontrado el usuario con id: {usuario.IdUsuario}");

                if (usuarioDto.Nombre == null)
                    throw new Exception($"El nombre del usuario es obligatorio");

                if (usuarioDto.Apellido == null)
                    throw new Exception($"El apellido del usuario es obligatorio");

                if (usuarioDto.NumeroIdentificacion == null)
                    throw new Exception($"El NumeroIdentificacion de identificación del usuario es obligatorio");

                if (usuarioDto.Correo == null)
                    throw new Exception($"El Correo del usuario es obligatorio");

                //Obtiene el id del usuario que esta realizando el request
                var idUsuario = Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();

                //Genera el detalle de los cambios realizados
                var detalleLog = modulo.HayCambios(usuarioDto, usuario, "Contrasenia");

                usuarioDto.Modificado = DateTime.Now;

                if (idUsuario != null )
                    usuarioDto.IdModificado = int.Parse(idUsuario);

                usuario.Nombre = usuarioDto.Nombre;
                usuario.Apellido = usuarioDto.Apellido;
                usuario.IdTipoIdentificacion = usuarioDto.IdTipoIdentificacion;
                usuario.NumeroIdentificacion = usuarioDto.NumeroIdentificacion;
                usuario.Correo = usuarioDto.Correo;
                usuario.IdModificado = usuarioDto.IdModificado;
                usuario.Modificado = DateTime.Now;

                _context.SaveChanges();

                //Realiza el registro en el log
                modulo.GuardarLog("Editar Usuario", detalleLog, (idUsuario != null ? int.Parse(idUsuario) : 0));

                return usuario;
            }
            catch (Exception ex)
            {
                var idUsuario = Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();
                modulo.GuardarLog("Editar Usuario", "", (idUsuario != null ? int.Parse(idUsuario) : 0), ex);

                throw new Exception(ex.Message, ex);
            }
        }

        // POST: api/Usuarios
        [HttpPost]
        public Usuario PostUsuario(Usuario usuarioDto)
        {
            try
            {

                var usuario = _context.Usuario.Where(u => u.NumeroIdentificacion == usuarioDto.NumeroIdentificacion).FirstOrDefault();

                if (usuario != null)
                    throw new Exception($"Usuario con número de identificación {usuarioDto.NumeroIdentificacion} ya se encuentra registrado");

                if (usuarioDto.Nombre == null)
                    throw new Exception($"El nombre del usuario es obligatorio");

                if (usuarioDto.Apellido == null)
                    throw new Exception($"El apellido del usuario es obligatorio");

                if (usuarioDto.NumeroIdentificacion == null)
                    throw new Exception($"El NumeroIdentificacion de identificación del usuario es obligatorio");

                if (usuarioDto.Correo == null)
                    throw new Exception($"El Correo del usuario es obligatorio");

                //Obtiene el id del usuario que esta realizando el request
                var idUsuario = Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();

                //Genera el detalle de los cambios realizados
                var detalleLog = modulo.HayCambios(new Usuario(), usuarioDto, "Contrasenia");

                usuarioDto.Creado = DateTime.Now;
                usuarioDto.Modificado = DateTime.Now;

                if (idUsuario != null)
                {
                    usuarioDto.IdCreado = int.Parse(idUsuario);
                    usuarioDto.IdModificado = int.Parse(idUsuario);
                }

                _context.Usuario.Add(usuarioDto);
                _context.SaveChanges();

                //Realiza el guardado de los cambios en el log
                modulo.GuardarLog("Crear Usuario", detalleLog, (idUsuario != null ? int.Parse(idUsuario) : 0));

                //No retorna la contraseña del usuario
                usuarioDto.Contrasenia = "";

                return usuarioDto;
            }
            catch (Exception ex)
            {
                var idUsuario = Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();
                modulo.GuardarLog("Crear Usuario", "", (idUsuario != null ? int.Parse(idUsuario) : 0), ex);

                throw new Exception(ex.Message, ex);
            }

        }

        // DELETE: api/Usuarios/5
        [HttpDelete("{idUsuario}")]
        public ActionResult<Usuario> DeleteUsuario(int idUsuario)
        {
            try
            {
                var usuario = _context.Usuario.Find(idUsuario);

                if (usuario == null)
                    throw new Exception($"El usuario con id: {idUsuario} no se encontró");

                //Genera el detalle de los cambios realizados
                var detalleLog = modulo.HayCambios(new Usuario(), usuario, "Contrasenia");

                _context.Usuario.Remove(usuario);
                _context.SaveChanges();

                var idUser = Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();
                modulo.GuardarLog("Eliminar Usuario", detalleLog, (idUser != null ? int.Parse(idUser) : 0));

                return usuario;
            }
            catch (Exception ex)
            {
                var idUser =Request.Headers.FirstOrDefault(x => x.Key == "Authorization").Value.FirstOrDefault();
                modulo.GuardarLog("Eliminar Usuario", "", (idUser != null ? int.Parse(idUser) : 0), ex);

                throw new Exception(ex.Message, ex);
            }
        }
    }
}

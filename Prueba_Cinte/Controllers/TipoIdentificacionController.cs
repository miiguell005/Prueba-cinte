using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Prueba_Cinte.Context;
using Prueba_Cinte.Context.Models;

namespace Prueba_Cinte.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoIdentificacionController : ControllerBase
    {
        private readonly AppDbContext _context;

        public TipoIdentificacionController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/TipoIdentificacions
        [HttpGet]
        public ActionResult<IEnumerable<TipoIdentificacion>> GetTipoIdentificacion()
        {
            return  _context.TipoIdentificacion.ToArray();
        }
    }
}

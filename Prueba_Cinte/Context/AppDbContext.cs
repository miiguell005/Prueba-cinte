using Microsoft.EntityFrameworkCore;
using Prueba_Cinte.Context.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Prueba_Cinte.Context
{
    public class AppDbContext : DbContext
    {

        public AppDbContext (DbContextOptions<AppDbContext> options)
                : base(options)
        {

        }

        public DbSet<Log> Log { get; set; }
        public DbSet<TipoIdentificacion> TipoIdentificacion { get; set; }
        public DbSet<Usuario> Usuario { get; set; }
    }
}

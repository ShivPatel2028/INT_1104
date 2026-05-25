using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AdminPanelTutorial
{
    public class Doctors
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Specialty { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
    }

    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Doctors> Doctors { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Seed Indian doctors data
            modelBuilder.Entity<Doctors>().HasData(
                new Doctors
                {
                    Id = 1,
                    Name = "Dr.RAJ GUPTA",
                    Specialty = "Cardiology",
                    Email = "raj.kumar@hospital.com",
                    Phone = "+91-9876543210",
                    Address = "VADODARA, Gujarat"
                },
                new Doctors
                {
                    Id = 2,
                    Name = "Dr.PRIYA SHARMA",
                    Specialty = "Pediatrics",
                    Email = "priya.sharma@hospital.com",
                    Phone = "+91-9876543211",
                    Address = "VADODARA, Gujarat"
                },
                new Doctors
                {
                    Id = 3,
                    Name = "Dr.VIJAY PATEL  ",
                    Specialty = "Neurology",
                    Email = "vijay.patel@hospital.com",
                    Phone = "+91-9876543212",
                    Address = "VADODARA, Gujarat"
                },
                new Doctors
                {
                    Id = 4,
                    Name = "Dr.ANITA GUPTA",
                    Specialty = "Gynecology",
                    Email = "anita.gupta@hospital.com",
                    Phone = "+91-9876543213",
                    Address = "VADODARA, Gujarat"
                },
                new Doctors
                {
                    Id = 5,
                    Name = "Dr.ADITYA VERMA",
                    Specialty = "Orthopedics",
                    Email = "aditya.verma@hospital.com",
                    Phone = "+91-9876543214",
                    Address = "VADODARA, Gujarat"
                }
            );
        }
    }

    public class DoctorsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public DoctorsController(ApplicationDbContext context)
        {
            _context = context;
        }

        public ActionResult Index()
        {
            var doctors = _context.Doctors.ToList();
            return View(doctors);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CreateDoctor(Doctors doctor)
        {
            if (!ModelState.IsValid)
            {
                return View("Create", doctor);
            }

            _context.Doctors.Add(doctor);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpPost]
        public bool Delete(int id)
        {
            try
            {
                var doctor = _context.Doctors.Find(id);
                if (doctor == null)
                {
                    return false;
                }

                _context.Doctors.Remove(doctor);
                _context.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public ActionResult Update(int id)
        {
            var doctor = _context.Doctors.Find(id);
            if (doctor == null)
            {
                return NotFound();
            }

            return View(doctor);
        }

        [HttpPost]
        public ActionResult UpdateDoctor(Doctors doctor)
        {
            if (!ModelState.IsValid)
            {
                return View("Update", doctor);
            }

            var existingDoctor = _context.Doctors.Find(doctor.Id);
            if (existingDoctor == null)
            {
                return NotFound();
            }

            existingDoctor.Name = doctor.Name;
            existingDoctor.Specialty = doctor.Specialty;
            existingDoctor.Email = doctor.Email;
            existingDoctor.Phone = doctor.Phone;
            existingDoctor.Address = doctor.Address;

            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}

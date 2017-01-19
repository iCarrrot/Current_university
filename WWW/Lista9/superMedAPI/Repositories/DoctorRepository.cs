using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
    public class DoctorRepository : IDoctorRepository
    {
		private int counter = 3;
		private List<Doctor> Doctors = new List<Doctor>
		{
			new Doctor {ID = 1, Name = "Klara", Surname = "Berezowski"},
			new Doctor {ID = 2, Name = "Caroline", Surname = "Lis"},
			new Doctor {ID = 3, Name = "Anna", Surname = "Konieczny"},
		};

		public List<Doctor> FindAll()
		{
			return Doctors;
		}

		public Doctor Find(int id)
		{
			return Doctors.Find(e => e.ID == id);
		}

		public Doctor Add(Doctor doctor)
		{
			doctor.ID = ++counter;
			Doctors.Add(doctor);
			return doctor;
		}

		public Doctor Update(int id, Doctor doctor)
		{
			var b = Doctors.Find(e => e.ID == id);
			if (b != null)
			{
				if (!string.IsNullOrEmpty(b.Name)) b.Name = doctor.Name;
				if (!string.IsNullOrEmpty(b.Surname)) b.Surname = doctor.Surname;
			}
			return b;
		}

		public void Remove(int id)
		{
			Doctors.RemoveAll(e => e.ID == id);
		}
	}
}

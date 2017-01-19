using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
    public class PatientRepository : IPatientRepository
    {
		private int counter = 4;
		private List<Patient> Patients = new List<Patient>
		{
			new Patient {ID = 1, Name = "Jan", Surname = "Kowalski"},
			new Patient {ID = 2, Name = "Rafal", Surname = "Nowak"},
			new Patient {ID = 3, Name = "Pawel", Surname = "Rajba"},
			new Patient {ID = 4, Name = "Mariusz", Surname = "Pudzianowski"},
		};

		public List<Patient> FindAll()
		{
			return Patients;
		}

		public Patient Find(int id)
		{
			return Patients.Find(e => e.ID == id);
		}

		public Patient Add(Patient patient)
		{
			patient.ID = ++counter;
			Patients.Add(patient);
			return patient;
		}

		public Patient Update(int id, Patient patient)
		{
			var b = Patients.Find(e => e.ID == id);
			if (b != null)
			{
				if (!string.IsNullOrEmpty(b.Name)) b.Name = patient.Name;
				if (!string.IsNullOrEmpty(b.Surname)) b.Surname = patient.Surname;
			}
			return b;
		}

		public void Remove(int id)
		{
			Patients.RemoveAll(e => e.ID == id);
		}
	}
}

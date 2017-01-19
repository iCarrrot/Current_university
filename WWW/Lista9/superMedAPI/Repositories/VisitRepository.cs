using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
    public class VisitRepository : IVisitRepository
    {
		private int counter = 10;
		private List<Visit> Visits = new List<Visit>
		{
			new Visit {ID = 1, DoctorID = 1, PatientID = 4, Date = new DateTime(2021, 10, 3)},
			new Visit {ID = 2, DoctorID = 2, PatientID = 3, Date = new DateTime(2020, 7, 7)},
			new Visit {ID = 3, DoctorID = 3, PatientID = 2, Date = new DateTime(2022, 2, 27)},
			new Visit {ID = 4, DoctorID = 3, PatientID = 1, Date = new DateTime(2023, 3, 13)},
			new Visit {ID = 5, DoctorID = 2, PatientID = 4, Date = new DateTime(2024, 5, 16)},
			new Visit {ID = 6, DoctorID = 1, PatientID = 3, Date = new DateTime(2025, 4, 6)},
			new Visit {ID = 7, DoctorID = 2, PatientID = 2, Date = new DateTime(2026, 9, 4)},
			new Visit {ID = 8, DoctorID = 1, PatientID = 1, Date = new DateTime(2027, 12, 29)},
			new Visit {ID = 9, DoctorID = 3, PatientID = 4, Date = new DateTime(2029, 8, 14)},
			new Visit {ID = 10, DoctorID = 2, PatientID =3, Date = new DateTime(2037, 6, 21)}
		};

		public Visit Find(int id)
		{
			return Visits.Find(e => e.ID == id);
		}

		public List<Visit> FindByPatient(int id)
		{
			return Visits.Where(e => e.PatientID == id).ToList<Visit>();
		}

		public List<Visit> FindByDoctor(int id)
		{
			return Visits.Where(e => e.DoctorID == id).ToList<Visit>();
		}

		public Visit Add(Visit visit)
		{
			visit.ID = ++counter;
			Visits.Add(visit);
			return visit;
		}

		public Visit Update(int id, Visit visit)
		{
			var b = Visits.Find(e => e.ID == id);
			if (b != null)
			{
				if (b.DoctorID > 0) b.DoctorID = visit.DoctorID;
				if (b.PatientID > 0) b.PatientID = visit.PatientID;
				if (b.Date.Year > 2016 ) b.Date = visit.Date;
			}
			return b;
		}

		public void Remove(int id)
		{
			Visits.RemoveAll(e => e.ID == id);
		}
	}
}

using System.Collections.Generic;
using superMedAPI.Models;

namespace superMedAPI.Repositories
{
	public interface IVisitRepository
	{
		Visit Add(Visit visit);
		Visit Find(int id);
		List<Visit> FindByDoctor(int id);
		List<Visit> FindByPatient(int id);
		void Remove(int id);
		Visit Update(int id, Visit visit);
	}
}
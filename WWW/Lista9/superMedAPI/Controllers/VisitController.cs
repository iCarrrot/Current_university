using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using superMedAPI.Repositories;
using superMedAPI.Models;

// For more information on enabling Web API for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace superMedAPI.Controllers
{
    [Route("api/[controller]")]
    public class VisitController : Controller
    {
		IVisitRepository visitRepository { get; set; }
		public VisitController(IVisitRepository visitRepository)
		{
			this.visitRepository = visitRepository;
		}


		// GET: api/values/doctor/id
		[HttpGet("doctor/{id}")]
		public IActionResult GetByDoctor(int id)
		{
			var visit = visitRepository.FindByDoctor(id);
			if (visit != null)
				return new ObjectResult(visit);
			else
				return NotFound();

		}

		// GET api/values/patient/id
		[HttpGet("patient/{id}")]
		public IActionResult GetByPatient(int id)
		{
			var visit = visitRepository.FindByPatient(id);
			if (visit != null)
				return new ObjectResult(visit);
			else
				return NotFound();
		}

		// POST api/values
		[HttpPost]
		public IActionResult Create([FromBody]Visit visitData)
		{
			if (visitData == null)
			{
				return BadRequest();
			}
			var visit = visitRepository.Add(visitData);
			return CreatedAtAction("Get", new { id = visit.ID }, visit);
		}

		// PUT api/values/5
		[HttpPut("{id}")]
		public IActionResult Update(int id, [FromBody]Visit visitData)
		{
			if (visitData == null || visitData.ID != id)
			{
				return BadRequest();
			}

			var visit = visitRepository.Find(id);
			if (visit == null)
			{
				return NotFound();
			}

			visitRepository.Update(id, visitData);
			return new NoContentResult();
		}

		// DELETE api/values/5
		[HttpDelete("{id}")]
		public IActionResult Delete(int id)
		{
			var visit = visitRepository.Find(id);
			if (visit == null)
			{
				return NotFound();
			}
			visitRepository.Remove(id);
			return new NoContentResult();
		}
	}
}

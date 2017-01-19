using Microsoft.AspNetCore.Mvc;
using l8z2.Models;
using l8z2.Services;

namespace l8z2.Controllers
{
    public class HomeController : Controller
    {
        private IPersonRepository _personRepository;

        public HomeController(IPersonRepository personRepository)
        {
            _personRepository = personRepository;
        }

        public IActionResult Index()
        {
            var model = _personRepository.GetPart(0);
            ViewBag.Title = "Lista osób";
            ViewBag.Links = new System.Collections.Generic.List<string[]>() {
                new string[2] {"1", "next"}
            };
            return View(model);
        }

        [Route("{id:int}")]
        public IActionResult Index(int id)
        {
            var model = _personRepository.GetPart(id);
            ViewBag.Title = "Lista osób";
            ViewBag.Links = new System.Collections.Generic.List<string[]>();
            if (id > 0)
            {
                ViewBag.Links.Add(new string[2] { (id - 1).ToString(), "prev" });
            }
            if (_personRepository.GetPart(id + 1).GetEnumerator().MoveNext())
            {
                ViewBag.Links.Add(new string[2] { (id + 1).ToString(), "next" });
            }
            return View(model);
        }

        public IActionResult Details(int id)
        {
            var model = _personRepository.GetById(id);
            ViewData["Title"] = model.FirstName + " " + model.LastName;
            return View(model);

        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using l8z4.Models;

namespace l8z4.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(Car car)
        {
            if (ModelState.IsValid)
            {
                return View("Sucess");
            }
            else
            {
            }
            return View();
        }

        public IActionResult Error()
        {
            return View();
        }
    }
}

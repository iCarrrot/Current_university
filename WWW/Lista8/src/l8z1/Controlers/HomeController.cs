using Microsoft.AspNetCore.Mvc;

namespace l8z1.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.Title = "IndexTitle";
            return View();
        }

        [Route("string")]
        public IActionResult String()
        {
            ViewBag.Title = "StringTitle";
            return Content("Tutaj jest string");
        }

        [Route("file")]
        public IActionResult MyFile()
        {
            ViewBag.Title = "FileTitle";
            return File("img.png", "image/png");
        }

        [Route("json")]
        public IActionResult MyJson()
        {
            ViewBag.Title = "JsonTitle";
            return Json(new string[3] { "as", "bd", "rt" });
        }

    }
}

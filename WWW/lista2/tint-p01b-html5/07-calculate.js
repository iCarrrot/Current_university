function messageHandler(e)
{
	switch (e.data.command)
	{
		case "add":
			postMessage(parseInt(e.data.a)+parseInt(e.data.b));
			break;
		case "mult":
			postMessage(e.data.a*e.data.b);
			break;
	}
}

addEventListener("message", messageHandler, true);
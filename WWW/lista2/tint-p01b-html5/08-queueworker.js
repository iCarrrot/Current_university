function messageHandler(e)
{
	//var x = 0.5+parseFloat(e);
	postMessage(fib(parseInt(e.data)));
}

function fib(n)
{
	if ( n==0 ) return 0;
	else if ( n==1 ) return 1;
	else return fib(n-1)+fib(n-2);
}

addEventListener("message", messageHandler, true);
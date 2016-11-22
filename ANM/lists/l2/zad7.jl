f(x)=x^2
fp(x)=2*x
function newton(xn,f,fp)
    return xn-f(xn)/fp(xn)
end
t=128
setprecision(t)
xn=BigFloat(1.3)
for i in 1:t
    xn=newton(xn,f,fp)
    print("  ")
    print(i)
    print("  ")
    println(xn)
end

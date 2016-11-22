Pkg.add("PyPlot")
using PyPlot

function steffensen(f,cn)
    #println(f(cn))
    bottom=(f(cn+f(cn))-f(cn))
    if bottom==0
        return cn
    end
    return cn-((f(cn))^2)/bottom
end
f(x)=e^(-x)-sin(x)
maxiter=100
setprecision(256)
cn=BigFloat(15)
lastcn=cn
for i = 1:maxiter
    if (f(cn))==0
        break
    end
    lastcn=cn
    cn=steffensen(f,cn)
    if cn==lastcn
        break
    end
    println(cn)
end

x=linspace(0,6*pi,1000)
plot(x,f(x),color="red",linewidth=2.0,linestyle="--")

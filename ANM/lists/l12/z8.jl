function AdaptiveSimpson(f,a,b)
    abstol=10.0^(-6)
    nf=3
    ff=[f(a),f((a+b)/2),f(b)]
    I1=(b-a) * dot([1,4,1],ff)/6
    function adaptrec(f,a,b,ff,I1,tol,nf)
        h=(b-a)/2
        fm=[f(a+h/2),f(b-h/2)]
        nf+=2
        fR = [ff[2],fm[2],ff[3]]
        fL = [ff[1],fm[1],ff[2]]
        IL = h*dot([1,4,1],fL)/6
        IR = h*dot([1,4,1],fR)/6
        I2=IL+IR
        I=I2+(I2-I1)/15
        if(abs(I-I2)>tol)
            (Il,nf) =adaptrec(f,a,a+h,fL,IL,tol/2,nf)
            (IR,nf) =adaptrec(f,b-h,b,fR,IR,tol/2,nf)
            I=IL+IR
        end
        return (I,nf)
    end
    return adaptrec(f,a,b,ff,I1,abstol,nf)
end
wrednaFunkcja(x)=sin(5000*x)*x

t=10000
setprecision(t)
sk=BigFloat(1)
ck=BigFloat(0)
pk=BigFloat(2)
k=Int(2)

function iter(sk,ck,k)
    sk=sqrt(1/2-ck/2)
    ck=sqrt(1/2+ck/2)
    pk=BigFloat(2)^k*sk
    k+=1
    return (sk,ck,pk,k)
end

function iterpopr(sk,ck,k)
    ck=sqrt(1/2+ck/2)
    sk=sk/(2*ck)
    pk=BigFloat(2)^k*sk
    k+=1
    return (sk,ck,pk,k)
end

while (k<=2*t)
    print(k)
    print(" ")
    println(pi-pk)
    #@printf("%f,%f,%f,%f\n",sk,ck,pk,pk-pi)
    (sk,ck,pk,k)=iter(sk,ck,k)
end
sk=BigFloat(1)
ck=BigFloat(0)
pk=BigFloat(2)
k=Int(2)

while (k<=2*t)
    print(k)
    print(" ")
    println(pi-pk)
    #@printf("%f,%f,%f,%f\n",sk,ck,pk,pk-pi)
    (sk,ck,pk,k)=iterpopr(sk,ck,k)
end

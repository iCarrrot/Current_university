using PyPlot
setprecision(700)
function odczytZPliku(nazwa)
    nowaTablica=[(0.0,0.0)]
    tablica=readdlm(nazwa)
    n=length(tablica)-1
    for i in 1:n+1
        j=2
        tx=""
        ty=""
        while (tablica[i][j]!=',')
            tx=string(tx,tablica[i][j])
            j+=1
        end
        j+=1
        while (tablica[i][j]!=')')
            ty=string(ty,tablica[i][j])
            j+=1
        end
        push!(nowaTablica,(parse(Float64,tx),parse(Float64,ty)))
    end
    deleteat!(nowaTablica,1)
    nowaTablica

end

function makeT(sposob,punkty)
    n=Int64(length( punkty)/3-1)
    if (sposob=="pitagoras")
        punkty[1,3]=0
        for i in 2:n+1
            punkty[i,3]=punkty[i-1,3]+sqrt((punkty[i-1,2]- punkty[i,2])^2 + (punkty[i-1,1]-punkty[i,1])^2)
        end
        
    elseif(sposob=="równoodległe")
        punkty[1,3]=0
        for i in 2:n+1
            punkty[i,3]=punkty[i-1,3]+1/(n+1)
        end
        
    elseif(sposob=="czebyszew")
        
        for i in 1:n+1
            punkty[i,3]=-cos.((2*i-1)/(2*n+1) * pi)
        end
        
    end
    T_MAX=punkty[n+1,3]
    T_MIN=punkty[1,3]
    (T_MAX,T_MIN)

end
function interpol(ε,nazwa,sposob,typ)
    tablica=odczytZPliku(nazwa)
    n=length(tablica)-1
    punkty = Array{Float64}(n+1,3)
    Y_t=Array{Float64}(n+3,2)#[t,y(t)]
    X_t=Array{Float64}(n+3,2)#[t,x(t)]
    Testx=Float64[]
    Testy=Float64[]
    for i in 1:n+1
        (tempx,tempy)=tablica[i]
        punkty[i,1]=tempx
        punkty[i,2]=tempy
        push!(Testx,tempx)
        push!(Testy,tempy)

    end
    (T_MAX,T_MIN)=makeT(sposob,punkty)
    for i in 1:n+1
        Y_t[i,1]=punkty[i,3]
        Y_t[i,2]=punkty[i,2]
        X_t[i,1]=punkty[i,3]
        X_t[i,2]=punkty[i,1]
    end
 
    temp_t=T_MIN
    Y_t[n+2,2]=Y_t[1,2]
    X_t[n+2,2]=X_t[1,2]
    Y_t[n+3,2]=Y_t[2,2]
    X_t[n+3,2]=X_t[2,2]
    Y_t[n+2,1]=Y_t[1,1]+T_MAX
    X_t[n+2,1]=X_t[1,1]+T_MAX
    Y_t[n+3,1]=Y_t[2,1]+T_MAX
    X_t[n+3,1]=X_t[2,1]+T_MAX
    X=Float64[]
    Y=Float64[]
    
    if(typ=="sklejana")
        p=Array{Float64}(n)
        q=Array{Float64}(n)
        u_y=Array{Float64}(n)
        u_x=Array{Float64}(n)
        s=Array{Float64}(n)
        t=Array{Float64}(n+1)
        v_y=Array{Float64}(n+1)
        v_x=Array{Float64}(n+1)
        M_y=Array{Float64}(n+1)
        M_x=Array{Float64}(n+1)


        

        h_t(k)=if(k==n+2) Y_t[2,1]-Y_t[1,1] elseif (k==n+3 )   Y_t[3,1]-Y_t[2,1] else Y_t[k,1]-Y_t[k-1,1] end 

        λ(k)=h_t(k)/(h_t(k)+h_t(k+1))



        d_y(k)=6./(h_t(k)+h_t(k+1)) *((Y_t[k+1,2]-Y_t[k,2])/h_t(k+1)-(Y_t[k,2]-Y_t[k-1,2])/h_t(k) )
        d_x(k)=6/(h_t(k)+h_t(k+1)) *((X_t[k+1,2]-X_t[k,2])/h_t(k+1)-(X_t[k,2]-X_t[k-1,2])/h_t(k) )


        q[1]=u_y[1]=u_x[1]=0
        s[1]=1

        for k in 2:n
            λ_k=λ(k)
            p[k]=λ_k*q[k-1]+2.0
            q[k]=(λ_k-1.0)/p[k]
            s[k]=-λ_k*s[k-1]/p[k]
            u_y[k]=(d_y(k)-λ_k*u_y[k-1])/p[k]
            u_x[k]=(d_x(k)-λ_k*u_x[k-1])/p[k]
        end


        t[n+1]=t[1]=1
        v_y[n+1]=v_y[1]=v_x[n+1]=v_x[1]=0

        for k in n:-1:2
            t[k]=q[k]*t[k+1]+s[k]
            v_y[k]=q[k]*v_y[k+1]+u_y[k]
            v_x[k]=q[k]*v_x[k+1]+u_x[k]
        end


        M_y[n+1]=(d_y(n+1)-(1-λ(n+1))*v_y[2]-λ(n+1)*v_y[n] )/(2+ (1-λ(n+1))*t[2] + λ(n+1)*t[n] )
        M_x[n+1]=(d_x(n+1)-(1-λ(n+1))*v_x[2]-λ(n+1)*v_x[n] )/(2+ (1-λ(n+1))*t[2] + λ(n+1)*t[n] )

        for k in 2:n
            M_y[k]=v_y[k]+t[k]*M_y[n]
            M_x[k]=v_x[k]+t[k]*M_x[n]
        end

        function š_y(x)
            k=0
            for i in 2:n+1
                if (x>=Y_t[i-1,1] && x<=Y_t[i,1])
                    k=i
                end
            end
            #println("t: ",x," t_i-1: ",Y_t[k-1,1]," t_i: ",Y_t[k,1]," k: ",k)
            1/h_t(k)*   (1/6*M_y[k-1]*(Y_t[k,1]-x)^3+
                         1/6*M_y[k]*(x-Y_t[k-1,1])^3+
                        (Y_t[k-1,2]-1/6*M_y[k-1]*h_t(k)^2)*(Y_t[k,1]-x)+
                        (Y_t[k,2]  -1/6*M_y[k]  *h_t(k)^2)*(x-Y_t[k-1,1])
                        )
        end

        function š_x(x)
            k=0
            for i in 2:n+1
                if (x>=X_t[i-1,1] && x<=X_t[i,1])
                    k=i
                   #println("to jest k: ",k," ",x," ",X_t[k,1])
                end

            end
            #println("to jest 2k: ",k," ",x," ")
            1/h_t(k)*   (1/6*M_x[k-1]*(X_t[k,1]-x)^3+
                         1/6*M_x[k]*(x-X_t[k-1,1])^3+
                        (X_t[k-1,2]-1/6*M_x[k-1]*h_t(k)^2)*(X_t[k,1]-x)+
                        (X_t[k,2]  -1/6*M_x[k]  *h_t(k)^2)*(x-X_t[k-1,1])
                        )
        end

        
        
        
        
        while temp_t<=T_MAX
            push!(X,š_x(temp_t))
            push!(Y,š_y(temp_t))
            temp_t+=ε
        end
        return (X,Y)

    elseif(typ=="wielomian")
        Num_y=copy(Y_t)
        Num_x=copy(X_t)
        for i in 1:n+1
            Num_y[i]=BigFloat(Num_y[i])
            Num_x[i]=BigFloat(Num_x[i])
        end
        ε=BigFloat(ε)

        function wsp(Num)
            k=1
            for i in 2:n+1
                for j in n+1:-1:i
                    Num[j,2]=(Num[j-1,2]-Num[j,2])/(Num[j-k,1]-Num[j,1])    
                end
                k+=1 
            end
        end
        wsp(Num_y)
        wsp(Num_x)
        function poly(Num,x)
            val=BigFloat(0)
            z=BigFloat(1)
            val=Num[1,2]
            for i in 2:n+1
                z=Num[i,2]
                if(z!=0)
                    for j in 1:i-1
                        z*=(x-Num[j,1])
                    end
                end
                val+=z
            end
            val
        end
        temp_t=BigFloat(temp_t)
        while temp_t<=T_MAX
            push!(X,Float64(poly(Num_x,temp_t)))
            push!(Y,Float64(poly(Num_y,temp_t)))
            temp_t+=ε/10
        end
        return(X,Y)

    end


end
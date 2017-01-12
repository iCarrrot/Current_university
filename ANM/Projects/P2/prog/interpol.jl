#Michał Martusewicz 282023 - zadanie P.2.12
using PyPlot
setprecision(700)

function mathFunction(nazwa)
    tablica=[(0.0,0.0)]
    if(nazwa=="sinus")
        trygoIter=BigFloat(0)
        while  trygoIter<=2*pi
            trygoIter+=pi/100
            push!(tablica, (trygoIter,sin.(trygoIter)) )
            #println(trygoIter,"  ",sin.(trygoIter))
            
        end
        
        return tablica
    end
    if(nazwa=="okrąg")
        trygoIter=BigFloat(0)
        while  trygoIter<=2*pi
            trygoIter+=pi/100
            push!(tablica, (cos.(trygoIter),sin.(trygoIter)) )
            #println(trygoIter,"  ",sin.(trygoIter))
            
        end
        deleteat!(tablica, 1)
        return tablica
    end
end


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
            punkty[i,3]=-cos.(BigFloat((2*i-1)/(2*n+1) )* pi)
        end
        
    end
    T_MAX=punkty[n+1,3]
    T_MIN=punkty[1,3]
    (T_MAX,T_MIN)

end
####################################################################
#
#
#Funkcja właściwa
#
#
####################################################################
function interpol(ε,czyZpliku,nazwa,sposob,typ)
    if(czyZpliku==1)
        tablica=odczytZPliku(nazwa)
    else
        tablica=mathFunction(nazwa)
    end
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
    
    if(typ=="okresowa")
        p=Array{Float64}(n)
        q=Array{Float64}(n)
        u_y=Array{Float64}(n)
        u_x=Array{Float64}(n)
        s=Array{Float64}(n)
        t=Array{Float64}(n+1)
        v_y=Array{Float64}(n+1)
        v_x=Array{Float64}(n+1)
        M_y=Array{Float64}(n+2)
        M_x=Array{Float64}(n+2)

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
        M_y[1]=M_y[n+1]
        M_y[n+2]=M_y[2]
        M_x[1]=M_x[n+1]
        M_x[n+2]=M_x[2]

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
            for  j = 1:n
                for k = n : -1 : j 
                    Num[k+1,2] = (Num[k+1,2]- Num[k,2])/(Num[k+1,1]- Num[k-j+1,1])
                end
            end
        end
        wsp(Num_y)
        wsp(Num_x)
        function poly(Num,x)
            
            temp = BigFloat(1)
            res = Num[1,2]
            for i=1:n 
                temp *= (x - Num[i,1])
                 res += Num[i+1,2] *temp
            end
            return res 
        end
        temp_t=BigFloat(temp_t)
        while temp_t<=T_MAX
            push!(X,Float64(poly(Num_x,temp_t)))
            push!(Y,Float64(poly(Num_y,temp_t)))
            temp_t+=ε
        end
        return(X,Y)

    elseif(typ=="naturalna")
        pn=Array{Float64}(n)
        qn=Array{Float64}(n)
        un_y=Array{Float64}(n)
        un_x=Array{Float64}(n)
        s=Array{Float64}(n)
        t=Array{Float64}(n+1)
        v_y=Array{Float64}(n+1)
        v_x=Array{Float64}(n+1)
        M_y=Array{Float64}(n+2)
        M_x=Array{Float64}(n+2)

        hn_t(k)=if(k==n+2) Y_t[2,1]-Y_t[1,1] elseif (k==n+3 )   Y_t[3,1]-Y_t[2,1] else Y_t[k,1]-Y_t[k-1,1] end 

        λn(k)=hn_t(k)/(hn_t(k)+hn_t(k+1))



        dn_y(k)=6./(hn_t(k)+hn_t(k+1)) *((Y_t[k+1,2]-Y_t[k,2])/hn_t(k+1)-(Y_t[k,2]-Y_t[k-1,2])/hn_t(k) )
        dn_x(k)=6/(hn_t(k)+hn_t(k+1)) *((X_t[k+1,2]-X_t[k,2])/hn_t(k+1)-(X_t[k,2]-X_t[k-1,2])/hn_t(k) )


        qn[1]=un_y[1]=un_x[1]=0
       

        for k in 2:n
            λn_k= λn(k)
            pn[k]=λn_k*qn[k-1]+2.0
            qn[k]=(λn_k-1.0)/pn[k]
            un_y[k]=(dn_y(k)-λn_k*un_y[k-1])/pn[k]
            un_x[k]=(dn_x(k)-λn_k*un_x[k-1])/pn[k]
        end


        M_y[n]=un_y[n]
        M_x[n]=un_x[n]

        for k in n-1:-1:2
            M_y[k]=un_y[k]+qn[k]*M_y[k+1]
            M_x[k]=un_x[k]+qn[k]*M_x[k+1]
        end
        M_y[1]=M_y[n+1]=0
        
        M_x[1]=M_x[n+1]=0
        

        function s_y(x)
            k=0
            for i in 2:n+1
                if (x>=Y_t[i-1,1] && x<=Y_t[i,1])
                    k=i
                end
            end
            #println("t: ",x," t_i-1: ",Y_t[k-1,1]," t_i: ",Y_t[k,1]," k: ",k)
            1/hn_t(k)*   (1/6*M_y[k-1]*(Y_t[k,1]-x)^3+
                         1/6*M_y[k]*(x-Y_t[k-1,1])^3+
                        (Y_t[k-1,2]-1/6*M_y[k-1]*hn_t(k)^2)*(Y_t[k,1]-x)+
                        (Y_t[k,2]  -1/6*M_y[k]  *hn_t(k)^2)*(x-Y_t[k-1,1])
                        )
        end

        function s_x(x)
            k=0
            for i in 2:n+1
                if (x>=X_t[i-1,1] && x<=X_t[i,1])
                    k=i
                   #println("to jest k: ",k," ",x," ",X_t[k,1])
                end

            end
            #println("to jest 2k: ",k," ",x," ")
            1/hn_t(k)*   (1/6*M_x[k-1]*(X_t[k,1]-x)^3+
                         1/6*M_x[k]*(x-X_t[k-1,1])^3+
                        (X_t[k-1,2]-1/6*M_x[k-1]*hn_t(k)^2)*(X_t[k,1]-x)+
                        (X_t[k,2]  -1/6*M_x[k]  *hn_t(k)^2)*(x-X_t[k-1,1])
                        )
        end

        
        while temp_t<=T_MAX
            push!(X,s_x(temp_t))
            push!(Y,s_y(temp_t))
            temp_t+=ε
        end
        return (X,Y)

    end


end
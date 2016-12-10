#Michał Martusewicz 282023 - zadanie P.2.12


using PyPlot
####################################
#punkty

tablica=[(0.0,0.0)]

ε=0.0001
polska=[ (3.2, 6.7)  (2.7, 6.5)  (2.1, 6.4)  (1.7, 6.0)  (1.1, 5.9)  (0.7, 5.7)  (0.4, 5.7)  (0.4, 5.4)  (0.5, 5.0)  (0.3, 4.6)  (0.6, 4.3)  (0.6, 4.0)  (0.7, 3.7)  (0.6, 3.2)  (0.8, 2.9)  (0.8, 2.6)  (0.6, 2.4)  (0.8, 2.3)  (0.9, 2.4)  (1.1, 2.2)  (1.4, 2.1)  (1.8, 2.0)  (1.7, 1.8)  (1.9, 1.4)  (2.2, 1.5)  (2.1, 1.8)  (2.7, 1.6)  (2.6, 1.4)  (3.3, 1.3)  (3.5, 0.9)  (3.7, 0.6)  (3.9, 0.8)  (4.2, 0.7)  (4.3, 0.4)  (4.5, 0.5)  (4.7, 0.7)  (5.0, 0.6)  (5.5, 0.8)  (5.9, 0.6)  (6.2, 0.4)  (6.4, 0.3)  (6.3, 0.7)  (6.5, 1.2)  (6.8, 1.7)  (7.2, 2.0)  (7.1, 2.2)  (7.2, 2.4)  (6.8, 2.8)  (6.7, 3.2)  (6.8, 3.6)  (6.4, 3.9)  (6.2, 4.2)  (6.9, 4.5)  (6.8, 5.1)  (6.6, 5.6)  (6.5, 6.0)  (6.1, 6.2)  (5.5, 6.1)  (5.0, 6.2)  (4.6, 6.2)  (4.1, 6.3)  (3.7, 6.0)  (3.4, 6.1)  (3.2, 6.5)  (3.7, 6.4) (3.2, 6.7)]
marchewka=[(4.6,0.3) (5.0,0.7) (7.0,7.0) (7.9,9.9) (8.0,10.3) (7.7,10.7) (7.0,11.5) (7.1,12.3) (7.8,13.1) (8.7,13.2) (9.8,16.3) (9.9,16.5) (9.6,16.5) (5.5+0.6,16.5) (6.1+0.6,16.7) (7.7,16.7) (8.6+0.6,17.2)  (8.4+0.6,18.3) (7.1+0.6,18.5) (6.2+0.6,17.3) (5.1+0.6,16.4) (5.8+0.6,17.4) (5.5,18.7) (4.0+0.6,17.4) (4.7+0.6,16.4) (3.6+0.6,17.3) (2.7+0.6,18.5) (1.4+0.6,18.3) (1.2+0.6,17.2) (3.3,16.7) (3.7+0.6,16.7) (4.3+0.6,16.5) (1.5,16.5) (1.1,16.5) (1.1,16.3) (2.0,11.0) (2.6,6.0) (4.2,0.7) (4.6,0.3)]

#tablica=readdlm("marchewka.pkt")
trygoIter=0.0
while  trygoIter<=2*pi
    trygoIter+=pi/100
    push!(tablica, (trygoIter,sin.(trygoIter)) )
    
end




n=length(tablica)-1



#punkty=[x,y,t]
Testx=Float64[]
Testy=Float64[]
punkty = Array{Float64}(n+1,3)

for i in 1:n+1
    (tempx,tempy)=tablica[i]
    #=
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
    tempx=parse(Float64,tx)
    tempy=parse(Float64,ty)

    println(tx,"\n",ty,"\n\n\n")
    =#
    punkty[i,1]=tempx
    punkty[i,2]=tempy
    push!(Testx,tempx)
    push!(Testy,tempy)

end

punkty[1,3]=0

for i in 2:n+1
    punkty[i,3]=punkty[i-1,3]+sqrt((punkty[i-1,2]- punkty[i,2])^2 + (punkty[i-1,1]-punkty[i,1])^2)
end
T_MAX=punkty[n+1,3]



###################
#okresowa sklejana

Y_t=Array{Float64}(n+2,2)#[t,y(t)]
X_t=Array{Float64}(n+2,2)#[t,x(t)]
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



for i in 1:n+1
    Y_t[i,1]=punkty[i,3]
    Y_t[i,2]=punkty[i,2]
    X_t[i,1]=punkty[i,3]
    X_t[i,2]=punkty[i,1]
end
Y_t[n+2,2]=Y_t[2,2]
X_t[n+2,2]=X_t[2,2]


h_t(k)=if(k==n+2) Y_t[2,1]-Y_t[1,1] elseif (k==n+3 )   Y_t[2,2]-Y_t[1,2] else Y_t[k,1]-Y_t[k-1,1] end 

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
    for i in 2:n+2
        if (x>=Y_t[i-1,1] && x<=Y_t[i,1])
            k=i
        end
    end
    1/h_t(k)*   (1/6*M_y[k-1]*(Y_t[k,1]-x)^3+
                 1/6*M_y[k]*(x-Y_t[k-1,1])^3+
                (Y_t[k-1,2]-1/6*M_y[k-1]*h_t(k)^2)*(Y_t[k,1]-x)+
                (Y_t[k,2]  -1/6*M_y[k]  *h_t(k)^2)*(x-Y_t[k-1,1])
                )
end

function š_x(x)
    k=0
    for i in 2:n+2
        if (x>=X_t[i-1,1] && x<=X_t[i,1])
            k=i
        end
    end
    1/h_t(k)*   (1/6*M_x[k-1]*(X_t[k,1]-x)^3+
                 1/6*M_x[k]*(x-X_t[k-1,1])^3+
                (X_t[k-1,2]-1/6*M_x[k-1]*h_t(k)^2)*(X_t[k,1]-x)+
                (X_t[k,2]  -1/6*M_x[k]  *h_t(k)^2)*(x-X_t[k-1,1])
                )
end

#######################################################

Num_y=copy(Y_t)
Num_x=copy(X_t)



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
    val=0.0
    z=1.0
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



#######################################################
#rysowanie



temp_t=0
X=Float64[]
Y=Float64[]
X1=Float64[]
Y1=Float64[]
T=Float64[]
#=
while temp_t<=T_MAX
    push!(X,š_x(temp_t))
    push!(Y,š_y(temp_t))
    temp_t+=ε
end
push!(X,š_x(0))

push!(Y,š_y(0))
=#
#println("192")
while temp_t<=T_MAX
    #push!(X,poly(Num_x,temp_t))
   # push!(Y,poly(Num_y,temp_t))
    push!(X1,š_x(temp_t))
    push!(Y1,š_y(temp_t))
   # push!(T,temp_t)
    #println(poly(Num_x,temp_t),"  ",š_x(temp_t),"  ",poly(Num_y,temp_t),"  ",š_y(temp_t))
    temp_t+=10*ε
end
x=linspace(0, 2*pi, n+1);y=sin.(x);
plot(x, y, label="Krzywa", "red", linewidth=1.0 )


#plot(X, Y, label="Krzywa", "blue", linewidth=1.0 )

plot(X1, Y1, label="Krzywa", "green", linewidth=1.0 )

plot(Testx,Testy,"red", linewidth=0.0, marker="o")
#=
subplot(211)
   #title("newton")
plot(T, Y, label="Krzywa Y - sklejana", "red", linewidth=1.0 )
plot(T, Y1, label="Krzywa Y - wielomian", "blue", linewidth=1.0 )

axis([-1., 70.,-5., 25.])
subplot(212)
  # title("newton")
plot(T, X, label="Krzywa X - sklejana", "orange", linewidth=1.0 )

plot(T, X1, label="Krzywa X - wielomian", "green", linewidth=1.0 )

=#
#axis([0, 20,0, 20])



#=
for i in 1:n

    text(Testx[i], Testy[i], string(i))
end
=#
axis("equal")

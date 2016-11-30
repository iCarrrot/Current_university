
#punkty=[x,y,t]
n=10

punkty = Array{Float64}(n+1,3)
punkty[1,3]=0
for i in 2:n+1
    punkty[i,3]=(punkty[i-1,2]- punkty[i,2])^2 + (punkty[i-1,1]-punkty[i,1])^2
end

Y_t=Array{Float64}(n+2,2)#[t,y(t)]
X_t=Array{Float64}(n+2,2)#[t,x(t)]
for i in 1:n+1
    Y_t[i,1]=punkty[i,3]
    Y_t[i,2]=punkty[i,2]
    X_t[i,1]=punkty[i,3]
    X_t[i,2]=punkty[i,1]
end
Y_t[n+2,2]=Y_t[2,2]
X_t[n+2,2]=X_t[2,2]

h_t(k)=if(k==n+2) Y_t[1,2]-Y_t[1,1] else Y_t[1,k]-Y_t[1,k-1] end

λ(k)=h_t(k)/(h_t(k)+h_t(k+1))


#Dla y(t):

d_y(k)=6/(h_t(k)+h_t(k+1))((Y_t(k+1)-Y_t(k))/h_t(k+1)-(Y_t(k)-Y_t(k-1))/h_t(k) )


p_y=Array{Float64}(n-1)
q_y=Array{Float64}(n)
u_y=Array{Float64}(n)
s_y=Array{Float64}(n)

q_y[1]=0
u_y[1]=0
s_y[1]=1

for k in 2:n
    λ_k=λ(k)
    p_y[k]=λ_k*q_y[k-1]+2
    q_y[k]=(λ_k-1)/p_y[k]
    s_y[k]=-λ_k*s_y[k-1]/p_y[k]
    u_y[k]=(d_y(k)-λ_k*u_y[k-1])/p_y[k]
end

t_y=Array{Float64}(n+1)
v_y=Array{Float64}(n+1)
t_y[n+1]=1
t_y[1]=1
v_y[n+1]=0
v_y[1]=0

for k in n:-1:2
    t_y[k]=q_y[k]*t_y[k+1]+s_y[k]
    v_y[k]=q_y[k]*v_y[k+1]+u_y[k]
end

M_y=Array{Float64}(n+1)
M_y[n+1]=(d_y(n+1)-(1-λ(n+1))*v_y[2]-λ(n+1)*v_y[n] )/(2+ (1-λ(n+1))*t_y[2] + λ(n+1)*t_y[n] )

for k in 2:n
    M_y[k]=v_y[k]+t_y[k]*M_y[n]
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
                (Y_t[k-1,2]-1/6*M_y[k-1]*h_t(k)^2)*(Y_t[k,1]-x)
                (Y_t[k,2]  -1/6*M_y[k]  *h_t(k)^2)*(x-Y_t[k-1,1])
                )
end

#dla x(t)
d_x(k)=6/(h_t(k)+h_t(k+1))((X_t(k+1)-X_t(k))/h_t(k+1)-(X_t(k)-X_t(k-1))/h_t(k) )


p_x=Array{Float64}(n-1)
q_x=Array{Float64}(n)
u_x=Array{Float64}(n)
s_x=Array{Float64}(n)

q_x[1]=0
u_x[1]=0
s_x[1]=1

for k in 2:n
    λ_k=λ(k)
    p_x[k]=λ_k*q_x[k-1]+2
    q_x[k]=(λ_k-1)/p_x[k]
    s_x[k]=-λ_k*s_x[k-1]/p_x[k]
    u_x[k]=(d_x(k)-λ_k*u_x[k-1])/p_x[k]
end

t_x=Array{Float64}(n+1)
v_x=Array{Float64}(n+1)
t_x[n+1]=1
t_x[1]=1
v_x[n+1]=0
v_x[1]=0

for k in n:-1:2
    t_x[k]=q_x[k]*t_x[k+1]+s_x[k]
    v_x[k]=q_x[k]*v_x[k+1]+u_x[k]
end

M_x=Array{Float64}(n+1)
M_x[n+1]=(d_x(n+1)-(1-λ(n+1))*v_x[2]-λ(n+1)*v_x[n] )/(2+ (1-λ(n+1))*t_x[2] + λ(n+1)*t_x[n] )

for k in 2:n
    M_x[k]=v_x[k]+t_x[k]*M_x[n]
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
                (X_t[k-1,2]-1/6*M_x[k-1]*h_t(k)^2)*(X_t[k,1]-x)
                (X_t[k,2]  -1/6*M_x[k]  *h_t(k)^2)*(x-X_t[k-1,1])
                )
end

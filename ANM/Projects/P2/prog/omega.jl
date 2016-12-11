#Michał Martusewicz 282023 - zadanie P.2.12

x=linspace(0,2,200)
y=0*x
plot(x,y)
 y=Float64[]
 x=linspace(2,3,200)
 for i in 1:length(x)
       push!(y,-sqrt(1-(x[i]-2)^2)+1)
       end

plot(x,y)
x=linspace(2,3,600)
 y=Float64[]
for i in 1:length(x)
        if(acos.(x[i]*2-5)/3 +1<2)
            push!(y,acos.(x[i]*2-5)/3 +1)
        else
            push!(y,2)
        end
end
plot(x,y)
x=linspace(4-2*sqrt(2)+0.000000001,2,200)
y=Float64[]
 for i in 1:length(x)
       push!(y,-sqrt(8-(x[i]-4)^2)+4)
  end
plot(x,y)
x=linspace(4-2*sqrt(2)+0.000000001,4+2*sqrt(2)-0.000000001,6000)
y=Float64[]
for i in 1:length(x)
       push!(y,sqrt(8-(x[i]-4)^2)+4)
       end
plot(x,y)


x=linspace(6,4+2*sqrt(2)-0.000000001,200)
y=Float64[]
 for i in 1:length(x)
       push!(y,-sqrt(8-(x[i]-4)^2)+4)
  end
plot(x,y)
x=linspace(5,6,600)
 y=Float64[]
for i in 1:length(x)
        if(acos.(-x[i]*2+11)/3 +1<2)
            push!(y,acos.(-x[i]*2+11)/3 +1)
        else
            push!(y,2)
        end
end
plot(x,y)
 y=Float64[]
 x=linspace(5,6,200)
 for i in 1:length(x)
       push!(y,-sqrt(1-(x[i]-6)^2)+1)
       end

plot(x,y)

x=linspace(6,8,200)
y=0*x
plot(x,y)
axis([0,8,-1,7],"equal")


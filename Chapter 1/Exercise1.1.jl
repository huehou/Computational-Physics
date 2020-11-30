using PyPlot

function euler(f0::Float64, df::Float64, dt::Float64, tend::Float64)
    n::Int64 = Int(tend/dt) + 1
    f::Vector{Float64} = zeros(n)
    t::Vector{Float64} = zeros(n)
    for i = 1:n-1
        f[i+1] = f[i] + df*dt
        t[i+1] = t[i] + dt
    end
    return t,f
end

#=
function euler(f0, df, dt, tend)
    f = [f0]
    t = [0]
    n = Int(tend/dt)
    for i = 1:n
        push!(f, f[end] + df*dt)
        push!(t, t[end] + dt)
    end
    return t,f
end
=#

function main()
    t,v = euler(0.0, -9.8, 0.1, 10.0)
    clf()
    plot(t,v)
    xlabel("t")
    ylabel("v(t)")
    title("Chapter 1 Exercise 1.1")
    display(gcf())
end

# @time euler(0.0, -9.8, 1.0, 10.0)

# using the simple implementation of euler took ~70% more time
# than the slightly complicated implementation. The time and 
# memory allocation can be checked by commenting out the line 
# containing @time macro.

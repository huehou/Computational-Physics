using PyPlot

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

function main()
    t,v = euler(0.0, -9.8, 1.0, 10.0)
    clf()
    plot(t,v)
    xlabel("t")
    ylabel("v(t)")
    title("Chapter 1 Exercise 1.1")
    display(gcf())
end

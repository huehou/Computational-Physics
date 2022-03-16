using LaTeXStrings
using PyPlot

σ = 10.
b = 8.0/3.0
x0 = 1.0
y0 = 0.0
z0 = 0.0
dt = 0.0001

function euler_1step(t0::Float64, x0::Float64, y0::Float64, z0::Float64, dt::Float64, r::Float64)
	x1::Float64 = x0 + σ*(y0 - x0)*dt
	y1::Float64 = y0 + (-x0*z0 + r*x0 - y0)*dt
	z1::Float64 = z0 + (x0*y0 - b*z0)*dt
	t1::Float64 = t0 + dt
	t1, x1, y1, z1
end

function euler(x0::Float64, y0::Float64, z0::Float64, dt::Float64, tend::Float64, r::Float64)
	n::Int64 = Int(tend/dt) + 1
	x::Vector{Float64} = zeros(n)
	y::Vector{Float64} = zeros(n)
	z::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	x[1] = x0
	y[1] = y0
	z[1] = z0
	
	for i = 1:n-1
		t[i+1], x[i+1], y[i+1], z[i+1] = euler_1step(t[i], x[i], y[i], z[i], dt, r)
	end

	t, x, y, z
end

function main()
	t1, x1, y1, z1 = euler(x0, y0, z0, dt, 50., 5.)
	t2, x2, y2, z2 = euler(x0, y0, z0, dt, 50., 10.)
	t3, x3, y3, z3 = euler(x0, y0, z0, dt, 50., 25.)

	plot(t1, z1)
	plot(t2, z2)
	plot(t3, z3)
	tick_params(direction = "in", top = true, right = true)
	xlim([0,50])
	ylim([0,45])
	xticks([i for i = 0:10:50])
	yticks([i for i = 0:10:40])
	xlabel("time")
	ylabel("z")
	title("Lorenz model    z versus time")
	annotate("\$r = 5\$", xy = (10,2), fontsize = 14)
	annotate("\$r = 10\$", xy = (10,7), fontsize = 14)
	annotate("\$r = 25\$", xy = (30,40), fontsize = 14)
	savefig("Figure3.15.pdf", bbox_inches = "tight")

end

main()

pygui()
show()

using LaTeXStrings
using PyPlot

g = 9.8
l = 1.
dt = 0.04
theta0 = 0.2
omega0 = 0.

function euler_1step(theta0::Float64, omega0::Float64, dt::Float64)
	theta1::Float64 = theta0 + omega0*dt
	omega1::Float64 = omega0 - g/l*theta0*dt
	theta1, omega1
end

function euler(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64)
	n::Int64 = Int(tend/dt) + 1
	theta::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	theta[1] = theta0
	omega1::Float64 = omega0
	for i = 1:n-1
		theta[i+1], omega1 = euler_1step(theta[i], omega1, dt)
		t[i+1] = t[i] + dt
	end
	t, theta
end

function main()
	t, theta = euler(theta0, omega0, dt, 10.)

	res = plot(t, theta)
	xlabel("time (s)")
	ylabel("\$\\theta\$ (radians)")
	xlim([0,10])
	ylim([-2,2])

	ax = gca()
	ax[:tick_params](direction = "in", right = true, top = true)
	xticks([0,2,4,6,8,10])
	yticks([-2,-1,0,1,2])
	annotate("Simple Pendulum - Euler method", xy = (1, 1.5), fontsize = 14)
	annotate("Length = 1m    time step = 0.04 s", xy = (1, 1.2), fontsize = 14)

	savefig("Figure3.2.pdf", bbox_inches = "tight")
	
end

main()



# pygui(true)
# show()

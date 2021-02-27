using LaTeXStrings
using PyPlot

g = 9.8
l = 1.0
dt = 0.04
omega0 = 0.0

function euler_1step(theta0::Float64, omega0::Float64, dt::Float64)
	omega1::Float64 = omega0 - g/l*sin(theta0)*dt
	theta1::Float64 = theta0 + omega1*dt
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
	t1, theta1 = euler(1.5, omega0, dt, 10.)
	t2, theta2 = euler(2.8, omega0, dt, 10.)

	plot(t1, theta1)
	plot(t2, theta2, ":")
	xlabel("time (s)")
	ylabel("\$\\theta\$ (radians)")
	xlim([0,10])
	ylim([-4,4])

	ax = gca()
	ax[:tick_params](direction = "in", right = true, top = true)
	xticks([0,2,4,6,8,10])
	yticks([-4,-2,0,2,4])
	annotate("nonlinear pendulum \n  \t\t\$q=0\$", xy = (3, 2.7), fontsize = 14)

	savefig("Figure3.5b.pdf", bbox_inches = "tight")
	
end

main()

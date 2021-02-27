using LaTeXStrings
using PyPlot

g = 9.8
l = 1.0
dt = 0.04
theta0 = 0.2
omega0 = 0.0
FD = 0.2
ΩD = 2.0

function euler_1step(t0::Float64, theta0::Float64, omega0::Float64, dt::Float64, q::Float64)
	omega1::Float64 = omega0 - g/l*theta0*dt - q*omega0*dt + FD*sin(ΩD*t0)*dt
	theta1::Float64 = theta0 + omega1*dt
	t1::Float64 = t0 + dt
	t1, theta1, omega1
end

function euler(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64, q::Float64)
	n::Int64 = Int(tend/dt) + 1
	theta::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	theta[1] = theta0
	omega1::Float64 = omega0
	for i = 1:n-1
		t[i+1], theta[i+1], omega1 = euler_1step(t[i], theta[i], omega1, dt, q)
	end
	t, theta
end

function main()
	t, theta = euler(theta0, omega0, dt, 20., 1.0)
	plot(t, theta)

	ax = gca()
	ax[:tick_params](direction = "in", right = true, top = true)
	xlim([0,20])
	ylim([-0.2, 0.2])
	xticks([0,5,10,15,20])
	yticks([-0.2,-0.1,0,0.1,0.2])
	xlabel("time (s)")
	ylabel("\$\\theta\$ (radians)")

	annotate("driven pendulum \n \$\\Omega_D = 2.0\$  \$F = 0.2\$ \n \$q = 1.0\$", xy = (7, 0.08), fontsize = 14)

	savefig("Figure3.5a.pdf", bbox_inches = "tight")
end

main()

# pygui(true)
# show()

using LaTeXStrings
using PyPlot

g = 9.8
l = 9.8
dt = 0.04
theta0 = 0.2
omega0 = 0.0
ΩD = 2.0/3.0
q = 1.0/2.0

function euler_1step(t0::Float64, theta0::Float64, omega0::Float64, dt::Float64, FD::Float64)
	omega1::Float64 = omega0 - g/l*sin(theta0)*dt - q*omega0*dt + FD*sin(ΩD*t0)*dt
	theta1::Float64 = theta0 + omega0*dt
	t1::Float64 = t0 + dt
	t1, theta1, omega1
end

function euler(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64, FD::Float64)
	n::Int64 = Int(tend/dt) + 1
	theta::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	omega::Vector{Float64} = zeros(n)
	theta[1] = theta0
	omega[1] = omega0
	omega1::Float64 = omega0
	for i = 1:n-1
		t[i+1], theta[i+1], omega1 = euler_1step(t[i], theta[i], omega1, dt, FD)
		if theta[i+1] > pi
			theta[i+1] -= 2*pi
		elseif theta[i+1] < -pi
			theta[i+1] += 2*pi
		end
		omega[i+1] = omega1
	end
	t, theta, omega
end

function main()
	t, theta, omega = euler(theta0, omega0, dt, 10000., 1.2)

	theta1::Vector{Float64} = []
	omega1::Vector{Float64} = []
	theta2::Vector{Float64} = []
	omega2::Vector{Float64} = []
	theta3::Vector{Float64} = []
	omega3::Vector{Float64} = []
	theta4::Vector{Float64} = []
	omega4::Vector{Float64} = []

	n = 0.
	for i = 1:length(t)
		if t[i] > (2*n+3/4)*π/ΩD
			n += 1
		end
		if abs(t[i] - 2*n*π/ΩD) < dt/2
			append!(theta1, theta[i])
			append!(omega1, omega[i])
		elseif abs(t[i] - (2*n+1/4)*π/ΩD) < dt/2
			append!(theta2, theta[i])
			append!(omega2, omega[i])
		elseif abs(t[i] - (2*n+1/2)*π/ΩD) < dt/2
			append!(theta3, theta[i])
			append!(omega3, omega[i])
		elseif abs(t[i] - (2*n+3/4)*π/ΩD) < dt/2
			append!(theta4, theta[i])
			append!(omega4, omega[i])
		end
	end

	figure()
	plot(theta1, omega1, ".", markersize = 2, label = "in phase")
	plot(theta2, omega2, ".", markersize = 2, label = "\$\\pi/4\$ phase difference")
	plot(theta3, omega3, ".", markersize = 2, label =  "\$\\pi/2\$ phase difference")
	plot(theta4, omega4, ".", markersize = 2, label =  "\$3\\pi/4\$ phase difference")
	xlabel("\$\\theta\$ (radians)")
	ylabel("\$\\omega\$ (radians/s)")
	xlim([-4,4])
	ylim([-3,3])
	# annotate("\$\\omega\$ versus \$\\theta\$ \t \$F_D = 1.2\$", xy = (-2, 0.75), fontsize = 14)
	tick_params(direction = "in", right = true, top = true)
	xticks([-4, -2, 0, 2, 4])
	yticks([-3, -2, -1, 0, 1, 2, 3])
	legend(frameon = false)
end

main()

pygui(true)
show()




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
	theta1::Float64 = theta0 + omega1*dt
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
	t1, theta1, omega1 = euler(theta0, omega0, dt, 60., 0.0)
	t2, theta2, omega2 = euler(theta0, omega0, dt, 60., 0.5)
	t3, theta3, omega3 = euler(theta0, omega0, dt, 60., 1.2)

	fig, axs = subplots(3, 1, sharex = true, sharey = false, gridspec_kw = Dict("hspace" => 0.0))

	axs[1].plot(t1, omega1)
	axs[1].set_ylim([-0.25,0.25])
	axs[1].spines["bottom"].set_color("none")
	axs[1].tick_params(direction = "in", right = true, top = true, bottom = false)
	axs[1].set_title("\$\\omega\$ versus time")
	axs[1].annotate("\$F_D = 0\$", xy = (40,0.08), fontsize = 14)
	
	axs[2].plot(t2, omega2)
	axs[2].set_ylim([-0.75,0.75])
	axs[2].spines["top"].set_color("none")
	axs[2].spines["bottom"].set_color("none")
	axs[2].tick_params(direction = "in", right = true, top = false, bottom = false)
	axs[2].annotate("\$F_D = 0.5\$", xy = (40,0.65), fontsize = 14)

	axs[3].plot(t3, omega3)
	axs[3].set_ylim([-3,3])
	axs[3].spines["top"].set_color("none")
	axs[3].tick_params(direction = "in", right = true, top = false, bottom = true)
	axs[3].annotate("\$F_D = 1.2\$", xy = (40,-1.2), fontsize = 14)

	xlim([0,60])
	xlabel("time (s)")
	fig.text(0.05, 0.5, "\$\\omega\$ (radians/s)", ha = "center", va = "center", rotation = "vertical")
	savefig("Figure3.6right.pdf", bbox_inches = "tight")
end

main()

pygui(true)
show()

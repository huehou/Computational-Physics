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
	theta[1] = theta0
	omega1::Float64 = omega0
	for i = 1:n-1
		t[i+1], theta[i+1], omega1 = euler_1step(t[i], theta[i], omega1, dt, FD)
		if theta[i+1] > pi
			theta[i+1] -= 2*pi
		elseif theta[i+1] < -pi
			theta[i+1] += 2*pi
		end
	end
	t, theta
end

function euler2(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64, FD::Float64)
	n::Int64 = Int(tend/dt) + 1
	theta::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	theta[1] = theta0
	omega1::Float64 = omega0
	for i = 1:n-1
		t[i+1], theta[i+1], omega1 = euler_1step(t[i], theta[i], omega1, dt, FD)
	end
	t, theta
end

function main()
	t1, theta1 = euler(theta0, omega0, dt, 60., 1.2)
	t2, theta2 = euler2(theta0, omega0, dt, 60., 1.2)

	fig, axs = subplots(2, 1, sharex = true, sharey = false, gridspec_kw = Dict("hspace" => 0.0))

	axs[1].plot(t1, theta1)
	axs[1].set_ylim([-4,4])
	axs[1].set_yticks([-4,-3,-2,-1,0,1,2,3,4])
	axs[1].set_yticklabels(["", "", "", "", 0, "", "", 3, ""])
	axs[1].spines["bottom"].set_color("none")
	axs[1].tick_params(direction = "in", right = true, top = true, bottom = false)
	axs[1].set_title("\$\\theta\$ versus time")
	
	axs[2].plot(t2, theta2)
	axs[2].set(facecolor = "None")
	axs[2].set_ylim([-10,4])
	axs[2].set_yticks([i for i in -10:4])
	axs[2].set_yticklabels([-10, " ", " ", " ", " ", -5, " ", " ", " ", " ", 0, " ", 2, " ", " "])
	axs[2].spines["top"].set_color("none")
	axs[2].tick_params(direction = "in", right = true, top = false)
	axs[2].set_xticks([0, 20, 40, 60])
	axs[2].set_xticklabels([0, 20, 40, 60])
	axs[2].annotate("\$F_D = 1.2\$", xy = (20,-1), fontsize = 14)

	xlim([0,60])
	xlabel("time (s)")
	fig.text(0.06, 0.5, "\$\\theta\$ (radians)", ha = "center", va = "center", rotation = "vertical")
	savefig("Figure3.6mid.pdf", bbox_inches = "tight")
end

main()

pygui(true)
show()

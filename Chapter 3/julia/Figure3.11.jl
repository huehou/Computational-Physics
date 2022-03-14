using LaTeXStrings
using PyPlot

g = 9.8
l = 9.8
dt = 0.01
theta0 = 0.2
omega0 = 0.0
ΩD = 2.0/3.0
q = 1.0/2.0

period = 2.0*π/ΩD

function euler_1step(t0::Float64, theta0::Float64, omega0::Float64, dt::Float64, FD::Float64)
	omega1::Float64 = omega0 - g/l*sin(theta0)*dt - q*omega0*dt + FD*sin(ΩD*t0)*dt
	theta1::Float64 = theta0 + omega0*dt
	t1::Float64 = t0 + dt
	t1, theta1, omega1
end

function euler(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64, FD::Float64)
	n::Int64 = trunc(tend/dt) + 1
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
	forces = 1.35:0.001:1.5
	Xvalues::Vector{Float64} = []
	Yvalues::Vector{Float64} = []
	for f in forces
		t, theta, omega = euler(theta0, omega0, dt, 400.0*period, f)
		n = 300
		for i = 1:length(t)
			if t[i] >= 300*period
				if t[i] > n*period
					n += 1
				end
				if abs(t[i] - n*period) < dt/2
					append!(Xvalues, f)
					append!(Yvalues, theta[i])
				end
			end
		end
	end

	figure()
	plot(Xvalues, Yvalues, ".", markersize = 2)
	xlabel("\$F_D\$")
	ylabel("\$\\theta\$ (radians)")
	xlim([1.35,1.5])
	ylim([1,3])
	annotate("Bifurcation diagram \t \$\\theta\$ versus \$F_D\$", xy = (1.355, 2.7), fontsize = 14)
	tick_params(direction = "in", right = true, top = true)
	xticks([i for i = 1.35:0.05:1.5])
	yticks([i for i = 1:0.5:3])
	savefig("Figure3.11.pdf", bbox_inches = "tight")

end

main()

pygui(true)
show()


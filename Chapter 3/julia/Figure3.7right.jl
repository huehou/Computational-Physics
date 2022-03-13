using LaTeXStrings
using Interpolations
using PyPlot
using GLM
using DataFrames

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
		# if theta[i+1] > pi
			# theta[i+1] -= 2*pi
		# elseif theta[i+1] < -pi
			# theta[i+1] += 2*pi
		# end
	end
	t, theta
end

function main()
	t1, theta1 = euler(theta0, omega0, dt, 120., 1.2)
	t2, theta2 = euler(theta0 + 0.01, omega0, dt, 120., 1.2)

	theta = @. abs.(theta1 - theta2)

	inter::Vector{Float64} = []
	t_inter::Vector{Float64} = []
	append!(inter, theta[91])
	append!(t_inter, t1[91])
	append!(inter, theta[1901])
	append!(t_inter, t1[1901])

	inter = log.(inter)
	X = t_inter
	Y = inter
	data = (;X, Y)
	res = lm(@formula(Y ~ X), data)
	inter = predict(res)
	inter = exp.(inter)

	semilogy(t1, theta)
	semilogy(t_inter, inter, ":")
	tick_params(direction = "in", top = true, right = true)

	xlim([0,150])
	xticks([0, 50, 100, 150])
	xlabel("time (s)")
	ylabel("\$\\Delta \\theta\$ (radians)")
	annotate("\$\\Delta \\theta\$ versus time \t \$F_D\$ = 1.2", xy = (50, 1e-5), fontsize = 14)
	savefig("Figure3.7right.pdf", bbox_inches = "tight")
end


main()

pygui(true)
show()

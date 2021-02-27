using LaTeXStrings
using PyPlot

g = 9.8
l = 1.0
dt = 0.04
theta0 = 0.2
omega0 = 0.0

function euler_1step(theta0::Float64, omega0::Float64, dt::Float64, q::Float64)
	omega1::Float64 = omega0 - g/l*theta0*dt - q*omega0*dt
	theta1::Float64 = theta0 + omega1*dt
	theta1, omega1
end

function euler(theta0::Float64, omega0::Float64, dt::Float64, tend::Float64, q::Float64)
	n::Int64 = Int(tend/dt) + 1
	theta::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	theta[1] = theta0
	omega1::Float64 = omega0
	for i = 1:n-1
		theta[i+1], omega1 = euler_1step(theta[i], omega1, dt, q)
		t[i+1] = t[i] + dt
	end
	t, theta
end

function main()
	t1, theta1 = euler(theta0, omega0, dt, 10., 1.0)
	t5, theta5 = euler(theta0, omega0, dt, 10., 5.0)
	t10, theta10 = euler(theta0, omega0, dt, 10., 10.0)
	plot(t1, theta1)
	plot(t5, theta5, ":")
	plot(t10, theta10, "--")

	ax = gca()
	ax[:tick_params](direction = "in", right = true, top = true)
	xlim([0,10])
	ylim([-0.2, 0.2])
	xticks([0,2,4,6,8,10])
	yticks([-0.2,-0.1,0,0.1,0.2])
	xlabel("time (s)")
	ylabel("\$\\theta\$ (radians)")

	annotate("\$q\$ = 1.0", xy = (1.5, -0.07), xytext = (2, -0.12), arrowprops = Dict("arrowstyle" => "->", "connectionstyle" => "arc3,rad=.2"))
	annotate("\$q\$ = 5", xy = (1, 0.03), xytext = (1.8, 0.09), arrowprops = Dict("arrowstyle" => "->", "connectionstyle" => "arc3,rad=.2"))
	annotate("\$q\$ = 10", xy = (0.9, 0.1), xytext = (1.7, 0.15), arrowprops = Dict("arrowstyle" => "->", "connectionstyle" => "arc3,rad=.2"))
	annotate("damped oscillator", xy = (4, 0.15), fontsize = 14)

	savefig("Figure3.4.pdf", bbox_inches = "tight")
end

main()

# pygui(true)
# show()

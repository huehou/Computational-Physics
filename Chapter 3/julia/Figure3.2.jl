# using Plots
using LaTeXStrings
using PyPlot
# pyplot()

g = 9.8
l = 1.
dt = 0.04
theta0 = 0.2
omega0 = 0.

theta = [theta0]
t = [0.]
omega = omega0

while t[end] <= 10
	push!(theta, theta[end] + omega*dt)
	push!(t, t[end]+dt)
	global omega = omega - g/l*theta[end]*dt
end

# res = plot(t, theta, 
		   # linewidth = 2,
		   # xlim = (0, 10),
		   # ylim = (-2,2),
		   # framestyle = :box,
		   # grid = :none,
		   # xlabel = "time (s)",
		   # ylabel = "\$\\theta\$ (radians)",
		   # legend = false)

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

# pygui(true)
# show()

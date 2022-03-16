using LaTeXStrings
using PyPlot

σ = 10.
b = 8.0/3.0
x0 = 1.0
y0 = 0.0
z0 = 0.0
dt = 0.0001

function euler_1step(t0::Float64, x0::Float64, y0::Float64, z0::Float64, dt::Float64, r::Float64)
	x1::Float64 = x0 + σ*(y0 - x0)*dt
	y1::Float64 = y0 + (-x0*z0 + r*x0 - y0)*dt
	z1::Float64 = z0 + (x0*y0 - b*z0)*dt
	t1::Float64 = t0 + dt
	t1, x1, y1, z1
end

function euler(x0::Float64, y0::Float64, z0::Float64, dt::Float64, tend::Float64, r::Float64)
	n::Int64 = Int(tend/dt) + 1
	x::Vector{Float64} = zeros(n)
	y::Vector{Float64} = zeros(n)
	z::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	x[1] = x0
	y[1] = y0
	z[1] = z0
	
	for i = 1:n-1
		t[i+1], x[i+1], y[i+1], z[i+1] = euler_1step(t[i], x[i], y[i], z[i], dt, r)
	end

	t, x, y, z
end

function main()
	t, x, y, z = euler(x0, y0, z0, dt, 1000., 25.)

	y1 = []
	z1 = []
	x2 = []
	z2 = []

	for i = 1:length(t)-1
		if t[i] <= 30.
			continue
		elseif x[i] == 0
			append!(y1, y[i])
			append!(z1, z[i])
		elseif (x[i] < 0.0 && x[i+1] > 0.0) || (x[i] > 0.0 && x[i+1] < 0.0)
			# Interpolation procedure
			v1 = [x[i], y[i], z[i]]
			v2 = [x[i+1], y[i+1], z[i+1]]
			dv = v2 - v1
			d = sqrt(sum(dv.^2))
			
			d0 = - d*v1[1]/dv[1]
			vnew = v1 + d0/d*dv
			if abs(vnew[1]) >= 1e-15
				println(v1)
				println(v2)
				println(dv)
				println(d)
				println(d0)
				println(vnew)
				exit(-1)
			end
			append!(y1, vnew[2])
			append!(z1, vnew[3])
		end
		if t[i] <= 30.
			continue
		elseif y[i] == 0
			append!(x2, y[i])
			append!(z2, z[i])
		elseif (y[i] < 0.0 && y[i+1] > 0.0) || (y[i] > 0.0 && y[i+1] < 0.0)
			# Interpolation procedure
			v1 = [x[i], y[i], z[i]]
			v2 = [x[i+1], y[i+1], z[i+1]]
			dv = v2 - v1
			d = sqrt(sum(dv.^2))
			
			d0 = - d*v1[2]/dv[2]
			vnew = v1 + d0/d*dv
			if abs(vnew[2]) >= 1e-15
				println(v1)
				println(v2)
				println(dv)
				println(d)
				println(d0)
				println(vnew)
				exit(-1)
			end
			append!(x2, vnew[1])
			append!(z2, vnew[3])
		end
	end

	plot(y1, z1, ".", markersize = 2)
	tick_params(direction = "in", top = true, right = true)
	xlim([-10,10])
	ylim([0,30])
	xticks([i for i = -10:5:10])
	yticks([i for i = 0:10:30])
	xlabel("y")
	ylabel("z")
	annotate("Phase space plot: z versus y when x = 0", xy = (-8,2), fontsize = 14)
	savefig("Figure3.17left.pdf", bbox_inches = "tight")

	figure()
	plot(x2, z2, ".", markersize = 2)
	tick_params(direction = "in", top = true, right = true)
	xlim([-20,20])
	ylim([0,40])
	xticks([i for i = -20:10:20])
	yticks([i for i = 0:10:40])
	xlabel("x")
	ylabel("z")
	annotate("Phase space plot: z versus x when y = 0", xy = (-18,2), fontsize = 14)
	savefig("Figure3.17right.pdf", bbox_inches = "tight")
	

end

main()

pygui()
show()

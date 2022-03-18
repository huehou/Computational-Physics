using LaTeXStrings
using PyPlot

function isBoundary(x0::Float64, y0::Float64)
	isOut = false
	normal = [0., 0.]
	if x0 >= 1.
		isOut = true
		normal = [-1., 0.]
	elseif x0 <= -1.
		isOut = true
		normal = [1., 0.]
	elseif y0 >= 1
		isOut = true
		normal = [0., -1.]
	elseif y0 <= -1
		isOut = true
		normal = [0., 1.]
	end

	isOut, normal
end

function reflect(x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64)
	ddt = dt/100.
	x1::Float64 = x0
	y1::Float64 = y0
	vx1::Float64 = vx0
	vy1::Float64 = vy0

	for i = 1:100
		x1 = x1 + vx1*ddt
		y1 = y1 + vy1*ddt

		isOut, normal = isBoundary(x1, y1)

		if isOut
			v = [vx1, vy1]
			v_perp = (vx1*normal[1] + vy1*normal[2]).*normal
			v_par = v - v_perp
			v = -v_perp + v_par
			vx1 = v[1]
			vy1 = v[2]
			if isnan(vx1) || isnan(vy1)
				println("Something is wrong here")
				exit(-1)
			end
		end
	end

	x1, y1, vx1, vy1
end
 
function euler_1step(t0::Float64, x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64)
	x1::Float64 = x0 + vx0*dt
	y1::Float64 = y0 + vy0*dt
	t1::Float64 = t0 + dt

	isOut, normal = isBoundary(x1, y1)
	if isOut
		x1, y1, vx0, vy0 = reflect(x0, y0, vx0, vy0, dt)
	end

	t1, x1, y1, vx0, vy0
end

function euler(x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64, tend::Float64)

	n::Int64 = Int(tend/dt) + 1
	x::Vector{Float64} = zeros(n)
	y::Vector{Float64} = zeros(n)
	vx::Vector{Float64} = zeros(n)
	vy::Vector{Float64} = zeros(n)
	t::Vector{Float64} = zeros(n)
	
	x[1] = x0
	y[1] = y0
	vx[1] = vx0
	vy[1] = vy0

	for i = 1:n-1
		t[i+1], x[i+1], y[i+1], vx[i+1], vy[i+1] = euler_1step(t[i], x[i], y[i], vx[i], vy[i], dt)
	end

	t, x, y, vx, vy
end

function main()
	t, x, y, vx, vy = euler(0.2, 0., cos(23*π/180), sin(23*π/180), 0.01, 11.0)
	
	plot(x, y, ".", markersize = 2)
	tick_params(direction = "in", right = true, top = true)
	xlabel("x")
	ylabel("y")
	xlim([-1,1])
	ylim([-1,1])
	xticks([i for i = -1:0.5:1])
	yticks([i for i = -1:0.5:1])
	
	savefig("Figure3.20.pdf", bbox_inches = "tight")
end

main()

pygui()
show()

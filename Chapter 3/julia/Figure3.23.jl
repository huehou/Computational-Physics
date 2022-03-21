using LaTeXStrings
using PyPlot

function isBoundary(x0::Float64, y0::Float64, α::Float64)
	isOut = false
	normal = [0., 0.]
	if y0 <= α && y0 >= -α
		if x0 >= 1.
			isOut = true
			normal = [-1., 0.]
		elseif x0 <= -1.
			isOut = true
			normal = [1., 0.]
		end
	elseif y0 > α 
		d = sqrt(x0^2 + (y0-α)^2)
		if d > 1.0
			isOut = true
			normal = [x0, (y0-α)]/d
		end
	elseif y0 < -α
		d = sqrt(x0^2 + (y0+α)^2)
		if d > 1.0
			isOut = true
			normal = [x0, (y0+α)]/d
		end
	end

	isOut, normal
end

function reflect(x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64, α::Float64)
	ddt = dt/100.
	x1::Float64 = x0
	y1::Float64 = y0
	vx1::Float64 = vx0
	vy1::Float64 = vy0

	for i = 1:100
		x1 = x1 + vx1*ddt
		y1 = y1 + vy1*ddt

		isOut, normal = isBoundary(x1, y1, α)

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
 
function euler_1step(t0::Float64, x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64, α::Float64)
	x1::Float64 = x0 + vx0*dt
	y1::Float64 = y0 + vy0*dt
	t1::Float64 = t0 + dt

	isOut, normal = isBoundary(x1, y1, α)
	if isOut
		x1, y1, vx0, vy0 = reflect(x0, y0, vx0, vy0, dt, α)
	end

	t1, x1, y1, vx0, vy0
end

function euler(x0::Float64, y0::Float64, vx0::Float64, vy0::Float64, dt::Float64, tend::Float64, α::Float64)

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
		t[i+1], x[i+1], y[i+1], vx[i+1], vy[i+1] = euler_1step(t[i], x[i], y[i], vx[i], vy[i], dt, α)
	end

	t, x, y, vx, vy
end

function boundary(α::Float64)
	x = [i for i = -1.0:0.01:1.0]
	uppercircle_y = @. α + sqrt(1 - x^2)
	lowercircle_y = @. - α - sqrt(1 - x^2)
	yboundary = [i for i in -α:0.01:α]
	leftx = [-1.0 for i in yboundary]
	rightx = [1.0 for i in yboundary]

	xout::Vector{Float64} = []
	yout::Vector{Float64} = []

	xout = vcat(xout, x)
	yout = vcat(yout, uppercircle_y)
	if length(rightx) > 0
		xout = vcat(xout, rightx)
		yout = vcat(yout, yboundary)
	end
	xout = vcat(xout, reverse(x))
	yout = vcat(yout, reverse(lowercircle_y))
	if length(leftx) > 0
		xout = vcat(xout, leftx)
		yout = vcat(yout, yboundary)
	end

	xout, yout
end

function Poincare(x::Vector{Float64}, y::Vector{Float64}, vx::Vector{Float64})
	xout = []
	vxout = []
	for i = 1:length(x)-1
		if y[i] == 0
			append!(xout, x[i])
			append!(vxout, vx[i])
		elseif y[i] < 0 && y[i+1] > 0
			append!(xout, x[i])
			append!(vxout, vx[i])
		elseif y[i] > 0 && y[i+1] < 0
			append!(xout, x[i])
			append!(vxout, vx[i])
		end
	end

	xout, vxout
end

function main()
	t, x, y, vx, vy = euler(0.2, 0., cos(23*π/180), sin(23*π/180), 0.01, 1000.0, 0.0)
	t2, x2, y2, vx2, vy2 = euler(0.2, 0., cos(23*π/180), sin(23*π/180), 0.01, 1000.0, 0.01)
	
	x, vx = Poincare(x, y, vx)
	plot(x, vx, ".", markersize = 2)
	tick_params(direction = "in", right = true, top = true)
	xlabel("\$x\$")
	ylabel("\$v_x\$")
	xlim([-1,1])
	ylim([-1,1])
	xticks([i for i = -1:0.5:1])
	yticks([i for i = -1:0.5:1])
	title("Circular stadium - phase space plot")
	savefig("Figure3.23left.pdf", bbox_inches = "tight")
	
	x2, vx2 = Poincare(x2, y2, vx2)
	figure()
	plot(x2, vx2, ".", markersize = 2)
	tick_params(direction = "in", right = true, top = true)
	xlabel("\$x\$")
	ylabel("\$v_x\$")
	xlim([-1,1])
	ylim([-1,1])
	xticks([i for i = -1:0.5:1])
	yticks([i for i = -1:0.5:1])
	title("Stadium billiard: \$\\alpha = 0.01\$")
	savefig("Figure3.23right.pdf", bbox_inches = "tight")
end

main()

pygui()
show()

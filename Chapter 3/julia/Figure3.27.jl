using LaTeXStrings
using FFTW
using PyPlot

g = 9.8
l = 9.8
dt = 0.01
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
	t1, theta1, omega1 = euler(theta0, omega0, dt, 100., 1.2)
	t2, theta2, omega2 = euler(theta0, omega0, dt, 100., 1.44)

	F1 = fftshift(fft(theta1))
	freq = fftshift(fftfreq(length(t1), 1.0/dt))

	plot(freq, abs.(F1).^2.0/1.1e7)
	tick_params(direction = "in", right = true, top = true)
	xlabel("frequency (Hz)")
	ylabel("Power (relative units)")
	xlim([0,2])
	ylim([0,3])
	xticks([i for i = 0:0.5:2])
	yticks([i for i = 0:1:3])
	annotate("Pendulum power spectrum\n\$F_D = 1.2\$", xy = (0.5, 2.6), fontsize = 14)
	savefig("Figure3.27left.pdf", bbox_inches = "tight")

	F2 = fftshift(fft(theta2))
	figure()
	plot(freq, abs.(F2).^2.0/1.1e7)
	tick_params(direction = "in", right = true, top = true)
	xlabel("frequency (Hz)")
	ylabel("Power (relative units)")
	xlim([0,1])
	ylim([0,3])
	xticks([i for i = 0:0.2:1])
	yticks([i for i = 0:1:3])
	annotate("Pendulum power spectrum\n\$F_D = 1.44\$", xy = (0.3, 2.6), fontsize = 14)
	savefig("Figure3.27right.pdf", bbox_inches = "tight")

end

main()

pygui(true)
show()




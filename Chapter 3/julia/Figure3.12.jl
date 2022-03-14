using LaTeXStrings
using PyPlot

function logistic(x0::Float64, μ::Float64, n::Int64)
	x1 = x0
	x = [x0]
	for i = 1:n
		x1 = μ*x1*(1-x1)
		append!(x, x1)
	end

	x
end

function main()
	x1 = logistic(0.6, 3.1, 50)
	x2 = logistic(0.32, 2.0, 50)
	x3 = logistic(0.32, 3.8, 50)

	plot(x1, marker = "o", markersize = 7, mfc = "none")
	plot(x2, marker = ".", markersize = 7)
	tick_params(direction = "in", top = true, right = true)
	xlabel("\$n\$")
	ylabel("\$x\$")
	title("logistic map     \$x\$ vs \$n\$")
	ylim([0,1])
	xlim([0,50])
	yticks([i for i = 0:0.2:1])
	xticks([i for i = 0:10:50])
	annotate("\$\\mu = 3.1\$", xy = (20, 0.8), fontsize = 14)
	annotate("\$\\mu = 2.0\$", xy = (20, 0.4), fontsize = 14)
	savefig("Figure3.12left.pdf", bbox_inches = "tight")
	
	figure()
	plot(x3, marker = ".", markersize = 7)
	tick_params(direction = "in", top = true, right = true)
	xlabel("\$n\$")
	ylabel("\$x\$")
	title("logistic map     \$x\$ vs \$n\$")
	ylim([0,1])
	xlim([0,50])
	yticks([i for i = 0:0.2:1])
	xticks([i for i = 0:10:50])
	annotate("\$\\mu = 3.8\$", xy = (10,0.1), fontsize = 14)
	savefig("Figure3.12right.pdf", bbox_inches = "tight")
end

main()

pygui()
show()

import numpy as np
import matplotlib.pyplot as plt

rho = 1.225
radius = 0.02133 # radius of a golf ball
A = np.pi * radius**2
m = 0.04593 # mass of golf ball
g = 9.8

def Fdrag(vx, vy):
    v = np.sqrt(vx**2 + vy**2)
    if v <= 14:
        C = 1
    else:
        C = 14/v
    theta = np.arctan2(vy, vx)
    res = -0.5*C*rho*A*v**2 * np.array([np.cos(theta), np.sin(theta)])
    return res
x0 = 0
y0 = 0
v0 = 70
theta0 = 9/180*np.pi
vx0 = v0 * np.cos(theta0)
vy0 = v0 * np.sin(theta0)
dt = 0.01

# Normal drive

x = [x0]
y = [y0]
vx = vx0
vy = vy0

while y[-1] >= 0:
    x += [ x[-1] + vx*dt ]
    y += [ y[-1] + vy*dt ]
    vx1 = vx + Fdrag(vx, vy)[0]/m*dt - 0.25*vy*dt
    vy1 = vy + Fdrag(vx, vy)[1]/m*dt + 0.25*vx*dt - g*dt
    vx, vy = vx1, vy1

plt.plot(x, y)

# Extra backspin

x = [x0]
y = [y0]
vx = vx0
vy = vy0

while y[-1] >= 0:
    x += [ x[-1] + vx*dt ]
    y += [ y[-1] + vy*dt ]
    vx1 = vx + Fdrag(vx, vy)[0]/m*dt - 1.5*0.25*vy*dt
    vy1 = vy + Fdrag(vx, vy)[1]/m*dt + 1.5*0.25*vx*dt - g*dt
    vx, vy = vx1, vy1

plt.plot(x, y ,':')

# smooth ball

def FdragSmooth(vx, vy):
    v = np.sqrt(vx**2 + vy**2)
    C = 1
    theta = np.arctan2(vy, vx)
    res = -0.5*C*rho*A*v**2 * np.array([np.cos(theta), np.sin(theta)])
    return res

x = [x0]
y = [y0]
vx = vx0
vy = vy0

while y[-1] >= 0:
    x += [ x[-1] + vx*dt ]
    y += [ y[-1] + vy*dt ]
    vx1 = vx + FdragSmooth(vx, vy)[0]/m*dt - 0.25*vy*dt
    vy1 = vy + FdragSmooth(vx, vy)[1]/m*dt + 0.25*vx*dt - g*dt
    vx, vy = vx1, vy1

plt.plot(x, y, '--')

# No spin

x = [x0]
y = [y0]
vx = vx0
vy = vy0

while y[-1] >= 0:
    x += [ x[-1] + vx*dt ]
    y += [ y[-1] + vy*dt ]
    vx1 = vx + Fdrag(vx, vy)[0]/m*dt 
    vy1 = vy + Fdrag(vx, vy)[1]/m*dt - g*dt
    vx, vy = vx1, vy1

plt.plot(x, y, '-.')
plt.ylim([0,80])
plt.xlim([0,300])
plt.tick_params(direction = 'in', top = True, right = True)
plt.xlabel('$x$ (m)')
plt.ylabel('$y$ (m)')
plt.xticks([0, 100, 200, 300])
plt.yticks([0, 20, 40, 60, 80])
plt.title("Golf ball trajectories")

plt.annotate("extra backspin", xy = (160, 50), xytext = (170, 60), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate("normal drive", xy = (195, 22), xytext = (200, 35), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate("smooth ball", xy = (80, 8), xytext = (90, 15), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate("no spin", xy = (100, 2), xytext = (120, 5), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=.2"))

plt.savefig("Figure2.13.pdf", bbox_inches = "tight")

plt.show()

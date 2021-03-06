import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 0
dt = 0.1
b2 = 4 * 10**(-5)
g = 9.81

angleDeg = [35, 45]
angleRad = [i*np.pi/180 for i in angleDeg]
plt.figure()

for i, angle in enumerate(angleRad):
    v = 700
    vx = v*np.cos(angle)
    vy = v*np.sin(angle)
    x = [x0]
    y = [y0]

    while y[-1] >= 0:
        x += [x[-1] + vx*dt]
        vx = vx - b2 * v * vx *dt
        y += [y[-1] + vy*dt]
        vy = vy - g*dt - b2*v*vy*dt
        v = np.sqrt(vx**2 + vy**2)
    
    plt.plot(np.array(x)/1000, np.array(y)/1000, ':')

for i, angle in enumerate(angleRad):
    v = 700
    vx = v*np.cos(angle)
    vy = v*np.sin(angle)
    x = [x0]
    y = [y0]

    while y[-1] >= 0:
        x += [x[-1] + vx*dt]
        vx = vx - b2 * v * vx * dt * np.exp(-y[-1]/1e4)
        y += [y[-1] + vy*dt]
        vy = vy - g*dt - b2*v*vy*dt*np.exp(-y[-1]/1e4)
        v = np.sqrt(vx**2 + vy**2)
    
    plt.plot(np.array(x)/1000, np.array(y)/1000)

plt.xlim((0,30))
plt.ylim((0,10))
plt.tick_params(direction = 'in', top = True, right = True)
plt.xlabel("$x$ (km)")
plt.ylabel("$y$ (km)")
plt.title("Canon shell trajectory")
plt.annotate(s='', xy=(21,4),xytext=(23,5.8),arrowprops=dict(arrowstyle='->',connectionstyle="arc3,rad=-.2"))
plt.annotate(s='', xy=(24,4),xytext=(25,5.8),arrowprops=dict(arrowstyle='->',connectionstyle="arc3,rad=-.2"))
plt.text(21, 6, "With density \n correction", size = 14)
plt.annotate(s='', xy=(17,4), xytext=(13,3), arrowprops=dict(arrowstyle='->', connectionstyle="arc3,rad=-.2"))
plt.annotate(s='', xy=(19,3.8), xytext=(16,2.5), arrowprops=dict(arrowstyle='->', connectionstyle="arc3,rad=-.2"))
plt.text(12, 2, "Without \n density correction", size = 14, horizontalalignment = "center")

plt.show()
import numpy as np
import matplotlib.pyplot as plt

import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 1
dt = 0.01
g = 9.81
vd = 35
Delta = 5
b2 = 4 * 10**(-5)

def b2(v):
    return 0.0039 + 0.0058/(1 + np.exp((v-vd)/Delta))



v = 49
angle = np.deg2rad(35)
vx = v*np.cos(angle)
vy = v*np.sin(angle)
x = [x0]
y = [y0]

while y[-1] >= 0:
    x += [x[-1] + vx*dt]
    vx = vx - b2(v) * v * vx *dt * np.exp(-y[-1]/1e4)
    y += [y[-1] + vy*dt]
    vy = vy - g*dt - b2(v)*v*vy*dt * np.exp(-y[-1]/1e4)
    v = np.sqrt(vx**2 + vy**2)

plt.plot(np.array(x), np.array(y))

v = 49
angle = np.deg2rad(35)
vx = v*np.cos(angle)
vy = v*np.sin(angle)
x = [x0]
y = [y0]
vwind = 4.5

while y[-1] >= 0:
    x += [x[-1] + vx*dt]
    vx = vx - b2(np.sqrt((vx-vwind)**2 + vy**2)) * np.sqrt((vx-vwind)**2 + vy**2) * (vx - vwind) *dt * np.exp(-y[-1]/1e4) 
    y += [y[-1] + vy*dt]
    vy = vy - g*dt - b2(np.sqrt((vx-vwind)**2 + vy**2))*np.sqrt((vx-vwind)**2 + vy**2) * (vy)*dt * np.exp(-y[-1]/1e4)
    v = np.sqrt(vx**2 + vy**2)

plt.plot(np.array(x), np.array(y), ':')

v = 49
angle = np.deg2rad(35)
vx = v*np.cos(angle)
vy = v*np.sin(angle)
x = [x0]
y = [y0]
vwind = -4.5

while y[-1] >= 0:
    x += [x[-1] + vx*dt]
    vx = vx - b2(np.sqrt((vx-vwind)**2 + vy**2)) * np.sqrt((vx-vwind)**2 + vy**2) * (vx - vwind) *dt * np.exp(-y[-1]/1e4) 
    y += [y[-1] + vy*dt]
    vy = vy - g*dt - b2(np.sqrt((vx-vwind)**2 + vy**2))*np.sqrt((vx-vwind)**2 + vy**2) * (vy)*dt * np.exp(-y[-1]/1e4)
    v = np.sqrt(vx**2 + vy**2)

plt.plot(np.array(x), np.array(y), '-.')

plt.xlabel("$x$ (m)")
plt.ylabel("$y$ (m)")
plt.title("Trajectory of a batted baseball")
plt.ylim((0,30))
plt.xlim((0,150))
plt.tick_params(direction = 'in', top = True, right = True)
plt.annotate(s = '', xy = (110, 18), xytext = (120, 22), arrowprops=dict(arrowstyle='->',connectionstyle="arc3,rad=-.2"))
plt.annotate(s = '', xy = (115, 8), xytext = (130, 12), arrowprops=dict(arrowstyle='->',connectionstyle="arc3,rad=-.2"))
plt.annotate(s = '', xy = (103, 12), xytext = (90, 8), arrowprops=dict(arrowstyle='->',connectionstyle="arc3,rad=-.1"))
plt.text(110, 22, "tailwind", size = 14)
plt.text(120, 12, "no wind", size = 14)
plt.text(76, 6.5, "headwind", size = 14)

plt.show()
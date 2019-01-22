import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 0
dt = 0.1
b2 = 4 * 10**(-5)
g = 9.81
angleDeg = [30, 35, 40, 45, 50, 55]
angleRad = [i*np.pi/180 for i in angleDeg]

# ======================
# Without Drag
# ======================

for i, angle in enumerate(angleRad):
    v = 700
    vx = v*np.cos(angle)
    vy = v*np.sin(angle)
    x = [x0]
    y = [y0]

    while y[-1] >= 0:
        x += [x[-1] + vx*dt]
        vx = vx 
        y += [y[-1] + vy*dt]
        vy = vy - g*dt
        v = np.sqrt(vx**2 + vy**2)
    
    plt.plot(np.array(x)/1000, np.array(y)/1000)

plt.xlabel('$x$ (km)')
plt.ylabel('$y$ (km)')
plt.title('Trajectory of cannon shell')
plt.tick_params(direction = 'in', right = True, top = True)
plt.xlim(0,60)
plt.ylim(0,20)
plt.figure()
# ================
# With drag
# ================

for angle in angleRad:
    v = 700
    vx = v*np.cos(angle)
    vy = v*np.sin(angle)
    x = [x0]
    y = [y0]
    print(y0)

    while y[-1] >= 0:
        x += [x[-1] + vx*dt]
        vx = vx - b2 * v * vx *dt
        y += [y[-1] + vy*dt]
        vy = vy - g*dt - b2*v*vy*dt
        v = np.sqrt(vx**2 + vy**2)
    
    plt.plot(x, y)

plt.show()



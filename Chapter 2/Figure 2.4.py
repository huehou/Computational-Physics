import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 0
dt = 0.1
b2 = 4 * 10**(-5)
g = 9.81
angleDeg = [30, 35, 40, 45, 50, 55]
angleRad = [i*np.pi/180 for i in angleDeg]
theta = [(30,'-'), (35,':'), (40,'-.'), (45,'--'), (50,'--'), (55,'-')];

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
    
    plt.plot(np.array(x)/1000, np.array(y)/1000, theta[i][1])

plt.xlabel('$x$ (km)')
plt.ylabel('$y$ (km)')
plt.title('Trajectory of cannon shell')
plt.tick_params(direction = 'in', right = True, top = True)
plt.xlim(0,60)
plt.ylim(0,20)
plt.text(45, 17.5, 'No drag', size = 14)

for i, (angle, style) in enumerate(theta[:-1]):
    plt.text(20, 5.2 + i*2, str(angle) + '$^o$', size = 14)
plt.text(20, 17.5, '55$^o$', size = 14)
plt.figure()
# ================
# With drag
# ================

for i, angle in enumerate(angleRad):
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
    
    plt.plot(np.array(x)/1000, np.array(y)/1000, theta[i][1])

plt.xlim(0,60)
plt.ylim(0,20)
plt.text(40, 17.5, 'With air drag', size = 14)
plt.title('Trajectory of canon shell')
plt.tick_params(direction = 'in', top = True, right = True)
plt.xlabel("$x$ (km)")
plt.ylabel("$y$ (km)")

plt.show()



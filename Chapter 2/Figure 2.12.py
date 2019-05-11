import numpy as np
import matplotlib.pyplot as plt

fLat = lambda theta: 0.5 * (np.sin(4*theta) - 0.25 * np.sin(8*theta) + 0.08*np.sin(12*theta) - 0.025*np.sin(16*theta))

thetaList = [(74*np.pi/180, '-.'), (118*np.pi/180, '-'), (125*np.pi/180, ':')]


dt = 0.01
vd = 35
Delta = 5
g = 9.81
s0 = 4.1e-4
omega = 0.2*2*np.pi

def b2(v):
    return 0.0039 + 0.0058/(1 + np.exp((v-vd)/Delta))

for theta, styl in thetaList:
    x0 = 0
    y0 = 2
    z0 = 0
    x = [x0]
    y = [y0]
    z = [z0]
    vx = 29                           
    vy = 0
    vz = 0
    v = np.sqrt(vx**2 + vy**2 + vz**2)

    while x[-1] < 18.2:
        x += [x[-1] + vx*dt]
        y += [y[-1] + vy*dt]
        z += [z[-1] + vz*dt]
        vz = vz + fLat(theta)*dt*g - s0*vx*omega*dt
        vy = vy - g*dt 
        vx = vx - b2(v)*v*vx*dt
        v = np.sqrt(vx**2 + vy**2 + vz**2)
        theta = theta + omega*dt

    x = np.array(x)*3.28084
    y = np.array(y)*3.28084
    z = np.array(z)*3.28084

    plt.plot(x, z, styl)

line1 = np.linspace(-0.6, 0.6, 100)
pitch = np.zeros(line1.size)
line2 = np.linspace(-0.8, 0.8, 100)
plate = np.ones(line2.size) * 60

plt.plot(pitch, line1, 'k--')
plt.plot(plate, line2, 'k--')
plt.ylim(-1,1)
plt.xlim(-10,70)
plt.tick_params(direction = 'in', right = True, top = True)
plt.title("Knuckle ball - horizontal deflection")
plt.xlabel("$x$ (feet)")
plt.ylabel("$z$ (feet)")

plt.annotate(s='', xy = (60, -0.45), xytext = (50, -0.7), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate(s='', xy = (0, 0.4), xytext = (-5, 0.75), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=.2"))
plt.text(42, -0.8, "homeplate")
plt.text(-8, 0.77, "pitcher")

plt.show()
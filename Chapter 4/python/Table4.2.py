import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

G_Ms = 4*np.pi**2
x0 = 1.0
y0 = 0.0
vx0 = 0.0
vy0 = 2*np.pi

def planet_1step(x0, y0, vx0, vy0, t0, dt):
    vx1 = vx0 - G_Ms*x0/(x0**2 + y0**2)**(3./2.)*dt
    x1 = x0 + vx1*dt
    vy1 = vy0 - G_Ms*y0/(x0**2 + y0**2)**(3./2.)*dt
    y1 = y0 + vy1*dt
    t1 = t0 + dt

    return (x1, y1, vx1, vy1, t1)

def planet(x0, y0, vx0, vy0, t, dt):
    steps = int(t/dt)

    x = np.zeros(steps+1)
    y = np.zeros(steps+1)
    vx = np.zeros(steps+1)
    vy = np.zeros(steps+1)
    t = np.zeros(steps+1)

    x[0] = x0
    y[0] = y0
    vx[0] = vx0
    vy[0] = vy0

    for i in range(steps):
        x[i+1], y[i+1], vx[i+1], vy[i+1], t[i+1] = planet_1step(x[i], y[i], vx[i], vy[i], t[i], dt) 

    return x, y, vx, vy, t

def circulate(r, v0, vmin, vmax, dt):

    # Trying to find the right vy0
    x0 = r
    y0 = 0.0
    vx0 = 0.0
    vy0 = v0
    t0 = 0.0
    R = 0.0
    T = 0.0

    x1, y1, vx1, vy1, t1 = planet_1step(x0, y0, vx0, vy0, t0, dt) 
    while True:
        if t1 > 0.0 and x0 < 0.0 and x1 >= 0.0:
            if np.abs((x1**2 + y1**2) - r**2) > 1e-10 and (x1**2 + y1**2) > r**2:
                print("Velocity {} is too high".format(v0))
                v0, vmax = (vmin+vmax)/2, v0
                x1 = r
                y1 = 0.0
                vx1 = 0.0
                vy1 = v0
                t1 = 0.0
            elif np.abs((x1**2 + y1**2) - r**2) > 1e-10 and (x1**2 + y1**2) < r**2:
                print("Velocity {} is too low".format(v0))
                vmin, v0 = v0, (vmin+vmax)/2
                x1 = r
                y1 = 0.0
                vx1 = 0.0
                vy1 = v0
                t1 = 0.0
        elif t1 > 0.0 and y0 < 0.0 and y1 >= 0.0:
            print("A success!")
            R = np.sqrt(x1**2 + y1**2)
            T = t1
            break

        x0, y0, vx0, vy0, t0 = x1, y1, vx1, vy1, t1
        x1, y1, vx1, vy1, t1 = planet_1step(x0, y0, vx0, vy0, t0, dt)

    x, y, vx, vy, t = planet(r, 0.0, 0.0, v0, 30.0, dt)

    # return R, T
    return x, y, vx, vy, t, R, T


def main():
    X0 = [0.72, 1.00, 1.52, 5.20, 9.54]
    V0 = [2*np.pi, 2*np.pi, 1., 1., 1.]
    VMAX = [10., 7., 7., 5., 4.2]
    X = []
    Y = []
    R = np.zeros(len(X0))
    T = np.zeros(len(X0))
    
    for i in range(len(X0)):
        x, y, vx, vy, t, R[i], T[i] = circulate(X0[i], V0[i], 0., VMAX[i], 0.0001)
        X += [x]
        Y += [y]
        print("This is for x0 = {}".format(X0[i]))

    for i in range(len(X)):
        ax = plt.plot(X[i], Y[i])

    plt.tick_params(direction = "in", top = True, right = True)
    plt.gca().set_aspect("equal")
    plt.xlim([-10,10])
    plt.ylim([-10,10])
    plt.xlabel("x (AU)")
    plt.ylabel("y (AU)")
    plt.title("Planetary circular orbits around the Sun")
    plt.xticks(np.arange(-10,10,5))
    plt.yticks(np.arange(-10,10,5))

    print("Kepler's constant table:")
    res = T**2/R**3
    print(res)



    plt.show()

if __name__ == "__main__":
    main()


    

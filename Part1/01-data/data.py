#!python

import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit

method = 'poly'
label_x = r'$x_{Ti}$'
label_y = r'$E_{tot}$ (Ry)'
filename = "lab2p8b.out"
figname = 'lab2p8b.png'

#limit = 5 * 1e-3 /13.605698065894
column_x = 0
column_y = 1


def exp_decay(x, a, b, c):
    return(a + b * np.exp(-c * x/100))
def poly_fit(x, a, b, c, d, e):
    return(a * x**4 + b * x**3 + c * x**2 + d * x + e)

f = open(filename, 'r')
i = 0
data = []

for line in f:
    data.append([float(i) for i in line.split()]);
#print(data)
f.close()

points = np.array([np.array(data)[:, column_x], np.array(data)[:, column_y]])

max_x = max(points[0])
min_x = min(points[0])
diff_x = (max_x - min_x)/1000.

#print(points[:,0])
#print(points[:,1])

fig = plt.figure()
plt.plot(points[0], points[1], 'ro')

if method == 'exp':
    popt, pcov = curve_fit(exp_decay, points[0], points[1])
    print(popt)
    x_test = np.arange(min_x, max_x, diff_x)
    plt.plot(x_test, exp_decay(x_test, *popt), 'k')
    plt.plot([min_x, max_x], [popt[0], popt[0]], 'b--')
    print(popt[0])
elif method == 'no':
    final = points[1, -1]
    hi = final + limit
    lo = final - limit
    plt.plot([min_x, max_x], [hi, hi], 'b--')
    plt.plot([min_x, max_x], [lo, lo], 'b--')
    print("E_final = {}".format(final))
    plt.axis([min_x-50*diff_x, max_x+50*diff_x, final-50*limit, final+50*limit])
elif method == 'poly':
    popt, pcov = curve_fit(poly_fit, points[0], points[1])
    print(popt)
    x_test = np.arange(min_x, max_x, diff_x)
    y_test = poly_fit(x_test, *popt)
    minpos = np.argmin(y_test)
    print([x_test[minpos], y_test[minpos]])
    plt.plot(x_test, y_test, 'k')
    #plt.axis([min_x-50*diff_x, max_x+50*diff_x, final-50*limit, final+50*limit])
    


plt.xlabel(label_x)
plt.ylabel(label_y)
plt.tight_layout()
plt.savefig(figname)

plt.show()


#!python

# runPEGS P T
# First argument = Number of Monte-Carlo steps / degree of freedom
# Second argument = Number of temperature steps

import matplotlib.pyplot as plt
import numpy as np

def energy_plot(lab_x, lab_y, filen, fign, ax_x):
    f = open(filen, 'r')
    data = []
    tmp = []
    
    for line in f:
        if line.split()[0] == '!':
            if tmp:
                data.append(np.mean(tmp))
            tmp = []
            continue
        else:
            tmp.append(float(line))
    data.append(np.mean(tmp))
    print(data)
    f.close()
    fig = plt.figure()
    plt.plot(ax_x, data, 'ro')
    plt.xlabel(lab_x)
    plt.ylabel(lab_y)
    plt.tight_layout()
    plt.savefig(fign)


label_x = 'Number of Monte-Carlo steps / degree of freedom'
label_y = r'$E_{avg}$'
filename = 'energy.P'
figname = 'fig.P.png'
axis_x = range(200,600+1,100)

energy_plot(label_x, label_y, filename, figname, axis_x)

label_x = 'Number of temperature steps'
label_y = r'$E_{avg}$'
filename = 'energy.T'
figname = 'fig.T.png'
axis_x = range(5,25+1,5)

energy_plot(label_x, label_y, filename, figname, axis_x)

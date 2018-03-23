#!/software/anaconda2/bin/python

ele_file = 'energy-element.out'
ele_f = open(ele_file, 'r')
ele_dict = {}

for line in ele_f:
    [ele, ener] = [i for i in line.split()]
    ele_dict[str(ele)] = float(ener)
ele_f.close()

comp_file = 'energy-prototype.out'
comp_f = open(comp_file, 'r')

count = 0
for num_line, line in enumerate(comp_f):
    raw = [i for i in line.split()]
    if len(raw) == 6:
        [ele_1, nat_1, ele_2, nat_2, prototype, energy] = raw
        e_beat = float(nat_1) * ele_dict[str(ele_1)] + float(nat_2) * ele_dict[str(ele_2)]
        if e_beat > float(energy):
            count += 1
            print("({:4d})  {:3d}: E_diff = {:2.15f}     {}{}{}{}     {}/{}/{}-{}-{}".format(count, num_line, e_beat-float(energy), ele_1, nat_1, ele_2, nat_2, ele_1, ele_2, ele_1, ele_2, prototype))


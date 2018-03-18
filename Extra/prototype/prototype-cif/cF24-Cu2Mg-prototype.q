! Generated by using cif2qe Version 1.2 - Date: Sun Mar 18 13:17:15 CDT 2018
!   _symmetry_space_group_name_H-M = 
!   _symmetry_Int_Tables_number = 1
!   _symmetry_cell_setting = 
! a=4.96317  b=4.96317  c=4.96317  alpha=60  beta=60  gamma=60
! Found by cif2qe: lattice = rhombohedral    Space group = P1   ibrav = 4
!
!
! Symmetry found:
!   1                        x, y, z    [x]  [ y]  [ z]
&CONTROL
                       title = 'cF24-Cu2Mg-prototype.cif'
                 calculation = 'relax'
                restart_mode = 'from_scratch'
                      outdir = './1'
                  pseudo_dir = '../PP/atompaw'
                      prefix = 'cF24-Cu2Mg-prototype'
                     disk_io = 'none'
                   verbosity = 'default'
               etot_conv_thr = 0.0001
               forc_conv_thr = 0.001
                       nstep = 400
                     tstress = .true.
                     tprnfor = .true.
 /
 &SYSTEM
                       ibrav = 0
                         nat = 6
                        ntyp = 2
                     ecutwfc = 60
                     ecutrho = 480
                    vdw_corr = 'xdm'
                      xdm_a1 = 1.2153
                      xdm_a2 = 2.3704
 /
 &ELECTRONS
            electron_maxstep = 200
                    conv_thr = 1.0D-7
              diago_thr_init = 1e-4
                 startingpot = 'atomic'
                 startingwfc = 'atomic'
                 mixing_mode = 'plain'
                 mixing_beta = 0.5
                 mixing_ndim = 8
             diagonalization = 'david'
 /
&IONS
                ion_dynamics = 'bfgs'
 /

ATOMIC_SPECIES
   Mg   24.3050000000  Mg.pw86pbe-n-kjpaw_psl.1.0.0.UPF
   Cu   63.5460000000  Cu.pw86pbe-n-kjpaw_psl.1.0.0.UPF

ATOMIC_POSITIONS crystal
Mg      0.75000000000000      0.75000000000000      0.75000000000000
Mg      0.50000000000000      0.50000000000000      0.50000000000000
Cu      0.12500000000000      0.12500000000000      0.12500000000000
Cu      0.62500000000000      0.12500000000000      0.12500000000000
Cu      0.12500000000000      0.62500000000000      0.12500000000000
Cu      0.12500000000000      0.12500000000000      0.62500000000000

K_POINTS automatic
3  3  3   0 0 0

CELL_PARAMETERS
     9.37903830244557      0.00000000000000      0.00000000000000
     4.68951915122279      8.12248543298514      0.00000000000000
     4.68951915122279      2.70749514432838      7.65795270633699




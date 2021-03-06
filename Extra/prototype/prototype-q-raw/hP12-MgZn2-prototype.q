! Generated by using cif2qe Version 1.2 - Date: Sun Mar 18 13:17:15 CDT 2018
!   _symmetry_space_group_name_H-M = 
!   _symmetry_Int_Tables_number = 1
!   _symmetry_cell_setting = 
! a=5.25128  b=5.25128  c=8.44523  alpha=90  beta=90  gamma=120
! Found by cif2qe: lattice = hexagonal    Space group = P1   ibrav = 4
!
!
! Symmetry found:
!   1                        x, y, z    [x]  [ y]  [ z]
&CONTROL
                       title = 'hP12-MgZn2-prototype.cif'
                 calculation = 'relax'
                restart_mode = 'from_scratch'
                      outdir = './1'
                  pseudo_dir = '../PP/atompaw'
                      prefix = 'hP12-MgZn2-prototype'
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
                         nat = 12
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
   Zn   65.3900000000  Zn.pw86pbe-n-kjpaw_psl.1.0.0.UPF

ATOMIC_POSITIONS crystal
Mg      0.33333300000000      0.66666700000000      0.06241800000000
Mg      0.66666700000000      0.33333300000000      0.56241800000000
Mg      0.66666700000000      0.33333300000000      0.93758200000000
Mg      0.33333300000000      0.66666700000000      0.43758200000000
Zn      0.00000000000000      0.00000000000000      0.00000000000000
Zn      0.00000000000000      0.00000000000000      0.50000000000000
Zn      0.17036100000000      0.34072200000000      0.75000000000000
Zn      0.82963900000000      0.17036100000000      0.25000000000000
Zn      0.34072200000000      0.17036100000000      0.25000000000000
Zn      0.65927800000000      0.82963900000000      0.75000000000000
Zn      0.17036100000000      0.82963900000000      0.75000000000000
Zn      0.82963900000000      0.65927800000000      0.25000000000000

K_POINTS automatic
3  3  2   0 0 0

CELL_PARAMETERS
     9.92348860010504      0.00000000000000      0.00000000000000
    -4.96174430005252      8.59399322185624      0.00000000000000
     0.00000000000000      0.00000000000000     15.95917489590596




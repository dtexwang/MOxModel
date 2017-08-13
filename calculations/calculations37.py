'''
DISPLAY UNITS:
cell density / (1e6 cells/ml)
csSRR / (fmol / cell / day)
eps34 / permil
d34 / permil
alpha34
f
Y / (1e6 cells / umol)
k / (1/d)

BASE UNITS for calculations:
cells
L
moles
days
1 (= 1000 permil)
'''

import pandas as pd
import numpy as np
import matplotlib as mpl
import pylab as pl
import uncertainties as u
import uncertainties.umath as um

## READ in the data
df = pd.read_csv('dataforpy37.csv')#, index_col=['tp'])

df['f_'] = u.ufloat(np.nan, np.nan)
df['d13C_'] = u.ufloat(np.nan, np.nan)
df['dD_'] = u.ufloat(np.nan, np.nan)
df['D13CH3D_'] = u.ufloat(np.nan, np.nan)
df['alpha13_'] = u.ufloat(np.nan, np.nan)
df['alphaD_'] = u.ufloat(np.nan, np.nan)
df['gamma_'] = u.ufloat(np.nan, np.nan)            # create new column ('gamma'), with all nan +/- 0 (this preserves the Type when replacing these cells with actual calculated values)

for i in range(0,np.size(df.index)):
    df.set_value(i,'f_',u.ufloat(df.get_value(i,'f'),df.get_value(i,'unc_f')))
    df.set_value(i,'d13C_',u.ufloat(df.get_value(i,'d13C'),df.get_value(i,'unc_d13C')))
    df.set_value(i,'dD_',u.ufloat(df.get_value(i,'dD'),df.get_value(i,'unc_dD')))
    df.set_value(i,'D13CH3D_',u.ufloat(df.get_value(i,'D13CH3D'),df.get_value(i,'unc_D13CH3D')))

for i in range(1,np.size(df.index)):
    df.set_value(i,'alpha13_', um.log((df.get_value(i,'d13C_')/1000+1)/(df.get_value(0,'d13C_')/1000+1))/um.log(df.get_value(i,'f_'))+1)
    df.set_value(i,'alphaD_', um.log((df.get_value(i,'dD_')/1000+1)/(df.get_value(0,'dD_')/1000+1))/um.log(df.get_value(i,'f_'))+1)
    df.set_value(i,'gamma_', ( (df.get_value(i,'D13CH3D_')/1000 - df.get_value(0,'D13CH3D_')/1000)/um.log(df.get_value(i,'f_')) + df.get_value(i,'alpha13_') + df.get_value(i,'alphaD_') - 1 ) / ( df.get_value(i,'alpha13_') * df.get_value(i,'alphaD_') ))
    

## RETRIEVE nominal values and uncertainties, and format the numbers

df2 = pd.DataFrame(index = df.index)   # create an empty data frame with same index as df

# apply number formatting
df2['tp'] = df.tp.apply(lambda number: "{0:.1f}".format(number))

df2['alpha13_nom'] = df.alpha13_.apply(lambda number: "{0:.4f}".format(u.nominal_value(number)))
df2['alpha13_sd'] = df.alpha13_.apply(lambda number: "{0:.4f}".format(u.std_dev(number)))

df2['alphaD_nom'] = df.alphaD_.apply(lambda number: "{0:.4f}".format(u.nominal_value(number)))
df2['alphaD_sd'] = df.alphaD_.apply(lambda number: "{0:.4f}".format(u.std_dev(number)))

df2['gamma_nom'] = df.gamma_.apply(lambda number: "{0:.4f}".format(u.nominal_value(number)))
df2['gamma_sd'] = df.gamma_.apply(lambda number: "{0:.4f}".format(u.std_dev(number)))


# turn the "nan"'s into ""
df2.replace("nan", "", inplace=True)
# this way is more complicated, but achieves the same thing: df2 = df2.applymap(lambda cell_contents: " " if cell_contents == "nan" else cell_contents)


## WRITE results to CSV
df2.to_csv('calculated37.csv')

set -e

##   (Re)generate NeuroML 2 & LEMS files from the python3 scripts

python3 c302_IClamp.py A
python3 c302_Syns.py A
python3 c302_Social.py A
python3 c302_Pharyngeal.py A
python3 c302_Full.py A
python3 c302_Muscles.py A
python3 c302_Oscillator.py A


python3 c302_IClamp.py B
python3 c302_Syns.py B
python3 c302_Social.py B
python3 c302_Pharyngeal.py B
python3 c302_Full.py B
python3 c302_Muscles.py B
python3 c302_Oscillator.py B


python3 c302_IClamp.py C
python3 c302_Syns.py C
python3 c302_Social.py C
python3 c302_Pharyngeal.py C
python3 c302_Full.py C
python3 c302_Muscles.py C
python3 c302_Oscillator.py C

python3 c302_IClamp.py C0
python3 c302_Syns.py C0
python3 c302_Social.py C0
python3 c302_Pharyngeal.py C0
python3 c302_Full.py C0
python3 c302_Muscles.py C0
python3 c302_Oscillator.py C0

python3 c302_IClamp.py C1
python3 c302_Syns.py C1
python3 c302_Social.py C1
python3 c302_Pharyngeal.py C1
python3 c302_Full.py C1
python3 c302_Muscles.py C1
python3 c302_Oscillator.py C1

python3 c302_IClamp.py C2
python3 c302_Syns.py C2
python3 c302_Social.py C2
python3 c302_Pharyngeal.py C2
python3 c302_Full.py C2
python3 c302_Muscles.py C2
python3 c302_Oscillator.py C2

python3 c302_IClamp.py D
python3 c302_Syns.py D
python3 c302_Social.py D
python3 c302_Pharyngeal.py D
python3 c302_Full.py D
python3 c302_Muscles.py D
python3 c302_Oscillator.py D

python3 c302_IClamp.py D1
python3 c302_Syns.py D1
python3 c302_Social.py D1
python3 c302_Pharyngeal.py D1
python3 c302_Full.py D1
python3 c302_Muscles.py D1
python3 c302_Oscillator.py D1

cd examples

## Validate generated NeuroML 2

jnml -validate c302_A_Full.net.nml
jnml -validate c302_A_Pharyngeal.net.nml
jnml -validate c302_A_Syns.net.nml
jnml -validate c302_A_Social.net.nml
jnml -validate c302_A_Muscles.net.nml

# Not validating B files as they use non NeuroML 2 compliant IaFCell model with activity...

jnml -validate c302_C_Full.net.nml
jnml -validate c302_C_Pharyngeal.net.nml

jnml -validate c302_C1_Full.net.nml
jnml -validate c302_C1_Pharyngeal.net.nml

jnml -validate c302_D_Full.net.nml
jnml -validate c302_D_Pharyngeal.net.nml

#jnml -validate c302_D1_Full.net.nml
#jnml -validate c302_D1_Pharyngeal.net.nml


## Try running these in jNeuroML with no GUI

#jnml LEMS_c302_A_Full.xml -nogui    #  Takes 2 mins to run!
jnml LEMS_c302_A_Pharyngeal.xml -nogui
jnml LEMS_c302_A_Syns.xml -nogui
jnml LEMS_c302_A_Social.xml -nogui

#jnml LEMS_c302_B_Full.xml -nogui    #  Takes 2 mins to run!
jnml LEMS_c302_B_Pharyngeal.xml -nogui
jnml LEMS_c302_B_Syns.xml -nogui
jnml LEMS_c302_B_Social.xml -nogui

## Try regenerating using command line options

cd ..

python3 c302.py c302_A_Syns2 parameters_A -cells ["ADAL","AIBL","RIVR","RMEV"] -cellstostimulate ["ADAL","RIVR"] -duration 500 -dt 0.1 -vmin -72 -vmax -48

python3 c302.py c302_A_Weights parameters_A -cells ["ADAL","AIBL","I1L","I3","DB5","PVCR"] -cellstostimulate ["ADAL","I1L","PVCR"] -connnumberoverride=["I1L-I3":2.5] -connnumberscaling=["PVCR-DB5":5] -duration 500 -dt 0.1 -vmin -72 -vmax -48

python3 c302.py c302_C1_Test parameters_C1 -cellstostimulate AFDL -connnumberscaling {"I1L-I3":2}

mkdir -p cells
python3 c302.py c302_D1_Weights parameters_D1 -cells ["ADAL","AIBL","I1L","I3","DB5","PVCR"] -cellstostimulate ["ADAL","I1L","PVCR"] -connnumberoverride=["I1L-I3":2.5] -connnumberscaling=["PVCR-DB5":5] -duration 500 -dt 0.1

cd examples

## Try converting some to NEURON

jnml LEMS_c302_A_Full.xml -neuron
jnml LEMS_c302_B_Pharyngeal.xml -neuron
jnml LEMS_c302_C_Syns.xml -neuron
nrnivmodl

cd -

## Try helper scripts

python3 runAndPlot.py -test

python3 c302_utils.py -nogui

echo "Successfully completed all c302 tests on Python 3!"
  

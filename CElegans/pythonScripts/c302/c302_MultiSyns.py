
# Model of a decision making circuit

# See https://github.com/openworm/OpenWorm/issues/212

# To run:
#          python c302_Social.py A   (uses parameters_A, requires jNeuroML to run)
# or
#          python c302_Social.py B   (uses parameters_B, requires jNeuroML built from the 
#                                     experimental branches to run: 'python getNeuroML experimental'
#                                     see https://github.com/NeuroML/jNeuroML)

from c302 import generate, add_new_input

import neuroml.writers as writers

import sys


if __name__ == '__main__':
    
    parameter_set = sys.argv[1] if len(sys.argv)==2 else 'A'
    
    exec('from parameters_%s import ParameterisedModel'%parameter_set)
    params = ParameterisedModel()
    
    cells = ["URYDL", "SMDDR", "ADAL", "RIML", "IL2VL", "RIPL"]
    cells_to_stimulate      = []
    
    reference = "c302_%s_MultiSyns"%parameter_set
    
    target_directory='examples'
    
    nml_doc = generate(reference, 
                       params, 
                       cells=cells, 
                       cells_to_stimulate=cells_to_stimulate, 
                       duration=1000, 
                       dt=0.1, 
                       validate=(parameter_set!='B'),
                       target_directory=target_directory)
             
    stim_amplitude = "0.35nA"
    add_new_input(nml_doc, "URYDL", "100ms", "200ms", stim_amplitude, params)
    add_new_input(nml_doc, "ADAL", "400ms", "200ms", stim_amplitude, params)
    add_new_input(nml_doc, "IL2VL", "700ms", "200ms", stim_amplitude, params)
    
    
    nml_file = target_directory+'/'+reference+'.nml'
    writers.NeuroMLWriter.write(nml_doc, nml_file) # Write over network file written above...
    
    print("(Re)written network file to: "+nml_file)
#!/bin/csh -f

set prog = ../../programs

make -C $prog flow

${prog}/flow << EOF >! flow.pic
Down
Box 6 3
    Quick equivalent width
    measurement to get 
    starting point of 
    analysis
Box 6 3
    Use \$\chi^2\$ analysis of
    helium lines to estimate
    broadening velocity
    parameter
Box 6 3
    Perform \$\chi^2\$ fitting
    of hydrogen line wings 
    to constrain \\logg
Box 6 3
    Create \\teff\\ vs.
    \\logg\\ diagrams
Tag
Box 6 3
    Find final solution by 
    impact parameter 
    analysis
ToTag
Right 4
Up
Box 6 2
    Repeat for higher 
    helium fraction
Up 1
Left 4 *
EOF


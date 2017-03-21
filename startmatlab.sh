#!/bin/sh

# NVIDIA CUDA
CUDA_PATH=/usr/local/cuda
export PYTHONPATH=$CUDA_PATH/lib64/:$PYTHONPATH

# Set timezone. If empty it can raise a Matlab warning when batch jops are executed
export TZ='Europe/Berlin'

# ASTRA    
export PATH=/opt/matlab/R2016b/bin/:$PATH
#export MATLAB_USER_PATH=/asap3/petra3/gpfs/common/p05/jm/matlab
# ASTRA 1.8 local
ASTRA_PATH=/asap3/petra3/gpfs/common/p05/astra/1.8
export LD_LIBRARY_PATH=$ASTRA_PATH/lib:$CUDA_PATH/lib64/:$LD_LIBRARY_PATH
export MATLABPATH=$ASTRA_PATH/matlab/mex/:$ASTRA_PATH/matlab/tools/:$ASTRA_PATH/samples/matlab/:$MATLABPATH
export PYTHONPATH=$ASTRA_PATH/python:$PYTHONPATH

#export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH

# local gcc 4.9, required to use matlab in python
#export LD_LIBRARY_PATH=/home/moosmanj/gcc/gcc/lib64/:$LD_LIBRARY_PATH
#export PATH=/home/moosmanj/gcc/gcc/bin:$PATH

echo -e 'Set environment variables:'
echo -e 'TZ:' $TZ
echo -e 'PATH:' $PATH
echo -e 'LD_LIBRARY_PATH:' $LD_LIBRARY_PATH
echo -e 'PYTHONPATH:' $PYTHONPATH
echo -e 'MATLABPATH:' $MATLABPATH
echo -e 'Starting MATLAB.\n'

#matlab_R2016b
matlab

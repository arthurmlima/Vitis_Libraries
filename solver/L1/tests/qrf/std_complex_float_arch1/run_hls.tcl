# Copyright (C) 2019-2022, Xilinx, Inc.
# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# vitis hls makefile-generator v2.0.0

source settings.tcl

set PROJ "qrf_test.prj"
set SOLN "sol1"

if {![info exists CLKP]} {
  set CLKP 300MHz
}

open_project -reset $PROJ

add_files "${XF_PROJ_ROOT}/L1/tests/qrf/kernel/kernel_qrf_0.cpp" -cflags "-DQRF_A_ROWS=3 -DQRF_A_COLS=3 -DQRF_TRANSPOSED_Q=0 -DSEL_ARCH=1 -D_DATA_PATH=${XF_PROJ_ROOT}/L1/tests/qrf/datas/ -I./ -I${XF_PROJ_ROOT}/L1/tests/qrf/host/ -I${XF_PROJ_ROOT}/L1/tests/qrf/kernel/ -I${XF_PROJ_ROOT}/L1/tests/qrf/ -I${XF_PROJ_ROOT}/L1/tests/ -I${XF_PROJ_ROOT}/L1/include/ -I${XF_PROJ_ROOT}/L1/include/hw -I${XF_PROJ_ROOT}/L2/include -I${XF_PROJ_ROOT}/../utils/L1/include/"
add_files -tb "${XF_PROJ_ROOT}/L1/tests/qrf/host/test_qrf.cpp" -cflags "-DQRF_A_ROWS=3 -DQRF_A_COLS=3 -DQRF_TRANSPOSED_Q=0 -DSEL_ARCH=1 -D_DATA_PATH=${XF_PROJ_ROOT}/L1/tests/qrf/datas/ -I./ -I${XF_PROJ_ROOT}/L1/tests/qrf/host/ -I${XF_PROJ_ROOT}/L1/tests/qrf/kernel/ -I${XF_PROJ_ROOT}/L1/tests/qrf/ -I${XF_PROJ_ROOT}/L1/tests/ -I${XF_PROJ_ROOT}/L1/include/ -I${XF_PROJ_ROOT}/L1/include/hw -I ./host -I${XF_PROJ_ROOT}/../utils/L1/include/"
set_top kernel_qrf_0

open_solution -reset $SOLN



set_part $XPART
create_clock -period $CLKP

if {$CSIM == 1} {
  csim_design
}

if {$CSYNTH == 1} {
  csynth_design
}

if {$COSIM == 1} {
  cosim_design
}

if {$VIVADO_SYN == 1} {
  export_design -flow syn -rtl verilog
}

if {$VIVADO_IMPL == 1} {
  export_design -flow impl -rtl verilog
}

exit
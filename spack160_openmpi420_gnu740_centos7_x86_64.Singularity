Bootstrap: docker
From: centos:centos7.4.1708
IncludeCmd: yes

# IMPORTANT: When you are going to work inside the container remember to source these 2 file in order to set the proper module environment with spack and Lmod
# source /opt/spack/share/spack/setup-env.sh && source /usr/share/lmod/8.2.7/init/sh


%post

yum -y install epel-release
yum -y groupinstall "Development tools"
yum install -y c-ares c-ares-devel Lmod python36
yum install -y  bzip2  gzip tar  zip unzip xz curl wget vim patch make cmake file git which perl-Data-Dumper perl-Thread-Queue boost-devel
yum install -y numactl-libs gtk2 atk cairo tcsh lsof ethtool tk pciutils libnl3 libmnl libudev-devel

rm -rf /var/cache/yum 
yum clean all

# INSTALL SPACK

cd /opt 
git clone https://github.com/spack/spack.git
cd spack
git checkout tags/v0.16.0

# SPACK ENVIRONMENT

export SPACK_ROOT=/opt/spack
export PATH=${SPACK_ROOT}/bin:$PATH
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos7-skylake:/opt/spack/share/spack/modules/linux-centos7-haswell

cat > /opt/spack/etc/spack/defaults/linux/compilers.yaml <<EOF
compilers:
- compiler:
    spec: gcc@4.8.5
    paths:
      cc: /bin/gcc
      cxx: /bin/g++
      f77: /bin/gfortran
      fc: /bin/gfortran
    flags: {}
    operating_system: centos7
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
EOF

spack install gcc@7.4.0 %gcc@4.8.5

spack gc -y

cat >> /opt/spack/etc/spack/defaults/linux/compilers.yaml <<EOF
- compiler:
    spec: gcc@7.4.0
    paths:
      cc: /opt/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/gcc-7.4.0-hox4jguvbmmdidqucgpybhmrnv5vxn4l/bin/gcc
      cxx: /opt/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/gcc-7.4.0-hox4jguvbmmdidqucgpybhmrnv5vxn4l/bin/g++
      f77: /opt/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/gcc-7.4.0-hox4jguvbmmdidqucgpybhmrnv5vxn4l/bin/gfortran
      fc: /opt/spack/opt/spack/linux-centos7-haswell/gcc-4.8.5/gcc-7.4.0-hox4jguvbmmdidqucgpybhmrnv5vxn4l/bin/gfortran
    flags: {}
    operating_system: centos7
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
EOF

spack install openmpi@4.0.2 %gcc@7.4.0 fabrics=psm2,verbs,ofi +pmi +legacylaunchers schedulers=slurm ^slurm@20-02-4-1 ^python@3.6.4

spack gc -y

# ADDITIONAL FILES TO HANDLE ENVIRONMENT VARIABLES

cat > /opt/load_module_spack_env.txt <<EOF
#!/bin/bash
# INSTRUCTIONS: source /opt/load_module_spack_env.txt

source /opt/spack/share/spack/setup-env.sh
source /usr/share/lmod/8.2.7/init/sh
EOF

cat > /opt/snapshot_env.sh <<EOF
#!/bin/bash
# INSTRUCTIONS: /opt/snapshot_env.sh

rm -f \$SINGULARITY_ENVIRONMENT
touch \$SINGULARITY_ENVIRONMENT
echo "# PART KEEP FIXED" >> \$SINGULARITY_ENVIRONMENT
echo "export TMPDIR=\`echo \$TMPDIR\`" >> \$SINGULARITY_ENVIRONMENT
echo "export TMP=\`echo \$TMP\`" >> \$SINGULARITY_ENVIRONMENT
echo "export SPACK_ROOT=\`echo \$SPACK_ROOT\`" >> \$SINGULARITY_ENVIRONMENT
echo "export PATH=\`echo \$PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export LMOD_CMD=\`echo \$LMOD_CMD\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MODULEPATH=\`echo \$MODULEPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "# PART TO CHANGE" >> \$SINGULARITY_ENVIRONMENT
echo "export LIBRARY_PATH=\`echo \$LIBRARY_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export LD_LIBRARY_PATH=\`echo \$LD_LIBRARY_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CPATH=\`echo \$CPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export INCLUDE=\`echo \$INCLUDE\`" >> \$SINGULARITY_ENVIRONMENT
echo "export C_INCLUDE_PATH=\`echo \$C_INCLUDE_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CPLUS_INCLUDE_PATH=\`echo \$CPLUS_INCLUDE_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CC=\`echo \$CC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export FC=\`echo \$FC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export F77=\`echo \$F77\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CXX=\`echo \$CXX\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CUDA_HOME=\`echo \$CUDA_HOME\`" >> \$SINGULARITY_ENVIRONMENT
echo "export cuDNN_ROOT=\`echo \$cuDNN_ROOT\`" >> \$SINGULARITY_ENVIRONMENT
echo "export PYTHONPATH=\`echo \$PYTHONPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export CMAKE_PREFIX_PATH=\`echo \$CMAKE_PREFIX_PATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MANPATH=\`echo \$MANPATH\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPICC=\`echo \$MPICC\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPICXX=\`echo \$MPICXX\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPIF90=\`echo \$MPIF90\`" >> \$SINGULARITY_ENVIRONMENT
echo "export MPIF77=\`echo \$MPIF77\`" >> \$SINGULARITY_ENVIRONMENT
EOF

chmod a+x /opt/snapshot_env.sh

%environment

# General environment variables
export SPACK_ROOT=/opt/spack
export PATH=/opt/spack/bin:/usr/share/lmod/8.2.7/libexec:$PATH
export LMOD_CMD=/usr/share/lmod/8.2.7/libexec/lmod
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos7-skylake:/opt/spack/share/spack/modules/linux-centos7-haswell
Bootstrap: docker
From: centos:8.2.2004
IncludeCmd: yes

# IMPORTANT: When you are going to work inside the container remember to source these 2 file in order to set the proper module environment with spack and Lmod
# source /opt/spack/share/spack/setup-env.sh && source /usr/share/lmod/8.2.7/init/sh

%post

dnf install -y epel-release 
dnf install -y 'dnf-command(config-manager)' 
dnf config-manager --set-enabled PowerTools 
dnf --enablerepo epel groupinstall -y "Development Tools" 
dnf --enablerepo epel install -y \
        curl \
        findutils \
        gcc-c++ \
        gcc \
        gcc-gfortran \
        git \
        gnupg2 \
        hostname \
        iproute \
        Lmod \
        make \
        patch \
        tcl \
        unzip \
        which 

dnf install -y python36

python3 --version

pip3.6 install boto3 
rm -rf /var/cache/yum 
dnf clean all

# INSTALL SPACK

cd /opt 
git clone https://github.com/spack/spack.git
cd spack
git checkout tags/v0.16.0

# SPACK ENVIRONMENT

export SPACK_ROOT=/opt/spack
export PATH=${SPACK_ROOT}/bin:$PATH
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos8-skylake

spack install openmpi@4.0.2 fabrics=psm2,verbs,ofi +pmi +legacylaunchers schedulers=slurm ^slurm@20-02-4-1 ^python@3.6.4

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

export LD_LIBRARY_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/lib:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/lib
export  INCLUDE=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/include:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/include
export C_INCLUDE_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/include:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/include
export MPIF90=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/bin/mpif90
export MPICXX=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/bin/mpic++
export CMAKE_PREFIX_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo
export CPATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/include/python3.6m
export LIBRARY_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/lib:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/lib
export MPICC=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/bin/mpicc
export SPACK_ROOT=/opt/spack
export MPIF77=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/bin/mpif77
export MANPATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/share/man:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/share/man::
export MODULEPATH=/opt/spack/share/spack/modules/linux-centos8-skylake
export CPLUS_INCLUDE_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/include:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/include
export PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/bin:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/bin:/opt/spack/bin:/usr/share/lmod/8.2.7/libexec:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PKG_CONFIG_PATH=/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/openmpi-4.0.2-udzycxkbazgxwskri4rjwlpx44m37vjz/lib/pkgconfig:/opt/spack/opt/spack/linux-centos8-skylake/gcc-8.3.1/python-3.6.4-4nhuat4vipgvtps4ebgka3bm7gojzmyo/lib/pkgconfig
export LMOD_CMD=/usr/share/lmod/lmod/libexec/lmod


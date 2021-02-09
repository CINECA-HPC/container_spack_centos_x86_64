Bootstrap: localimage
From: spack160_openmpi420_gnu740_centos7_x86_64.sif
IncludeCmd: yes

%post

yum -y install vim wget zlib-devel bzip2 gcc make make-devel libstdc++-devel gcc-gfortran gcc-c++ diffutils perl m4 openssh-clients openssh-server

source /opt/load_module_spack_env.txt
module load gcc-7.4.0-gcc-4.8.5-hox4jgu openmpi-4.0.2-gcc-7.4.0-ejkw5r3 zlib-1.2.11-gcc-7.4.0-mxnzf2f

mkdir /tmpdir
cd /tmpdir
wget https://github.com/yambo-code/yambo/archive/5.0.0.tar.gz -O yambo-5.0.0.tar.gz
tar zxvf yambo-5.0.0.tar.gz
cd yambo-5.0.0.tar.gz

./configure --enamble-mpi --enable-open-mp --enable-msgs-comps --enable-time-profile --enable-memory-profile
make -j4 yambo
make interfaces ypp
mkdir -p /usr/local/yambo-4.5.3/lib
cp bin /usr/local/yambo-4.5.3/.
cp lib/external/gfortran/mpifort/lib/*.a /usr/local/yambo-4.5.3/lib/. 
cp lib/external/gfortran/mpifort/lib/*.la /usr/local/yambo-4.5.3/lib/.
cp lib/external/gfortran/mpifort/v4/serial/lib/*.a /usr/local/yambo-4.5.3/lib/.
cp lib/external/gfortran/mpifort/v4/serial/lib/*.la /usr/local/yambo-4.5.3/lib/.

%environment

export PATH=/usr/local/yambo-4.5.3/bin:${PATH}
export LD_LIBRARY_PATH=/usr/local/yambo-4.5.3/lib:${LD_LIBRARY_PATH}


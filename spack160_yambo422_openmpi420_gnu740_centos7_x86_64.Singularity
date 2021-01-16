Bootstrap: localimage
From: spack160_openmpi420_gnu740_centos7_x86_64.sif
IncludeCmd: yes

%post

spack install yambo@4.2.2 +dp io=iotk,etsf-io +mpi +openmp profile=time,memory %gcc@7.4.0  ^openmpi@4.0.2 %gcc@7.4.0 fabrics=psm2,verbs,ofi +pmi +legacylaunchers schedulers=slurm ^slurm@20-02-4-1 ^python@3.6.4



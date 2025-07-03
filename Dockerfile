FROM continuumio/miniconda3

SHELL ["/bin/bash", "--login", "-c"]

# clone relightable gaussian
WORKDIR /workspace
RUN git clone https://github.com/NJU-3DV/Relightable3DGaussian.git
WORKDIR Relightable3DGaussian

# install environment
RUN conda env create --file environment.yml
RUN conda init bash
RUN conda activate r3dg

# install pytorch=1.12.1
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.6 cudatoolkit-dev -c pytorch -c conda-forge

# install torch_scatter==2.1.1
RUN pip install torch_scatter==2.1.1

# install kornia==0.6.12
RUN pip install kornia==0.6.12

# install nvdiffrast=0.3.1
RUN git clone https://github.com/NVlabs/nvdiffrast
RUN pip install ./nvdiffrast

# install knn-cuda
RUN pip install ./submodules/simple-knn

# install bvh
RUN pip install ./bvh

# install relightable 3D Gaussian
RUN pip install ./r3dg-rasterization



# download pre-processed tanks and temples
RUN curl https://box.nju.edu.cn/f/f0b094cc22bf4934a000/?dl=1
RUN unzip data_tnt.zip datasets/

# run tanks and temples
RUN sh script/run_tnt.sh

FROM ubuntu:22.04

RUN apt update
RUN apt install -y git make gcc g++ zlib1g-dev ncbi-blast+

# Install miniprot
RUN git clone --branch v0.13 https://github.com/lh3/miniprot
RUN cd miniprot && make && cd ..
ENV PATH="$PATH:/miniprot"

# Install mafft
RUN git clone --branch v7.526 https://gitlab.com/sysimm/mafft.git
RUN cd mafft/core && make clean && make && make install && cd ../..

WORKDIR /chroquetas

COPY db/ ./db
COPY --chmod=765 bin/ChroQueTas.sh /bin/ChroQueTas.sh


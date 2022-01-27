# bwa-mem2 and Samtools app
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-samtools

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1 AS builder

ENV BWA_VER=2.2.1 \
	SAMTOOLS_VER=1.14 \
	CLEAR_VER=35750

# install bwa mem2 binaries
RUN wget "https://github.com/bwa-mem2/bwa-mem2/releases/download/v${BWA_VER}/bwa-mem2-${BWA_VER}_x64-linux.tar.bz2" && \
	tar -vxjf bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
	rm bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
	cd bwa-mem2-${BWA_VER}_x64-linux && \
	mkdir /usr/local/bin && \
	cp bwa-mem2* /usr/local/bin/ && \
	# install samtools
	wget "https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2" -O "samtools.tar.bz2" && \
	tar -vxjf samtools.tar.bz2 && \
	rm samtools.tar.bz2 && \
	cd samtools-${SAMTOOLS_VER} && \
	autoreconf && ./configure && \
	make -j 6 && \
	make prefix=/usr/local install && \
	# install minimal versioned clearlinux OS
	swupd os-install \
		--no-progress \
		--no-boot-update \
		--no-scripts \
		--version ${CLEAR_VER} \
		--path /install_root \
		--statedir /swupd-state \
		--bundles=os-core,libstdcpp,devpkg-bzip2

# final image with minimal OS install and app binaries
FROM scratch

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools"

COPY --from=builder /install_root /
COPY --from=builder /usr/local /usr/local

RUN useradd bioseq

USER bioseq
WORKDIR /home/bioseq
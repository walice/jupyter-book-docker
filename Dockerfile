FROM jupyter/scipy-notebook:dc57157d6316

# START binder compatibility
# from https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}

# END binder compatibility code

# Add modification code below

USER ${NB_USER}

# Upgrade Jupyter install
#RUN pip install --upgrade jupyter jupyter-core jupyter-console

# Jupyter notebook extensions
RUN \
    pip install export_embedded/main --sys-prefix && \
    #pip install jupyter_contrib_nbextensions && \
    #jupyter contrib nbextension install --sys-prefix && \
    jupyter nbextension enable export_embedded/main --sys-prefix

RUN jupyter nbextensions_configurator enable --sys-prefix

# Jupyter Book packages
RUN pip install -U "jupyter-book>=0.7.0b" && \
    pip install ghp-import

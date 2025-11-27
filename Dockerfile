FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

USER root

# Copy the explicit conda lock file into the image
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Create a new environment from the explicit lock file using mamba
RUN mamba create -y -n dsci522-env --file /tmp/conda-linux-64.lock && \
    mamba clean -a -y && \
    fix-permissions "$CONDA_DIR" && \
    fix-permissions "/home/$NB_USER"

# Switch back to the notebook user
USER $NB_USER

# Start Jupyter notebook (this is the default entrypoint, but we make it explicit)
CMD ["start-notebook.sh"]


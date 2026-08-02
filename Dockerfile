# Base image
FROM debian:stable-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    npm \
    poppler-utils && \
    rm -rf /var/lib/apt/lists/*

# Add the host user so bind-mounted files retain their ownership.
ARG USER_ID
ARG GROUP_ID
ARG USERNAME
ARG PROJECT_SUBDIR=proj/loom
ENV PROJECT_DIR=/home/${USERNAME}/${PROJECT_SUBDIR}
RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m ${USERNAME} && \
    mkdir -p ${PROJECT_DIR}/.cache && \
    chown -R ${USERNAME}:${USERNAME} ${PROJECT_DIR}

WORKDIR ${PROJECT_DIR}
USER ${USERNAME}

# Install Claude after switching to the unprivileged user.
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

RUN mkdir -p /home/${USERNAME}/.npm-global && \
    npm config set prefix /home/${USERNAME}/.npm-global && \
    npm i -g @openai/codex
ENV PATH="/home/${USERNAME}/.npm-global/bin:${PATH}"

CMD ["bash"]

# Base image
FROM debian:stable-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 20 & Gemini CLI
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @google/gemini-cli && \
    rm -rf /var/lib/apt/lists/*

# Add user
ARG USER_ID
ARG GROUP_ID
ARG USERNAME
RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m ${USERNAME} && \
    mkdir -p /app/.cache && chown -R ${USERNAME}:${USERNAME} /app

# Set the default user
USER ${USERNAME}

# Install Claude - must be installed after switching to user
RUN curl -fsSL https://claude.ai/install.sh | bash

# Add Claude to PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

CMD ["bash"]

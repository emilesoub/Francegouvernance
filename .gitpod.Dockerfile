# On part d'une image de base fournie par Gitpod, qui contient déjà plein d'outils utiles.
FROM gitpod/workspace-full:latest

# On passe temporairement en mode "administrateur" pour installer des logiciels.
USER root

# On met à jour la liste des logiciels et on installe des outils essentiels.
# - protobuf-compiler : un "traducteur" spécial pour le langage de la blockchain.
# - curl, etc. : des utilitaires pour télécharger des choses depuis internet.
RUN apt-get update && apt-get install -y \
    protobuf-compiler \
    curl \
    ca-certificates \
    gnupg \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# On installe une version très précise du langage Go, celui utilisé par le Cosmos SDK.
ARG GO_VERSION=1.24.0
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# On installe l'outil principal pour construire notre blockchain : Ignite CLI.
RUN curl https://get.ignite.com/cli! | bash

# On redevient un utilisateur normal.
USER gitpod

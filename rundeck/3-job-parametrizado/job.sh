#!/bin/bash

# Aqui o script irá tentar criar o diretório '.ssh' dentro da home do usuário.
su -c 'mkdir -p ~/.ssh' @option.user@

# É verificado se a chave pública já está presente dentro do arquivo "authorized_keys" no diretório ".ssh" na home do usuário e jogamos as saídas (stdout e stderr) para o limbo dentro do linux.
grep "@option.key@" /home/@option.user@/.ssh/authorized_keys > /dev/null

# Aqui temos uma condição que irá validar o return code do comando anterior (grep), caso o return code seja diferente de 0, ou seja, retornou com erro, a chave será concatenada ao final do arquivo authorized_keys. Caso retorne 0, que siginifica que rodou com sucesso, simplesmente será apresentada a mensagem "Chave já existe".

if [ $? !=0 ]; then
    su -c 'echo "@option.key@" >> ~/.ssh/authorized_keys' @option.user@
    echo 'Chave adicionada'
else
   echo 'Chave já existe'
fi

# Por fim, é criado a autorização para que este novo usuário possa utilizar o SUDO.

echo '@option.user@ ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/@option.user@


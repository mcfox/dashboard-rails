# Ferramenta para Gerenciamento de Widgets

Essa gem tem como objetivo gerenciar widgets para uso em dashboard

### Instalação

Adicione essa linha no Gemfile do sistema:
```ruby
gem 'taxweb_widgets', :git => 'https://TOKEN:x-oauth-basic@github.com/taxweb/taxweb_widgets'
```

Salve o arquivo e instale a gem utilizando o comando abaixo no diretório raiz da aplicação:
```sh
$ bundle install
```

Aplique os arquivos da gem (migrations, configs, initializers) através do comando:
```sh
$ rails g taxweb_widgets:install
```

Gere as tabelas no seu banco de dados com o comando:
```sh
$ rake db:migrate
```

Adicione no seu arquivo **application.css**
```js
    *= require taxweb_widgets
```

Adicione no seu arquivo **application.js**
```js
    //= require taxweb_widgets
```
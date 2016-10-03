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

### Geradores

Para sobrescrever as views de configuração dos Widgets utilize:
```sh
rails g taxweb_widgets:view
```

### Widgets

A lógida dos widgets são criados na pasta `app/widgets/exemplo_widget.rb`
```ruby
class ExemploWidget < ApplicationWidget

  name! 'Widget Exempo'
  description! 'Esse Widget é apenas um exemplo'

  description! :executar, 'Essa ação é um outro exemplo'
  def executar
    @ano =  params[:ano] || Date.today.year
  end

end
```

**Cada ação será uma visão diferente do widget. Exemplo: Calendário Mensal, Calendário Semanal, você terá o widget Calendários e as ações mensal e semanal.**

Parametros utilizados como documentação para exibir na lista de configuração de Widgets x Usuários.

- **name!** identifica o nome (título) do Widget. 
- **description!** é a descrição (função)  do Widget.
- **description! :acao** é a descrição (função) da ação daquele Widget.

O conteúdo visual do Widget (VIEW) seguirá o padrão do rails estando na pasta `app/views/widgets/nome_do_widget/nome_da_acao.html.erb`:

*app/widgets/exemplo/executar.html.erb*
```html
<div>
Meu widget de exemplo retornou o ano: <%= @ano %>
<%= link_to 'Próximo Ano e recarregar Widget', widget_path(ano: (@ano +1), widget_ajax: true %>
<%= link_to 'Ir para página externa normalmente', 'http://www.google.com.br/' %>
</div>
```

Para direcionar o usuário para configurar seus widgets, faça um link para `taxweb_widgets_path`
```html
<%= link_to 'Gerenciar Widgets', taxweb_widgets_path %>
```

### Helpers

Para verificar a permissão de acesso ao Widget pelo usuário atual (current_user), utilize o helper `user_can_widget?(nome_widget, ação)`:
```html
<% if user_can_widget?(:calendarios, :mensal) %>
 
<% end %>
```

Para adicionar um widget use o helper `add_widget(nome_widget, ação)`:
```html
<%= add_widget(:calendarios, :mensal) %>
```

Para referenciar um path do widget de forma automática utilize `widget_path`. Esse helper espera que haja definido em params *widget_name* e *widget_name* :
```html
#params[:widget_name] = 'calendarios'
#params[:widget_naction] = 'mensal'
<%= widget_path(novo_atributo: 'novo valor') %>
``` 

Para criar um link que faça uma chamada ajax e retorne o resultado HTML no próprio widget (como mudar de página por exemplo):
```html
<%= link_to 'Link Remoto', widget_path({ano: @ano}), widget_ajax: true %>
```

Formulário para reescrever o plugin baseado em algum parametro:
```html
<%= form_tag widget_path, method: :get, widget_ajax: true do %>

<% end %>
```

### Recursos AJAX (automáticos)

Toda vez que um elemento com classe `widget-user-contro` for alterado será disparado um evento AJAX que irá localizar as configuraçẽos do usuário na view de configuração e retornará um HTML com o conteúdo no elemento `.widgets_list .list`

Todo formulário em widget que tenha a atributo `widget_ajax` terá seu evento "submit" enviado por AJAX, retornando o resultado no próprio container do widget, portanto é esperado um retorno HTML.
 
Todo elemento com atributo `data-url` tentará criar um contador com tempo igual ao atributo `data-tick` para atualização automática do widget.


# Dashboard Rails

This Gem is dessigne to help create a dashboard page where the user can select the dsiplayed widgets.

The user selects the widgte he would like to display and save this information.

For the moment we require a model *User* and the method *current_user* 

### Installation

Add the gem to the Gemfile

```ruby
gem 'dashboard-rails'
```
adn run bundle install

```sh
$ bundle install
```

Generate some required files using the provided generator
```sh
$ rails g dashboard-rails:install
```

A migration will be created the table where we keep the dashboard settings per user

```sh
$ rake db:migrate
```

Add the provide css to  **application.css**
```js
    *= require dashboard-rails
```

Add the provide js to **application.js**
```js
    //= require dashboard-rails
```

### Dashboard Page

To create you dashboard page, just add the following helper to your page

```html
<%= add_dashboard %>
```

Or you can generate the dashboard viwes in your project:
```sh
rails g dashboard-rails:view
```

### the Dashboard Configuration Page


### Widget Generators

To create the widget skeleton use:
```sh
rails generate dashboard-rails:widget #{widget_name}
```


All widgets are create under the `app/widgets` folder


## How to create a Widget

For example:

```ruby
class ExemploWidget < ApplicationWidget

  name! 'Widget Exemplo'
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

Para direcionar o usuário para configurar seus widgets, faça um link para `dashboard-rails_path`
```html
<%= link_to 'Gerenciar Widgets', dashboard-rails_path %>

<%= link_to 'Gerenciar Widgets', dashboard_settings_path %>


```

### Helpers

Para verificar a permissão de acesso ao Widget pelo usuário atual (current_user), utilize o helper `user_can_widget?(nome_widget, ação)`:
```html
<% if show_widget?(:calendarios, :mensal) %>
 
<% end %>
```

Para adicionar um widget use o helper `add_widget(nome_widget, ação)`:
```html
<%= add_widget(:calendarios, :mensal) %>
```

Para referenciar um path do widget de forma automática utilize `widget_path`. Esse helper espera que haja definido em params *widget_name* e *widget_name* :
```html
<!-- ESPERA QUE EXISTA params[:widget_name] e params[:widget_action] definidos -->
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

### Atualização Manual do Widget

Para atualizar um widget de forma manual você precisa recuperar o elemento do widget com a classe `widget` e chamar o método `widget_load_from_ajax`:
```javascript
var elemento = $('.widget:first')
//Esse elemento precisa ser um elemento jQuery
widget_load_from_ajax(elemento);
```

### Recursos AJAX (automáticos)

Toda vez que um elemento com classe `widget-user-control` for alterado será disparado um evento AJAX que irá localizar as configuraçẽos do usuário na view de configuração e retornará um HTML com o conteúdo no elemento `.widgets_list .list`. Caso não seja informado esse item, o primeiro formulário com a classe `widget_config` será passado como elemento destino.

Todo formulário em widget que tenha a atributo `widget_ajax` terá seu evento "submit" enviado por AJAX, retornando o resultado no próprio container do widget, portanto é esperado um retorno HTML.
 
Todo elemento com atributo `data-url` tentará criar um contador com tempo igual ao atributo `data-tick` para atualização automática do widget.